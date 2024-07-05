package com.javaweb.converter;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.utils.MapUtils;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class CustomerSearchBuilderConverter {
    public CustomerSearchBuilder toCustomerSearchBuilder(Map<String, Object> requestParam){
        CustomerSearchBuilder builder = new CustomerSearchBuilder.Builder()
                .setFullName(MapUtils.getObject(requestParam, "fullName", String.class))
                .setPhone(MapUtils.getObject(requestParam, "phone", String.class))
                .setEmail(MapUtils.getObject(requestParam, "email", String.class))
                .setStatus(MapUtils.getObject(requestParam, "status", String.class))
                .setStaffId(MapUtils.getObject(requestParam, "staffId", String.class))
                .build();

        return builder;
    }
}
