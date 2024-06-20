package com.javaweb.repository.custom;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface BuildingRepositoryCustom {
    public List<BuildingEntity> findAllBuildings(BuildingSearchBuilder builder, Pageable pageable);
    int countTotalItem(BuildingSearchBuilder builder);
}
