package com.javaweb.repository.custom;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.entity.CustomerEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CustomerRepositoryCustom {
    public List<CustomerEntity> findAllCustomers(CustomerSearchBuilder builder, Pageable pageable);
    int countTotalItem(CustomerSearchBuilder builder);
}
