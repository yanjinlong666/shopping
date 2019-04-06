/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:IBrandService.java 
 * 包名:com.fh.shop.backend.biz.brand 
 * 创建日期:2018年12月27日下午2:58:54 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.biz.brand;

import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.po.brand.Brand;

import java.util.List;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：IBrandService    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月27日 下午2:58:54    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月27日 下午2:58:54    
 * 修改备注：       
 * @version </pre>    
 */
public interface IBrandService {

	/** <pre>queryTotalCount(查询总条数)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:44:05    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:44:05    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>    
	 */
	Long queryTotalCount(Brand brand);

	/** <pre>queryBrand(分页条件查询)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:53:00    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:53:00    
	 * 修改备注： 
	 * @param brand
	 * @return</pre>    
	 */
	List<Brand> queryBrand(Brand brand);

	/** <pre>addBrand(添加)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:08:03    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:08:03    
	 * 修改备注： 
	 * @param brand</pre>    
	 */
	void addBrand(Brand brand);

	/** <pre>queryBrandById(回显)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:36:52    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:36:52    
	 * 修改备注： 
	 * @param id
	 * @return</pre>    
	 */
	Brand queryBrandById(Integer id);

	/** <pre>updateBrand(修改)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:46:39    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:46:39    
	 * 修改备注： 
	 * @param brand</pre>    
	 */
	void updateBrand(Brand brand);

	/** <pre>deleteBatchBrand(批量删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午8:03:34    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午8:03:34    
	 * 修改备注： 
	 * @param ids</pre>    
	 */
	ServiceResponse deleteBatchBrand(String ids);

	/** <pre>queryBrandAll(查询所有)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月29日 下午2:15:16    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月29日 下午2:15:16    
	 * 修改备注： 
	 * @return</pre>    
	 */
	List<Brand> queryBrandAll();

	/** <pre>deleteBrand(删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:29:29    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:29:29    
	 * 修改备注： 
	 * @param id</pre>    
	 */
	ServiceResponse deleteBrand(Integer id);

    List<Brand> queryBrandAllById(Brand brand);


}
