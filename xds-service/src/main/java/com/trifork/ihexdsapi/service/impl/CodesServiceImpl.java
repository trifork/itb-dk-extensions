package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.service.CodesExecption;
import com.trifork.ihexdsapi.service.CodesService;
import java.util.LinkedList;
import java.util.List;
import org.openapitools.model.Code;

public class CodesServiceImpl implements CodesService {

    public record CodeListDefinition(String codes, String names, String scheme) {}

    private List<Code> typeCodesList;
    private List<Code> formatCodesList;
    private List<Code> healthcareFacilityTypeCodesList;
    private List<Code> eventCodesList;
    private List<Code> practiseSettingCodesList;
    private List<Code> availabilityStatusList;
    private List<Code> documentTypeList;

    private List<Code> classCodeList;

    public CodesServiceImpl(
            CodeListDefinition type,
            CodeListDefinition format,
            CodeListDefinition event,
            CodeListDefinition facility,
            CodeListDefinition practice,
            CodeListDefinition documentClass)
            throws CodesExecption {
        typeCodesList =
                generateListOfCodes(
                        type, "Amount of type codes doesn't match amount of type codes names");
        formatCodesList =
                generateListOfCodes(
                        format, "Amount of type codes doesn't match amount of format codes names");
        eventCodesList =
                generateListOfCodes(
                        event, "Amount of type codes doesn't match amount of event codes names");
        healthcareFacilityTypeCodesList =
                generateListOfCodes(
                        facility,
                        "Amount of type codes doesn't match amount of healthcare type codes names");
        practiseSettingCodesList =
                generateListOfCodes(
                        practice,
                        "Amount of type codes doesn't match amount of practicesetting codes names");
        classCodeList =
                generateListOfCodes(
                        documentClass,
                        "Amount of type codes doesn't match amount of class codes names");
        availabilityStatusList = generateListOfAvailabilityStatus();
        documentTypeList = generateDocumentType();
    }

    private List<Code> generateListOfAvailabilityStatus() {
        List<Code> codesCollection = new LinkedList<>();

        // Approved
        Code c = new Code();
        c.setCode("APPROVED");
        c.setName("Approved");
        c.setScheme(" ");

        codesCollection.add(c);
        // Deprecated
        c = new Code();
        c.setCode("DEPRECATED");
        c.setName("Deprecated");
        c.setScheme(" ");

        codesCollection.add(c);
        // Submitted
        c = new Code();
        c.setCode("SUBMITTED");
        c.setName("Submitted");
        c.setScheme(" ");

        codesCollection.add(c);
        return codesCollection;
    }

    private List<Code> generateDocumentType() {
        List<Code> codesCollection = new LinkedList<>();

        // Approved
        Code c = new Code();
        c.setCode("STABLE");
        c.setName("Stable");
        c.setScheme(" ");

        codesCollection.add(c);
        // Deprecated
        c = new Code();
        c.setCode("ON-DEMAND");
        c.setName("On-demand");
        c.setScheme(" ");
        codesCollection.add(c);

        return codesCollection;
    }

    private List<Code> generateListOfCodes(CodeListDefinition definition, String execptionMsg)
            throws CodesExecption {
        String[] codesArray = definition.codes().split(";");
        String[] namesArray = definition.names().split(";");
        String scheme = definition.scheme();
        if (codesArray.length != namesArray.length) {
            throw new CodesExecption(200, execptionMsg);
        }
        List<Code> codesCollection = new LinkedList<>();

        for (int i = 0; i < codesArray.length; i++) {
            Code temp = new Code();
            temp.setCode(codesArray[i]);
            temp.setName(namesArray[i]);
            temp.setScheme(scheme);
            codesCollection.add(temp);
        }
        return codesCollection;
    }

    @Override
    public List<Code> getTypeCodesList() {
        return List.copyOf(typeCodesList);
    }

    @Override
    public String getClassCodeNameFromCode(String classCode) {
        List<Code> classCodes = getClassCodeList();
        int i = 0;

        while (i < classCodes.size()) {
            if (java.util.Objects.equals(classCodes.get(i).getCode(), classCode)) {
                return classCodes.get(i).getName();
            }
            i++;
        }
        return null;
    }

    @Override
    public List<Code> getFormatCodesList() {
        return List.copyOf(formatCodesList);
    }

    @Override
    public List<Code> getHealthcareFacilityTypeCodesList() {
        return List.copyOf(healthcareFacilityTypeCodesList);
    }

    @Override
    public List<Code> getEventCodesList() {
        return List.copyOf(eventCodesList);
    }

    @Override
    public List<Code> getPractiseSettingCodesList() {
        return List.copyOf(practiseSettingCodesList);
    }

    @Override
    public List<Code> getAvailabilityStatusList() {
        return List.copyOf(availabilityStatusList);
    }

    @Override
    public List<Code> getDocumentTypeList() {
        return List.copyOf(documentTypeList);
    }

    public List<Code> getClassCodeList() {
        return List.copyOf(classCodeList);
    }
}
