# Source-derived CDA conformance checks

The validator now also exposes **PHAD-DK 1.0.1, PMR-DK 2.0.0, PRF-DK 3.0.0
and PSCR-DK 2.0.0**. APD-DK 2.0.1, CPD-DK 2.0.0, PDC-DK 2.0/3.0.0 and
PHMR-DK 1.3/2.1.0 have additional source-derived checks. QRD and QFDD remain
covered by the separately documented [PRO rules](pro-conformance.md).

All targets retain **partial coverage**. The original XSD and inherited
Schematron/Gazelle checks still run. The four new profiles use the shared CDA
XSD and generic Gazelle CDA engine with their own Schematrons; there is no
claim that Gazelle provides a national checker for these four profiles.

Gazelle findings are mapped to GITB errors and warnings using their notification
types. The C-CDA 2.1 engine used by both PHMR releases emits descriptions without
`ERROR`/`WARNING` prefixes; the former description-prefix mapping silently dropped
those findings. The adapter now preserves their severity, rule IDs and offending
object paths in the description. The existing `cdadt-IISpec-cdadt011` uppercase-UUID
exception remains informational, and successful checks remain omitted.
`GazelleFindingsTest` exercises actual generated C-CDA errors, typed warnings and
the UUID exception. `CdaGazelleFindingsIT` verifies both PHMR routes with missing
and supplied organizer IDs under the explicitly declared C-CDA Vital Signs
Organizer V3 template (C-CDA 2.1, CONF:1198-7282,
`ccdav21-VitalSignsOrganizerV3-ccdav211617`). The rule is implemented in the
[pinned Gazelle sources](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/ccdav21-validator-jar/0.0.2/ccdav21-validator-jar-0.0.2-sources.jar);
this reporting correction adds no national-profile rules or broader coverage claim.

The reused C-CDA engine also contains an unconditional C-CDA document-template
whitelist (`ccdav21-CCDAV21ClinicalDocumentSpec-ccdav215689`). That single rule is
excluded for the two PHMR targets: [PHMR-DK 1.3 sections 2.2–2.3](https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf)
and [PHMR-DK 2.1.0 section 2.1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf)
declare the international PHMR root `2.16.840.1.113883.10.20.9` and Danish root
`1.2.208.184.11.1`, which are absent from the C-CDA whitelist. The PHMR Schematrons
continue to require those roots. Tests verify that missing PHMR declarations
still fail, and that C-CDA entry-template errors still reach the report on both
PHMR routes. Existing sample expectations and all other Gazelle rules are retained.

## Sources and traceability

The official [MedCom HL7 release tree](https://svn.medcom.dk/svn/releases/Standarder/HL7/)
was inspected at SVN revision 4398 on 2026-09-15. The
[source manifest](cda-conformance/sources.json) records exact URLs, retrieval
dates and SHA-256 hashes. PHMR 1.3 uses the historical revision already selected
by this repository, not the current PHMR guide.

The maintained sources are `cda-validator/domain/cda-dk/sch/versions/*-conformance.sch`. Every new
assertion has a stable ID, an official `see` URL, a specification section (and
clause identifier where available), a severity, and an XPath context. Assertions
use independent patterns so overlapping contexts are not masked by the
Schematron first-matching-rule rule. Missing children are reported on an existing
parent; attribute constraints are reported on the owning element.

The [rule inventory](cda-conformance/rules.json) contains every executable XPath
and source reference. Regenerate both CDA and PRO inventories with:

```bash
python3 scripts/conformance-rule-inventory.py
python3 scripts/conformance-rule-inventory.py --check
```

`cda-validator/src/test/resources/cda/*-cases.xml` contains targeted mutations and positive cases for these
assertions. The shared `ConformanceSchematronTest` compiles the actual ISO
Schematrons with Saxon, executes them and checks the reported IDs and locations.
These synthetic fixtures isolate the added rules: they are **not** advertised
as complete CDA examples that pass the full validation chain. Published examples
are tested separately, with their original bytes preserved.

## Implemented additions

| Target | Added coverage |
| --- | --- |
| APD-DK 2.0.1 | Header identity, fixed codes/title, author cardinality and requester role, prohibited header participants, appointment interval, body/encounter structure, performer and location requirements, reason relationships, dated templates and optional precondition identifiers. Applies the latest published 2021 errata. |
| CPD-DK 2.0.0 | Document code and identifiers, version/validity events, required/optional section cardinalities, section codes and dates, narrative element presence, health concern and goal/intervention entry requirements. |
| PDC-DK 2.0 and 3.0.0 | Header structure, document code/title, Sundhedsdatastyrelsen author/custodian identifiers, prohibited header elements, creation-time consistency and service interval. PDC 2.0 applies the 2022 errata. |
| PHMR-DK 1.3 | Explicit international and Danish templates, document code, monitoring service event/class and interval, structured body. The existing version-specific and PHMR Java checks remain active. |
| PHMR-DK 2.1.0 | Measurement-code correspondence between body and header, traced also to the Word sender protocol. The above plus document UUID and authority, fixed document labels, body/section classes, section codes and narrative/entry presence. Existing measurement and version checks remain active. |
| PHAD-DK 1.0.1 | Document identity/code, version and validity events, non-XML body, PDF media type, Base64 representation and lexical Base64 validity. |
| PMR-DK 2.0.0 | Header and SOR structure, prohibited elements, version/time/episode events, results section and organizer, four unambiguous observation templates: numeric PQ, coded CD, timestamp TS and numeric interval IVL_PQ. Includes template dates, status, value types, timestamp precision and interval boundary attributes. Section 5.4 permits unknown/irrelevant observation times as NI/NA. |
| PRF-DK 3.0.0 | Header and SOR structure, prohibited elements, version/time/episode events, optional section cardinalities and the fixed classes, template dates, codes and required narrative elements of 20 unambiguous section templates. |
| PSCR-DK 2.0.0 | Header and SOR structure, prohibited elements, version/time/episode events, optional section cardinalities and the fixed classes, template dates, codes and required narrative elements of all 16 section templates. |

## Specification conflicts and interpretation decisions

These decisions are deliberately visible. Published examples are evidence for
investigation, not authority to weaken normative requirements.

* **APD errata:** the 2021-11-24 errata supersedes the two-required-authors rule:
  the responsible author remains mandatory and a requester is optional. A
  supplied requester uses `REFB`. Version identifier root is
  `1.2.208.184.100.10`. Errata item 16 reverses item 13's attempted mandatory
  repetition value; it remains optional. Obsolete concept-interval constraints
  are not added. `playingEntity/name` is treated as an element, consistent with
  CDA, despite the guide's attribute spelling.
* **CPD:** the episode heading says required while its table says 0..1; no
  mandatory-episode assertion is introduced. The interventions section and
  entry have conflicting SHALL/SHOULD wording; the new cardinality findings are
  warnings. The Outcomes section describes `component` where CDA section
  entries normally use `entry`; no new assertion requires that contradictory
  structure. The header's national template root takes precedence over the
  truncated root in document clause C1. The version table supplies
  `cpd-v2.0.0`; the prose has a spelling error.
* **PDC:** the 2.0 errata corrects the author/custodian SOR to
  `1126211000016009`; the 3.0 guide explicitly repeats that value. These are
  requirements of these releases, not a runtime lookup of a current organisation.
* **PHAD:** the guide cover says 1.0.1, while H16 prints `phad-v1.0.0` in prose
  and `phad-v1.0` in its table. Both printed markers are accepted; neither proves
  the patch release. The selected validation target determines the rules. The
  contradictory document template extension/date is not enforced. The episode
  requirement also conflicts with a 0..1 table and is not made mandatory.
  Table 5 puts `mediaType` and `representation` on `nonXMLBody/text`, consistent
  with CDA; prose placing them directly on `nonXMLBody` is not followed.
* **Pregnancy document template extensions:** the header and document-level
  chapters prescribe different extensions for the same template root. PMR also
  retains `1.0` in its header prose despite its 2.0 release and examples. No
  conflicting document-template extension assertion is added; the national root
  and explicit service-event version marker are enforced.
* **PRF provider SOR:** H0073 prints `1.2.208.176.1.14`, while calling it SOR.
  The new provider rule checks authority/identifier presence, but does not
  enforce this disputed OID. Other explicit SOR constraints are retained.
* **PRF allergy section:** section 3 identifies maternal allergy with root
  `1.2.208.184.19.2.94`, but section 4.14 copies root `...19.2.67` from fetal
  allergy and assigns a different fixed code. Applying both to root 67 would
  make conformity impossible. Root 67 accepts either published allergy code; it cannot distinguish maternal
  from fetal allergy on its own. The remaining 4.14-specific rules are deferred. Work-environment section 4.11 uses the updated
  `2025-06-30` date; the adjacent old clause number is not part of the date.
* **PMR integer/string observations:** 5.12 labels integer observations with
  root `...21.2.4`, already used for string observations; the overview identifies
  integer root `...21.2.8`. Strict type rules for these two templates are deferred
  rather than imposing incompatible ST and INT constraints on one root.
  PMR organizer components are children of the organizer as shown in the table,
  not of `effectiveTime` as the prose indentation suggests.
* **PSCR title spacing:** the prescribed heading runs directly into the CPR in
  prose. Presence is checked; an exact text assertion is deferred. The section
  title/display-name constraints in the pregnancy profiles currently check
  presence rather than all exact Danish strings.
* **Pregnancy null values:** the guides restrict `nullFlavor` to NI and NA. PMR
  section 5.4 explicitly permits these for unknown/irrelevant observation times;
  timestamp precision applies when a value is supplied. PRF fetal-allergy code
  B0267 is `2903021000005101`; the superscript 6 in the table is a footnote, not
  an extra code digit (also confirmed by the prose clause).
* **Cardinality and identifiers:** template cardinalities count the matching
  declaration, not unrelated template IDs. Optional sections do not become
  required. A supplied optional element can still have mandatory children.
  UUID syntax is checked where prescribed; global uniqueness and ownership
  cannot be established from one document.

## Remaining coverage

This is an extension of validation, not a claim of exhaustive transcription of
every constraint in the guides. PRF and PSCR entry-level clinical relationships,
conditional observations, most value-set membership and code/display-name/unit
correspondence remain to be implemented. CPD clinical entry templates and the
CPD-FLP specification are not exhaustively audited. Additional PDC body rules
and PHMR measurement rules beyond the existing checks remain incomplete.

Generic CDA-header guidance is referenced by the profiles but has not been
re-audited end to end for every release. Sender/receiver test protocols include
workflow, presentation, registry and clinical requirements that cannot be
reduced to single-document XPath assertions. No rule claims to verify SOR
membership, identity ownership, correct medical content, human presentation,
cross-document pregnancy continuity or an attachment's complete PDF validity.
An optional section with a missing/unknown template may fall outside the
template-scoped checks; the shared XSD does not prove national identity.

## Example report and reproduction

The [Markdown example report](example-validation-report.md) gives actual results
for every imported example, grouped by selected release. Each failing example
lists rule IDs, counts, messages, source links for the source-derived rules and
a representative XML location. Raw reports and complete finding locations are
also saved in `test-results/reports/` and `test-results/example-results/`.

The release tree's XML examples and QRD test-protocol examples are included.
Unrelated stylesheets, schema build files and background international examples
are excluded. Existing historical PHMR/QFDD examples remain included. Archived
APD examples whose original release is unsupported are identified as comparisons
against the supported APD release; their results do not claim original-release
validation. Identical files at different published URLs share a result and retain
all source URLs in the catalogue. Numbers in PMR/PSCR/QRD example filenames do
not select a profile version: the guide and document declaration do.

```bash
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
bash cda-validator/tests/run-container-tests.sh
python3 scripts/example_report.py
```

The Docker run writes `test-results/example-validation-report.md`, which CI
uploads with the validation artifacts. The final command regenerates the checked-in
`docs/example-validation-report.md` from that run. The report lists unexecuted
examples explicitly and exits unsuccessfully if any result is missing; it checks
input hashes before using saved results. Never update regression expectations
merely because a new run differs: review the new rule and its cited source first.
