package com.fh.shop.backend.biz.product;

import com.fh.core.common.DataTableResult;
import com.fh.core.common.FileInfo;
import com.fh.shop.backend.po.pruduct.Product;

import java.util.List;
import java.util.Map;

public interface IProductService {

	/** <pre>addProduct(这里用一句话描述这个方法的作用)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月23日 下午6:48:05    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月23日 下午6:48:05    
	 * 修改备注：
	 * @param fileInfo
	 * @param rootPath
	 */
	void addProduct(Product product, FileInfo fileInfo, String rootPath, List<FileInfo> fileInfoList);

	/** <pre>queryProduct(查询)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午2:06:57
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午2:06:57
	 * 修改备注：
	 * @return</pre>
	 */
	List<Product> queryProduct(Product product);

	/** <pre>deleteProduct(删除)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午2:39:19
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午2:39:19
	 * 修改备注：
	 * @param id</pre>
	 */
	void deleteProduct(Integer id);

	/** <pre>deleteBatchProduct(批量删除)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月25日 下午9:27:19
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月25日 下午9:27:19
	 * 修改备注：
	 * @param ids</pre>
	 */
	void deleteBatchProduct(String ids);

	/** <pre>queryProductById(回显)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午7:25:51
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午7:25:51
	 * 修改备注：
	 * @param id
	 * @return</pre>
	 */
	Product queryProductById(Integer id);

	/** <pre>updateProduct(修改)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午7:37:41
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午7:37:41
	 * 修改备注：
     * @param product</pre>
     * @param rootPath
     * @param fileInfo
     */
	void updateProduct(Product product, String rootPath, FileInfo fileInfo, List<FileInfo> fileInfoList);

	/** <pre>queryTotalCount(查询总条数)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月26日 下午9:19:54
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月26日 下午9:19:54
	 * 修改备注：
	 * @param product
	 * @return</pre>
	 */
	Long queryTotalCount(Product product);

	List<Product> queryProductList(Product product);


	List<Product> queryProductPageList(Product product);

    DataTableResult buildDatable(Map<String, String[]> parameterMap, Product product);


    void addProductByFileInput(Product product);

	String uploadProductImage(FileInfo fileInfo, String rootPath);

	void updateProductByFileInput(Product product, String rootPath);
}
