package com.fh.shop.backend.po.dept;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;

import java.io.Serializable;

public class Dept implements Serializable {

    private static final long serialVersionUID = -2565459431694949716L;

    private Integer id;
    private String deptName;
    private Integer pid;
    private String remark;
    //节点ids
    private String ids;

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

}
