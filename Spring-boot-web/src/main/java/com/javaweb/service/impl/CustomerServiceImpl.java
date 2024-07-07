package com.javaweb.service.impl;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.converter.CustomerConverter;
import com.javaweb.converter.CustomerSearchBuilderConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.CustomerService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    CustomerSearchBuilderConverter customerSearchBuilderConverter;

    @Autowired
    CustomerRepository customerRepository;

    @Autowired
    CustomerConverter customerConverter;

    @Autowired
    UserRepository userRepository;


    @Override
    public List<CustomerDTO> findAllCustomers(Map<String, Object> requestParam, Pageable pageable) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(requestParam);
        List<CustomerEntity> customerEntities = customerRepository.findAllCustomers(customerSearchBuilder, pageable);
        List<CustomerDTO> result = new ArrayList<>();
        for (CustomerEntity item : customerEntities) {
            CustomerDTO customer = customerConverter.convertToDto(item);
            result.add(customer);
        }
        return result;
    }

    @Override
    public int countTotalItems(Map<String, Object> requestParam) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(requestParam);
        return customerRepository.countTotalItem(customerSearchBuilder);
    }

    @Override
    @Transactional
    public void saveOrUpdateCustomer(Long id, CustomerDTO customerDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            if (id == null) {
                customerDTO.setCreatedDate(new Date());
                customerDTO.setActiveStatus("1");
                customerDTO.setCreatedBy(userDetails.getUsername());
            } else {
                customerDTO.setModifiedDate(new Date());
                customerDTO.setModifiedBy(userDetails.getUsername());
            }

            Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
            boolean isManager = authorities.contains(new SimpleGrantedAuthority("ROLE_MANAGER"));
            boolean isStaff = authorities.contains(new SimpleGrantedAuthority("ROLE_STAFF"));

            CustomerEntity customer;
            if (id == null) {
                customer = customerConverter.convertToEntity(customerDTO);
                customerRepository.save(customer);
                id = customer.getId();
            } else {
                customer = customerRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Customer not found"));
                BeanUtils.copyProperties(customerDTO, customer, "id", "createdBy", "createdDate", "activeStatus");
                customerRepository.save(customer);
            }

            if (isStaff && id != null) {
                UserEntity userEntity = userRepository.findOneByUserName(userDetails.getUsername());
                AssignmentCustomerDTO assignmentCustomerDTO = new AssignmentCustomerDTO();
                assignmentCustomerDTO.setCustomerId(id);
                assignmentCustomerDTO.setStaffs(Collections.singletonList(userEntity.getId()));
                assignCustomerToStaff(assignmentCustomerDTO);
            }
        } else {
            customerDTO.setStatus("Chưa xử lý");
            customerDTO.setCreatedBy("Anonymous");
            customerRepository.save(customerConverter.convertToEntity(customerDTO));
        }
    }

    @Override
    @Transactional
    public CustomerDTO prepareCustomer(Long id) {
        CustomerEntity customer = customerRepository.findById(id).get();
        CustomerDTO customerDTO = customerConverter.convertToDto(customer);
        return customerDTO;
    }

    @Override
    public void deleteCustomer(Long[] ids) {
        List<Long> idList = Arrays.asList(ids);
        List<CustomerEntity> customers = customerRepository.findByIdIn(idList);
        for (CustomerEntity customer : customers) {
            customer.setActiveStatus("0");
        }
        customerRepository.saveAll(customers);
    }

    @Override
    public ResponseDTO assignCustomerToStaff(AssignmentCustomerDTO assignmentCustomerDTO) {
        Long customerId = assignmentCustomerDTO.getCustomerId();
        List<Long> staffIds = assignmentCustomerDTO.getStaffs();

        CustomerEntity customer = customerRepository.findById(customerId).get();
        List<UserEntity> staffMembers = userRepository.findByIdIn(staffIds);
        customer.setUserCus(staffMembers);
        customerRepository.save(customer);

        ResponseDTO response = new ResponseDTO();
        response.setMessage("Giao khách hàng thành công");
        return response;
    }

    public boolean canEditCustomer(Long id, String username) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null) {
            return false;
        }

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            if ("ROLE_MANAGER".equals(authority.getAuthority())) {
                return true;
            }
        }

        CustomerEntity customer = customerRepository.findById(id).orElse(null);
        if (customer == null) {
            return false;
        }

        for (UserEntity staff : customer.getUserCus()) {
            if (staff.getUserName().equals(username)) {
                return true;
            }
        }

        return false;
    }


}
