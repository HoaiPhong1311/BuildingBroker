package com.javaweb.api.admin;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.CustomerService;
import com.javaweb.service.TransactionService;
import com.javaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;

@RestController
@RequestMapping("/api/customers")
public class CustomerAPI {

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private TransactionService transactionService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CustomerRepository customerRepository;

    @PostMapping
    public String addCustomer(@RequestBody CustomerDTO customerDTO){
        customerDTO.setCreatedDate(new Date());
        customerDTO.setActiveStatus("1");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication != null && authentication.getPrincipal() instanceof UserDetails){
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            customerDTO.setCreatedBy(userDetails.getUsername());

            Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
            boolean isManager = authorities.contains(new SimpleGrantedAuthority("ROLE_MANAGER"));
            boolean isStaff = authorities.contains(new SimpleGrantedAuthority("ROLE_STAFF"));

            Long customerId = customerService.saveOrUpdateCustomer(null, customerDTO);

            if(isStaff){
                UserEntity userEntity = userRepository.findOneByUserName(userDetails.getUsername());
                AssignmentCustomerDTO assignmentCustomerDTO = new AssignmentCustomerDTO();
                assignmentCustomerDTO.setCustomerId(customerId);
                assignmentCustomerDTO.setStaffs(Collections.singletonList(userEntity.getId()));
                customerService.assignCustomerToStaff(assignmentCustomerDTO);
            }

            return new String("Add Customer Success");
        }
        else {
            customerDTO.setStatus("Chưa xử lý");
            customerDTO.setCreatedBy("Anonymous");
            customerService.saveOrUpdateCustomer(null, customerDTO);
            return new String("Gửi thông tin thành công");
        }
    }

    @PostMapping("/{id}")
    public String updateCustomer(@PathVariable Long id, @RequestBody CustomerDTO customerDTO){
        customerDTO.setModifiedDate(new Date());
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(authentication != null && authentication.getPrincipal() instanceof UserDetails){
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            customerDTO.setModifiedBy(userDetails.getUsername());
        }
        customerService.saveOrUpdateCustomer(id, customerDTO);
        return new String("Update Customer Success");
    }

    @DeleteMapping("/{ids}")
    public String deleteCustomer(@PathVariable Long[] ids){
        customerService.deleteCustomer(ids);
        return new String("Delete Customer Success");
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaff(@PathVariable("id") Long id){
        return userService.loadstaffByCustomer(id);
    }

    @PutMapping
    public String updateAssignmentCustomer(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO){
        customerService.assignCustomerToStaff(assignmentCustomerDTO);
        return new String("Update Assignment Customer Success");
    }

    @PostMapping("/transaction")
    public String addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO){
        transactionService.addOrUpdateTransaction(transactionDTO);
        return new String("Update or Add Transaction Success");
    }

    @GetMapping("/transactions/{id}")
    public ResponseDTO loadTransaction(@PathVariable Long id){
        TransactionDTO transactionDTO = transactionService.getTransactionById(id);
        ResponseDTO result = new ResponseDTO();
        result.setData(transactionDTO);
        result.setMessage("Success");
        return result;
    }
}
