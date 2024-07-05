package com.javaweb.converter;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.CustomerDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper modelMapper;

    public CustomerDTO convertToDto(CustomerEntity customerEntity) {
        return modelMapper.map(customerEntity, CustomerDTO.class);
    }

    public CustomerEntity convertToEntity(CustomerDTO customerDTO) {
        return modelMapper.map(customerDTO, CustomerEntity.class);
    }
}
