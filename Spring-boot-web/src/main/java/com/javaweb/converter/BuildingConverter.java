package com.javaweb.converter;

import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.entity.BuildingEntity;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class BuildingConverter {

    @Autowired
    private ModelMapper modelMapper;

    public BuildingDTO toBuildingDTO(BuildingEntity item) {
        BuildingDTO building = modelMapper.map(item, BuildingDTO.class);

        building.setAddress(item.getStreet() + "," + item.getWard() + "," + districtCode.valueOf(item.getDistrict()).getDistrictName());

        String rentAreas = item.getRentAreas().stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        building.setRentArea(rentAreas);

        return building;
    }

    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity item) {
        BuildingSearchResponse building = modelMapper.map(item, BuildingSearchResponse.class);

        // Kiểm tra item.getDistrict() trước khi gọi districtCode.valueOf()
        if (item.getDistrict() != null) {
            building.setAddress(item.getStreet() + "," + item.getWard() + "," + districtCode.valueOf(item.getDistrict()).getDistrictName());
        } else {
            // Xử lý trường hợp item.getDistrict() là null
            building.setAddress(item.getStreet() + "," + item.getWard() + ", null");
        }

        String rentAreas = item.getRentAreas().stream().map(it -> it.getValue().toString()).collect(Collectors.joining(","));
        building.setRentArea(rentAreas);

        return building;
    }

    public BuildingEntity toBuildingEntity(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);
        String typeCodesString = buildingDTO.getTypeCode().stream()
                .collect(Collectors.joining(","));
        buildingEntity.setTypeCode(typeCodesString);
        return buildingEntity;
    }
}
