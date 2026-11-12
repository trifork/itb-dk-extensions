# QFDD-DK and QRD-DK conformance Schematrons

These ISO Schematrons use XPath/XSLT 2.0 and target **QFDD-DK 1.2** and
**QRD-DK 1.3.2**. They supplement the existing XSD, shared Schematrons and
Gazelle validation. They do not establish complete MedCom certification.

- [QFDD-DK 1.2](../cda-validator/domain/cda-dk/sch/versions/qfdd-v1.2-conformance.sch): header,
  document and section structure; all five question patterns; help, options,
  feedback, copyright, media, reference ranges, preconditions and six groupers.
- [QRD-DK 1.3.2](../cda-validator/domain/cda-dk/sch/versions/qrd-v1.3.2-conformance.sch): header,
  optional participants, updated author/SOR metadata, sections, all five response
  patterns, inherited QFDD templates, and external QFDD references.
- [Paired QRD/QFDD checks](../cda-validator/domain/cda-dk/sch/versions/qrd-qfdd-pair-conformance.sch):
  response/question identifiers, question codes, selected coded options, copied
  option limits, selection counts, media and referenced QFDD identity.

The first two files are registered for their respective releases in
`cda-validator/domain/cda-dk/config.properties` and `cda-validator/domain/cda-dk/rulesets.json`. The paired file is
**not** a release of its own. The QRD-DK 1.3.2 route applies it inside the plugin
(`QrdQfddPairRules`): it resolves the QFDD the QRD references, builds the envelope
below and merges the findings into the normal report. See [Paired input](#paired-input).

## Sources and traceability

The [source manifest](pro-conformance/sources.json) records download URLs,
SHA-256 hashes and the observed SVN revision. The documents are not republished:

- [QFDD-DK 1.2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf), 11 February 2022.
- [QRD-DK 1.3.2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf), 27 May 2025.
- [Sender test protocol](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Afsendelse.docx), 11 October 2024, especially section 3.4.
- [Receiver test protocol](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/DK-QRD_Testprotokol_Modtagelse.docx), for presentation and workflow requirements.
- Both profile-specific narrative guides and the
  [link-resolving guide 1.1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QFDD-QRD-link-resolving-v1.1.pdf).

Each assertion has a stable ID, source URL (`see`), section/page reference and
diagnostic. `C123` means `CONF:123`; `DK25` means `CONF-DK:25`. Combined IDs
represent related clauses. `SHARED` and `COPY` identify QFDD requirements imported
by QRD section 1.6.1. Unnumbered requirements use descriptive IDs.

The [rule inventory](pro-conformance/rules.json) contains every assertion,
context, expression, severity, diagnostic and source URL. Maintain the `.sch`
files directly and regenerate the inventory after editing:

```sh
python3 scripts/conformance-rule-inventory.py
python3 scripts/conformance-rule-inventory.py --check
```

These are reviewed extractions, not a claim that every sentence is executable.
Danish profile requirements take precedence over the international base guides.
QFDD 1.1 is also published; these additions target 1.2 and are not applied to 1.1.

## Interpretations and conflicts

These decisions are explicit so they can be reviewed with MedCom.

| Source | Interpretation |
|---|---|
| QFDD 2.2 CONF-DK:1 and CONF-DK:3 | Prose has erroneous header-template and LOINC OIDs. Use `1.2.208.184.12.1` and `2.16.840.1.113883.6.1`, consistent with the template definitions, examples and existing validator. |
| Template cardinalities | Count the specified root, not all template IDs. Sliders intentionally declare both base and derived templates. |
| QFDD 2.2.2 CONF-DK:5 vs CONF:30 and CONF-DK:6 | Exactly one assigned person conflicts with an optional person and the explicit organisation-only case. Do not add an unconditional person requirement. Check names when present and the organisation-only `NA` identifier. |
| QFDD 3.1/4.2; QRD 3.1 | The document-level list appears to require several different sections per component, but the section chapters make copyright/information sections optional. Require a structured body, components and one section per component; do not require copyright. |
| QFDD 4.1/4.3 | Information-only and question sections share `...32.2.1`. No-entry sections are treated as information-only; sections with entries get question-entry checks. No replacement template ID is invented. |
| QRD 4.2 | Information-only uses `...32.2.1`, corrected in 1.3.1, and contains no entries. Response sections use `...33.2.1` and require entries. |
| Media value cardinality | Tables say `0..1`, but numbered prose says exactly one. Use the explicit numbered `1..1` requirement. |
| QFDD 5.12 | Prose still prints the feedback template ID and `@originalText`; revision history/table/appendix identify text-question template `...32.4.9`, and CDA defines `originalText` as an element. Use those corrected forms. |
| Entry relationships | Help, options, media and feedback are separate relationship slices. Optional help does not become mandatory, and media is not required to simultaneously contain feedback. Present recognised slices get their mandatory type/child checks. Unknown extension slices are not globally prohibited by these open templates. |
| QRD 2.2.1 telecom | “at least one [1..1]” conflicts with two telecoms in the example. Enforce the common minimum, without inventing a maximum. |
| QRD 2.2.11 | Introductory prose conflicts with numbered requirements. Follow the numbered requirements and example: first event declares the profile; second holds the answering interval. |
| QRD 1.3.2 author | Follow updated normative 2.2.2, even where older examples omit the represented organisation. Use lowercase `self`/`guardian` from the guide; the older Word protocol uses `Self`. Actual roles require external evidence. |
| QRD numeric/text answers | Value is `0..1`, explicitly corrected in 1.3.1. Multiple choice permits no values; discrete slider explicitly requires one. |
| QRD 5.9 | The table fixes external-reference root `2.16.840.1.113883.4.873`; 5.9.1 requires a version 4 UUID extension. The referenced QFDD's own root identifies its responsible organisation and need not equal this root. |
| Paired: mandatory answers | QFDD 5.7 and QRD 5.5 state the *minimum number of choices a user should select*. A multiple-choice or discrete-slider question with minimum ≥ 1 whose preconditions hold needs an answer with at least that many options. Numeric, text and analog-slider questions have no minimum in QFDD 1.2, so an unanswered one is never an error. |
| Paired: preconditions | QFDD 5.4: a question is asked only if all its preconditions hold; section 6 adds the groupers. `PRO-PAIR-PRECONDITION` reports an answer with a value to a question whose preconditions evaluate to false. Evaluation supports coded (CE) and `IVL_INT` criteria, the six groupers and `negationInd`. Anything else, an unknown referenced question or an unrecognised grouper gives warning `PRO-PAIR-PRECONDITION-UNEVALUATED`, and the dependent checks are skipped for that question. |
| Paired: criterion matching | A criterion names a question by `code/@code` only. The official associated-text example uses a different code system in the criterion than on the question, so the code system is not compared. A coded criterion value also compares its code system when the criterion states one. A criterion on an unanswered question is false. |
| Paired: answered twice | QRD 5.9 and the test protocol identify one question per response id, and the answer value cardinality is 0..1 or fixed. Two responses with the same id are therefore reported (`PRO-PAIR-ANSWER-DUPLICATE`). This is an interpretation, not an explicit SHALL. |
| Paired: slider scale | QFDD 5.13 defines the analog slider scale as `head`, step `increment` and end `denominator`. An answer must lie between `head` and `denominator` and on a step. The copied range in the QRD must equal the QFDD range (QRD 5.3). QFDD 1.2 defines no unit on numeric questions, so units are not compared. |

SHALL violations are errors; SHOULD cardinality violations are warnings.
“SHOULD contain zero or one” does not justify warning when absent. MAY
cardinalities constrain supplied elements. Optional unbounded elements do not
produce vacuous assertions. Datatypes resolve XML QNames, including aliases.

Each assertion has its own pattern, preventing Schematron's first-matching-rule
behavior from silently skipping constraints with overlapping contexts.

## Remaining requirements and limits

| Requirement family | Coverage / remaining work |
|---|---|
| Global identifiers, CPR/SOR and responsible organisation | Structure only. Required attributes and UUID/OID syntax are checked where specified. Registry existence, ownership and global uniqueness need external evidence. |
| Language and binding-realm value sets | Cardinality is covered; authoritative vocabulary membership is not. Example lists are not complete value sets. |
| Identity, guardian status, requester and actual times | XML structure and conditional SELF coding are checked. Truthfulness needs source-system or registry evidence. |
| Referenced general CDA header/narrative guides | Existing XSD/Gazelle/shared validation remains. Secondary guides have not been completely re-audited here. |
| Preconditions/groupers | Templates and required children are checked, and question preconditions are evaluated against the answers (see Paired input). Feedback activation (criteria on feedback observations) is not evaluated. Unspecified conjunction-code values are not invented. |
| Numeric/slider ranges and units | Analog slider answers are compared with the QFDD scale. Other numeric ranges, units (QFDD 1.2 defines none) and clinical plausibility are not compared. |
| Word protocol comparisons | The paired file covers the comparisons listed above. Complete preservation of information sections, conditional questions, all media and narrative answer options still needs additional checks or review. |
| Narrative guides | Profile package tables mark these informative. Narrative text presence is checked; example HTML/table layouts and semantic text equivalence are not promoted to mandatory errors. |
| Receiver protocol | Rendering, fallback for unknown/invalid releases, browser display, interaction and workflows need UI/integration tests. |
| Sender protocol XML 1.0 / UTF-8 | These concern original bytes/declarations. XPath over an already parsed XML tree cannot reliably enforce the original encoding. |
| National questionnaire bank/link resolving | Local references and supplied pairs are checkable. The QRD route resolves references through a mock registry limited to the bundled sample QFDDs; national publication and retrieval need external integration. Validation never fetches arbitrary URLs. |
| XDS authorInstitution | CDA fields are checked; comparison with submitted XDS metadata and consent behavior needs an XDS transaction fixture. |
| Certification | Passing these checks is not proof of full conformance. Conflicts above remain candidates for clarification with MedCom. |

## Paired input

Validate each CDA separately first. Then apply the paired Schematron to this
envelope. The `pro` namespace is a repository integration format, not MedCom CDA:

```xml
<pro:documents xmlns:pro="urn:dk:medcom:pro:validation">
  <pro:qfdd>
    <ClinicalDocument xmlns="urn:hl7-org:v3">...</ClinicalDocument>
  </pro:qfdd>
  <pro:qrd>
    <ClinicalDocument xmlns="urn:hl7-org:v3">...</ClinicalDocument>
  </pro:qrd>
</pro:documents>
```

The paired schema supplements individual checks. Unanswered optional questions
remain legal.

### In the QRD route

Every `qrd.v1.3.2` validation also compares the QRD with its QFDD. The plugin takes
the reference from `externalDocument/id` (root `2.16.840.1.113883.4.873`, QRD 5.9),
asks a `QfddResolver` for the document and applies the paired Schematron to the
envelope. Findings carry the `PRO-PAIR-*` rule IDs and the line of the answer.

| Situation | Result |
| --- | --- |
| QFDD resolved, answers consistent | INFO `PRO-PAIR-QFDD` names the compared QFDD; no other finding. |
| QFDD resolved, inconsistency | ERROR with the failing `PRO-PAIR-*` ID on the answer element. |
| No reference, several different references, QFDD not found, ambiguous or unavailable | WARNING `PRO-PAIR-QFDD-UNRESOLVED` ("could not be validated against its QFDD"). Never a silent pass. |
| Comparison could not run (for example an unparsable QFDD) | ERROR `PRO-PAIR-ENGINE`. |

**Mock registry.** No QFDD registry exists yet. `MockQfddResolver` serves the QFDDs
bundled in the plugin under `qfdd-mock/<id>.xml`: byte-identical copies of
`samples/qfdd`, enforced by `MockQfddResolverTest`. A QRD that references any other
QFDD is reported as unresolved. A real registry only has to implement
`QfddResolver`; the resolver never fetches caller-supplied URLs.

### Consistency checks

| Rule | Checks |
| --- | --- |
| `PRO-PAIR-QUESTION-ID`, `-QUESTION-CODE` | Each response identifies exactly one QFDD question and repeats its code. |
| `PRO-PAIR-ANSWER-TYPE` | The response pattern matches the question pattern (numeric, multiple choice, text, analog slider, discrete slider). |
| `PRO-PAIR-ANSWER-OPTION`, `-ANSWER-COUNT`, `-OPTION-LIMITS` | Selected options exist, their number is within the limits, and the limits are copied. |
| `PRO-PAIR-ANSWER-MISSING` | A question with minimum options ≥ 1 whose preconditions hold has an answer with enough options. Reported at the QRD response organizer. |
| `PRO-PAIR-ANSWER-DUPLICATE` | No question is answered twice. |
| `PRO-PAIR-ANSWER-RANGE`, `-REFERENCE-RANGE` | Analog slider answers lie on the QFDD scale and the copied range equals the QFDD's. |
| `PRO-PAIR-PRECONDITION`, `-PRECONDITION-UNEVALUATED` | An answer to a question that should not have been asked is an error; preconditions that cannot be evaluated are a warning. |
| `PRO-PAIR-QFDD-REFERENCE`, `-QFDD-VERSION`, `-MEDIA` | The reference, a stated version and the copied media match the QFDD. |

Published examples are not exempt: `qrd_multiple_choice_grouped.xml` answers five
multiple-choice questions with the Discrete Slider pattern (five `PRO-PAIR-ANSWER-TYPE`
findings), and the associated answer in `qrd_associated_text_*.xml` carries the QFDD
feedback template `32.4.6` instead of `33.4.6`, so it is not recognised as an answer.

Still not compared: feedback activation, preservation of information sections and
conditional narrative, and terminology membership of answer codes.

## Verification

```sh
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
python3 scripts/conformance-rule-inventory.py --check
python3 tests/check-rulesets.py
bash cda-validator/tests/run-container-tests.sh
```

Tests compile the actual schemas with the ISO XSLT2 Schematron compiler and run
SVRL against synthetic fixtures and targeted mutations in [cda-validator/src/test/resources/pro](../cda-validator/src/test/resources/pro).
They cover inheritance, missing/duplicate structures, optional answers, datatype
namespaces, UUIDs, author metadata and pairs. Findings must have XML locations.
These fixtures test the new schemas; they are not claims that every synthetic
fixture also passes the separate CDA XSD.

Official sample bytes are preserved. Additional findings are recorded in their
expectations after reviewing the reasons against the source clauses.
