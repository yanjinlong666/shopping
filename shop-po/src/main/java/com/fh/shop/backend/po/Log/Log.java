package com.fh.shop.backend.po.Log;

import com.fh.shop.backend.po.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Log extends Page implements Serializable {

    private static final long serialVersionUID = 1660931710298770452L;

    private Long id;
    private String userName;
    private Date createTime;
    private String createTimeStr;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date createTimeMin;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date createTimeMax;
    private String info;
    private Integer status;
    private Integer executeTime;
    private Integer executeTimeMin;
    private Integer executeTimeMax;
    private String content;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getExecuteTime() {
        return executeTime;
    }

    public void setExecuteTime(Integer executeTime) {
        this.executeTime = executeTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTimeMin() {
        return createTimeMin;
    }

    public void setCreateTimeMin(Date createTimeMin) {
        this.createTimeMin = createTimeMin;
    }

    public Date getCreateTimeMax() {
        return createTimeMax;
    }

    public void setCreateTimeMax(Date createTimeMax) {
        this.createTimeMax = createTimeMax;
    }

    public Integer getExecuteTimeMin() {
        return executeTimeMin;
    }

    public void setExecuteTimeMin(Integer executeTimeMin) {
        this.executeTimeMin = executeTimeMin;
    }

    public Integer getExecuteTimeMax() {
        return executeTimeMax;
    }

    public void setExecuteTimeMax(Integer executeTimeMax) {
        this.executeTimeMax = executeTimeMax;
    }

    public String getCreateTimeStr() {
        return createTimeStr;
    }

    public void setCreateTimeStr(String createTimeStr) {
        this.createTimeStr = createTimeStr;
    }
}
