/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:User.java 
 * 包名:com.fh.shop.backend.po.user 
 * 创建日期:2019年1月7日下午3:55:17 
 * Copyright (c) 2019, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.po.user;

import com.fh.shop.backend.po.Page;
import com.fh.shop.backend.po.dept.Dept;
import org.apache.commons.fileupload.util.LimitedInputStream;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：User    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2019年1月7日 下午3:55:17    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2019年1月7日 下午3:55:17    
 * 修改备注：       
 * @version </pre>    
 */
public class User extends Page implements Serializable{
	
	private static final long serialVersionUID = 4586091830234651473L;
	
	private Integer id;
	private String userName;
	private String realName;//真实名字
	private Integer sex;
	private String userPwd;
	//薪资
	private Double salary;
	private Double salaryMin;
	private Double salaryMax;
	//生日
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	private String birthdayStr;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthdayMin;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthdayMax;
	//部门
	private Dept dept = new Dept();

	//验证码
	private String imgCode;
	//加盐salt
	private String salt;
	//上次登录时间
	private Date lastLoginTime;
	//当天登录次数
	private Integer loginCount;
	//上次登陆时间
	private Date loginTime;
	//上次错误登陆时间
	private Date errorLastLoginTime;
	//错误登陆次数
	private Integer errorLoginCount;
	//用户状态
	private Integer status;
	//批量删除ids
	private String ids;
	//ids的集合
	private List<Integer> idsList;
	//头像路径
	private String headerImage;
	//头像老路径
	private String oldHeadImgPath;

	public String getOldHeadImgPath() {
		return oldHeadImgPath;
	}

	public void setOldHeadImgPath(String oldHeadImgPath) {
		this.oldHeadImgPath = oldHeadImgPath;
	}

	public String getHeaderImage() {
		return headerImage;
	}

	public void setHeaderImage(String headerImage) {
		this.headerImage = headerImage;
	}

	public List<Integer> getIdsList() {
		return idsList;
	}

	public void setIdsList(List<Integer> idsList) {
		this.idsList = idsList;
	}

	public String getBirthdayStr() {
		return birthdayStr;
	}

	public void setBirthdayStr(String birthdayStr) {
		this.birthdayStr = birthdayStr;
	}

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public Double getSalaryMin() {
		return salaryMin;
	}

	public void setSalaryMin(Double salaryMin) {
		this.salaryMin = salaryMin;
	}

	public Double getSalaryMax() {
		return salaryMax;
	}

	public void setSalaryMax(Double salaryMax) {
		this.salaryMax = salaryMax;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getBirthdayMin() {
		return birthdayMin;
	}

	public void setBirthdayMin(Date birthdayMin) {
		this.birthdayMin = birthdayMin;
	}

	public Date getBirthdayMax() {
		return birthdayMax;
	}

	public void setBirthdayMax(Date birthdayMax) {
		this.birthdayMax = birthdayMax;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Date getErrorLastLoginTime() {
		return errorLastLoginTime;
	}

	public void setErrorLastLoginTime(Date errorLastLoginTime) {
		this.errorLastLoginTime = errorLastLoginTime;
	}

	public Integer getErrorLoginCount() {
		return errorLoginCount;
	}

	public void setErrorLoginCount(Integer errorLoginCount) {
		this.errorLoginCount = errorLoginCount;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Integer getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getImgCode() {
		return imgCode;
	}

	public void setImgCode(String imgCode) {
		this.imgCode = imgCode;
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
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
}
