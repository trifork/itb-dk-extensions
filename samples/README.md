# MedCom CDA examples

All imported CDA examples are mapped to explicit targets in [validation-cases.json](validation-cases.json). The [all-example Markdown report](../docs/example-validation-report.md) records actual findings, while [coverage notes](../docs/cda-conformance.md) distinguish incomplete rules and source conflicts. Newly imported APD, CPD, PDC, PHMR, PHAD, PMR, PRF and PSCR files retain their published names (with folder prefixes where needed) and original bytes. `publishedSources` records aliases when identical bytes appear at several URLs. Archived APD files are labelled as migration comparisons.

## QRD and QFDD examples

These XML documents are copied byte-for-byte from the MedCom release folders:

- [QFDD examples](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/)
- [QRD examples](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/)
- [QRD test-protocol examples](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/)

The repository already contained `qfdd/qfdd_example.xml` and `qrd/qrd_numeric.xml`;
those were identical to the published files and are reused. Filenames below are
local descriptive names; the source links and SHA-256 hashes in
[validation-cases.json](validation-cases.json) identify the original bytes.

The folders publish documentation, schemas and examples, but no Schematron files.
Numbers such as `1.1`, `2.0` and `3.19` in example filenames identify examples or
test-protocol steps, not additional CDA profile releases. These examples use the
existing `qfdd.v1.2` and `qrd.v1.3.2` validation targets.

## Using the examples

Upload a file in the matching QFDD-DK 1.2 or QRD-DK 1.3.2 ITB test, or use
the validator upload form at <http://localhost:8091/cda-dk/upload>. To run all
repository samples with their recorded expected outcomes:

```bash
./run-samples.sh --check-versions
```

The same samples run in Docker validation CI and appear individually in its
summary. They are not all valid documents: published examples and deliberate
negative test cases retain their original content. Expected failures are recorded
explicitly in the manifest; they count as passing regression tests when the
expected findings are observed. Validation targets still have partial coverage.

## Recorded validation findings

- All nine QFDD examples have the existing `sdtc:statusCode` discrepancy between
  the shared SVN XSD and Gazelle's packaged schema: one expected XSD error each.
- All ten QRD question-pattern examples omit `qrd-v1.3`, so the selected QRD-DK
  1.3.2 target reports a version error. Numeric graphics and analog-slider examples
  also have schema errors for `observation/reference` ordering; both XSD stages
  report those findings.
- `qrd_m_3.19.xml` declares `qrd-v9.9` and is an explicit negative version test.
- The expanded specification checks find additional errors in all 24 PRO samples,
  including the other four QRD test-protocol documents. Examples include omitted
  1.3.2 author metadata, missing observation status codes, outdated section/template
  codes, and missing or incorrect external references. The original XML remains
  unchanged. Exact counts and expected assertion IDs are in the manifest; the
  [audited findings](../docs/pro-conformance/sample-findings.json) include locations.
  See [source interpretations](../docs/pro-conformance.md) for the normative basis.

These results were checked with the pinned validator image and the plugin built
from source. No source XML was modified to make it pass.

## Files

| Local file | Published example | Source |
| --- | --- | --- |
| [qfdd/qfdd_example.xml](qfdd/qfdd_example.xml) | Example: Multiple Choice Question Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/0397c59c-a93f-470a-b8ff-2bc5c5f42b13) |
| [qfdd/qfdd_text.xml](qfdd/qfdd_text.xml) | Example: Text Question Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/1251f3c7-07d6-4d7d-aa89-cf33cb5cdb9f) |
| [qfdd/qfdd_numeric_graphics.xml](qfdd/qfdd_numeric_graphics.xml) | Example: Numeric Question Pattern Observation, Graphics [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/1fdb7308-f4fb-4eb1-af62-c8a429915dc1) |
| [qfdd/qfdd_numeric.xml](qfdd/qfdd_numeric.xml) | Example: Numeric Question Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/20ee1a5c-d574-4c04-b315-24e644cef53a) |
| [qfdd/qfdd_associated_text.xml](qfdd/qfdd_associated_text.xml) | Example: Associatedtext question embedded in a Multiple Choice Question[Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/2c8f8bd7-059d-410d-aed9-afe37ce389ed) |
| [qfdd/qfdd_discrete_slider.xml](qfdd/qfdd_discrete_slider.xml) | Example: Discrete Slider Question [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/391bb19d-6ccd-4a3d-a3df-ea4ec58155cc) |
| [qfdd/qfdd_multiple_choice_grouped.xml](qfdd/qfdd_multiple_choice_grouped.xml) | Example: Multiple Choice Question Pattern Observation, grouped [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/3aa7cec1-2718-47a5-8161-767e87c28a35) |
| [qfdd/qfdd_analog_slider_feedback.xml](qfdd/qfdd_analog_slider_feedback.xml) | Example: Analog Slider Question Pattern Observation, Question Feedback Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/a8aea6f4-d4ab-4926-8328-f92e0b91d68e) |
| [qfdd/qfdd_analog_slider.xml](qfdd/qfdd_analog_slider.xml) | Example: Analog Slider Question Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/b178eac3-f194-4b53-aaab-78807db7ed42) |
| [qrd/qrd_numeric.xml](qrd/qrd_numeric.xml) | Example: Numeric Response Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_1.0_Numeric_Question.xml) |
| [qrd/qrd_numeric_graphics.xml](qrd/qrd_numeric_graphics.xml) | Example: Numeric Response Pattern Observation, Graphics [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_1.1_Numeric_Question_-_Graphics.xml) |
| [qrd/qrd_multiple_choice.xml](qrd/qrd_multiple_choice.xml) | Example: Multiple Choice Response Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_2.0_Multiple_Choise_Question.xml) |
| [qrd/qrd_multiple_choice_grouped.xml](qrd/qrd_multiple_choice_grouped.xml) | Example: Multiple Choice Response Pattern Observation, grouped [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_2.1_Multiple_Choise_Question_-_Grouped.xml) |
| [qrd/qrd_text.xml](qrd/qrd_text.xml) | Example: Text Response Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.0_Text_Question.xml) |
| [qrd/qrd_associated_text_1.xml](qrd/qrd_associated_text_1.xml) | Example: Associatedtext question embedded in a Multiple Choice Question[Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.1.1_Text_Question_-_Associated%20Text%20Question.xml) |
| [qrd/qrd_associated_text_2.xml](qrd/qrd_associated_text_2.xml) | Example: Associatedtext question embedded in a Multiple Choice Question[Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.1.2_Text_Question_-_Associated%20Text%20Question.xml) |
| [qrd/qrd_analog_slider.xml](qrd/qrd_analog_slider.xml) | Example: Analog Slider Response Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_4.0_Analog_Slider_Question.xml) |
| [qrd/qrd_analog_slider_feedback.xml](qrd/qrd_analog_slider_feedback.xml) | Example: Analog Slider Response Pattern Observation, Question Feedback Pattern Observation [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_4.1_Analog_Slider_Question_-_Question%20Feedback%20Pattern%20Observation.xml) |
| [qrd/qrd_discrete_slider.xml](qrd/qrd_discrete_slider.xml) | Example: Discrete Slider Response [Header title] | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_5.0_Discrete_Slider_Question.xml) |
| [qrd/qrd_m_3.19.xml](qrd/qrd_m_3.19.xml) | MedCom test eksempel, teststep 3.1 | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.19.xml) |
| [qrd/qrd_m_3.1_a.xml](qrd/qrd_m_3.1_a.xml) | MedCom test eksempel, teststep 3.1 | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.1_A.xml) |
| [qrd/qrd_m_3.22_a.xml](qrd/qrd_m_3.22_a.xml) | MedCom test eksempel, teststep 3.9 | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.22_A.xml) |
| [qrd/qrd_m_3.9_a.xml](qrd/qrd_m_3.9_a.xml) | MedCom test eksempel, teststep 3.9 | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.9_A.xml) |
| [qrd/qrd_m_3.9_b.xml](qrd/qrd_m_3.9_b.xml) | MedCom test eksempel, teststep 3.9 | [MedCom](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.9_B.xml) |
