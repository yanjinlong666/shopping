package com.fh.shop.backend.controller.product;


import com.fh.core.common.DataTableResult;
import com.fh.core.common.FileInfo;
import com.fh.core.common.ServiceResponse;
import com.fh.core.util.FileUtil;
import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.biz.brand.IBrandService;
import com.fh.shop.backend.biz.image.IImageService;
import com.fh.shop.backend.biz.product.IProductService;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.po.brand.Brand;
import com.fh.shop.backend.po.image.Images;
import com.fh.shop.backend.po.pruduct.Product;
import com.fh.shop.backend.util.SystemConstant;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ProductController extends BaseController {
    //处理data类型
	/*@InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        simpleDateFormat.setLenient(false);
        CustomDateEditor dateEditor = new CustomDateEditor(simpleDateFormat, true);
        binder.registerCustomEditor(Date.class, dateEditor);
	}*/

    //记录日志
    //private static final Logger LOG = LoggerFactory.getLogger(ProductController.class);

    //注入产品service
    @Resource(name = "productService")
    private IProductService productService;

    //注入品牌service
    @Autowired
    private IBrandService brandService;

    //注入图片
    @Resource
    private IImageService imageService;

    /**
     * <pre>toAddProduct(去添加)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月23日 下午6:45:14
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月23日 下午6:45:14
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("/product/toAddProduct")
    public String toAddProduct(ModelMap map) {
        return "product/addProduct";
    }

    /**
     * 主子图片上传
     */
    @RequestMapping("/product/uploadProductImage")
    @ResponseBody
    public ServiceResponse uploadProductImage(@RequestParam MultipartFile productImage, HttpServletRequest request){
        //获取根路径
        String rootPath = getRootPath(request);
        //文件对象转换
        FileInfo fileInfo = new FileInfo();
        try {
            fileInfo = FileUtil.convertFileInfo(productImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //上传图片返回图片名
        String copyFile = productService.uploadProductImage(fileInfo,rootPath);
        return ServiceResponse.success(SystemConstant.PRODUCT_IMAGE_PATH+copyFile);
    }


    /**
     * <pre>addProduct(添加 图片普通文件域 未用fileinput)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月23日 下午6:45:51
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月23日 下午6:45:51
     * 修改备注：
     * @param product
     * @param request
     * @param productName
     * @param productPrice
     * @return</pre>
     */
    /*@RequestMapping("/product/addProduct")
    @LogAnnotation("添加产品")
    public String addProduct(Product product, HttpServletRequest request, String productName, Float productPrice,
                             @RequestParam MultipartFile productImage,
                             @RequestParam MultipartFile[] productImages) throws IOException {
        //获取根路径
        String rootPath = getRootPath(request);
        //文件对象转换
        FileInfo fileInfo = FileUtil.convertFileInfo(productImage);
        List<FileInfo> fileInfoList = FileUtil.convertFileInfoList(productImages);
        productService.addProduct(product, fileInfo, rootPath, fileInfoList);
        return "redirect:/product/toProductList.jhtml";
    }*/
    /**
     * 添加商品 图片使用的是fileinput
     */
    @RequestMapping("/product/addProductByFileInput")
    @LogAnnotation("添加产品")
    @ResponseBody
    public ServiceResponse addProductByFileInput(Product product){
        productService.addProductByFileInput(product);
        return ServiceResponse.success();
    }

    /**
     * <pre>toProductList(去展示页面)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月24日 下午7:58:31
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月24日 下午7:58:31
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("product/toProductList")
    public String toProductList() {
        return "product/productList";
    }

    /**
     * <pre>queryProduct ( 查询 )
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月24日 下午8:08:28
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月24日 下午8:08:28
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("/product/queryProduct")
    @ResponseBody
    public ServiceResponse queryProduct(Product product, HttpServletRequest req) {
        //获取前台信息（排序）
        Map<String, String[]> parameterMap = req.getParameterMap();
        //构建dataTable所需要的数据
        DataTableResult dataTableResult = productService.buildDatable(parameterMap,product);
        //响应前台
        return ServiceResponse.success(dataTableResult);

		//排序
		/*Map<String, String[]> parameterMap = req.getParameterMap();
		Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
		String order = null;
		String dir = null;
		String column = null;
		while (iterator.hasNext()){
			Map.Entry<String, String[]> entry = iterator.next();
            System.out.println(entry.getKey()+":"+StringUtils.join(entry.getValue(),";"));
			if (entry.getKey().equals("order[0][column]")){
				order = entry.getValue()[0];

			}else if (entry.getKey().equals("order[0][dir]")){
				dir = entry.getValue()[0];
			}
		}
		column = parameterMap.get("columns["+order+"][data]")[0];
		System.out.println(order+":"+dir+":"+column);*/

		/*//接收排序参数
		if(StringUtils.isNotEmpty(req.getParameter("order[0][column]"))){
			String order = req.getParameter("order[0][column]");//排序的列号
			String orderDir = req.getParameter("order[0][dir]");//排序的顺序asc or desc
			String orderColumn = req.getParameter("columns["+order+"][data]");//排序的列
			if (Integer.parseInt(req.getParameter("order[0][column]"))==0){
				product.setSortFiled("id");
				product.setSort("desc");
			}else{
				if (orderColumn.equals("entryTimeStr")){
					product.setSortFiled("entryTime");
					product.setSort(orderDir);
				}else if (orderColumn.equals("updateTimeStr")){
					product.setSortFiled("updateTime");
					product.setSort(orderDir);
				}else{
					product.setSortFiled(orderColumn);
					product.setSort(orderDir);
				}
			}
		}*/
    }

    /** <pre>buildDate(处理时间)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2019年1月12日 下午3:24:25
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2019年1月12日 下午3:24:25
     * 修改备注：
     * @param product</pre>
     */
	/*private void buildDate(Product product) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				if (StringUtils.isNotEmpty(product.getEntryTimeBeginStr())) {
					product.setEntryTimeBegin(sdf.parse(product.getto'ListEntryTimeBeginStr()));
				}
				if (StringUtils.isNotEmpty(product.getEntryTimeEndStr())) {
					product.setEntryTimeEnd(sdf.parse(product.getEntryTimeEndStr()));
				}
				if(StringUtils.isNotEmpty(product.getUpdateTimeBeginStr())){
					product.setUpdateTimeBegin(sdf.parse(product.getUpdateTimeBeginStr()));
				}
				if(StringUtils.isNotEmpty(product.getUpdateTimeEndStr())){
					product.setUpdateTimeEnd(sdf.parse(product.getUpdateTimeEndStr()));
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}*/

    /**
     * <pre>deleteProduct(删除)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月25日 下午2:32:46
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月25日 下午2:32:46
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("/product/deleteProduct")
    @ResponseBody
    @LogAnnotation("删除产品")
    public ServiceResponse deleteProduct(Integer id, HttpServletResponse response) {
        productService.deleteProduct(id);
        return ServiceResponse.success();
		
		/*JSONObject jo = JSONObject.fromObject(map);
		outJson(jo.toString(), response);*/
    }

    /**
     * <pre>deleteBatchProduct(批量删除)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月25日 下午9:26:08
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月25日 下午9:26:08
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("product/deleteBatchProduct")
    @ResponseBody
    @LogAnnotation("批量删除产品")
    public ServiceResponse deleteBatchProduct(String ids, HttpServletResponse response) {
        productService.deleteBatchProduct(ids);
        return ServiceResponse.success();
    }

    /**
     * <pre>updateProduct(回显)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月26日 下午7:22:31
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月26日 下午7:22:31
     * 修改备注：
     * @return</pre>
     */
    @RequestMapping("product/toUpdateProduct")
    public ModelAndView updateProduct(Integer id) {
        ModelAndView mav = new ModelAndView("product/updateProduct");
        Product product = productService.queryProductById(id);
        List<Images> imagesList = imageService.findImagesByProductId(id);
        mav.addObject("product", product);
        mav.addObject("imageList", imagesList);
        return mav;
    }

    /**
     * <pre>updateProduct(修改产品 图片未使用fileInput)
     * 创建人：yjl 17737518686@163.com
     * 创建时间：2018年12月26日 下午7:35:54
     * 修改人：yjl 17737518686@163.com
     * 修改时间：2018年12月26日 下午7:35:54
     * 修改备注：
     * @return</pre>
     */
    /*@RequestMapping("product/updateProduct")
    @LogAnnotation("修改产品")
    public String updateProduct(Product product, @RequestParam MultipartFile productImage, HttpServletRequest request,
                                @RequestParam MultipartFile[] productImages) throws IOException {
        //获取根路径
        String rootPath = getRootPath(request);
        //文件对象转换
        FileInfo fileInfo = FileUtil.convertFileInfo(productImage);
        List<FileInfo> fileInfoList = FileUtil.convertFileInfoList(productImages);
        productService.updateProduct(product, rootPath, fileInfo, fileInfoList);
        //跳转列表
        return "redirect:/product/toProductList.jhtml";
    }*/
    /**
     * 修改商品 图片使用fileInput
     */
    @RequestMapping("product/updateProductByFileInput")
    @LogAnnotation("修改产品")
    public String updateProduct(Product product,HttpServletRequest request) {
        //获取根路径
        String rootPath = getRootPath(request);
        productService.updateProductByFileInput(product,rootPath);
        //跳转列表
        return "redirect:/product/toProductList.jhtml";
    }

    /**
     * 查看子图片
     */
    @RequestMapping("product/findImages")
    public String findImages(ModelMap result, Integer productId) {
        List<Images> imagesList = imageService.findImagesByProductId(productId);
        result.put("imageList", imagesList);
        return "product/imageList";
    }

    /**
     * 按条件导出excel
     */
    @RequestMapping("product/exportExcel")
    public void exportExcel(Product product, HttpServletResponse response) {
        //查询符合条件的数据
        List<Product> productList = productService.queryProductList(product);
        //将其转为excel格式
        XSSFWorkbook workbook = buildExcel(productList);
        //下载
        FileUtil.excelDownload(workbook, response);

    }

    private XSSFWorkbook buildExcel(List<Product> productList) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        //创建sheet
        buildSheet(productList, workbook);
        return workbook;
    }

    private void buildSheet(List<Product> productList, XSSFWorkbook workbook) {
        XSSFSheet sheet = workbook.createSheet("商品表");
        //创建标题
        buildTitle(sheet, workbook);
        //创建表头
        buildHeader(sheet, workbook);
        //创建表体
        buildBody(productList, sheet, workbook);
    }

    private void buildTitle(XSSFSheet sheet, XSSFWorkbook workbook) {
        //合并单元格
        CellRangeAddress cellRangeAddress = new CellRangeAddress(1, 3, 4, 7);
        sheet.addMergedRegion(cellRangeAddress);
        XSSFRow rowTitle = sheet.createRow(1);
        XSSFCell cell = rowTitle.createCell(4);
        cell.setCellValue("商品列表");
        //创建大标题样式
        XSSFCellStyle cellStyle = buildTitleStyle(workbook);
        cell.setCellStyle(cellStyle);
    }

    private XSSFCellStyle buildTitleStyle(XSSFWorkbook workbook) {
        //创建样式
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        //居中
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        //背景色
        cellStyle.setFillForegroundColor(HSSFColor.GREEN.index);
        cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        //设置字体
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(26);
        font.setColor(HSSFColor.RED.index);
        cellStyle.setFont(font);
        return cellStyle;
    }

    private void buildBody(List<Product> productList, XSSFSheet sheet, XSSFWorkbook workbook) {
        //创建表体日期带颜色样式
        XSSFCellStyle colorDateStyle = buildBodyColorDateStyle(workbook);
        //创建表体颜色样式
        XSSFCellStyle colorStyle = buildBodyColorStyle(workbook);
        //创建表体日期样式
        XSSFCellStyle cellDateStyle = buildBodyDateStyle(workbook);
        int startRow = 5;
        int startCol = 4;
        for (int i = 0; i < productList.size(); i++) {
            XSSFRow rowBody = sheet.createRow(startRow + i);
            XSSFCell cellProductName = rowBody.createCell(startCol);
            cellProductName.setCellValue(productList.get(i).getProductName());
            XSSFCell cellPrice = rowBody.createCell(startCol + 1);
            cellPrice.setCellValue(productList.get(i).getProductPrice());
            XSSFCell cellEntryTime = rowBody.createCell(startCol + 2);
            cellEntryTime.setCellValue(productList.get(i).getEntryTime());
            cellEntryTime.setCellStyle(cellDateStyle);
            XSSFCell cellBrandName = rowBody.createCell(startCol + 3);
            cellBrandName.setCellValue(productList.get(i).getBrand().getBrandName());
            if (productList.get(i).getProductPrice() < 100) {
                cellPrice.setCellStyle(colorStyle);
                cellProductName.setCellStyle(colorStyle);
                cellEntryTime.setCellStyle(colorDateStyle);
                cellBrandName.setCellStyle(colorStyle);
            }
        }
    }

    private XSSFCellStyle buildBodyDateStyle(XSSFWorkbook workbook) {
        XSSFCellStyle cellDateStyle = workbook.createCellStyle();
        cellDateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy h:mm"));
        return cellDateStyle;
    }

    private XSSFCellStyle buildBodyColorStyle(XSSFWorkbook workbook) {
        XSSFCellStyle colorStyle = workbook.createCellStyle();
        colorStyle.setFillForegroundColor(HSSFColor.RED.index);
        colorStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return colorStyle;
    }

    private XSSFCellStyle buildBodyColorDateStyle(XSSFWorkbook workbook) {
        XSSFCellStyle colorDateStyle = workbook.createCellStyle();
        colorDateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy h:mm"));
        colorDateStyle.setFillForegroundColor(HSSFColor.RED.index);
        colorDateStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        return colorDateStyle;
    }


    private void buildHeader(XSSFSheet sheet, XSSFWorkbook workbook) {
        //创建样式
        XSSFCellStyle xssfCellStyle = buildHeaderStyle(workbook);
        XSSFRow rowHeader = sheet.createRow(4);
        String[] rowHeaderArr = {"商品名字", "商品价格", "录入时间", "品牌名字"};
        for (int i = 0; i < rowHeaderArr.length; i++) {
            XSSFCell cell = rowHeader.createCell(i + 4);
            cell.setCellValue(rowHeaderArr[i]);
            cell.setCellStyle(xssfCellStyle);
        }
    }

    private XSSFCellStyle buildHeaderStyle(XSSFWorkbook workbook) {
        //创建表头样式
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFont(font);
        return cellStyle;
    }

    /**
     * 按品牌导出Excel
     */
    @RequestMapping("product/exportExcelByBrand")
    public void exportExcelByBrand(Product product, HttpServletResponse response) {
        //查询所有品牌
        List<Brand> brandList = brandService.queryBrandAll();
        List<Product> productList = null;
        Integer brandId = product.getBrand().getId();
        XSSFWorkbook workbook = new XSSFWorkbook();
        for (int i = 0; i < brandList.size(); i++) {
            //根据品牌查询商品集合
            productList = queryProductBybrandId(product, brandList, brandId, i);
            //转为excel
            buildExcel(brandList, productList, workbook, i);
        }
        //下载
        FileUtil.excelDownload(workbook, response);
    }

    private List<Product> queryProductBybrandId(Product product, List<Brand> brandList, Integer brandId, int i) {
        List<Product> productList;
        if (brandId == -1) {
            product.getBrand().setId(brandList.get(i).getId());
            productList = productService.queryProductList(product);
        } else {
            if (product.getBrand().getId() == brandList.get(i).getId()) {
                product.getBrand().setId(product.getBrand().getId());
                productList = productService.queryProductList(product);
            } else {
                productList = new ArrayList<>();
            }
        }
        return productList;
    }

    private void buildExcel(List<Brand> brandList, List<Product> productList, XSSFWorkbook workbook, int i) {
        //创建sheet
        XSSFSheet sheet = workbook.createSheet(brandList.get(i).getBrandName() + "【" + productList.size() + "】");
        //创建大标题
        buildTitle(sheet, workbook);
        //创建表头
        buildHeader(sheet, workbook);
        //创建表体
        buildBody(productList, workbook, sheet);
    }

    private void buildBody(List<Product> productList, XSSFWorkbook workbook, XSSFSheet sheet) {
        int startRow = 5;
        int startCol = 4;
        if (productList.size() != 0) {
            for (int j = 0; j < productList.size(); j++) {
                XSSFRow rowBody = sheet.createRow(j + startRow);
                XSSFCell cellProductName = rowBody.createCell(startCol);
                cellProductName.setCellValue(productList.get(j).getProductName());
                XSSFCell cellPrice = rowBody.createCell(startCol + 1);
                cellPrice.setCellValue(productList.get(j).getProductPrice());
                XSSFCell cellEntryTime = rowBody.createCell(startCol + 2);
                cellEntryTime.setCellValue(productList.get(j).getEntryTime());
                cellEntryTime.setCellStyle(buildBodyDateStyle(workbook));
                XSSFCell cellBrandName = rowBody.createCell(startCol + 3);
                cellBrandName.setCellValue(productList.get(j).getBrand().getBrandName());
                if (productList.get(j).getProductPrice() < 100) {
                    cellProductName.setCellStyle(buildBodyColorStyle(workbook));
                    cellPrice.setCellStyle(buildBodyColorStyle(workbook));
                    cellEntryTime.setCellStyle(buildBodyColorDateStyle(workbook));
                    cellBrandName.setCellStyle(buildBodyColorStyle(workbook));
                }
            }
        }
    }

}



