package com.javaweb.repository.custom.impl;

import com.javaweb.builder.CustomerSearchBuilder;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import com.javaweb.repository.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public void queryJoin(CustomerSearchBuilder builder, StringBuilder sql) {
        String staffId = builder.getStaffId();
        if(staffId != null) {
            sql.append(" join assignmentcustomer ac on ac.customerid = c.id ");
        }
    }

    public void queryWhereNormal(CustomerSearchBuilder builder, StringBuilder where) {
        try{
            Field[] fields = CustomerSearchBuilder.class.getDeclaredFields();
            for(Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId")){
                    Object value = item.get(builder);
                    if(value != null){
                        if(item.getType().getName().equals("java.lang.Long")) {
                            where.append(" AND c." + fieldName.toLowerCase() + " = " + value);
                        }
                        else if(item.getType().getName().equals("java.lang.integer")) {
                            where.append(" AND c." + fieldName.toLowerCase() + " = " + value);
                        }
                        else if(item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND c." + fieldName.toLowerCase() + " like '%" + value + "%'");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void queryWhereSpecial(CustomerSearchBuilder builder, StringBuilder where) {
        String staffId = builder.getStaffId();
        if(staffId != null) {
            where.append(" AND ac.staffid = " + staffId);
        }
    }

    @Override
    public List<CustomerEntity> findAllCustomers(CustomerSearchBuilder builder, Pageable pageable) {
        String sql = buildQueryFilter(builder);
        Query query = entityManager.createNativeQuery(sql, CustomerEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(CustomerSearchBuilder builder) {
        String sql = buildQueryFilter(builder);
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }


    private String buildQueryFilter(CustomerSearchBuilder builder) {
        StringBuilder sql = new StringBuilder("SELECT c.* FROM customer c ");
        queryJoin(builder, sql);
        StringBuilder where = new StringBuilder("WHERE 1=1");
        queryWhereNormal(builder, where);
        queryWhereSpecial(builder, where);
        sql.append(where);
        sql.append(" and is_active = 1");
        sql.append(" GROUP BY c.id ");
        return sql.toString();
    }
}
