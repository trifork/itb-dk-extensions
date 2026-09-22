package com.trifork.ihexdsapi.service;

import java.util.List;
import org.openapitools.model.ConfigResponse;

@FunctionalInterface
public interface ConfigsService {

    List<ConfigResponse> getListOfConfigResponses();
}
