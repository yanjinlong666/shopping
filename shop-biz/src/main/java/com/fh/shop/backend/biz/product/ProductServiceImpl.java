package com.fh.shop.backend.biz.product;

import com.fh.core.common.DataTableResult;
import com.fh.core.common.FileInfo;
import com.fh.core.util.DateUtil;
import com.fh.core.util.FileUtil;


import com.fh.shop.backend.biz.BaseService;
import com.fh.shop.backend.biz.image.IImageService;

import com.fh.shop.backend.mapper.brand.IBrandMapper;
import com.fh.shop.backend.mapper.product.IProductMapper;
import com.fh.shop.backend.po.image.Images;
import com.fh.shop.backend.po.pruduct.Product;
import com.fh.shop.backend.util.SystemConstant;
import com.fh.shop.backend.vo.ProductVo;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("productService")
public class ProductServiceImpl extends BaseService implements IProductService {
	//注入商品mapper
	@Autowired
	private IProductMapper productMapper;

	//注入图片service
	@Resource
	private IImageService iImageService;

	//注入品牌mapper
	@Autowired
	private IBrandMapper iBrandMapper;

	/* (添加)
	 * @see com.fh.shop.backend.biz.product.IProductService#addProduct(java.lang.String)
	 */
	@Override
	public void addProduct(Product product, FileInfo fileInfo, String rootPath, List<FileInfo> fileInfoList) {
		//添加主图
		addNewImg(product, rootPath, fileInfo);
		//时间赋值
		Date now = new Date();
		product.setEntryTime(now);
		product.setUpdateTime(now);
		//添加商品
		productMapper.addProduct(product);
		//添加子图
		addNewChildImg(product, rootPath, fileInfoList);
	}

	/* (查询)
	 * @see com.fh.shop.backend.biz.product.IProductService#queryProduct()
	 */
	@Override
	public List<Product> queryProduct(Product product) {
		List<Product> listProductPage = productMapper.queryProduct(product);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Product productPage : listProductPage) {
			if (productPage.getEntryTime() != null) {
				productPage.setEntryTimeStr(sdf.format(productPage.getEntryTime()));
			}
			if (productPage.getUpdateTime() != null) {
				productPage.setUpdateTimeStr(sdf.format(productPage.getUpdateTime()));
			}
		}
		return listProductPage;
	}

	/* (删除)
	 * @see com.fh.shop.backend.biz.product.IProductService#deleteProduct(java.lang.Integer)
	 */
	@Override
	public void deleteProduct(Integer id) {
		productMapper.deleteProduct(id);
	}

	/* (批量删除)
	 * @see com.fh.shop.backend.biz.product.IProductService#deleteBatchProduct(java.lang.String)
	 */
	@Override
	public void deleteBatchProduct(String ids) {
		if (StringUtils.isNotEmpty(ids)) {
			String[] idsArr = ids.split(",");
			List<Integer> idsList = new ArrayList<>();
			for (String id : idsArr) {
				idsList.add(Integer.parseInt(id));
			}
			productMapper.deleteBatchProduct(idsList);
		}

	}

	/* (回显)
	 * @see com.fh.shop.backend.biz.product.IProductService#queryProductById(java.lang.Integer)
	 */
	@Override
	public Product queryProductById(Integer id) {
		return productMapper.queryProductById(id);
	}

	/* (修改)
	 * @see com.fh.shop.backend.biz.product.IProductService#updateProduct(com.fh.shop.backend.po.pruduct.Product)
	 */
	@Override
	public void updateProduct(Product product, String rootPath, FileInfo fileInfo, List<FileInfo> fileInfoList) {
		//修改时间赋值
		product.setUpdateTime(new Date());
		//更新主图
		updateMainImg(product, rootPath, fileInfo);
		//更新子图
		updateChildImg(product, rootPath, fileInfoList);
		//修改商品
		productMapper.updateProduct(product);
	}

	private void updateChildImg(Product product, String rootPath, List<FileInfo> fileInfoList) {
		//删除老子图
		delOldChildImg(product, rootPath);
		//增加新子图
		addNewChildImg(product, rootPath, fileInfoList);
	}

	private void addNewChildImg(Product product, String rootPath, List<FileInfo> fileInfoList) {
		List<Images> imagesList = new ArrayList<>();
		//拷贝新子图
		for (FileInfo info : fileInfoList) {
			if (info.getSize() > 0) {
				InputStream inputStream = info.getIs();
				String originalFilename = info.getFileName();
				String copyFileNames = FileUtil.copyFile(inputStream, originalFilename, rootPath + SystemConstant.PRODUCT_IMAGE_PATH);
				//image存入list
				Images images = new Images();
				images.setImagePath(SystemConstant.PRODUCT_IMAGE_PATH + copyFileNames);
				images.getProduct().setId(product.getId());
				imagesList.add(images);
			}
		}
		//更新数据库,批量插入
		if (imagesList.size() > 0) {
			iImageService.addImages(imagesList);
		}
	}

	private void delOldChildImg(Product product, String rootPath) {
		//删除服务器图片
		//根据id查询子图路径来删除服务器图片
		if (product.getDelImgIds().length() > 0) {
			String[] idsArr = product.getDelImgIds().substring(1).split(",");
			List<Integer> idsList = new ArrayList<>();
			for (String id : idsArr) {
				idsList.add(Integer.parseInt(id));
			}
			List<Images> imagesList = iImageService.findImageByImageIds(idsList);
			for (Images images : imagesList) {
				FileUtil.deleteFile(rootPath + images.getImagePath());
			}
			//删除数据库记录
			iImageService.delOldPath(product.getDelImgIds().substring(1));
		}
		/*//前台传路径方式
		String delImgPaths = product.getDelImgPaths();
		if (delImgPaths.length()>0){
			String[] pathsArr = delImgPaths.substring(1).split(",");
			for (String path : pathsArr) {
				FileUtil.deleteFile(rootPath+path);
			}*/

	}


	private void updateMainImg(Product product, String rootPath, FileInfo fileInfo) {
		if (fileInfo.getSize() > 0) {
			//删除老图片
			delOldImg(product, rootPath);
			//增加新图片
			addNewImg(product, rootPath, fileInfo);
		}
	}

	private void addNewImg(Product product, String rootPath, FileInfo fileInfo) {
		if (fileInfo.getSize() > 0) {
			//拷贝新图片
			String copyFile = FileUtil.copyFile(fileInfo.getIs(), fileInfo.getFileName(), rootPath + SystemConstant.PRODUCT_IMAGE_PATH);
			//更新数据库路径信息
			product.setProductImagePath(SystemConstant.PRODUCT_IMAGE_PATH + copyFile);
		}
	}

	private void delOldImg(Product product, String rootPath) {
		String oldRealPath = rootPath + product.getProductImagePath();
		FileUtil.deleteFile(oldRealPath);
	}


	/* (查询总条数)
	 * @see com.fh.shop.backend.biz.product.IProductService#queryTotalCount(com.fh.shop.backend.po.pruduct.Product)
	 */
	@Override
	public Long queryTotalCount(Product product) {
		return productMapper.queryTotalCount(product);
	}

	@Override
	public List<Product> queryProductList(Product product) {
		return productMapper.queryProductList(product);
	}


	@Override
	public List<Product> queryProductPageList(Product product) {
		return productMapper.queryProductPageList(product);
	}

	@Override
	public DataTableResult buildDatable(Map<String, String[]> parameterMap,
										Product product) {
		//处理排序
		buildOrder(parameterMap, product);
		//查询总条数
		Long totalCount = queryTotalCount(product);
		//分页赋值
		/*product.setStart(product.getStart());
		product.setLength(product.getLength());*/
		//查询数据
		List<Product> productList = queryProductPageList(product);
		//po转vo
		List<ProductVo> productVoList = convertPoToVo(productList);
		//组装数据
		return DataTableResult.buildDataTableResult(product.getDraw(),totalCount,totalCount,productVoList);

	}


    @Override
    public void addProductByFileInput(Product product) {
		//时间赋值
		Date date = new Date();
		product.setEntryTime(date);
		product.setUpdateTime(date);
		//添加商品
		productMapper.addProduct(product);
        //批量添加子图路径到数据库
		addBatchNewChildImg(product);
    }

	public void addBatchNewChildImg(Product product) {
		String[] paths = product.getProductImagePathChildren().split(",");
		if (paths.length>0){
			List<Images> iamgesList = new ArrayList<>();
			for (String path : paths) {
				Images images = new Images();
				images.setImagePath(path);
				images.getProduct().setId(product.getId());
				iamgesList.add(images);
			}
			iImageService.addImages(iamgesList);
		}

	}

	@Override
	public String uploadProductImage(FileInfo fileInfo,String rootPath) {
		String copyFile = "";
		if (fileInfo.getSize()>0){
			copyFile = FileUtil.copyFile(fileInfo.getIs(),fileInfo.getFileName(),rootPath+SystemConstant.PRODUCT_IMAGE_PATH);
		}
		return copyFile;
	}

	@Override
	public void updateProductByFileInput(Product product,String rootPath) {
		//修改时间赋值
		product.setUpdateTime(new Date());
		//更新主图
		if (StringUtils.isNotEmpty(product.getProductImageNewPath())){
			//如果更新了主图 删除服务器主图
			delOldImg(product,rootPath);
			//新路径赋值
			product.setProductImagePath(product.getProductImageNewPath());
		}
		//更新子图
		//删除老图
		delOldChildImg(product,rootPath);
		//批量添加子图路径到数据库
		addBatchNewChildImg(product);
		//修改商品
		productMapper.updateProduct(product);
	}

	public List<ProductVo> convertPoToVo(List<Product> productList) {
		List<ProductVo> productVoList = new ArrayList<>();
		for (Product productPo : productList) {
			ProductVo productVo = new ProductVo();
			productVo.setId(productPo.getId());
			productVo.setProductName(productPo.getProductName());
			productVo.setProductPrice(productPo.getProductPrice());
			productVo.setEntryTimeStr(DateUtil.date2Str(productPo.getEntryTime(),DateUtil.Y_M_D));
			productVo.setUpdateTimeStr(DateUtil.date2Str(productPo.getUpdateTime(),DateUtil.Y_M_D));
			productVo.setBrandName(productPo.getBrand().getBrandName());
			productVo.setProductImagePath(productPo.getProductImagePath());
			productVoList.add(productVo);
		}
		return productVoList;
	}

	public void buildOrder(Map<String, String[]> parameterMap, Product product) {
		String order = "";
		if (parameterMap.get(SystemConstant.ORDER) != null) {
			order = parameterMap.get(SystemConstant.ORDER)[0];//排序的列号
		}
		String dir = "";
		if (parameterMap.get(SystemConstant.ORDER_DIR) != null) {
			dir = parameterMap.get(SystemConstant.ORDER_DIR)[0];//排序的方向
		}
		String columnTemp = parameterMap.get(getOrderColumn(order))[0];//排序的字段
		//通过谷歌的gson将json字符串转为java的Map
		Gson gson = new Gson();
		Map<String,String> orderMap = gson.fromJson(SystemConstant.ORDER_MAP_STR, Map.class);
		String column = StringUtils.isEmpty(orderMap.get(columnTemp)) ? columnTemp : orderMap.get(columnTemp);
		//排序字段赋值
		product.setSort(dir);
		product.setSortFiled(column);
	}


}
