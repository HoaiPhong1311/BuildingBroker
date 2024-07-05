package com.javaweb.controller.admin;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.enums.Status;
import com.javaweb.enums.TransactionType;
import com.javaweb.enums.districtCode;
import com.javaweb.enums.typeCode;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.request.CustomerSearchRequest;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.CustomerService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@RestController(value = "customersControllerOfAdmin")
public class CustomerController {
    @Autowired
    private IUserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    private ModelMapper modelMapper;

    @GetMapping(value = "/admin/customer-list")
    public ModelAndView customerList(@RequestParam Map<String, Object> requestParam,
                                     @ModelAttribute("modelSearch") CustomerSearchRequest searchUser,
                                     HttpServletRequest servletRequest) {
        ModelAndView mav = new ModelAndView("/admin/customer/list");
        mav.addObject("staffs", userService.getStaffs());
        mav.addObject("status", Status.type());

        DisplayTagUtils.of(servletRequest, searchUser);
        Pageable pageable = PageRequest.of(searchUser.getPage() - 1, searchUser.getMaxPageItems());
        List<CustomerDTO> result = new ArrayList<>();
        if(SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            requestParam.put("staffId", staffId);
            result = customerService.findAllCustomers(requestParam, pageable);
        }
        else {
            result = customerService.findAllCustomers(requestParam, pageable);
        }

        CustomerDTO customerDTO = new CustomerDTO();
        customerDTO.setListResult(result);
        customerDTO.setTotalItems(customerService.countTotalItems(requestParam));

        mav.addObject("customerList", customerDTO);
        mav.addObject("result", result);
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView addCustomer(@ModelAttribute("customerEdit") CustomerDTO customerDTO){
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("status", Status.type());
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView addCustomer(@PathVariable Long id){
        ModelAndView mav = new ModelAndView("admin/customer/edit");

        CustomerDTO customerDTO = customerService.prepareCustomer(id);
        mav.addObject("customerEdit", customerDTO);
        mav.addObject("status", Status.type());

        mav.addObject("transactionType", TransactionType.transactionType());
        List<TransactionEntity> list = transactionRepository.findByCodeAndAndCustomerId("CSKH", id.toString());
        List<TransactionEntity> list2 = transactionRepository.findByCodeAndAndCustomerId("DDX", id.toString());
        List<TransactionDTO> transactionDTOList = list.stream()
                .map(entity -> modelMapper.map(entity, TransactionDTO.class))
                .collect(Collectors.toList());
        List<TransactionDTO> transactionDTOList2 = list2.stream()
                .map(entity -> modelMapper.map(entity, TransactionDTO.class))
                .collect(Collectors.toList());

        mav.addObject("transactionList", transactionDTOList);
        mav.addObject("transactionList2", transactionDTOList2);
        return mav;
    }
}
