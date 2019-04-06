/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:BrandServiceImpl.java 
 * 包名:com.fh.shop.backend.biz.brand 
 * 创建日期:2018年12月27日下午2:59:24 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.biz.brand;

import com.fh.core.common.ResponseEnum;
import com.fh.core.common.ServiceResponse;
import com.fh.core.util.RedisUtil;
import com.fh.shop.backend.mapper.brand.IBrandMapper;
import com.fh.shop.backend.mapper.product.IProductMapper;
import com.fh.shop.backend.po.brand.Brand;
import com.fh.shop.backend.po.pruduct.Product;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：BrandServiceImpl    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月27日 下午2:59:24    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月27日 下午2:59:24    
 * 修改备注：       
 * @version </pre>    
 */
@Service("brandService")
public class BrandServiceImpl implements IBrandService {
	//注入品牌mapper
	@Autowired
	private IBrandMapper brandMapper;
	//注入商品mapper
	@Autowired
	private IProductMapper productMapper;
	
	/* (查询总条数)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#queryTotalCount(com.fh.shop.backend.po.brand.Brand)    
	 */
	@Override
	public Long queryTotalCount(Brand brand) {
		return brandMapper.queryTotalCount(brand);
	}

	/* (分页条件查询)
	 * @see com.fh.shop.backend.biz.brand.IBrandService#queryBrand(com.fh.shop.backend.po.brand.Brand)
	 */
	@Override
	public List<Brand> queryBrand(Brand brand) {
		List<Brand> brandList = brandMapper.queryBrand(brand);
		return brandList;
	}

	/* (添加)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#addBrand(com.fh.shop.backend.po.brand.Brand)    
	 */
	@Override
	public void addBrand(Brand brand) {
		brand.setEntryTime(new Date());
		brand.setUpdateTime(new Date());
		brandMapper.addBrand(brand);
	}

	/* (回显)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#queryBrandById(java.lang.Integer)    
	 */
	@Override
	public Brand queryBrandById(Integer id) {
		return brandMapper.queryBrandById(id);
	}

	/* (修改)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#updateBrand(com.fh.shop.backend.po.brand.Brand)    
	 */
	@Override
	public void updateBrand(Brand brand) {
		brand.setUpdateTime(new Date());
		brandMapper.updateBrand(brand);
	}

	/* (批量删除)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#deleteBatchBrand(java.lang.String)    
	 */
	@Override
	public ServiceResponse deleteBatchBrand(String ids) {
		List<Integer> idsList = new ArrayList<>();
		if (StringUtils.isNotEmpty(ids)) {
			String[] idsArr = ids.split(",");
			for (String id : idsArr) {
				idsList.add(Integer.parseInt(id));
			}
		}
		//判断是否有商品在使用
		List<Product> listProduct = productMapper.queryProductByBrandIds(idsList);
		if(listProduct.size()==0){
			//如果没有使用执行删除
			brandMapper.deleteBatchBrand(idsList);
			return ServiceResponse.success();
		}else{
			return ServiceResponse.error(ResponseEnum.ERROR_DEL);
		}
	}

	/* (查询所有)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#queryBrandAll()    
	 */
	@Override
	public List<Brand> queryBrandAll() {
		Gson gson = new Gson();
		//判断redis缓存中是否有值
		String brandListStr = RedisUtil.get("brandList");
		if (StringUtils.isEmpty(brandListStr)){
			//如果没有值,查询数据库
			List<Brand> brandList = brandMapper.queryBrandAll();
			//转为json字符串放进缓存
			String brandListJson = gson.toJson(brandList);
			RedisUtil.set("brandList",brandListJson);
			return brandList;
		}
		//如果有值,转为list
		Type type = new TypeToken<List<Brand>>() {
		}.getType();
		List<Brand> brandList = gson.fromJson(brandListStr, type);
		return brandList;
	}

	/* (删除)    
	 * @see com.fh.shop.backend.biz.brand.IBrandService#deleteBrand(java.lang.Integer)    
	 */
	@Override
	public ServiceResponse deleteBrand(Integer id) {
		//判断是否有商品在使用
		List<Product> listProduct = productMapper.queryProductByBrandId(id);
		if(listProduct.size()==0){
			//如果没有使用执行删除
			brandMapper.deleteBrand(id);
			//throw new RuntimeException("qwertyuiop");
			return ServiceResponse.success();
		}else{
			return ServiceResponse.error(ResponseEnum.ERROR_DEL);
		}
	}

	@Override
	public List<Brand> queryBrandAllById(Brand brand) {
		return brandMapper.queryBrandAllById(brand);
	}

}
