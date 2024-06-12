package com.javaweb.repository;

import com.javaweb.repository.entity.BuildingEntity;
import com.javaweb.repository.entity.RentAreaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RentAreaRepository extends JpaRepository<RentAreaEntity, Long> {
    void deleteAllByBuildingIdIn(List<BuildingEntity> buildings);
    void deleteAllByBuildingIdIn(BuildingEntity buildings);
}
