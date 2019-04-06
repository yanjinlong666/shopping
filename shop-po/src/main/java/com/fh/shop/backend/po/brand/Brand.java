/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:Brand.java 
 * 包名:com.fh.shop.backend.po.brand 
 * 创建日期:2018年12月27日下午2:52:14 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.po.brand;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fh.shop.backend.po.Page;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：Brand    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月27日 下午2:52:14    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月27日 下午2:52:14    
 * 修改备注：       
 * @version </pre>    
 */
public class Brand extends Page implements Serializable{

	private static final long serialVersionUID = 8764721431536154786L;
	
	private Integer id;
	private String brandName;
	//录入时间
	private Date entryTime;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date entryTimeBegin;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date entryTimeEnd;
	//修改时间
	private Date updateTime;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTimeBegin;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateTimeEnd;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public Date getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}
	public Date getEntryTimeBegin() {
		return entryTimeBegin;
	}
	public void setEntryTimeBegin(Date entryTimeBegin) {
		this.entryTimeBegin = entryTimeBegin;
	}
	public Date getEntryTimeEnd() {
		return entryTimeEnd;
	}
	public void setEntryTimeEnd(Date entryTimeEnd) {
		this.entryTimeEnd = entryTimeEnd;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Date getUpdateTimeBegin() {
		return updateTimeBegin;
	}
	public void setUpdateTimeBegin(Date updateTimeBegin) {
		this.updateTimeBegin = updateTimeBegin;
	}
	public Date getUpdateTimeEnd() {
		return updateTimeEnd;
	}
	public void setUpdateTimeEnd(Date updateTimeEnd) {
		this.updateTimeEnd = updateTimeEnd;
	}
	@Override
	public String toString() {
		return "Brand [id=" + id + ", brandName=" + brandName + ", entryTime=" + entryTime + ", entryTimeBegin="
				+ entryTimeBegin + ", entryTimeEnd=" + entryTimeEnd + ", updateTime=" + updateTime
				+ ", updateTimeBegin=" + updateTimeBegin + ", updateTimeEnd=" + updateTimeEnd + "]";
	}
	
}
