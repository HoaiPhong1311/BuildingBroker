package com.javaweb.repository;

import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.repository.entity.BuildingEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BuildingRepository extends JpaRepository<BuildingEntity, Long>, BuildingRepositoryCustom {
    List<BuildingEntity> findByNameContainingAndWardContaining(String name, String ward);

    List<BuildingEntity> findAll();

    List<BuildingEntity> findAllByIdIn(List<Long> ids);

    void deleteByIdIn(List<Long> buildingIds);

}
