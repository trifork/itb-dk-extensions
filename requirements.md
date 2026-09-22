Krav til CDA-validering i ITB

1. Generelt testsetup

Vi ønsker at udfase den nuværende CDA-validator (https://cda.medcom.dk), som i dag
validerer en begrænset del af de conformance-krav, der er defineret i MedComs
CDA-profiler.

Vi ønsker en mere omfattende validering fra ITB'en, der udelukkende er baseret på
Schematron-filer. Dokumenter skal kunne valideres op mod alle MedComs CDA-profiler,
og valideringen skal samtidig sikre, at de generelle CDA-krav overholdes.

Vi har god erfaring med at anvende AI til at udarbejde Schematron-filer på baggrund
af eksisterende dokumentation af profiler. Vi ser gerne dette anvendt til at
effektivisere udviklingen og opnå en bredere validering.

2. Test af spørgeskemastandarder

Spørgeskemastandarder er komplekse, da et spørgeskema kan indeholde forskellige
spørgsmål, typer af svarmuligheder (fx slider, multiple choice og boolean) og
afhængigheder på tværs.

- Det skal være muligt at validere både den generelle struktur og konkrete
  standarder og use cases, fx "Kræftplan V5".
- PRO-sekretariatet danner løbende nye spørgeskemaer (QFDD). Der er behov for et
  støtteværktøj, som kan validere strukturen af et konkret spørgeskema i forbindelse
  med generering af dokumenter.
- Der er behov for generiske valideringsbyggeklodser til de forskellige typer af
  spørgsmål og svarmuligheder. Byggeklodserne skal kunne kombineres og sammensættes
  efter behov for det enkelte spørgeskema.
- Andre leverandører danner spørgeskemabesvarelser (QRD). Der er behov for at kunne
  validere, om en besvarelse er korrekt opbygget og stemmer overens med det
  oprindelige spørgeskema (QFDD).

3. Validering af sektioner i QFDD

Støtteværktøjet skal blandt andet kunne understøtte validering af den korrekte
anvendelse af følgende sektioner i en QFDD:

- Questionnaire Form Definition Section: Den mest komplekse sektion, som
  indeholder og strukturerer spørgeskemaets spørgsmål.
- Copy Right Section: En mindre kompleks og valgfri sektion, som indeholder
  licensoplysninger for spørgsmål, der er underlagt ophavsret.
- Information Only Section: Den mindst komplekse og valgfri sektion, som
  udelukkende indeholder tekst i form af narrativ information.

4. Integration til Dokumentdelingsservicen

Det er et stort ønske at få en integration fra ITB'en til Dokumentdelingsservicen.
Integrationen skal gøre det muligt at udsøge dokumenter på samme måde som i
XDS-portalen ud fra følgende kriterier:

- Test-CPR
- Dokumenttype og version
- Dokument-ID
- Eventuelt et bestemt tidsinterval

Dette vil lette arbejdsgangene omkring test og certificering af dokumentbaserede
standarder.
