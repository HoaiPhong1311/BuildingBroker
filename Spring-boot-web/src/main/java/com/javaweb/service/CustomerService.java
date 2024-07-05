package com.javaweb.service;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface CustomerService {
    List<CustomerDTO> findAllCustomers(Map<String, Object> requestParam, Pageable pageable);

    int countTotalItems(Map<String, Object> requestParam);

    void saveOrUpdateCustomer(Long id, CustomerDTO customerDTO);

    CustomerDTO prepareCustomer(Long id);

    void deleteCustomer(Long[] ids);

    ResponseDTO assignCustomerToStaff(AssignmentCustomerDTO assignmentCustomerDTO);
}
