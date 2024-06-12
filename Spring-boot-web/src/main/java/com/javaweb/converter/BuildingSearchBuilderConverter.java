package com.javaweb.converter;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.utils.MapUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class BuildingSearchBuilderConverter {
    public BuildingSearchBuilder toBuildingSearchBuilder(Map<String, Object> requestParam, List<String> typeCode){
        BuildingSearchBuilder builder = new BuildingSearchBuilder.Builder()
                .setName(MapUtils.getObject(requestParam, "name", String.class))
                .setWard(MapUtils.getObject(requestParam, "ward", String.class))
                .setStreet(MapUtils.getObject(requestParam, "street", String.class))
                .setDistrict(MapUtils.getObject(requestParam, "district", String.class))
                .setNumberOfBasement(MapUtils.getObject(requestParam, "numberOfBasement", Long.class))
                .setManagerName(MapUtils.getObject(requestParam, "managerName", String.class))
                .setManagerPhoneNumber(MapUtils.getObject(requestParam, "managerPhone", String.class))
                .setTypeCode(typeCode)
                .setFloorArea(MapUtils.getObject(requestParam, "floorArea", Long.class))
                .setRentPriceFrom(MapUtils.getObject(requestParam, "rentPriceFrom", Long.class))
                .setRentPriceTo(MapUtils.getObject(requestParam, "rentPriceTo", Long.class))
                .setAreaFrom(MapUtils.getObject(requestParam, "areaFrom", Long.class))
                .setAreaTo(MapUtils.getObject(requestParam, "areaTo", Long.class))
                .setStaffId(MapUtils.getObject(requestParam, "staffId", Long.class))
                .setDirection(MapUtils.getObject(requestParam, "direction", String.class))
                .setLevel(MapUtils.getObject(requestParam, "level", String.class))
                .build();

        return builder;
    }
}
