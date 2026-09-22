# MedCom CDA example validation report

This report records actual XSD, Schematron and Gazelle results from the pinned XML validator image. Official XML bytes are unchanged. File hashes and source URLs are recorded in the [example catalogue](../samples/validation-cases.json).

**Interpretation:** FAILURE means the example has reported validation errors; it does not mean the regression test failed. SUCCESS means no errors were found by the implemented checks. Coverage is partial. Counts are findings, not independent specification clauses or a percentage of conformance: inherited validators may report the same underlying defect more than once.

See [coverage and specification conflicts](cda-conformance.md) and [QRD/QFDD coverage](pro-conformance.md). Ambiguous clauses that are deliberately not enforced are coverage gaps, not silent evidence of conformity.

Examples executed: **111 / 111**. Official source URLs indexed: **116**. Identical published bytes can share one validation result. Archived APD examples without a supported original release are explicitly labelled as migration comparisons below.

| Profile | Examples | No errors | With errors | Errors | Warnings |
| --- | ---: | ---: | ---: | ---: | ---: |
| APD-DK 2.0.1 | 25 | 5 | 20 | 87 | 0 |
| CPD-DK 2.0.0 | 3 | 0 | 3 | 43 | 14 |
| PDC-DK 2.0 | 9 | 0 | 9 | 48 | 0 |
| PDC-DK 3.0.0 | 5 | 0 | 5 | 12 | 0 |
| PHAD-DK 1.0.1 | 3 | 0 | 3 | 7 | 0 |
| PHMR-DK 1.3 | 1 | 0 | 1 | 1 | 0 |
| PHMR-DK 2.1.0 | 13 | 11 | 2 | 2 | 0 |
| PMR-DK 2.0.0 | 12 | 11 | 1 | 2 | 0 |
| PRF-DK 3.0.0 | 4 | 4 | 0 | 0 | 0 |
| PSCR-DK 2.0.0 | 12 | 11 | 1 | 4 | 0 |
| QFDD-DK 1.2 | 9 | 0 | 9 | 40 | 0 |
| QRD-DK 1.3.2 | 15 | 0 | 15 | 305 | 0 |

Run interval (UTC): 2026-09-15T17:29:32.100416+00:00 to 2026-09-15T17:32:34.063333+00:00.

Deployed resource bundle SHA-256: `0fa1da52d51485fbe78e7b1168901d1a38168235407199819fc8d845bb2f36c8`.

```text
Reference: isaitb/xml-validator:1.12.4@sha256:ac2a33077b6f5595db0991f17f13df0efd40cbeda12703d2cc1b8a96769e8b75
Image: sha256:737094f497281efb3494a62ee06a0e4f78cc319a2db0d9581b68f9f2f3ab45ed OS/architecture: linux/amd64 Digests: ["isaitb/xml-validator@sha256:ac2a33077b6f5595db0991f17f13df0efd40cbeda12703d2cc1b8a96769e8b75"]
```

## APD-DK 2.0.1

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [apd_invalid.xml](../samples/apd/apd_invalid.xml) | FAILURE | 7 | 0 | 7 |
| [apd_minimum.xml](../samples/apd/apd_minimum.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_10_apd_municipality_morning_sbj.xml](../samples/apd/2.0_DK-APD_Example_1_10_apd_municipality_morning_sbj.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_12_apd_region_days.xml](../samples/apd/2.0_DK-APD_Example_1_12_apd_region_days.xml) | SUCCESS | 0 | 0 | 0 |
| [2.0_DK-APD_Example_1_17_apd_with_co_author_and_extra_data.xml](../samples/apd/2.0_DK-APD_Example_1_17_apd_with_co_author_and_extra_data.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_18_apd_overlappende.xml](../samples/apd/2.0_DK-APD_Example_1_18_apd_overlappende.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_19_apd_historisk.xml](../samples/apd/2.0_DK-APD_Example_1_19_apd_historisk.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_20_apd_week53.xml](../samples/apd/2.0_DK-APD_Example_1_20_apd_week53.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_21_apd_no_author_address.xml](../samples/apd/2.0_DK-APD_Example_1_21_apd_no_author_address.xml) | SUCCESS | 0 | 0 | 0 |
| [2.0_DK-APD_Example_1_2_apd_maximum.xml](../samples/apd/2.0_DK-APD_Example_1_2_apd_maximum.xml) | FAILURE | 2 | 0 | 2 |
| [2.0_DK-APD_Example_1_4_apd_municipality_a.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_a.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_4_apd_municipality_b.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_b.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_4_apd_municipality_c.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_c.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_4_apd_municipality_d.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_d.xml) | FAILURE | 3 | 0 | 3 |
| [2.0_DK-APD_Example_1_4_apd_municipality_e.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_e.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_4_apd_municipality_f.xml](../samples/apd/2.0_DK-APD_Example_1_4_apd_municipality_f.xml) | FAILURE | 1 | 0 | 1 |
| [2.0_DK-APD_Example_1_5_apd_region.xml](../samples/apd/2.0_DK-APD_Example_1_5_apd_region.xml) | SUCCESS | 0 | 0 | 0 |
| [2.0_DK-APD_Example_1_6_apd_gp.xml](../samples/apd/2.0_DK-APD_Example_1_6_apd_gp.xml) | SUCCESS | 0 | 0 | 0 |
| [2.0_DK-APD_Example_1_7_apd_gp_specialist_yder.xml](../samples/apd/2.0_DK-APD_Example_1_7_apd_gp_specialist_yder.xml) | FAILURE | 3 | 0 | 3 |
| [2.0_DK-APD_Example_1_8_apd_gp_citizen.xml](../samples/apd/2.0_DK-APD_Example_1_8_apd_gp_citizen.xml) | SUCCESS | 0 | 0 | 0 |
| [2.0_DK-APD_Example_1_9_apd_v11.xml](../samples/apd/2.0_DK-APD_Example_1_9_apd_v11.xml) | FAILURE | 9 | 0 | 9 |
| [Tidligere versioner_DK-APD_Example_1.xml](../samples/apd/Tidligere%20versioner_DK-APD_Example_1.xml) | FAILURE | 14 | 0 | 14 |
| [Tidligere versioner_DK-APD_Example_No_Time_Place.xml](../samples/apd/Tidligere%20versioner_DK-APD_Example_No_Time_Place.xml) | FAILURE | 10 | 0 | 10 |
| [Tidligere versioner_DK-APD_Example_apd-2-0.xml](../samples/apd/Tidligere%20versioner_DK-APD_Example_apd-2-0.xml) | FAILURE | 11 | 0 | 11 |
| [Tidligere versioner_DK-APD_Example_minimum.xml](../samples/apd/Tidligere%20versioner_DK-APD_Example_minimum.xml) | FAILURE | 17 | 0 | 17 |

### apd_invalid.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_16_apd_invalid.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.10']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.b: The content of element 'author' is not complete. One of '{"urn:hl7-org:v3":realmCode, "urn:hl7-org:v3":typeId, "urn:hl7-org:v3":templateId, "urn:hl7-org:v3":functionCode, "urn:hl7-org:v3":time}' is expected. | XML:78:27 |
| error | [APD-DK-2.0.1-40d4](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | A supplied requester author must identify a requester with REFB Source: errata items 1 and 11, CONF-DK-APD:40d4/47aa. | /ClinicalDocument[1]/author[2] |
| error | [APD-DK-2.0.1-69ee-5363](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-bf38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Performer requires one telecom Source: errata item 17, CONF-DK-APD:bf38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/performer[1]/assignedEntity[1] |
| error | [APD-DK-2.0.1-cd01](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Performer requires one addr Source: errata item 17, CONF-DK-APD:cd01. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/performer[1]/assignedEntity[1] |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.b: The content of element 'author' is not complete. One of '{"urn:hl7-org:v3":realmCode, "urn:hl7-org:v3":typeId, "urn:hl7-org:v3":templateId, "urn:hl7-org:v3":functionCode, "urn:hl7-org:v3":time}' is expected. | contentToValidate:78:27 |

### apd_minimum.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_1_apd_minimum.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_10_apd_municipality_morning_sbj.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_10_apd_municipality_morning_sbj.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_12_apd_region_days.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_12_apd_region_days.xml).

No errors or warnings from the implemented checks.

### 2.0_DK-APD_Example_1_17_apd_with_co_author_and_extra_data.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_17_apd_with_co_author_and_extra_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-61c6](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD requires a responsible author and permits one requester Source: errata item 10, CONF-DK-APD:61c6. | /ClinicalDocument[1] |

### 2.0_DK-APD_Example_1_18_apd_overlappende.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_18_apd_overlappende.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_19_apd_historisk.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_19_apd_historisk.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_20_apd_week53.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_20_apd_week53.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_21_apd_no_author_address.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_21_apd_no_author_address.xml).

No errors or warnings from the implemented checks.

### 2.0_DK-APD_Example_1_2_apd_maximum.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_2_apd_maximum.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-40d4](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | A supplied requester author must identify a requester with REFB Source: errata items 1 and 11, CONF-DK-APD:40d4/47aa. | /ClinicalDocument[1]/author[2] |
| error | [APD-DK-2.0.1-bf38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Performer requires one telecom Source: errata item 17, CONF-DK-APD:bf38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/performer[1]/assignedEntity[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_a.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_a.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_b.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_b.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_c.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_c.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_d.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_d.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-7e5c](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment high must agree Source: 2.1.10.1 CONF-DK-APD:7e5c. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/high[1] |
| error | [APD-DK-2.0.1-ad38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment low must agree Source: 2.1.10.1 CONF-DK-APD:ad38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/low[1] |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_e.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_e.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_4_apd_municipality_f.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_4_apd_municipality_f.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |

### 2.0_DK-APD_Example_1_5_apd_region.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_5_apd_region.xml).

No errors or warnings from the implemented checks.

### 2.0_DK-APD_Example_1_6_apd_gp.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_6_apd_gp.xml).

No errors or warnings from the implemented checks.

### 2.0_DK-APD_Example_1_7_apd_gp_specialist_yder.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_7_apd_gp_specialist_yder.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":id}'. One of '{"urn:hl7-org:v3":name, "urn:hl7-org:v3":telecom, "urn:hl7-org:v3":addr, "urn:hl7-org:v3":standardIndustryClassCode, "urn:hl7-org:v3":asOrganizationPartOf}' is expected. | XML:58:91 |
| error | [APD-DK-2.0.1-91ea-062f](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Location identifiers must identify SOR entries Source: 5.3 CONF-DK-APD:91ea/4862/062f. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/participant[1]/participantRole[1]/id[1] |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":id}'. One of '{"urn:hl7-org:v3":name, "urn:hl7-org:v3":telecom, "urn:hl7-org:v3":addr, "urn:hl7-org:v3":standardIndustryClassCode, "urn:hl7-org:v3":asOrganizationPartOf}' is expected. | contentToValidate:58:91 |

### 2.0_DK-APD_Example_1_8_apd_gp_citizen.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_8_apd_gp_citizen.xml).

No errors or warnings from the implemented checks.

### 2.0_DK-APD_Example_1_9_apd_v11.xml

**Comparison limitation:** Official APD 2.0 folder includes an example deliberately declaring apd-v1.1; expected release mismatch.

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/2.0/DK-APD_Example_1_9_apd_v11.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.14.11.1'][@extension = '2019-09-10']]] is required [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1] |
| error | (validator diagnostic) | 1 | (DKCDAdocumentationOfSDTC): element hl7:id[@root = '1.2.208.184.100.10'][@extension = 'apd-v2.0.1'] is mandatory [min 1x]. | /ClinicalDocument[1]/documentationOf[2]/serviceEvent[1] |
| error | [APD-DK-2.0.1-49d8-ad5b](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:49d8-ad5b. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1] |
| error | [APD-DK-2.0.1-9245](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Appointment category must use the published MedCom codes Source: 5.1 CONF-DK-APD:9245; errata item 5. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | [APD-DK-2.0.1-9b39-efbf](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:9b39-efbf. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-c362-7e02](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Reason observation must be OBS/EVN Source: 5.1 CONF-DK-APD:c362/7e02. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/entryRelationship[1]/observation[1] |
| error | [APD-DK-2.0.1-cce6-7df6](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:cce6-7df6. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/participant[1]/participantRole[1] |
| error | [APD-DK-2.0.1-ed37](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Appointment category must use the MedCom code system Source: 5.1 CONF-DK-APD:ed37. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67. | /ClinicalDocument[1] |

### Tidligere versioner_DK-APD_Example_1.xml

**Comparison limitation:** Archived APD example; historical release is not registered. Compared with APD-DK 2.0.1 for migration diagnostics, not claimed to validate its original release.

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/Tidligere%20versioner/DK-APD_Example_1.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.14.11.1'][@extension = '2019-09-10']]] is required [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.10']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.11']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-49d8-ad5b](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:49d8-ad5b. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1] |
| error | [APD-DK-2.0.1-69ee-5363](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-7e5c](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment high must agree Source: 2.1.10.1 CONF-DK-APD:7e5c. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/high[1] |
| error | [APD-DK-2.0.1-851d-37d2](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one time interval event Source: 2.1.10 CONF-DK-APD:851d-37d2. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-9245](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Appointment category must use the published MedCom codes Source: 5.1 CONF-DK-APD:9245; errata item 5. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | [APD-DK-2.0.1-9b39-efbf](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:9b39-efbf. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-ad38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment low must agree Source: 2.1.10.1 CONF-DK-APD:ad38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/low[1] |
| error | [APD-DK-2.0.1-c362-7e02](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Reason observation must be OBS/EVN Source: 5.1 CONF-DK-APD:c362/7e02. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/entryRelationship[1]/observation[1] |
| error | [APD-DK-2.0.1-cce6-7df6](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:cce6-7df6. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/participant[1]/participantRole[1] |
| error | [APD-DK-2.0.1-ed37](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Appointment category must use the MedCom code system Source: 5.1 CONF-DK-APD:ed37. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67. | /ClinicalDocument[1] |

### Tidligere versioner_DK-APD_Example_No_Time_Place.xml

**Comparison limitation:** Archived APD example; historical release is not registered. Compared with APD-DK 2.0.1 for migration diagnostics, not claimed to validate its original release.

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/Tidligere%20versioner/DK-APD_Example_No_Time_Place.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.14.11.1'][@extension = '2019-09-10']]] is required [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.10']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.11']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-69ee-5363](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-8506](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one entry Source: 3.1/4.1 CONF-DK-APD:8506. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-851d-37d2](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one time interval event Source: 2.1.10 CONF-DK-APD:851d-37d2. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-9b39-efbf](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:9b39-efbf. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-C14749](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD section requires one code Source: 4.1 CONF-DK-APD:d9f0; CONF:1098-7725/14749. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-d9f0](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD section requires one title Source: 4.1 CONF-DK-APD:d9f0; CONF:1098-7725/14749. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67. | /ClinicalDocument[1] |

### Tidligere versioner_DK-APD_Example_apd-2-0.xml

**Comparison limitation:** Archived APD example; historical release is not registered. Compared with APD-DK 2.0.1 for migration diagnostics, not claimed to validate its original release.

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/Tidligere%20versioner/DK-APD_Example_apd-2-0.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.10']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.11']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-69ee-5363](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-7e5c](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment high must agree Source: 2.1.10.1 CONF-DK-APD:7e5c. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/high[1] |
| error | [APD-DK-2.0.1-851d-37d2](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one time interval event Source: 2.1.10 CONF-DK-APD:851d-37d2. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-8cd7](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require addr Source: 2.1.2 and errata item 14, CONF-DK-APD:8cd7. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [APD-DK-2.0.1-CODE-4](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Precondition must use RepeatingDocumentType in the MedCom code system Source: 5.4/5.5 CONF-DK-APD:72b5/e3ff/2b78/ab85. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/precondition[2]/criterion[1] |
| error | [APD-DK-2.0.1-ad38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment low must agree Source: 2.1.10.1 CONF-DK-APD:ad38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/low[1] |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [APD-DK-2.0.1-cce6-7df6](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:cce6-7df6. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/participant[1]/participantRole[1] |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67. | /ClinicalDocument[1] |

### Tidligere versioner_DK-APD_Example_minimum.xml

**Comparison limitation:** Archived APD example; historical release is not registered. Compared with APD-DK 2.0.1 for migration diagnostics, not claimed to validate its original release.

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Eksempler/Tidligere%20versioner/DK-APD_Example_minimum.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.14.11.1'][@extension = '2019-09-10']]] is required [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.10']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | (validator diagnostic) | 1 | (AppointmentDocument): element hl7:documentationOf[hl7:serviceEvent[hl7:templateId[@root = '1.2.208.184.10.1.11']]] is mandatory [min 1x]. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-49d8-ad5b](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:49d8-ad5b. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1] |
| error | [APD-DK-2.0.1-69ee-5363](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one profile version event Source: 2.1.10 CONF-DK-APD:69ee-5363. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-7e5c](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment high must agree Source: 2.1.10.1 CONF-DK-APD:7e5c. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/high[1] |
| error | [APD-DK-2.0.1-851d-37d2](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD requires one time interval event Source: 2.1.10 CONF-DK-APD:851d-37d2. | /ClinicalDocument[1] |
| error | [APD-DK-2.0.1-8cd7](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require addr Source: 2.1.2 and errata item 14, CONF-DK-APD:8cd7. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [APD-DK-2.0.1-9245](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Appointment category must use the published MedCom codes Source: 5.1 CONF-DK-APD:9245; errata item 5. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | [APD-DK-2.0.1-9b39-efbf](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:9b39-efbf. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [APD-DK-2.0.1-ad38](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Body and header appointment low must agree Source: 2.1.10.1 CONF-DK-APD:ad38. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/effectiveTime[1]/low[1] |
| error | [APD-DK-2.0.1-b770](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | Performer requires one name Source: errata item 17, CONF-DK-APD:b770. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/performer[1]/assignedEntity[1]/representedOrganization[1] |
| error | [APD-DK-2.0.1-c362-7e02](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Reason observation must be OBS/EVN Source: 5.1 CONF-DK-APD:c362/7e02. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/entryRelationship[1]/observation[1] |
| error | [APD-DK-2.0.1-c79d](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/Errata_APD-DK-v2.0.1_2021_11_24.pdf) | 1 | APD authors require telecom Source: 2.1.2 and errata item 14, CONF-DK-APD:c79d. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [APD-DK-2.0.1-cce6-7df6](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | APD template must identify the 2019-09-10 release Source: 4.1/5.1/5.3.1 CONF-DK-APD:cce6-7df6. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/participant[1]/participantRole[1] |
| error | [APD-DK-2.0.1-ed37](https://svn.medcom.dk/svn/releases/Standarder/HL7/Appointment/Dokumentation/APD-DK-v2.0.1.pdf) | 1 | Appointment category must use the MedCom code system Source: 5.1 CONF-DK-APD:ed37. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/encounter[1]/code[1] |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target APD-DK 2.0.1 requires exactly one profile version declaration 'apd-v2.0.1' in documentationOf/serviceEvent/id. Source: 2.2.12, CONF-DK-APD:9f67. | /ClinicalDocument[1] |

## CPD-DK 2.0.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [cpd_kol.xml](../samples/cpd/cpd_kol.xml) | FAILURE | 11 | 5 | 8 |
| [CPD-DK_Ex_Version 2.0 Diabetes.xml](../samples/cpd/CPD-DK_Ex_Version%202.0%20Diabetes.xml) | FAILURE | 18 | 4 | 8 |
| [CPD-DK_Ex_Version 2.0 Hjerte.xml](../samples/cpd/CPD-DK_Ex_Version%202.0%20Hjerte.xml) | FAILURE | 14 | 5 | 8 |

### cpd_kol.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Eksempler/CPD-DK_Ex_Version%202.0%20KOL.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (HealthConcernSubSectionCDASection): choice (hl7:entry[hl7:observation[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.20'][@extension = '2018-09-28']]] or hl7:entry[hl7:act[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.21'][@extension = '2018-09-28']]]) does not contain enough elements [min 1x] | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/component[2]/section[1] |
| error | (validator diagnostic) | 1 | (InterventionsSection): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.15.1.10.20.3.2'][@extension = '2018-11-28']]] is mandatory [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | (validator diagnostic) | 1 | dtr1-1-BIN: there must be a nullFlavor, or content must be non-empty | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[3]/section[1]/component[1]/section[1]/title[1] |
| error | [CPD-DK-2.0.0-C241](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Health concerns needs a Health Status Observation or Health Concern Act Source: 4.1 CONF:241. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [CPD-DK-2.0.0-C36](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Goals section needs at least one entry Source: 4.2 CONF:36. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1] |
| error | [CPD-DK-2.0.0-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | CPD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[0]] |  |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[1]] |  |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[1]/section/entry[0]] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[0]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[3]/section/component[0]/section/title] |  |
| warning | (validator diagnostic) | 2 | (HealthConcernSubSectionCDASection): element hl7:code is coded with binding strength 'preferred' and contains a code other than the specified set. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/component[1]/section[1] |
| warning | [CPD-DK-2.0.0-C46](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Interventions section needs at least one entry Source: 4.3 CONF:46. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| warning | cdabasic-SectionSpec-rmim052 | 1 | WARNING : Potential error : Section.text SHALL be specified, as it is a required element (RMIM-052) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section] |  |
| warning | cdabasic-SectionSpec-rmim052 | 1 | WARNING : Potential error : Section.text SHALL be specified, as it is a required element (RMIM-052) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[1]/section] |  |

### CPD-DK_Ex_Version 2.0 Diabetes.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Eksempler/CPD-DK_Ex_Version%202.0%20Diabetes.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (HealthConcernSubSectionCDASection): choice (hl7:entry[hl7:observation[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.20'][@extension = '2018-09-28']]] or hl7:entry[hl7:act[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.21'][@extension = '2018-09-28']]]) does not contain enough elements [min 1x] | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/component[2]/section[1] |
| error | (validator diagnostic) | 1 | (InterventionsSection): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.15.1.10.20.3.2'][@extension = '2018-11-28']]] is mandatory [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | (validator diagnostic) | 5 | dtr1-1-BIN: there must be a nullFlavor, or content must be non-empty | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[3]/section[1]/component[1]/section[1]/title[1] |
| error | [CPD-DK-2.0.0-C241](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Health concerns needs a Health Status Observation or Health Concern Act Source: 4.1 CONF:241. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [CPD-DK-2.0.0-C36](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Goals section needs at least one entry Source: 4.2 CONF:36. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1] |
| error | [CPD-DK-2.0.0-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | CPD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[0]] |  |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[1]] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[0]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[1]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[2]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[3]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[4]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[3]/section/component[0]/section/title] |  |
| warning | (validator diagnostic) | 2 | (HealthConcernSubSectionCDASection): element hl7:code is coded with binding strength 'preferred' and contains a code other than the specified set. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/component[1]/section[1] |
| warning | [CPD-DK-2.0.0-C46](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Interventions section needs at least one entry Source: 4.3 CONF:46. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| warning | cdabasic-SectionSpec-rmim052 | 1 | WARNING : Potential error : Section.text SHALL be specified, as it is a required element (RMIM-052) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section] |  |

### CPD-DK_Ex_Version 2.0 Hjerte.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Eksempler/CPD-DK_Ex_Version%202.0%20Hjerte.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | (HealthConcernSubSectionCDASection): choice (hl7:entry[hl7:observation[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.20'][@extension = '2018-09-28']]] or hl7:entry[hl7:act[hl7:templateId[@root = '1.2.208.184.15.1.10.20.1.21'][@extension = '2018-09-28']]]) does not contain enough elements [min 1x] | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/component[3]/section[1] |
| error | (validator diagnostic) | 1 | (InterventionsSection): element hl7:component[hl7:section[hl7:templateId[@root = '1.2.208.184.15.1.10.20.3.2'][@extension = '2018-11-28']]] is mandatory [min 1x]. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | (validator diagnostic) | 2 | dtr1-1-BIN: there must be a nullFlavor, or content must be non-empty | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[3]/section[1]/component[1]/section[1]/title[1] |
| error | [CPD-DK-2.0.0-C241](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Health concerns needs a Health Status Observation or Health Concern Act Source: 4.1 CONF:241. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1] |
| error | [CPD-DK-2.0.0-C36](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Goals section needs at least one entry Source: 4.2 CONF:36. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1] |
| error | [CPD-DK-2.0.0-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | CPD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[0]] |  |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section/entry[1]] |  |
| error | cdabasic-EntrySpec-rmim066 | 1 | ERROR : This condition is not verified : When entry@typeCode=DRIV, the section containing the entry SHALL contain a text element (RMIM-066) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[1]/section/entry[0]] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[0]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[2]/section/component[1]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[3]/section/component[0]/section/title] |  |
| error | cdadt-EDSpec-cdadt023 | 1 | ERROR : This condition is not verified : In ED datatype, if it is not null, it SHALL have a binary string or reference element (CDADT-023) [at /ClinicalDocument/component/structuredBody/component[3]/section/component[1]/section/title] |  |
| warning | (validator diagnostic) | 2 | (HealthConcernSubSectionCDASection): element hl7:code is coded with binding strength 'preferred' and contains a code other than the specified set. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/component[1]/section[1] |
| warning | [CPD-DK-2.0.0-C46](https://svn.medcom.dk/svn/releases/Standarder/HL7/CPD/Dokumentation/CPD-DK.pdf) | 1 | Interventions section needs at least one entry Source: 4.3 CONF:46. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| warning | cdabasic-SectionSpec-rmim052 | 1 | WARNING : Potential error : Section.text SHALL be specified, as it is a required element (RMIM-052) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[0]/section] |  |
| warning | cdabasic-SectionSpec-rmim052 | 1 | WARNING : Potential error : Section.text SHALL be specified, as it is a required element (RMIM-052) [at /ClinicalDocument/component/structuredBody/component[1]/section/component[1]/section] |  |

## PDC-DK 2.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [pdc20_minimum.xml](../samples/pdc/pdc20_minimum.xml) | FAILURE | 6 | 0 | 6 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-maximum_data.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-maximum_data.xml) | FAILURE | 5 | 0 | 5 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-minimum_data.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-minimum_data.xml) | FAILURE | 5 | 0 | 5 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example_confidential_address.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example_confidential_address.xml) | FAILURE | 4 | 0 | 4 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.1_PDC20_Example_confidential_address.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1_PDC20_Example_confidential_address.xml) | FAILURE | 4 | 0 | 4 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data.xml) | FAILURE | 6 | 0 | 6 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data_differentNarrativeText.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data_differentNarrativeText.xml) | FAILURE | 6 | 0 | 6 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-minimum_data.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-minimum_data.xml) | FAILURE | 6 | 0 | 6 |
| [2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example_confidential_address.xml](../samples/pdc/2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example_confidential_address.xml) | FAILURE | 6 | 0 | 6 |

### pdc20_minimum.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.2/PDC20_Example-minimum_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C136](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/effectiveTime[1]/low[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-maximum_data.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.0/PDC20_Example-maximum_data.xml), [MedCom source 2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1/PDC20_Example-maximum_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example-minimum_data.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.0/PDC20_Example-minimum_data.xml), [MedCom source 2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1/PDC20_Example-minimum_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.0_PDC20_Example_confidential_address.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.0/PDC20_Example_confidential_address.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.1_PDC20_Example_confidential_address.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1/PDC20_Example_confidential_address.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.1/PDC20_Example-maximum_data.xml), [MedCom source 2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.2/PDC20_Example-maximum_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C136](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/effectiveTime[1]/low[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-maximum_data_differentNarrativeText.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.1/PDC20_Example-maximum_data_differentNarrativeText.xml), [MedCom source 2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.2/PDC20_Example-maximum_data_differentNarrativeText.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C136](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/effectiveTime[1]/low[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example-minimum_data.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.1/PDC20_Example-minimum_data.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C136](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/effectiveTime[1]/low[1] |

### 2.0_PDC-DK_2_0_Testprotokol_v1.1.1_PDC20_Example_confidential_address.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.1/PDC20_Example_confidential_address.xml), [MedCom source 2](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/2.0/PDC-DK_2_0_Testprotokol_v1.1.2/PDC20_Example_confidential_address.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | [PDC-DK-2.0-C114](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC author time must equal document creation time Source: 2.1.1 CONF-DK:114. | /ClinicalDocument[1]/author[1]/time[1] |
| error | [PDC-DK-2.0-C120-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C129-NAME](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/Errata_PDC-DK-v.2.0_2022-10-07.pdf) | 1 | PDC organisation name must be Sundhedsdatastyrelsen Source: 2.1.1/2.1.4 CONF-DK:120/129. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1]/representedCustodianOrganization[1]/name[1] |
| error | [PDC-DK-2.0-C136](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v2.0.pdf) | 1 | PDC service start must equal document creation time Source: 2.1.9 CONF-DK:136. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/effectiveTime[1]/low[1] |

## PDC-DK 3.0.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Dokumentation/PDC-DK-v3.0.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [pdc30_minimum.xml](../samples/pdc/pdc30_minimum.xml) | FAILURE | 2 | 0 | 2 |
| [3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel-forskellig-narrativ.xml](../samples/pdc/3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel-forskellig-narrativ.xml) | FAILURE | 2 | 0 | 2 |
| [3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel.xml](../samples/pdc/3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel.xml) | FAILURE | 2 | 0 | 2 |
| [3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_navne-og-adressebeskyttelse.xml](../samples/pdc/3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_navne-og-adressebeskyttelse.xml) | FAILURE | 2 | 0 | 2 |
| [3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_nullFlavor-ved-FGVH.xml](../samples/pdc/3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_nullFlavor-ved-FGVH.xml) | FAILURE | 4 | 0 | 4 |

### pdc30_minimum.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/3.0/PDC-DK_3_0_Testprotokol_v1.0.0/PDC-DK_Eks_minimalt-eksempel.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |

### 3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel-forskellig-narrativ.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/3.0/PDC-DK_3_0_Testprotokol_v1.0.0/PDC-DK_Eks_maksimalt-eksempel-forskellig-narrativ.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |

### 3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_maksimalt-eksempel.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/3.0/PDC-DK_3_0_Testprotokol_v1.0.0/PDC-DK_Eks_maksimalt-eksempel.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |

### 3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_navne-og-adressebeskyttelse.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/3.0/PDC-DK_3_0_Testprotokol_v1.0.0/PDC-DK_Eks_navne-og-adressebeskyttelse.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |

### 3.0_PDC-DK_3_0_Testprotokol_v1.0.0_PDC-DK_Eks_nullFlavor-ved-FGVH.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PDC/Eksempler/3.0/PDC-DK_3_0_Testprotokol_v1.0.0/PDC-DK_Eks_nullFlavor-ved-FGVH.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAauthor): element hl7:assignedAuthor[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/author[1] |
| error | (validator diagnostic) | 1 | KNOWN INHERITED-RULE CONFLICT: this legacy check expects the old placeholder identifier; the guide/errata requires the SOR identifier. (PDC-DK-CDAcustodian): element hl7:representedCustodianOrganization[hl7:id[@root = '1.2.208.176'][@extension = 'NI']] is required [min 1x]. | /ClinicalDocument[1]/custodian[1]/assignedCustodian[1] |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.d: Invalid content was found starting with element 'providerOrganization'. No child element is expected at this point. | XML:33:25 |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.d: Invalid content was found starting with element 'providerOrganization'. No child element is expected at this point. | contentToValidate:33:25 |

## PHAD-DK 1.0.1

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [PHAD-DK-Ex_v1.0 Grete Bruun Svendsen Udskrivningsaftale.xml](../samples/phad/PHAD-DK-Ex_v1.0%20Grete%20Bruun%20Svendsen%20Udskrivningsaftale.xml) | FAILURE | 1 | 0 | 1 |
| [PHAD-DK_Ex_v1.0 Grete Bruun Svendsen Netværksmøde.xml](../samples/phad/PHAD-DK_Ex_v1.0%20Grete%20Bruun%20Svendsen%20Netv%C3%A6rksm%C3%B8de.xml) | FAILURE | 3 | 0 | 3 |
| [PHAD-DK_Ex_v1.0 Rasmus Test Lauridsen Netværksmøde.xml](../samples/phad/PHAD-DK_Ex_v1.0%20Rasmus%20Test%20Lauridsen%20Netv%C3%A6rksm%C3%B8de.xml) | FAILURE | 3 | 0 | 3 |

### PHAD-DK-Ex_v1.0 Grete Bruun Svendsen Udskrivningsaftale.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Eksempler/PHAD-DK-Ex_v1.0%20Grete%20Bruun%20Svendsen%20Udskrivningsaftale.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [PHAD-DK-1.0.1-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) | 1 | PHAD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |

### PHAD-DK_Ex_v1.0 Grete Bruun Svendsen Netværksmøde.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Eksempler/PHAD-DK_Ex_v1.0%20Grete%20Bruun%20Svendsen%20Netv%c3%a6rksm%c3%b8de.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-TEMPLATE | 1 | Selected target PHAD-DK 1.0.1 requires document template 1.2.208.184.22.1. Source: 2.1.1 / 3.1. | /ClinicalDocument[1] |
| error | [PHAD-DK-1.0.1-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) | 1 | PHAD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |
| error | [PHAD-DK-1.0.1-TEMPLATE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) | 1 | Require one declaration of template 1.2.208.184.22.1 Source: 2.1.1; 3.1 CONF:2 (template extension conflicting with revision history). | /ClinicalDocument[1] |

### PHAD-DK_Ex_v1.0 Rasmus Test Lauridsen Netværksmøde.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Eksempler/PHAD-DK_Ex_v1.0%20Rasmus%20Test%20Lauridsen%20Netv%c3%a6rksm%c3%b8de.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-TEMPLATE | 1 | Selected target PHAD-DK 1.0.1 requires document template 1.2.208.184.22.1. Source: 2.1.1 / 3.1. | /ClinicalDocument[1] |
| error | [PHAD-DK-1.0.1-H3](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) | 1 | PHAD requires one validity interval event Source: 2.1.5 CONF H3. | /ClinicalDocument[1] |
| error | [PHAD-DK-1.0.1-TEMPLATE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHAD/Dokumentation/PHAD-DK.pdf) | 1 | Require one declaration of template 1.2.208.184.22.1 Source: 2.1.1; 3.1 CONF:2 (template extension conflicting with revision history). | /ClinicalDocument[1] |

## PHMR-DK 1.3

[Specification](https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [phmr_v1_3_weight.xml](../samples/phmr/phmr_v1_3_weight.xml) | FAILURE | 1 | 0 | 1 |

### phmr_v1_3_weight.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Eksempler/Ex1-Weight_measurement.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [PHMR-DK-1.3-SERVICE-MPROT](https://svn.medcom.dk/svn/releases/!svn/bc/2690/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-Profile-v1.3.pdf) | 1 | PHMR service events must be monitoring programmes Source: 2.14 CONF-PHMR-41. | /ClinicalDocument[1]/documentationOf[2]/serviceEvent[1] |

## PHMR-DK 2.1.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [phmr_example01.xml](../samples/phmr/phmr_example01.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-02.xml](../samples/phmr/PHMR-example-02.xml) | FAILURE | 1 | 0 | 1 |
| [PHMR-example-03.xml](../samples/phmr/PHMR-example-03.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-04.xml](../samples/phmr/PHMR-example-04.xml) | FAILURE | 1 | 0 | 1 |
| [PHMR-example-05.xml](../samples/phmr/PHMR-example-05.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-06.xml](../samples/phmr/PHMR-example-06.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-07.xml](../samples/phmr/PHMR-example-07.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-08.xml](../samples/phmr/PHMR-example-08.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-09.xml](../samples/phmr/PHMR-example-09.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-10.xml](../samples/phmr/PHMR-example-10.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-11.xml](../samples/phmr/PHMR-example-11.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-12.xml](../samples/phmr/PHMR-example-12.xml) | SUCCESS | 0 | 0 | 0 |
| [PHMR-example-13.xml](../samples/phmr/PHMR-example-13.xml) | SUCCESS | 0 | 0 | 0 |

### phmr_example01.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-01.xml).

No errors or warnings from the implemented checks.

### PHMR-example-02.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-02.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [PHMR-DK-2.1.0-TITLE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Dokumentation/PHMR-DK-v2.1.0.pdf) | 1 | PHMR title must be Hjemmemålinger Source: 2.1.4. | /ClinicalDocument[1]/title[1] |

### PHMR-example-03.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-03.xml).

No errors or warnings from the implemented checks.

### PHMR-example-04.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-04.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | PHMR-DK-2.1.0-83 | 1 | PHMR-DK 2.1.0 requires one or two body sections (CONF-PHMR-DK-83); found 3. | /ClinicalDocument[1]/component[1]/structuredBody[1] |

### PHMR-example-05.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-05.xml).

No errors or warnings from the implemented checks.

### PHMR-example-06.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-06.xml).

No errors or warnings from the implemented checks.

### PHMR-example-07.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-07.xml).

No errors or warnings from the implemented checks.

### PHMR-example-08.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-08.xml).

No errors or warnings from the implemented checks.

### PHMR-example-09.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-09.xml).

No errors or warnings from the implemented checks.

### PHMR-example-10.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-10.xml).

No errors or warnings from the implemented checks.

### PHMR-example-11.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-11.xml).

No errors or warnings from the implemented checks.

### PHMR-example-12.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-12.xml).

No errors or warnings from the implemented checks.

### PHMR-example-13.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PHMR/Eksempler/PHMR-example-13.xml).

No errors or warnings from the implemented checks.

## PMR-DK 2.0.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [PMR 1.1 UL vægt uge 12.xml](../samples/pmr/PMR%201.1%20UL%20v%C3%A6gt%20uge%2012.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 1.2 fosterskøn uge 15.xml](../samples/pmr/PMR%201.2%20fostersk%C3%B8n%20uge%2015.xml) | FAILURE | 2 | 0 | 2 |
| [PMR 1.3 ULvægt ULtermin uge 20 .xml](../samples/pmr/PMR%201.3%20ULv%C3%A6gt%20ULtermin%20uge%2020%20.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 1.4 fosterskøn uge 21.xml](../samples/pmr/PMR%201.4%20fostersk%C3%B8n%20uge%2021.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 1.5 fosterskøn uge 29.xml](../samples/pmr/PMR%201.5%20fostersk%C3%B8n%20uge%2029.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 2.1 UL vægt uge 12.xml](../samples/pmr/PMR%202.1%20UL%20v%C3%A6gt%20uge%2012.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 2.2 fosterskøn uge 15.xml](../samples/pmr/PMR%202.2%20fostersk%C3%B8n%20uge%2015.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 2.3 ULvægt ULtermin uge 20.xml](../samples/pmr/PMR%202.3%20ULv%C3%A6gt%20ULtermin%20uge%2020.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR 2.4 fosterskøn uge 21.xml](../samples/pmr/PMR%202.4%20fostersk%C3%B8n%20uge%2021.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR-DK 2.0 example 1 max.xml](../samples/pmr/PMR-DK%202.0%20example%201%20max.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR-DK 2.0 example 2 max.xml](../samples/pmr/PMR-DK%202.0%20example%202%20max.xml) | SUCCESS | 0 | 0 | 0 |
| [PMR-DK 2.0 example 3 max.xml](../samples/pmr/PMR-DK%202.0%20example%203%20max.xml) | SUCCESS | 0 | 0 | 0 |

### PMR 1.1 UL vægt uge 12.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%201.1%20UL%20v%c3%a6gt%20uge%2012.xml).

No errors or warnings from the implemented checks.

### PMR 1.2 fosterskøn uge 15.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%201.2%20fostersk%c3%b8n%20uge%2015.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [PMR-DK-2.0.0-DOCUMENT-UUID](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf) | 1 | Document identifier extension must be a UUID version 4 Source: 2.1 globally unique document identifier. | /ClinicalDocument[1]/id[1] |
| error | [PMR-DK-2.0.0-OBS-3-UUID](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Dokumentation/PMR-DK-2.0.0.pdf) | 1 | PMR observation identifier must be a UUID version 4 Source: 5.7 identifier constraints. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[1]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/id[1] |

### PMR 1.3 ULvægt ULtermin uge 20 .xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%201.3%20ULv%c3%a6gt%20ULtermin%20uge%2020%20.xml).

No errors or warnings from the implemented checks.

### PMR 1.4 fosterskøn uge 21.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%201.4%20fostersk%c3%b8n%20uge%2021.xml).

No errors or warnings from the implemented checks.

### PMR 1.5 fosterskøn uge 29.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%201.5%20fostersk%c3%b8n%20uge%2029.xml).

No errors or warnings from the implemented checks.

### PMR 2.1 UL vægt uge 12.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%202.1%20UL%20v%c3%a6gt%20uge%2012.xml).

No errors or warnings from the implemented checks.

### PMR 2.2 fosterskøn uge 15.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%202.2%20fostersk%c3%b8n%20uge%2015.xml).

No errors or warnings from the implemented checks.

### PMR 2.3 ULvægt ULtermin uge 20.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%202.3%20ULv%c3%a6gt%20ULtermin%20uge%2020.xml).

No errors or warnings from the implemented checks.

### PMR 2.4 fosterskøn uge 21.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR%202.4%20fostersk%c3%b8n%20uge%2021.xml).

No errors or warnings from the implemented checks.

### PMR-DK 2.0 example 1 max.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR-DK%202.0%20example%201%20max.xml).

No errors or warnings from the implemented checks.

### PMR-DK 2.0 example 2 max.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR-DK%202.0%20example%202%20max.xml).

No errors or warnings from the implemented checks.

### PMR-DK 2.0 example 3 max.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PMR/Eksempler/PMR-DK%202.0%20example%203%20max.xml).

No errors or warnings from the implemented checks.

## PRF-DK 3.0.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Dokumentation/PRF-DK-v3.0.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [PRF-DK v3.0 example 1.xml](../samples/prf/PRF-DK%20v3.0%20example%201.xml) | SUCCESS | 0 | 0 | 0 |
| [PRF-DK v3.0 example 2.xml](../samples/prf/PRF-DK%20v3.0%20example%202.xml) | SUCCESS | 0 | 0 | 0 |
| [PRF-DK v3.0 example 3.xml](../samples/prf/PRF-DK%20v3.0%20example%203.xml) | SUCCESS | 0 | 0 | 0 |
| [PRF-DK v3.0 example 4.xml](../samples/prf/PRF-DK%20v3.0%20example%204.xml) | SUCCESS | 0 | 0 | 0 |

### PRF-DK v3.0 example 1.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Eksempler/PRF-DK%20v3.0%20example%201.xml).

No errors or warnings from the implemented checks.

### PRF-DK v3.0 example 2.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Eksempler/PRF-DK%20v3.0%20example%202.xml).

No errors or warnings from the implemented checks.

### PRF-DK v3.0 example 3.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Eksempler/PRF-DK%20v3.0%20example%203.xml).

No errors or warnings from the implemented checks.

### PRF-DK v3.0 example 4.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRF/Eksempler/PRF-DK%20v3.0%20example%204.xml).

No errors or warnings from the implemented checks.

## PSCR-DK 2.0.0

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Dokumentation/PSCR-DK-v2.0.0.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [PSCR-DK v2.0 example 1.xml](../samples/pscr/PSCR-DK%20v2.0%20example%201.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 2.xml](../samples/pscr/PSCR-DK%20v2.0%20example%202.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 3.xml](../samples/pscr/PSCR-DK%20v2.0%20example%203.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 4.xml](../samples/pscr/PSCR-DK%20v2.0%20example%204.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 5.xml](../samples/pscr/PSCR-DK%20v2.0%20example%205.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 6.xml](../samples/pscr/PSCR-DK%20v2.0%20example%206.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR-DK v2.0 example 7.xml](../samples/pscr/PSCR-DK%20v2.0%20example%207.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR_1.1_omsorg2_ fødestedSV_naegels2026-02-20.xml](../samples/pscr/PSCR_1.1_omsorg2_%20f%C3%B8destedSV_naegels2026-02-20.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR_1.2_omsorg1_fødestedOd_naegels2026-02-30.xml](../samples/pscr/PSCR_1.2_omsorg1_f%C3%B8destedOd_naegels2026-02-30.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR_2.1_resume_specialtegn.xml](../samples/pscr/PSCR_2.1_resume_specialtegn.xml) | FAILURE | 4 | 0 | 3 |
| [PSCR_2.2_resume kort.xml](../samples/pscr/PSCR_2.2_resume%20kort.xml) | SUCCESS | 0 | 0 | 0 |
| [PSCR_2.2_resume_langt.xml](../samples/pscr/PSCR_2.2_resume_langt.xml) | SUCCESS | 0 | 0 | 0 |

### PSCR-DK v2.0 example 1.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%201.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 2.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%202.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 3.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%203.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 4.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%204.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 5.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%205.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 6.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%206.xml).

No errors or warnings from the implemented checks.

### PSCR-DK v2.0 example 7.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR-DK%20v2.0%20example%207.xml).

No errors or warnings from the implemented checks.

### PSCR_1.1_omsorg2_ fødestedSV_naegels2026-02-20.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR_1.1_omsorg2_%20f%c3%b8destedSV_naegels2026-02-20.xml).

No errors or warnings from the implemented checks.

### PSCR_1.2_omsorg1_fødestedOd_naegels2026-02-30.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR_1.2_omsorg1_f%c3%b8destedOd_naegels2026-02-30.xml).

No errors or warnings from the implemented checks.

### PSCR_2.1_resume_specialtegn.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR_2.1_resume_specialtegn.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":td}'. One of '{"urn:hl7-org:v3":content, "urn:hl7-org:v3":linkHtml, "urn:hl7-org:v3":sub, "urn:hl7-org:v3":sup, "urn:hl7-org:v3":br, "urn:hl7-org:v3":footnote, "urn:hl7-org:v3":footnoteRef, "urn:hl7-org:v3":renderMultiMedia, "urn:hl7-org:v3":paragraph, "urn:hl7-org:v3":list}' is expected. | XML:121:14 |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.d: Invalid content was found starting with element 'td'. No child element is expected at this point. | XML:236:14 |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":td}'. One of '{"urn:hl7-org:v3":content, "urn:hl7-org:v3":linkHtml, "urn:hl7-org:v3":sub, "urn:hl7-org:v3":sup, "urn:hl7-org:v3":br, "urn:hl7-org:v3":footnote, "urn:hl7-org:v3":footnoteRef, "urn:hl7-org:v3":renderMultiMedia, "urn:hl7-org:v3":paragraph, "urn:hl7-org:v3":list}' is expected. | contentToValidate:121:14 |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.d: Invalid content was found starting with element 'td'. No child element is expected at this point. | contentToValidate:236:14 |

### PSCR_2.2_resume kort.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR_2.2_resume%20kort.xml).

No errors or warnings from the implemented checks.

### PSCR_2.2_resume_langt.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PSCR/Eksempler/PSCR_2.2_resume_langt.xml).

No errors or warnings from the implemented checks.

## QFDD-DK 1.2

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [qfdd_example.xml](../samples/qfdd/qfdd_example.xml) | FAILURE | 4 | 0 | 4 |
| [qfdd_text.xml](../samples/qfdd/qfdd_text.xml) | FAILURE | 3 | 0 | 3 |
| [qfdd_numeric_graphics.xml](../samples/qfdd/qfdd_numeric_graphics.xml) | FAILURE | 4 | 0 | 4 |
| [qfdd_numeric.xml](../samples/qfdd/qfdd_numeric.xml) | FAILURE | 5 | 0 | 5 |
| [qfdd_associated_text.xml](../samples/qfdd/qfdd_associated_text.xml) | FAILURE | 3 | 0 | 3 |
| [qfdd_discrete_slider.xml](../samples/qfdd/qfdd_discrete_slider.xml) | FAILURE | 3 | 0 | 3 |
| [qfdd_multiple_choice_grouped.xml](../samples/qfdd/qfdd_multiple_choice_grouped.xml) | FAILURE | 8 | 0 | 4 |
| [qfdd_analog_slider_feedback.xml](../samples/qfdd/qfdd_analog_slider_feedback.xml) | FAILURE | 5 | 0 | 5 |
| [qfdd_analog_slider.xml](../samples/qfdd/qfdd_analog_slider.xml) | FAILURE | 5 | 0 | 5 |

### qfdd_example.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/0397c59c-a93f-470a-b8ff-2bc5c5f42b13).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_text.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/1251f3c7-07d6-4d7d-aa89-cf33cb5cdb9f).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_numeric_graphics.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/1fdb7308-f4fb-4eb1-af62-c8a429915dc1).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_numeric.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/20ee1a5c-d574-4c04-b315-24e644cef53a).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C59](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.1; 4.3, p. 19, C59. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_associated_text.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/2c8f8bd7-059d-410d-aed9-afe37ce389ed).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_discrete_slider.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/391bb19d-6ccd-4a3d-a3df-ea4ec58155cc).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[3]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_multiple_choice_grouped.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/3aa7cec1-2718-47a5-8161-767e87c28a35).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C73](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 2 | QFDD-DK 1.2: id cardinality must be 1..*. Source: qfdd 5.1, p. 23, C73. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[2]/organizer[1] |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 4 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_analog_slider_feedback.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/a8aea6f4-d4ab-4926-8328-f92e0b91d68e).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C59](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.1; 4.3, p. 19, C59. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

### qfdd_analog_slider.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Eksempler/b178eac3-f194-4b53-aaab-78807db7ed42).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:sdtc":statusCode}'. One of '{"urn:hl7-org:v3":effectiveTime}' is expected. | XML:15:31 |
| error | [QFDD-DK-1.2-C59](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=19) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.1; 4.3, p. 19, C59. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-C76](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=23) | 1 | QFDD-DK 1.2: @code must be completed. Source: qfdd 5.1, p. 23, C76. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QFDD-DK-1.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QFDD-DK 1.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1] |
| error | [QFDD-DK-1.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QFDD-DK 1.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/observation[1]/code[1] |

## QRD-DK 1.3.2

[Specification](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf)

| Example | Result | Errors | Warnings | Distinct error rules |
| --- | --- | ---: | ---: | ---: |
| [qrd_numeric.xml](../samples/qrd/qrd_numeric.xml) | FAILURE | 12 | 0 | 10 |
| [qrd_numeric_graphics.xml](../samples/qrd/qrd_numeric_graphics.xml) | FAILURE | 13 | 0 | 13 |
| [qrd_multiple_choice.xml](../samples/qrd/qrd_multiple_choice.xml) | FAILURE | 9 | 0 | 9 |
| [qrd_multiple_choice_grouped.xml](../samples/qrd/qrd_multiple_choice_grouped.xml) | FAILURE | 26 | 0 | 13 |
| [qrd_text.xml](../samples/qrd/qrd_text.xml) | FAILURE | 10 | 0 | 10 |
| [qrd_associated_text_1.xml](../samples/qrd/qrd_associated_text_1.xml) | FAILURE | 9 | 0 | 9 |
| [qrd_associated_text_2.xml](../samples/qrd/qrd_associated_text_2.xml) | FAILURE | 9 | 0 | 9 |
| [qrd_analog_slider.xml](../samples/qrd/qrd_analog_slider.xml) | FAILURE | 16 | 0 | 12 |
| [qrd_analog_slider_feedback.xml](../samples/qrd/qrd_analog_slider_feedback.xml) | FAILURE | 12 | 0 | 12 |
| [qrd_discrete_slider.xml](../samples/qrd/qrd_discrete_slider.xml) | FAILURE | 9 | 0 | 9 |
| [qrd_m_3.19.xml](../samples/qrd/qrd_m_3.19.xml) | FAILURE | 39 | 0 | 19 |
| [qrd_m_3.1_a.xml](../samples/qrd/qrd_m_3.1_a.xml) | FAILURE | 34 | 0 | 15 |
| [qrd_m_3.22_a.xml](../samples/qrd/qrd_m_3.22_a.xml) | FAILURE | 35 | 0 | 17 |
| [qrd_m_3.9_a.xml](../samples/qrd/qrd_m_3.9_a.xml) | FAILURE | 35 | 0 | 19 |
| [qrd_m_3.9_b.xml](../samples/qrd/qrd_m_3.9_b.xml) | FAILURE | 37 | 0 | 19 |

### qrd_numeric.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_1.0_Numeric_Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 2 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 2 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_numeric_graphics.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_1.1_Numeric_Question_-_Graphics.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | XML:190:37 |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | contentToValidate:190:37 |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-REL-MEDIA-TEMPLATE-4](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=40) | 1 | QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.2'] cardinality must be 1..1. Source: qrd 5.4, p. 40, REL-MEDIA-TEMPLATE-4. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observationMedia[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_multiple_choice.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_2.0_Multiple_Choise_Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_multiple_choice_grouped.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_2.1_Multiple_Choise_Question_-_Grouped.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C132](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 2 | QRD-DK 1.3.2: id cardinality must be 1..*. Source: qrd 5.1, p. 35, C132. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[2]/organizer[1] |
| error | [QRD-DK-1.3.2-C135](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 4 | QRD-DK 1.3.2: @code must be completed. Source: qrd 5.1, p. 35, C135. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QRD-DK-1.3.2-C180](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.5, p. 41, C180. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C236](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=48) | 5 | QRD-DK 1.3.2: templateId[@root='2.16.840.1.113883.10.20.33.4.5'] cardinality must be 1..1. Source: qrd 5.8, p. 48, C236. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[2]/observation[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-INFO-NO-ENTRY](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33) | 1 | QRD-DK 1.3.2: Information-only sections contain no entries. Source: qrd 4.2, p. 33, 4.2 prose. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 6 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_text.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.0_Text_Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C214](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.6, p. 44, C214. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_associated_text_1.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.1.1_Text_Question_-_Associated%20Text%20Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_associated_text_2.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_3.1.2_Text_Question_-_Associated%20Text%20Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_analog_slider.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_4.0_Analog_Slider_Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 2 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | XML:181:37 |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | Gazelle CDA document check | 2 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | contentToValidate:181:37 |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 2 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 2 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_analog_slider_feedback.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_4.1_Analog_Slider_Question_-_Question%20Feedback%20Pattern%20Observation.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | (validator diagnostic) | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | XML:180:37 |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | Gazelle CDA document check | 1 | cvc-complex-type.2.4.a: Invalid content was found starting with element '{"urn:hl7-org:v3":reference}'. One of '{"urn:hl7-org:v3":referenceRange}' is expected. | contentToValidate:180:37 |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_discrete_slider.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Eksempler/QRD_Example_5.0_Discrete_Slider_Question.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-AUTHOR-ORGANISATION](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: representedOrganization cardinality must be 1..1. Source: qrd 2.2.2, p. 16, AUTHOR-ORGANISATION. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 1 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK11](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: documentationOf cardinality must be 2..2. Source: qrd 2.2.11, p. 28, DK11. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/component[2]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_m_3.19.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.19.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | CDA-DK-PROFILE-VERSION | 1 | Selected target QRD-DK 1.3.2 requires exactly one profile version declaration 'qrd-v1.3' in documentationOf/serviceEvent/id. Source: 2.2.11 DocumentationOf. | /ClinicalDocument[1] |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 4 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 2 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C138-143](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 3 | QRD-DK 1.3.2: observation[templateId/@root=('2.16.840.1.113883.10.20.33.4.4', '2.16.840.1.113883.10.20.33.4.5', '2.16.840.1.113883.10.20.33.4.6', '2.16.840.1.113883.10.20.33.4.7', '2.16.840.1.113883.10.20.33.4.8')] cardinality must be 1..1. Source: qrd 5.1, p. 35, C138-143. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[8]/section[1]/entry[1]/organizer[1]/component[1] |
| error | [QRD-DK-1.3.2-C159](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 3 | QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.4, p. 39, C159. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C180](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 3 | QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.5, p. 41, C180. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C205](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 2 | QRD-DK 1.3.2: @moodCode must be EVN. Source: qrd 5.6, p. 44, C205. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[6]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C22](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.1, p. 15, C22. | /ClinicalDocument[1]/recordTarget[1]/patientRole[1] |
| error | [QRD-DK-1.3.2-C34](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[11]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK14](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=28) | 1 | QRD-DK 1.3.2: @extension must be qrd-v1.3. Source: qrd 2.2.11, p. 28, DK14. | /ClinicalDocument[1]/documentationOf[1]/serviceEvent[1]/id[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-DK43](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-DK44](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 8 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C125](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30) | 3 | QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observation[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[11]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_m_3.1_a.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.1_A.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 4 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C126](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 2 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qrd 4.1, p. 32, C126. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 2 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[8]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C171](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 2 | QRD-DK 1.3.2: xsi:type must identify a CDA datatype: INT REAL TS. Source: qrd 5.4, p. 39, C171. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[8]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/value[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 2 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C22](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.1, p. 15, C22. | /ClinicalDocument[1]/recordTarget[1]/patientRole[1] |
| error | [QRD-DK-1.3.2-C34](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[11]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-DK43](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-DK44](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 11 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C125](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30) | 3 | QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observation[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[11]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_m_3.22_a.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.22_A.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 3 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C135](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 5 | QRD-DK 1.3.2: @code must be completed. Source: qrd 5.1, p. 35, C135. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 5 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C214](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 3 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.6, p. 44, C214. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C34](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK25](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.4, p. 39, DK25. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK26](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 4 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.5, p. 41, DK26. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[7]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK27](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 2 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.6, p. 44, DK27. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[2]/observation[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-DK43](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-DK44](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-INFO-NO-ENTRY](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33) | 2 | QRD-DK 1.3.2: Information-only sections contain no entries. Source: qrd 4.2, p. 33, 4.2 prose. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 2 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C125](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30) | 1 | QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observation[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_m_3.9_a.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.9_A.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 3 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C135](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 5 | QRD-DK 1.3.2: @code must be completed. Source: qrd 5.1, p. 35, C135. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 5 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C214](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 2 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.6, p. 44, C214. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C22](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.1, p. 15, C22. | /ClinicalDocument[1]/recordTarget[1]/patientRole[1] |
| error | [QRD-DK-1.3.2-C34](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK25](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.4, p. 39, DK25. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK26](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 4 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.5, p. 41, DK26. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[7]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK27](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 1 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.6, p. 44, DK27. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[2]/observation[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-DK43](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-DK44](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-INFO-NO-ENTRY](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33) | 2 | QRD-DK 1.3.2: Information-only sections contain no entries. Source: qrd 4.2, p. 33, 4.2 prose. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 2 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C125](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30) | 1 | QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observation[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1]/observation[1]/code[1] |

### qrd_m_3.9_b.xml

Published at: [MedCom source 1](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Testprotokol/Test_eksempler/QRD_M_3.9_B.xml).

| Severity | Rule / specification | Count | Finding | Example location |
| --- | --- | ---: | --- | --- |
| error | [QRD-DK-1.3.2-C121-CODE](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=32) | 3 | QRD-DK 1.3.2: @code must be 74465-6. Source: qrd 4.1, p. 32, C121-CODE. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/code[1] |
| error | [QRD-DK-1.3.2-C135](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=35) | 5 | QRD-DK 1.3.2: @code must be completed. Source: qrd 5.1, p. 35, C135. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/statusCode[1] |
| error | [QRD-DK-1.3.2-C168](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.4, p. 39, C168. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C189](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 5 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.5, p. 41, C189. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C214](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 3 | QRD-DK 1.3.2: statusCode cardinality must be 1..1. Source: qrd 5.6, p. 44, C214. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-C22](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=15) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.1, p. 15, C22. | /ClinicalDocument[1]/recordTarget[1]/patientRole[1] |
| error | [QRD-DK-1.3.2-C34](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: code cardinality must be 1..1. Source: qrd 2.2.2, p. 16, C34. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-C37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, C37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-COPY-C67](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=20) | 1 | QRD-DK 1.3.2: @typeCode must be DRIV. Source: qfdd 4.2 (QFDD imported by QRD 1.6.1), p. 20, COPY-C67. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1] |
| error | [QRD-DK-1.3.2-DK25](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=39) | 1 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.4, p. 39, DK25. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[5]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK26](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=41) | 4 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.5, p. 41, DK26. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[7]/section[1]/entry[1]/organizer[1]/component[1]/observation[1] |
| error | [QRD-DK-1.3.2-DK27](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=44) | 2 | QRD-DK 1.3.2: reference cardinality must be 1..1. Source: qrd 5.6, p. 44, DK27. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1]/entry[1]/organizer[1]/component[2]/observation[1] |
| error | [QRD-DK-1.3.2-DK37](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: An author identified as the patient must carry the SELF role and its specified labels. Source: qrd 2.2.2, p. 16, DK37. | /ClinicalDocument[1]/author[1]/assignedAuthor[1] |
| error | [QRD-DK-1.3.2-DK43](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: telecom cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK43. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-DK44](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=16) | 1 | QRD-DK 1.3.2: addr cardinality must be 1..*. Source: qrd 2.2.2, p. 16, DK44. | /ClinicalDocument[1]/author[1]/assignedAuthor[1]/representedOrganization[1] |
| error | [QRD-DK-1.3.2-INFO-NO-ENTRY](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=33) | 2 | QRD-DK 1.3.2: Information-only sections contain no entries. Source: qrd 4.2, p. 33, 4.2 prose. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[4]/section[1] |
| error | [QRD-DK-1.3.2-REFERENCE-SYSTEM](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QRD/Dokumentation/QRD-DK_1.3.2.pdf#page=50) | 2 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.6.1. Source: qrd 5.9; 5.9.1, p. 50, REFERENCE-SYSTEM. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/reference[1]/externalDocument[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C125](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=30) | 1 | QRD-DK 1.3.2: @code must be 74467-2. Source: qfdd 5.7, p. 30, SHARED-C125. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[2]/section[1]/entry[1]/organizer[1]/component[1]/observation[1]/entryRelationship[1]/observation[1]/code[1] |
| error | [QRD-DK-1.3.2-SHARED-C145](https://svn.medcom.dk/svn/releases/Standarder/HL7/PRO/QFDD/Dokumentation/DK-QFDD-v1.2.pdf#page=33) | 1 | QRD-DK 1.3.2: @codeSystem must be 2.16.840.1.113883.5.4. Source: qfdd 5.9, p. 33, SHARED-C145. | /ClinicalDocument[1]/component[1]/structuredBody[1]/component[10]/section[1]/entry[1]/observation[1]/code[1] |
