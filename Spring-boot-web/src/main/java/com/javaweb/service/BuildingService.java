package com.javaweb.service;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.repository.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

public interface BuildingService {
    List<BuildingSearchResponse> findAll(Map<String, Object> requestParam, List<String> typeCode, Pageable pageable);

    void deleteBuilding(Long[] ids);

    ResponseDTO assignBuildingToStaff(AssignmentBuildingDTO assignmentBuildingDTO);

    BuildingDTO prepareBuildingEditData(Long id);

    void saveOrUpdateBuilding(Long id, BuildingDTO buildingDTO);

    int countTotalItems();

}
