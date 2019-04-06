package com.fh.shop.backend.po.member;

import com.fh.shop.backend.po.DataTablePage;
import com.fh.shop.backend.po.area.Area;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Member extends DataTablePage implements Serializable {

    private static final long serialVersionUID = 2938221376485843727L;

    private Integer id;
    private String userName;
    private String passWord;
    private String phone;
    private String email;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    //生日条件查询
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthdayBegin;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthdayEnd;
    /*private Area areaSheng = new Area();
    private Area areaShi = new Area();
    private Area areaXian = new Area();*/
    //省市县的id,name拼接
    private String areaIds;
    private String areaNames;

    public String getAreaNames() {
        return areaNames;
    }

    public void setAreaNames(String areaNames) {
        this.areaNames = areaNames;
    }

    public String getAreaIds() {
        return areaIds;
    }

    public void setAreaIds(String areaIds) {
        this.areaIds = areaIds;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }


    public Date getBirthdayBegin() {
        return birthdayBegin;
    }

    public void setBirthdayBegin(Date birthdayBegin) {
        this.birthdayBegin = birthdayBegin;
    }

    public Date getBirthdayEnd() {
        return birthdayEnd;
    }

    public void setBirthdayEnd(Date birthdayEnd) {
        this.birthdayEnd = birthdayEnd;
    }
}
