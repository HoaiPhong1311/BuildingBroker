package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum typeCode {
    TANG_TRET("Tầng trệt"),
    NOI_THAT("Nội thất"),
    NGUYEN_CAN("Nguyên căn");

    private final String typeCodeName;

    typeCode(String typeCodeName){
        this.typeCodeName = typeCodeName;
    }

    public String getTypeCodeName() {
        return typeCodeName;
    }

    public static Map<String, String> getTypeCode(){
        Map<String, String> listTypeCode = new LinkedHashMap<>();
        for(typeCode item : typeCode.values()){
            listTypeCode.put(item.toString(), item.getTypeCodeName());
        }
        return listTypeCode;
    }
}
