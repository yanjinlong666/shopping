package com.fh.shop.backend.po;

import java.io.Serializable;

public class DataTablePage implements Serializable {

    private static final long serialVersionUID = 6917529752780592605L;

    private Integer draw;
    private Integer start;
    private Integer length;
    //升降序字段
    private String sortFiled;
    //升降序方向
    private String sort;

    public String getSortFiled() {
        return sortFiled;
    }

    public void setSortFiled(String sortFiled) {
        this.sortFiled = sortFiled;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }
}
