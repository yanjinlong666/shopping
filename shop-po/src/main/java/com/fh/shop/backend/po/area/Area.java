package com.fh.shop.backend.po.area;

import java.io.Serializable;

public class Area implements Serializable {

    private static final long serialVersionUID = -5441364763295128171L;

    private Integer id;
    private Integer pid;
    private String areaName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }
}
