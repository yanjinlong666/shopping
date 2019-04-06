/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:IProductMapper.java 
 * 包名:com.fh.shop.backend.mapper.product 
 * 创建日期:2018年12月24日下午2:17:01 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.mapper.product;

import com.fh.shop.backend.po.pruduct.Product;

import java.util.List;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：IProductMapper    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月24日 下午2:17:01    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月24日 下午2:17:01    
 * 修改备注：       
 * @version </pre>    
 */
public interface IProductMapper {
	public void addProduct(Product product);

	/** <pre>queryProduct(分页条件查询)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午2:07:55    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午2:07:55    
	 * 修改备注： 
	 * @param product 
	 * @return</pre>    
	 */
	public List<Product> queryProduct(Product product);

	/** <pre>deleteProduct(删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午2:40:10    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午2:40:10    
	 * 修改备注： 
	 * @param id</pre>    
	 */
	public void deleteProduct(Integer id);

	/** <pre>deleteBatchProduct(批量删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午9:30:22    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午9:30:22    
	 * 修改备注： 
	 * @param idsList</pre>    
	 */
	public void deleteBatchProduct(List<Integer> idsList);

	/** <pre>queryProductById(这里用一句话描述这个方法的作用)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午7:27:23    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午7:27:23    
	 * 修改备注： 
	 * @param id
	 * @return</pre>    
	 */
	public Product queryProductById(Integer id);

	/** <pre>updateProduct(修改)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午7:39:55    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午7:39:55    
	 * 修改备注： 
	 * @param product</pre>    
	 */
	public void updateProduct(Product product);

	/** <pre>queryTotalCount(查询总条数)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午9:20:54    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午9:20:54    
	 * 修改备注： 
	 * @param product
	 * @return</pre>    
	 */
	public Long queryTotalCount(Product product);

	/** <pre>queryProductByBlandId(根据品牌id查询商品)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月2日 下午3:09:18    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月2日 下午3:09:18    
	 * 修改备注： 
	 * @param id
	 * @return</pre>    
	 */
	public List<Product> queryProductByBrandId(Integer id);

	/** <pre>queryProductByBlandIds(根据品牌ids查询商品)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月2日 下午3:26:26    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月2日 下午3:26:26    
	 * 修改备注： 
	 * @param idsList
	 * @return</pre>    
	 */
	public List<Product> queryProductByBrandIds(List<Integer> idsList);

    List<Product> queryProductList(Product product);

	List<Product> queryProductPageList(Product product);

    List<Product> queryProductListApi();
}
