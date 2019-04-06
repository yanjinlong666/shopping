/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:IBrandMapper.java 
 * 包名:com.fh.shop.backend.mapper.product 
 * 创建日期:2018年12月27日下午3:00:29 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.mapper.brand;

import com.fh.shop.backend.po.brand.Brand;

import java.util.List;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：IBrandMapper    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月27日 下午3:00:29    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月27日 下午3:00:29    
 * 修改备注：       
 * @version </pre>    
 */
public interface IBrandMapper {

	/** <pre>queryTotalCount(查询总条数)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:45:12    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:45:12    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>    
	 */
	Long queryTotalCount(Brand brand);

	/** <pre>queryBrand(分页条件查询)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:54:34    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:54:34    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>    
	 */
	List<Brand> queryBrand(Brand brand);

	/** <pre>addBrand(添加)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:09:34    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:09:34    
	 * 修改备注： 
	 * @param brand</pre>    
	 */
	void addBrand(Brand brand);

	/** <pre>deleteBrand(删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:30:05    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:30:05    
	 * 修改备注： 
	 * @param id</pre>    
	 */
	void deleteBrand(Integer id);

	/** <pre>queryBrandById(回显)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:37:41    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:37:41    
	 * 修改备注： 
	 * @param id
	 * @return</pre>    
	 */
	Brand queryBrandById(Integer id);

	/** <pre>updateBrand(这里用一句话描述这个方法的作用)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:47:26    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:47:26    
	 * 修改备注： 
	 * @param brand</pre>    
	 */
	void updateBrand(Brand brand);

	/** <pre>deleteBatchBrand(这里用一句话描述这个方法的作用)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午8:06:00    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午8:06:00    
	 * 修改备注： 
	 * @param idsList</pre>    
	 */
	void deleteBatchBrand(List<Integer> idsList);

	/** <pre>queryBrandAll(查询品牌所有)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月29日 下午2:17:38    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月29日 下午2:17:38    
	 * 修改备注： 
	 * @return</pre>    
	 */
	List<Brand> queryBrandAll();

    List<Brand> queryBrandAllById(Brand brand);

}
