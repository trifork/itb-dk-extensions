import com.google.gson.Gson;
import java.io.*;
import java.net.*;
import java.nio.charset.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.*;
import org.sonar.api.batch.fs.InputFile;
import org.sonar.api.batch.rule.ActiveRule;
import org.sonar.api.rule.RuleKey;
import org.sonarsource.sonarlint.core.analysis.api.*;
import org.sonarsource.sonarlint.core.analysis.container.global.GlobalAnalysisContainer;
import org.sonarsource.sonarlint.core.commons.api.SonarLanguage;
import org.sonarsource.sonarlint.core.commons.progress.ProgressIndicator;
import org.sonarsource.sonarlint.core.commons.tracing.Trace;
import org.sonarsource.sonarlint.core.plugin.commons.*;
import org.sonarsource.sonarlint.core.rule.extractor.*;

public class SonarLocal {
    record Source(Path base, Path file) implements ClientInputFile {
        public String getPath() {
            return file.toString();
        }

        public boolean isTest() {
            return file.toString().contains("/src/test/");
        }

        public Charset getCharset() {
            return StandardCharsets.UTF_8;
        }

        public <G> G getClientObject() {
            return null;
        }

        public InputStream inputStream() throws IOException {
            return Files.newInputStream(file);
        }

        public String contents() throws IOException {
            return Files.readString(file);
        }

        public String relativePath() {
            return base.relativize(file).toString();
        }

        public URI uri() {
            return file.toUri();
        }

        public SonarLanguage language() {
            return SonarLanguage.JAVA;
        }
    }

    record Rule(SonarLintRuleDefinition def) implements ActiveRule {
        public RuleKey ruleKey() {
            return RuleKey.parse(def.getKey());
        }

        public String severity() {
            return def.getDefaultSeverity().name();
        }

        public String language() {
            return "java";
        }

        public String param(String k) {
            return params().get(k);
        }

        public Map<String, String> params() {
            return def.getDefaultParams();
        }

        public String internalKey() {
            return def.getInternalKey().orElse(null);
        }

        public String templateRuleKey() {
            return null;
        }

        public String qpKey() {
            return null;
        }
    }

    public static void main(String[] args) throws Exception {
        Path base = Path.of(args[0]), extension = Path.of(args[1]);
        var loaded =
                new PluginsLoader()
                        .load(
                                new PluginsLoader.Configuration(
                                        Set.of(
                                                extension.resolve("analyzers/sonarjava.jar"),
                                                extension.resolve(
                                                        "analyzers/sonarjavasymbolicexecution.jar")),
                                        Set.of(SonarLanguage.JAVA),
                                        false,
                                        Optional.empty()),
                                Set.of())
                        .getLoadedPlugins();
        if (loaded.getAllPluginInstancesByKeys().size() != 2) {
            throw new IllegalStateException("Both Java and symbolic-execution analyzers must load");
        }
        var definitions =
                new RulesDefinitionExtractor()
                        .extractRules(
                                loaded.getAllPluginInstancesByKeys(),
                                Set.of(SonarLanguage.JAVA),
                                false,
                                true,
                                new RuleSettings(Map.of()));
        var rules =
                definitions.stream()
                        .filter(SonarLintRuleDefinition::isActiveByDefault)
                        .map(Rule::new)
                        .toList();
        List<ClientInputFile> files;
        try (var stream = Files.walk(base)) {
            files =
                    stream.filter(
                                    p ->
                                            p.toString().endsWith(".java")
                                                    && p.toString().contains("/src/")
                                                    && !p.toString().contains("/target/"))
                            .map(p -> (ClientInputFile) new Source(base, p))
                            .toList();
        }
        var fs =
                new ClientModuleFileSystem() {
                    public Stream<ClientInputFile> files() {
                        return files.stream();
                    }

                    public Stream<ClientInputFile> files(String l, InputFile.Type t) {
                        return files.stream()
                                .filter(f -> t == null || f.isTest() == (t == InputFile.Type.TEST));
                    }
                };
        var config =
                AnalysisSchedulerConfiguration.builder()
                        .setWorkDir(Path.of(args[4]))
                        .setClientPid(ProcessHandle.current().pid())
                        .setFileSystemProvider(k -> fs)
                        .build();
        var container = new GlobalAnalysisContainer(config, loaded);
        container.startComponents();
        var analysis =
                AnalysisConfiguration.builder()
                        .setBaseDir(base)
                        .addInputFiles(files)
                        .addActiveRules(rules)
                        .putExtraProperty("sonar.java.source", "25")
                        .putExtraProperty("sonar.java.jdkHome", args[5])
                        .putExtraProperty(
                                "sonar.java.libraries", Files.readString(Path.of(args[3])))
                        .putExtraProperty(
                                "sonar.java.test.libraries", Files.readString(Path.of(args[3])))
                        .build();
        var output = new ArrayList<Map<String, Object>>();
        var trace = Trace.begin("scan", "local");
        try {
            var results =
                    container
                            .getModuleRegistry()
                            .getContainerFor(base.getFileName().toString())
                            .analyze(
                                    analysis,
                                    i -> {
                                        var m = new LinkedHashMap<String, Object>();
                                        m.put(
                                                "file",
                                                i.getInputFile() == null
                                                        ? null
                                                        : i.getInputFile().relativePath());
                                        m.put("line", i.getStartLine());
                                        m.put("endLine", i.getEndLine());
                                        m.put("rule", i.getRuleKey().toString());
                                        m.put("message", i.getMessage());
                                        output.add(m);
                                    },
                                    new ProgressIndicator() {
                                        public void notifyProgress(String s, Integer n) {}

                                        public boolean isCanceled() {
                                            return false;
                                        }
                                    },
                                    trace);
            if (!results.failedAnalysisFiles().isEmpty())
                throw new IllegalStateException(
                        "Sonar failed to analyze "
                                + results.failedAnalysisFiles().size()
                                + " files");
            var report = new LinkedHashMap<String, Object>();
            report.put("files", files.size());
            report.put("rules", rules.size());
            report.put("issues", output);
            Files.writeString(Path.of(args[2]), new Gson().toJson(report));
            System.out.println(
                    "SCANNED "
                            + files.size()
                            + " files with "
                            + rules.size()
                            + " rules; "
                            + output.size()
                            + " issues; failed files: "
                            + results.failedAnalysisFiles().size());
        } finally {
            trace.finishSuccessfully();
            container.stopComponents();
            loaded.close();
        }
    }
}
