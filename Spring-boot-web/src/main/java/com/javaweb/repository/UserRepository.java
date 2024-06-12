package com.javaweb.repository;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.custom.UserRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> , UserRepositoryCustom {

//    @Query("SELECT ab.staffId from AssignmentBuildingEntity ab WHERE ab.buildingId = :buildingid")
//    List<Long> findByBuildingId(@Param("buildingid") Long buildingid);

    @Query("SELECT u FROM UserEntity u JOIN u.buildings b WHERE b.id = :buildingid")
    List<UserEntity> findStaffByBuildingId(@Param("buildingid") Long buildingid);

    List<UserEntity> findByIdIn(List<Long> ids);

    UserEntity findOneByUserNameAndStatus(String name, int status);
    Page<UserEntity> findByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status,
                                                                                                  Pageable pageable);
    List<UserEntity> findByStatusAndRoles_Code(Integer status, String roleCode);
    Page<UserEntity> findByStatusNot(int status, Pageable pageable);
    long countByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(String userName, String fullName, int status);
    long countByStatusNot(int status);
    UserEntity findOneByUserName(String userName);
}
