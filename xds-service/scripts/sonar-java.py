#!/usr/bin/env python3
"""Run VS Code's bundled Sonar Java analyzers locally, with the compiled test classpath."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--project', type=Path, default=ROOT,
                        help='Maven project to analyze (defaults to xds-service)')
    parser.add_argument('--extension', type=Path, help='SonarQube for IDE extension directory')
    parser.add_argument('--java-home', type=Path, help='Java 25+ JDK used to run the analyzer')
    args = parser.parse_args()
    project = args.project.resolve()
    extension = args.extension
    if extension is None:
        candidates = list((Path.home() / '.vscode/extensions').glob('sonarsource.sonarlint-vscode-*'))
        if not candidates:
            parser.error('Install SonarQube for IDE, or provide --extension')
        extension = max(candidates, key=lambda p: tuple(int(n) for n in p.name.split('-')[2].split('.')))
    extension = extension.resolve()
    engine = extension / 'server/sonarlint-ls.jar'
    for artifact in (engine, extension / 'analyzers/sonarjava.jar', extension / 'analyzers/sonarjavasymbolicexecution.jar'):
        if not artifact.is_file():
            parser.error(f'Missing analyzer component: {artifact}')

    reports = list((project / 'target/surefire-reports').glob('TEST-*.xml'))
    if not reports:
        parser.error('Run mvn verify first')
    properties = {p.get('name'): p.get('value') for p in ET.parse(reports[0]).findall('./properties/property')}
    classpath = [str(project / suffix) for suffix in ('target/classes', 'target/test-classes')
                 if (project / suffix).is_dir()]
    classpath.extend(properties['java.class.path'].split(os.pathsep))
    classpath = list(dict.fromkeys(classpath))
    missing = [p for p in classpath if not Path(p).exists()]
    if missing:
        parser.error('Compiled test classpath is stale; rerun the Maven tests')

    java_home = args.java_home or (Path(os.environ['SONAR_JAVA_HOME']) if 'SONAR_JAVA_HOME' in os.environ else None)
    if java_home is None and sys.platform == 'darwin':
        java_home = Path(subprocess.check_output(['/usr/libexec/java_home', '-v', '25'], text=True).strip())
    java = str(java_home / 'bin/java') if java_home else shutil.which('java')
    javac = str(java_home / 'bin/javac') if java_home else shutil.which('javac')
    if not java or not javac:
        parser.error('Provide a Java 25+ JDK with --java-home')
    output = project / 'target/reports/sonar-java.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='ihe-xds-sonar-') as directory:
        work = Path(directory)
        cp_file = work / 'classpath.txt'
        cp_file.write_text(','.join(classpath))
        subprocess.run([javac, '-cp', str(engine), '-d', str(work), str(ROOT / 'scripts/sonar/SonarLocal.java')], check=True)
        subprocess.run([java, '-cp', os.pathsep.join((str(work), str(engine))), 'SonarLocal', str(project), str(extension), str(output), str(cp_file), str(work / 'analysis'), properties['java.home']], check=True)
    report = json.loads(output.read_text())
    print(f"Sonar Java: {report['files']} files, {report['rules']} active rules, {len(report['issues'])} findings")
    for issue in report['issues']:
        print(f"{issue.get('file')}:{issue.get('line', '')} {issue['rule']} {issue['message']}")
    print(f'Report: {output}')
    return 1 if report['issues'] else 0


if __name__ == '__main__':
    sys.exit(main())
