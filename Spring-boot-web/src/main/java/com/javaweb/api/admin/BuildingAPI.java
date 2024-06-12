package com.javaweb.api.admin;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.repository.entity.BuildingEntity;
import com.javaweb.service.BuildingService;
import com.javaweb.service.impl.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/buildings")
public class BuildingAPI {

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private UserService userService;
    @Autowired
    private ModelMapper modelMapper;

    @PostMapping
    public String addBuilding(@RequestBody BuildingDTO buildingDTO){
        buildingService.saveOrUpdateBuilding(null, buildingDTO);
        return new String("Add Building Success");
    }

    @PostMapping("/{id}")
    public String updateBuilding(@PathVariable Long id, @RequestBody BuildingDTO buildingDTO){
        buildingService.saveOrUpdateBuilding(id, buildingDTO);
        return new String("Update Building Success");
    }

    @DeleteMapping("/{ids}")
    public String deleteBuilding(@PathVariable Long[] ids){
        buildingService.deleteBuilding(ids);
        return new String("Delete Building Success");
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaff(@PathVariable("id") Long id){
        return userService.loadStaffByBuilding(id);
    }

    @PutMapping
    public String updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO){
        buildingService.assignBuildingToStaff(assignmentBuildingDTO);
        return new String("Update Assignment Building Success");
    }
}
