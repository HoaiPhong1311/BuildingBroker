package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TransactionType {
    CSKH("Chăm Sóc Khách Hàng"),

    DDX("Dẫn Đi Xem");

    private final String name;

    TransactionType(String name) {this.name = name;}

    public static Map<String, String> transactionType(){
        Map<String, String> map = new LinkedHashMap<>();
        for(TransactionType type : TransactionType.values()){
            map.put(type.toString(), type.name);
        }
        return map;
    }
}
