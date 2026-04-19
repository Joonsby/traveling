package com.traveling.stay.dto;

import java.util.List;

public class FacilityCategoryInfo {
    private String categoryName;
    private List<String> facilityList;

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<String> getFacilityList() {
        return facilityList;
    }

    public void setFacilityList(List<String> facilityList) {
        this.facilityList = facilityList;
    }
}
