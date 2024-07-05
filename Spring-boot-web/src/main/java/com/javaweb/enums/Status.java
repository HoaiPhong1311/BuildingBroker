package com.javaweb.enums;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

public enum Status {
    CHUA_XU_LY("Chưa xử lý"),

    DANG_XU_LY("Đang xử lý"),

    DA_XU_LY("Đã xử lý");

    private String statusName;

    Status(String statusName) {this.statusName = statusName;}

    public String getStatusName() {return statusName;}

    public static Map<String, String> type(){
        Map<String, String> map = new LinkedHashMap<>();
        for (Status s : Status.values()) {
            map.put(s.getStatusName(), s.getStatusName());
        }
        return map;
    }


}
