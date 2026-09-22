package com.trifork.ihexdsapi.service;

import java.util.List;
import org.openapitools.model.Code;

public interface CodesService {

    List<Code> getFormatCodesList();

    List<Code> getHealthcareFacilityTypeCodesList();

    List<Code> getEventCodesList();

    List<Code> getPractiseSettingCodesList();

    List<Code> getAvailabilityStatusList();

    List<Code> getDocumentTypeList();

    List<Code> getTypeCodesList();

    String getClassCodeNameFromCode(String classCode);
}
