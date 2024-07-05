package com.javaweb.repository.custom.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import com.javaweb.repository.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public void queryJoin(BuildingSearchBuilder builder, StringBuilder sql){
        Long staffId = builder.getStaffId();
        if(staffId != null) {
            sql.append(" JOIN assignmentbuilding ab on ab.buildingid = b.id ");
        }
    }

    public void queryWhereNormal(BuildingSearchBuilder builder, StringBuilder where){
        try {
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for(Field item : fields) {
                // Phai cap quyen neu khong se bi loi
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId")  && !fieldName.equals("typeCode")
                        && !fieldName.startsWith("area") && !fieldName.startsWith("rentPrice")) {
                    Object value = item.get(builder);
                    if(value != null) {
                        if(item.getType().getName().equals("java.lang.Long")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " = " + value);
                        }
                        else if(item.getType().getName().equals("java.lang.integer")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " = " + value);
                        }
                        else if(item.getType().getName().equals("java.lang.String")) {
                            where.append(" AND b." + fieldName.toLowerCase() + " like '%" + value + "%'");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void queryWhereSpecial(BuildingSearchBuilder builder, StringBuilder where){
        Long staffId = builder.getStaffId();
        if(staffId != null) {
            where.append(" AND ab.staffid = " + staffId);
        }

        // Cach dung Exists
        Long rentAreaFrom = builder.getAreaFrom();
        Long rentAreaTo = builder.getAreaTo();
        if(rentAreaFrom != null || rentAreaTo != null) {
            where.append(" AND EXISTS (SELECT * FROM rentarea r WHERE r.buildingid = b.id ");
            if(rentAreaFrom != null) {
                where.append(" AND r.value >= " + rentAreaFrom);
            }
            if(rentAreaTo != null) {
                where.append(" AND r.value <= " + rentAreaTo);
            }
            where.append(") ");
        }

        Long rentPriceFrom = builder.getRentPriceFrom();
        Long rentPriceTo = builder.getRentPriceTo();
        if(rentPriceFrom != null) {
            where.append(" AND rentprice >= " + rentPriceFrom);
        }
        if(rentPriceTo != null) {
            where.append(" AND rentprice <= " + rentPriceTo);
        }

        List<String> typeCode = builder.getTypeCode();
        if(typeCode != null && !typeCode.isEmpty()){
            where.append(" AND (");
            String sqlJoin = typeCode.stream().map(item -> "b.type LIKE '%" + item + "%' ").collect(Collectors.joining(" OR "));
            where.append(sqlJoin + ") ");
        }
    }

    @Override
    public List<BuildingEntity> findAllBuildings(BuildingSearchBuilder builder, Pageable pageable) {
        String sql = buildQueryFilter(builder);
        Query query = entityManager.createNativeQuery(sql, BuildingEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(BuildingSearchBuilder builder) {
        String sql = buildQueryFilter(builder);
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }

    private String buildQueryFilter(BuildingSearchBuilder builder) {
        StringBuilder sql = new StringBuilder("SELECT b.* FROM building b ");
        queryJoin(builder, sql);
        StringBuilder where = new StringBuilder("WHERE 1=1");
        queryWhereNormal(builder, where);
        queryWhereSpecial(builder, where);
        sql.append(where);
        sql.append(" GROUP BY b.id ");
        return sql.toString();
    }


}
