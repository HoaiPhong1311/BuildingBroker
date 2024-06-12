package com.javaweb.repository.custom;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.response.StaffResponseDTO;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepositoryCustom {
	List<UserEntity> findByRole(String roleCode);
	List<UserEntity> getAllUsers(Pageable pageable);
	int countTotalItem();

}
