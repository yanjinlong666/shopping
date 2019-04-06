package com.fh.shop.backend.biz;

public class BaseService {
    public String getOrderColumn(String order) {
        return "columns[" + order + "][data]";
    }
}
