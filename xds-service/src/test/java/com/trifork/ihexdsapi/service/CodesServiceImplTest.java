package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.service.impl.CodesServiceImpl;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CodesServiceImplTest {

    // @Autowired
    private CodesServiceImpl subject;

    @BeforeEach
    void setup() throws CodesExecption {

        // A lot of variables
        String typeCodeCodes = "53576-5;74468-0;74465-6;11502-2;56446-8;";
        String typeCodeNames =
                "Personal health monitoring report Document;Questionnaire Form Definition"
                        + " Document;Questionnaire Response Document;LABORATORY"
                        + " REPORT.TOTAL;Appointment Summary Document;";
        String typeCodeScheme = "2.16.840.1.113883.6.1";
        String formatCodeCodes =
                "urn:ad:dk:medcom:phmr:full;urn:ad:dk:medcom:qfdd:full;urn:ad:dk:medcom:qrd:full;urn:ad:dk:medcom:appointmentsummary:full;urn:ad:dk:medcom:labreports:svareksponeringsservice;";
        String formatCodeNames =
                "DK PHMR schema;DK QFDD schema;DK QRD schema;DK Appointment Summary Document"
                        + " schema;Laboratoriesvar (samling af svar);";
        String formatCodeScheme = "1.2.208.184.100.10";
        String eventCodeCodes = "1.2.208.176.2.1;1.2.208.176.2.4;";
        String eventCodeNames = "NPU;Episode of care label;";

        String healthcareFacilityTypeCodeCodes =
                "N/A;264372000;20078004;554221000005108;554031000005103;546821000005103;547011000005103;546811000005109;550621000005101;22232009;550631000005103;550641000005106;550651000005108;394761003;550661000005105;42665001;554211000005102;550711000005101;550671000005100;554061000005105;264361005;554041000005106;554021000005101;550681000005102;550691000005104;550701000005104;554231000005106;554051000005108;";
        String healthcareFacilityTypeCodeNames =
                "N/A;apotek;behandlingscenter for"
                        + " stofmisbrugere;bosted;diætistklinik;ergoterapiklinik;fysioterapiklinik;genoptræningscenter"
                        + " (snomed:"
                        + " rehabiliteringscenter);hjemmesygepleje;hospital;jordemoderklinik;kiropraktor"
                        + " klinik;lægelaboratorium;lægepraksis (snomed:  almen"
                        + " lægepraksis);lægevagt;plejehjem;præhospitals enhed (snomed: "
                        + " præhospitalsenhed);psykologisk"
                        + " rådgivningsklinik;speciallægepraksis;statsautoriseret fodterapeut (snomed: "
                        + " fodterapeutklinik);sundhedscenter;sundhedsforvaltning;sundhedspleje;tandlægepraksis;tandpleje"
                        + " klinik;tandteknisk klinik;vaccinationsklinik;zoneterapiklinik;";
        String healthcareFacilityTypeCodeScheme = "2.16.840.1.113883.6.96";
        String practiceSettingCodeCodes =
                "N/A;408443003;394577000;394821009;394588006;394582007;394914008;394583002;394811001;394585009;408472002;394803006;394807007;419192003;394579002;408463005;394609007;551411000005104;394596001;394600006;394601005;394580004;421661004;408454008;394809005;394592004;418112009;394805004;394584008;394589003;394610002;394591006;394812008;394594003;394801008;394604002;394915009;394611003;394587001;394537008;394810000;554011000005107;394581000;394605001;394603008;408448007;394612005;";
        String practiceSettingCodeNames =
                "N/A;almen medicin;anæstesiologi;arbejdsmedicin;børne- og"
                        + " ungdomspsykiatri;dermato-venerologi;diagnostisk"
                        + " radiologi;endokrinologi;geriatri;gynækologi og"
                        + " obstetrik;hepatologi;hæmatologi;infektionsmedicin;intern"
                        + " medicin;kardiologi;karkirurgi;kirurgi;kirurgisk gastroenterologi;klinisk"
                        + " biokemi;klinisk farmakologi;klinisk fysiologi og nuklearmedicin (snomed: "
                        + " klinisk fysiologi);klinisk genetik;klinisk immunologi;klinisk"
                        + " mikrobiologi;klinisk neurofysiologi;klinisk"
                        + " onkologi;lungesygdomme;medicinsk allergologi;medicinsk"
                        + " gastroenterologi;nefrologi;neurokirurgi;neurologi;odontologi (snomed:"
                        + " odontologiske specialer);oftalmologi;ortopædisk"
                        + " kirurgi;oto-rhino-laryngologi;patologisk anatomi og"
                        + " cytologi;plastikkirurgi;psykiatri;pædiatri;reumatologi;Retsmedicin;samfundsmedicin;tand-,"
                        + " mund- og kæbekirurgi;thoraxkirurgi;tropemedicin;urologi;";
        String practiceSettingCodeScheme = "2.16.840.1.113883.6.96";
        String classCodeCodes = "001";
        String classCodeNames = "Clinical report;";
        String classCodeScheme = "1.2.208.184.100.9";

        subject =
                new CodesServiceImpl(
                        new CodesServiceImpl.CodeListDefinition(
                                typeCodeCodes, typeCodeNames, typeCodeScheme),
                        new CodesServiceImpl.CodeListDefinition(
                                formatCodeCodes, formatCodeNames, formatCodeScheme),
                        new CodesServiceImpl.CodeListDefinition(eventCodeCodes, eventCodeNames, ""),
                        new CodesServiceImpl.CodeListDefinition(
                                healthcareFacilityTypeCodeCodes,
                                healthcareFacilityTypeCodeNames,
                                healthcareFacilityTypeCodeScheme),
                        new CodesServiceImpl.CodeListDefinition(
                                practiceSettingCodeCodes,
                                practiceSettingCodeNames,
                                practiceSettingCodeScheme),
                        new CodesServiceImpl.CodeListDefinition(
                                classCodeCodes, classCodeNames, classCodeScheme));
    }

    @Test
    void testFailedCreatingCodeServiceImpl() {
        String typeCodeCodes = "53576-5;74468-0;74465-6;11502-2;56446-8;62-3344";
        String typeCodeNames =
                "Personal health monitoring report Document;Questionnaire Form Definition"
                        + " Document;Questionnaire Response Document;LABORATORY"
                        + " REPORT.TOTAL;Appointment Summary Document;";
        String typeCodeScheme = "2.16.840.1.113883.6.1";
        String formatCodeCodes =
                "urn:ad:dk:medcom:phmr:full;urn:ad:dk:medcom:qfdd:full;urn:ad:dk:medcom:qrd:full;urn:ad:dk:medcom:appointmentsummary:full;urn:ad:dk:medcom:labreports:svareksponeringsservice;";
        String formatCodeNames =
                "DK PHMR schema;DK QFDD schema;DK QRD schema;DK Appointment Summary Document"
                        + " schema;Laboratoriesvar (samling af svar);";
        String formatCodeScheme = "1.2.208.184.100.10";
        String eventCodeCodes = "1.2.208.176.2.1;1.2.208.176.2.4;";
        String eventCodeNames = "NPU;Episode of care label;";

        String healthcareFacilityTypeCodeCodes =
                "N/A;264372000;20078004;554221000005108;554031000005103;546821000005103;547011000005103;546811000005109;550621000005101;22232009;550631000005103;550641000005106;550651000005108;394761003;550661000005105;42665001;554211000005102;550711000005101;550671000005100;554061000005105;264361005;554041000005106;554021000005101;550681000005102;550691000005104;550701000005104;554231000005106;554051000005108;";
        String healthcareFacilityTypeCodeNames =
                "N/A;apotek;behandlingscenter for"
                        + " stofmisbrugere;bosted;diætistklinik;ergoterapiklinik;fysioterapiklinik;genoptræningscenter"
                        + " (snomed:"
                        + " rehabiliteringscenter);hjemmesygepleje;hospital;jordemoderklinik;kiropraktor"
                        + " klinik;lægelaboratorium;lægepraksis (snomed:  almen"
                        + " lægepraksis);lægevagt;plejehjem;præhospitals enhed (snomed: "
                        + " præhospitalsenhed);psykologisk"
                        + " rådgivningsklinik;speciallægepraksis;statsautoriseret fodterapeut (snomed: "
                        + " fodterapeutklinik);sundhedscenter;sundhedsforvaltning;sundhedspleje;tandlægepraksis;tandpleje"
                        + " klinik;tandteknisk klinik;vaccinationsklinik;zoneterapiklinik;";
        String healthcareFacilityTypeCodeScheme = "2.16.840.1.113883.6.96";
        String practiceSettingCodeCodes =
                "N/A;408443003;394577000;394821009;394588006;394582007;394914008;394583002;394811001;394585009;408472002;394803006;394807007;419192003;394579002;408463005;394609007;551411000005104;394596001;394600006;394601005;394580004;421661004;408454008;394809005;394592004;418112009;394805004;394584008;394589003;394610002;394591006;394812008;394594003;394801008;394604002;394915009;394611003;394587001;394537008;394810000;554011000005107;394581000;394605001;394603008;408448007;394612005;";
        String practiceSettingCodeNames =
                "N/A;almen medicin;anæstesiologi;arbejdsmedicin;børne- og"
                        + " ungdomspsykiatri;dermato-venerologi;diagnostisk"
                        + " radiologi;endokrinologi;geriatri;gynækologi og"
                        + " obstetrik;hepatologi;hæmatologi;infektionsmedicin;intern"
                        + " medicin;kardiologi;karkirurgi;kirurgi;kirurgisk gastroenterologi;klinisk"
                        + " biokemi;klinisk farmakologi;klinisk fysiologi og nuklearmedicin (snomed: "
                        + " klinisk fysiologi);klinisk genetik;klinisk immunologi;klinisk"
                        + " mikrobiologi;klinisk neurofysiologi;klinisk"
                        + " onkologi;lungesygdomme;medicinsk allergologi;medicinsk"
                        + " gastroenterologi;nefrologi;neurokirurgi;neurologi;odontologi (snomed:"
                        + " odontologiske specialer);oftalmologi;ortopædisk"
                        + " kirurgi;oto-rhino-laryngologi;patologisk anatomi og"
                        + " cytologi;plastikkirurgi;psykiatri;pædiatri;reumatologi;Retsmedicin;samfundsmedicin;tand-,"
                        + " mund- og kæbekirurgi;thoraxkirurgi;tropemedicin;urologi;";
        String practiceSettingCodeScheme = "2.16.840.1.113883.6.96";
        String classCodeCodes = "001";
        String classCodeNames = "Clinical report;";
        String classCodeScheme = "1.2.208.184.100.9";

        Assertions.assertThrows(
                CodesExecption.class,
                () ->
                        new CodesServiceImpl(
                                new CodesServiceImpl.CodeListDefinition(
                                        typeCodeCodes, typeCodeNames, typeCodeScheme),
                                new CodesServiceImpl.CodeListDefinition(
                                        formatCodeCodes, formatCodeNames, formatCodeScheme),
                                new CodesServiceImpl.CodeListDefinition(
                                        eventCodeCodes, eventCodeNames, ""),
                                new CodesServiceImpl.CodeListDefinition(
                                        healthcareFacilityTypeCodeCodes,
                                        healthcareFacilityTypeCodeNames,
                                        healthcareFacilityTypeCodeScheme),
                                new CodesServiceImpl.CodeListDefinition(
                                        practiceSettingCodeCodes,
                                        practiceSettingCodeNames,
                                        practiceSettingCodeScheme),
                                new CodesServiceImpl.CodeListDefinition(
                                        classCodeCodes, classCodeNames, classCodeScheme)));
    }

    @Test
    void testGetTypeCodesList() {
        Assertions.assertEquals(5, subject.getTypeCodesList().size());
    }

    @Test
    void testGetEventCodesList() {
        Assertions.assertEquals(2, subject.getEventCodesList().size());
    }

    @Test
    void testGetDocumentTypeList() {

        Assertions.assertEquals(2, subject.getDocumentTypeList().size());
    }

    @Test
    void testGetFormatCodesList() {
        Assertions.assertEquals(5, subject.getFormatCodesList().size());
    }

    @Test
    void testGetPractiseSettingCodesList() {
        Assertions.assertEquals(47, subject.getPractiseSettingCodesList().size());
    }

    @Test
    void testGetAvailabilityStatusList() {
        Assertions.assertEquals(3, subject.getAvailabilityStatusList().size());
    }

    @Test
    void testGetHealthcareFacilityTypeCodesList() {
        Assertions.assertEquals(28, subject.getHealthcareFacilityTypeCodesList().size());
    }
}
