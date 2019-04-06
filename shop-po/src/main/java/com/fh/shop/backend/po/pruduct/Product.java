package com.fh.shop.backend.po.pruduct;

import java.io.Serializable;
import java.util.Date;

import com.fh.shop.backend.po.DataTablePage;
import org.springframework.format.annotation.DateTimeFormat;

import com.fh.shop.backend.po.Page;
import com.fh.shop.backend.po.brand.Brand;

public class Product extends DataTablePage implements Serializable{

	private static final long serialVersionUID = 5875103797026769716L;
	
	private Integer id;
	//商品名字
	private String productName;
	//商品价格
	private Float productPrice;
	//价格条件查询
	private Float productPriceMin;
	private Float productPriceMax;
	//录入时间
	private Date entryTime;
	private String entryTimeStr;
	//录入时间条件查询
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date entryTimeBegin;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date entryTimeEnd;
	private String entryTimeBeginStr;
	private String entryTimeEndStr;
	//修改时间
	private Date updateTime;
	private String updateTimeStr;
	//修改时间条件查询
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date updateTimeBegin;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date updateTimeEnd;
	private String updateTimeBeginStr;
	private String updateTimeEndStr;
	//对应的品牌
	private Brand brand = new Brand();
	//升降序
	private String orderStr ;
	//主图片上传路径
	private String productImagePath;
	//子图片上传路径
	private String productImagePathChildren;
	//修改时删除的图片id
	private String delImgIds;
	//修改时删除的图片path
	private String delImgPaths;
	//修改时存放主图片的新路径
	private String productImageNewPath;


	public String getProductImageNewPath() {
		return productImageNewPath;
	}

	public void setProductImageNewPath(String productImageNewPath) {
		this.productImageNewPath = productImageNewPath;
	}

	public String getProductImagePathChildren() {
		return productImagePathChildren;
	}

	public void setProductImagePathChildren(String productImagePathChildren) {
		this.productImagePathChildren = productImagePathChildren;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Float getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(Float productPrice) {
		this.productPrice = productPrice;
	}
	public Float getProductPriceMin() {
		return productPriceMin;
	}
	public void setProductPriceMin(Float productPriceMin) {
		this.productPriceMin = productPriceMin;
	}
	public Float getProductPriceMax() {
		return productPriceMax;
	}
	public void setProductPriceMax(Float productPriceMax) {
		this.productPriceMax = productPriceMax;
	}
	public Date getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
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
	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	public String getEntryTimeStr() {
		return entryTimeStr;
	}
	public void setEntryTimeStr(String entryTimeStr) {
		this.entryTimeStr = entryTimeStr;
	}
	public String getEntryTimeBeginStr() {
		return entryTimeBeginStr;
	}
	public void setEntryTimeBeginStr(String entryTimeBeginStr) {
		this.entryTimeBeginStr = entryTimeBeginStr;
	}
	public String getEntryTimeEndStr() {
		return entryTimeEndStr;
	}
	public void setEntryTimeEndStr(String entryTimeEndStr) {
		this.entryTimeEndStr = entryTimeEndStr;
	}
	public String getUpdateTimeStr() {
		return updateTimeStr;
	}
	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}
	public String getUpdateTimeBeginStr() {
		return updateTimeBeginStr;
	}
	public void setUpdateTimeBeginStr(String updateTimeBeginStr) {
		this.updateTimeBeginStr = updateTimeBeginStr;
	}
	public String getUpdateTimeEndStr() {
		return updateTimeEndStr;
	}
	public void setUpdateTimeEndStr(String updateTimeEndStr) {
		this.updateTimeEndStr = updateTimeEndStr;
	}
	public String getOrderStr() {
		return orderStr;
	}
	public void setOrderStr(String orderStr) {
		this.orderStr = orderStr;
	}

	public String getProductImagePath() {
		return productImagePath;
	}

	public void setProductImagePath(String productImagePath) {
		this.productImagePath = productImagePath;
	}

	public String getDelImgIds() {
		return delImgIds;
	}

	public void setDelImgIds(String delImgIds) {
		this.delImgIds = delImgIds;
	}

	public String getDelImgPaths() {
		return delImgPaths;
	}

	public void setDelImgPaths(String delImgPaths) {
		this.delImgPaths = delImgPaths;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", productName=" + productName + ", productPrice=" + productPrice
				+ ", productPriceMin=" + productPriceMin + ", productPriceMax=" + productPriceMax + ", entryTime="
				+ entryTime + ", entryTimeStr=" + entryTimeStr + ", entryTimeBegin=" + entryTimeBegin
				+ ", entryTimeEnd=" + entryTimeEnd + ", entryTimeBeginStr=" + entryTimeBeginStr + ", entryTimeEndStr="
				+ entryTimeEndStr + ", updateTime=" + updateTime + ", updateTimeStr=" + updateTimeStr
				+ ", updateTimeBegin=" + updateTimeBegin + ", updateTimeEnd=" + updateTimeEnd + ", updateTimeBeginStr="
				+ updateTimeBeginStr + ", updateTimeEndStr=" + updateTimeEndStr + ", brand=" + brand + "]";
	}

}
