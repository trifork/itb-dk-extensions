# Specifikation for udvidet CDA-validering i ITB

Status: Arbejdsgrundlag baseret på [requirements.md](requirements.md) og den
eksisterende implementering i dette repository.

Kravene nedenfor konkretiserer kravgrundlaget. Foreslåede tekniske løsninger og
åbne beslutninger er markeret særskilt; de er ikke nye krav fra MedCom.

## 1. Formål og afgrænsning

Den eksisterende CDA-validator i ITB skal videreudvikles til at dække de generelle
CDA-krav og conformance-kravene i alle MedComs CDA-profiler. Målet er at kunne
udfase den nuværende validator på cda.medcom.dk og basere valideringen udelukkende
på Schematron-filer.

Arbejdet omfatter også validering af spørgeskemaer (QFDD), sammenhængen mellem
spørgeskemaer og besvarelser (QRD) samt den ønskede integration til
Dokumentdelingsservicen.

Den eksisterende ITB-installation og validatorintegration er udgangspunktet.
Etablering af en ny testplatform indgår derfor ikke som en ny leverance.
Støtteværktøjet skal validere dokumenter; kravgrundlaget beskriver ikke en editor
eller en generator til spørgeskemaer.

## 2. Eksisterende fundament

Følgende er implementeret i repositoryet. Oversigten er baseret på filer og
konfiguration; den er ikke en ny verifikation af et kørende miljø.

| Område | Eksisterende funktionalitet | Reference |
| --- | --- | --- |
| Lokal ITB-installation | Docker Compose med ITB UI, testmotor, database, cache og CDA-validator | [docker-compose.yml](docker-compose.yml) |
| Klargøring | Scripts til opstart, ITB-konfiguration, testsuite og testbruger | [get-up-and-running/](get-up-and-running/) |
| Validatoradgang | Webformular, REST API og GITB SOAP API | [cda-validator/domain/cda-dk/config.properties](cda-validator/domain/cda-dk/config.properties) |
| Profiler | 12 eksplicitte releasevalg for APD, CPD, PDC, PHMR, QRD, QFDD, PHAD, PMR, PRF og PSCR; alle med delvis kravdækning | [regelsætkatalog](cda-validator/domain/cda-dk/rulesets.json) |
| Valideringsregler | Fælles CDA XSD, profilspecifikke Schematron-regler og Gazelle-plugin | [cda-validator/domain/cda-dk/](cda-validator/domain/cda-dk/), [cda-validator/](cda-validator/) |
| ITB-testforløb | Midlertidig PHMR-forbindelsestest og ét interaktivt forløb pr. registreret release med upload eller valgfri DDS-søgning | [get-up-and-running/test-suite/](get-up-and-running/test-suite/) |
| DDS-integration | Samlet Java 25-service med REST, GITB SOAP, søgning, repositoryfiltrering og hentning | [xds-service/](xds-service/), [opsætning](docs/xds.md) |
| Projektstruktur | Selvstændige Maven-projekter til CDA og XDS; Java-tests og komponentspecifik teststøtte i hvert projekt | [CDA](cda-validator/README.md), [XDS](xds-service/README.md) |
| Eksempeldokumenter | CDA-eksempler og script til at vise valideringsresultater | [samples/](samples/), [run-samples.sh](run-samples.sh) |

Den nuværende valideringskæde er XSD → Schematron → Gazelle-plugin. Den opfylder
dermed endnu ikke målet om udelukkende Schematron-baseret validering.
Registreringen af en profil er heller ikke dokumentation for fuld kravdækning.

[README.md](README.md) beskriver kendte afvigelser mellem eksempeldokumenter,
regelsæt og den nuværende MedCom-validator. Disse skal indgå i det videre arbejde
som dokumenterede afvigelser, ikke som en antagelse om, at alle eksempler er gyldige.

## 3. Funktionelle krav

### VAL-01 — Generelle CDA-krav og MedCom-profiler

Kilde: requirements.md, afsnit 1.

- Et dokument skal valideres mod både generelle CDA-krav og den valgte MedCom-profil
  i den relevante version.
- Der skal udarbejdes en oversigt over alle profiler og versioner i målomfanget.
  De seks eksisterende valideringstyper er første udgangspunkt, ikke den endelige
  afgrænsning af "alle MedComs CDA-profiler".
- Hvert conformance-krav skal kunne spores til dokumentation, version og den regel,
  der implementerer kravet. Manglende dokumentation og manglende regler skal fremgå.
- Profil og version skal fremgå af valideringsresultatet. En profil eller version,
  der ikke understøttes, må ikke rapporteres som valideret med fuld dækning.

Accept: En dækningsoversigt forbinder krav med regler og testeksempler. For hver
understøttet profil/version demonstreres generel og profilspecifik validering med
både gyldige og ugyldige dokumenter. Udækkede krav er synlige.

### VAL-02 — Overgang til Schematron

Kilde: requirements.md, afsnit 1.

- Conformance-regler skal implementeres i Schematron med versionsstyrede kilder.
  Kompileret XSLT kan fortsat anvendes som afviklingsformat.
- Eksisterende XSD- og plugin-kontroller skal kortlægges, før de erstattes, så
  overgangen ikke medfører utilsigtet tab af validering.
- Regler og tilhørende værdisæt skal kunne afvikles med en kendt version og med
  alle nødvendige afhængigheder til stede.
- Kontroller, hvis realisering i Schematron er uafklaret, skal fremgå særskilt.
  Det gælder blandt andet kontrol af den oprindelige fils encoding.

Accept: Det aftalte regelsæt kan afvikles uden Gazelle-plugin med dokumenteret
kravdækning. Håndteringen af XSD er afklaret efter afsnit 7, før slutmålet erklæres
opfyldt. Hver ændring i forhold til eksisterende resultater kan forklares ud fra
kravgrundlaget eller en dokumenteret rettelse.

### VAL-03 — AI-assisteret regeludvikling

Kilde: requirements.md, afsnit 1. Dette er et ønske til udviklingsmetoden.

AI kan anvendes til at udarbejde forslag til Schematron-regler ud fra eksisterende
profildokumentation. Foreslået kvalitetskrav: Regler optages først efter faglig
gennemgang og test; en AI-genereret fortolkning er ikke i sig selv en normativ kilde.

Accept: Regler udarbejdet med AI har samme sporbarhed, gennemgang og testdækning
som øvrige regler.

### QFDD-01 — Generel struktur og sektioner

Kilde: requirements.md, afsnit 2 og 3.

PRO-sekretariatet skal kunne indsende en QFDD og få valideret dens struktur og
korrekte anvendelse af sektioner:

| Sektion | Valideringsomfang |
| --- | --- |
| Questionnaire Form Definition Section | Strukturering af spørgsmål, svarmuligheder og indbyrdes afhængigheder efter den valgte profilversion |
| Copy Right Section | Valgfri sektion; korrekt struktur og licensoplysninger, når sektionen forekommer |
| Information Only Section | Valgfri sektion; korrekt struktur og narrativ information, når sektionen forekommer |

De præcise kardinaliteter, koder, template-id'er og øvrige constraints skal hentes
fra den relevante profildokumentation.

Accept: Testgrundlaget omfatter korrekt og forkert opbygning af hver sektion samt
dokumenter med og uden de valgfrie sektioner. Udeladelse af en valgfri sektion må
ikke i sig selv medføre fejl.

### QFDD-02 — Genbrugelige valideringsbyggeklodser

Kilde: requirements.md, afsnit 2.

- Fælles regler for spørgsmål og svarmuligheder skal kunne genbruges og
  sammensættes til det enkelte spørgeskema.
- Byggeklodserne skal omfatte de relevante repræsentationer af blandt andet slider,
  multiple choice og boolean samt afhængigheder mellem spørgsmål.
- Hver byggeklods skal beskrive, hvilke strukturer og profilversioner den gælder
  for, hvilke forudsætninger den har, og hvilke fejl den kan rapportere.
- Nye spørgeskemaer skal kunne sammensættes af eksisterende byggeklodser med
  særskilte regler for eventuelle nye behov.

Accept: Hver byggeklods har positive og negative testeksempler. Mindst to
spørgeskemaer demonstrerer genbrug af samme regler uden kopiering af regellogik.

### QFDD-03 — Konkrete standarder og use cases

Kilde: requirements.md, afsnit 2.

Generel QFDD-validering skal kunne suppleres med regler for et konkret spørgeskema
og dets version, eksempelvis "Kræftplan V5". Resultatet skal vise, om der er udført
generel validering alene eller også validering af en konkret use case.

Accept: Et aftalt referencespørgeskema valideres med både fælles regler og egne
krav. Et dokument, der er generelt gyldigt, men bryder et krav i use casen, udløser
den relevante fejl. Kræftplan V5 kan bruges, når dokumentation og eksempler foreligger.

### QRD-01 — Besvarelse i forhold til det oprindelige spørgeskema

Kilde: requirements.md, afsnit 2.

- En QRD skal kunne valideres både selvstændigt mod QRD-profilen og i forhold til
  den QFDD, besvarelsen vedrører.
- Sammenligningen skal anvende den korrekte identitet og version af QFDD'en.
- Den skal kontrollere sammenhængen mellem spørgsmål og svar, tilladte svartyper
  og svarmuligheder samt obligatoriske svar og afhængigheder, hvor disse er
  defineret i spørgeskemaet og profilen.
- Manglende eller tvetydig reference til en QFDD skal give et tydeligt resultat om,
  at sammenhængen ikke kunne valideres. Det må ikke fremstå som en bestået kontrol.

Accept: Testgrundlaget omfatter et gyldigt QFDD/QRD-par, forkert QFDD-version,
ukendt spørgsmål, ugyldig svartype eller svarmulighed, manglende påkrævet svar og
brud på en defineret afhængighed. En ugyldig reference-QFDD må ikke føre til et
ubetinget godkendt sammenligningsresultat.

### DDS-01 — Dokumentudsøgning fra ITB

Kilde: requirements.md, afsnit 4. Integrationen er et stort ønske og et særskilt
arbejdsspor; den prioriteres særskilt fra udvidelsen af valideringsreglerne.

- Et ITB-testforløb skal kunne udsøge dokumenter i Dokumentdelingsservicen ud fra
  test-CPR, dokumenttype og version, dokument-ID og eventuelt tidsinterval.
- Søgningen skal præsentere tilstrækkelige metadata til at identificere det ønskede
  dokument ved flere resultater.
- Som foreslået konkretisering af testarbejdsgangen skal et valgt dokument kunne
  hentes og sendes til den eksisterende CDA-validering i samme ITB-forløb.
- Ingen fund, flere fund, adgangsfejl og tekniske fejl skal kunne skelnes fra
  fejl i selve CDA-dokumentet.

Accept: Et ITB-forløb demonstrerer søgning med de aftalte filtre, valg, hentning og
validering af et testdokument. Der findes testtilfælde for ingen fund, flere fund
og servicefejl. Den præcise betydning af version og tidsinterval er aftalt.

Implementationsstatus: Det valgfrie XDS-forløb er implementeret for alle registrerede
CDA-profiler; se [opsætning og begrænsninger](docs/xds.md). Version betyder den
CDA-profilrelease, der vælges med ITB-testen, og kontrolleres efter hentning; den
udledes ikke af XDS-metadata. Tidsfiltrene gælder service start/stop, angivet med
tidszone. Mock-baserede tests dækker søgning, valg, hentning, fejlsituationer og samme
valideringsfund som upload. De automatiske tests bruger syntetiske services og
dokumenterer ikke live TEST1-adgang. Aktuelle navngivne signeringsidentiteter skal
konfigureres i `xds-service/local/`; adgang, filterfortolkning og samlet accept skal
verificeres særskilt. DDS-01 er derfor ikke fuldt accepteret.

## 4. Foreslået teknisk opbygning

Den eksisterende validator og dens rapportering genbruges. Reglerne opdeles
logisk i fælles CDA-regler, profilregler, QFDD-byggeklodser og use case-regler.
Den nuværende filstruktur ligger i `cda-validator/domain/cda-dk/`, med
release-specifikke regler under `sch/versions/`. Videre opdeling i genbrugelige
byggeklodser skal bevare denne registrering og undgå utilsigtet dobbelt afvikling.

Eksisterende valideringstyper og integrationspunkter bevares under overgangen.
Tilføjelser til valg af version, use case og reference-QFDD skal beskrives i en
inputkontrakt, før de implementeres. Det nuværende TDL-eksempel bruger `xml` og
`type`. Der findes en testet dokument-envelope til de separate QRD/QFDD-regler,
beskrevet i [PRO conformance](docs/pro-conformance.md), men endnu ikke et registreret
ITB-forløb eller en offentlig validatorrute til dokumentpar.

QFDD/QRD-sammenligning skal udføres med Schematron-regler. Hvordan reference-QFDD'en
stilles til rådighed for reglerne, skal afprøves i den eksisterende validator.
En mulig løsning er et ITB-forløb, der modtager begge dokumenter og forbereder dem
til sammenligning. Det er et løsningsforslag, ikke allerede implementeret adfærd.

Dokumentudsøgning og hentning er placeret i det valgfrie XDS-forløb.
`xds-service/` samler REST og GITB i én proces med fælles Java-services; den hentede
CDA sendes uændret til validatorens eksisterende integrationspunkt. Yderligere
adgangs- og filterkrav skal afklares før samlet accept, jf. DDS-01.

## 5. Rapportering og verifikation

Foreslåede fælles acceptkrav for den videre implementering:

- Resultater vises i de eksisterende ITB-valideringsrapporter med stabilt regel-id,
  alvorlighedsgrad, forståelig fejltekst og dokumentplacering, hvor den kan angives.
- Rapport eller tilknyttede testmetadata identificerer profil, version, regelsæt og
  eventuel use case/reference-QFDD samt kontroller, der ikke kunne gennemføres.
- Hver ny regel eller regelgruppe testes med et gyldigt eksempel og målrettede
  ugyldige eksempler. Testene kontrollerer forventede regel-id'er og resultater.
- Eksisterende eksempler bruges til regression med eksplicitte forventninger og
  dokumenterede kendte afvigelser. Resultatlighed med cda.medcom.dk er et
  sammenligningsgrundlag, ikke i sig selv bevis for korrekt eller fuld kravdækning.
- De eksisterende releaseforløb, herunder PHMR, QFDD og valgfri dokumentudsøgning,
  skal fortsat fungere. Et ITB-forløb til QFDD/QRD-par er fortsat udestående.

`run-samples.sh` kontrollerer nu hver prøve mod et eksplicit regelsæt og forventet
resultat i `samples/validation-cases.json`. Standardadressen er
`http://localhost:8091`. Tilvalget `--check-versions` kontrollerer også versionskonflikter,
afvisning af ukendte versioner og PHMR-specifik validering.

Alle registrerede profiler anvender eksplicitte danske releasevalg fra
`cda-validator/domain/cda-dk/rulesets.json`, herunder PHMR-DK 2.1.0 og separate valg for PDC-DK 2.0 og
3.0.0. Testnavne og instruktioner angiver samme release som valideringsinputtet.
Se [versionspolitikken](docs/versioning.md). Kilder og versionsmarkører er
kortlagt; fuld conformance-dækning af hver release er fortsat udestående.

## 6. Foreslået leverancerækkefølge

1. **Krav- og regelkortlægning:** Fastlæg profilversioner og dokumentationskilder,
   kortlæg eksisterende dækning og afvigelser, og afklar Schematron/XSD-målet.
2. **QFDD-forløb:** Udbyg det registrerede QFDD-DK 1.2-forløb med den manglende
   kravdækning og genbrugelige byggeklodser.
3. **Referencespørgeskema:** Sammensæt og test regler til en konkret use case.
4. **QRD-sammenligning:** Fastlæg inputkontrakten og implementer validering af
   QFDD/QRD-par med målrettede fejlscenarier.
5. **Bredere profildækning og migration:** Udvid systematisk dækningen og erstat
   Gazelle-kontroller med verificerede Schematron-regler. Afslut XSD-afklaringen
   i implementeringen, før Schematron-målet erklæres opfyldt.
6. **Dokumentdelingsservice:** Verificer det implementerede søge-, hente- og
   valideringsforløb mod det aftalte testmiljø, og dokumenter filtersemantik og
   accept. Dette spor kan videreudvikles uafhængigt af regeludvidelserne.

Udfasning af cda.medcom.dk forudsætter dokumenteret dækning af det aftalte samlede
omfang og accept af kendte afvigelser. Den eksisterende ITB-integration alene er
ikke et kriterium for udfasning.

## 7. Åbne beslutninger og nødvendigt materiale

| Emne | Afklaring før den berørte implementering |
| --- | --- |
| Profilomfang | Hvilke profiler og versioner indgår i "alle MedComs CDA-profiler", og hvilke normative dokumenter gælder? Det nuværende katalog omfatter også PHAD, PSCR, PMR og PRF, men registrering er ikke fuld kravdækning. |
| Schematron alene | Skal XSD helt fjernes, eller kan XSD bevares som teknisk strukturkontrol, mens conformance-regler ligger i Schematron? Kravgrundlaget siger udelukkende Schematron; bevarelse af XSD kræver en eksplicit afklaring. |
| Kontroller af kildefilen | Hvordan opfyldes eksempelvis encoding-kravet, hvis regellaget alene må se et parset XML-dokument? |
| Normative uoverensstemmelser | Hvilken kilde har forrang ved konflikt mellem profiler, XSD, eksisterende regler og eksempeldokumenter? |
| Referencespørgeskema | Dokumentation, QFDD, versionsidentifikation og gyldige/ugyldige QRD-eksempler til Kræftplan V5 eller en anden aftalt første use case. |
| QFDD/QRD-kontrakt | Hvordan identificeres og leveres reference-QFDD og version, og hvordan håndteres flere mulige referencer? |
| Dokumentdelingsservicen | Testmiljø, servicekontrakt, autentifikation, testdata og metadatafelter til søgning og hentning. |
| Søgefiltre | Betydningen af dokumentversion, tilladte filterkombinationer samt hvilket tidspunkt, hvilken tidszone og hvilke intervalgrænser tidsfilteret anvender. |
| Accept og udfasning | Hvem godkender kravfortolkning, samlet dækning og overgangen fra den eksisterende MedCom-validator? |

Disse afklaringer begrænser de berørte dele af implementeringen. Kortlægning af
de eksisterende regler og etablering af dokumenterede testforventninger kan
påbegyndes på det nuværende grundlag.
