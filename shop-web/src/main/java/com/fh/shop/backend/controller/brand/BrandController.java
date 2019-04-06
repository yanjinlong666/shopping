/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:BrandController.java 
 * 包名:com.fh.shop.backend.controller.brand 
 * 创建日期:2018年12月27日下午2:57:59 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.controller.brand;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.annotation.LogAnnotation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fh.shop.backend.biz.brand.IBrandService;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.po.brand.Brand;

import org.springframework.web.servlet.ModelAndView;


/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：BrandController    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月27日 下午2:57:59    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月27日 下午2:57:59    
 * 修改备注：       
 * @version </pre>    
 */
@Controller
@RequestMapping("brand")
public class BrandController extends BaseController{
	//处理日期
	/*@InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        simpleDateFormat.setLenient(false);
        CustomDateEditor dateEditor = new CustomDateEditor(simpleDateFormat, true);
        binder.registerCustomEditor(Date.class, dateEditor);
	}*/
	
	//记录日志
	private static final Logger LOG = LoggerFactory.getLogger(BrandController.class);
	
	/*@Autowired
	@Qualifier("brandServiceImpl")*/
	@Resource(name = "brandService")
	private IBrandService brandService;
	/**
	 * <pre>toBrandList(去展示页面)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:31:49    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:31:49    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toBrandList")
	public String toBrandList(){
		return "brand/brandList";
	}
	/**
	 * <pre>queryBrand(分页查询)
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午3:32:24    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午3:32:24    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("queryBrand")
	@ResponseBody
	public Map queryBrand(Brand brand,Integer start,Integer length,Integer draw){
		//开始下标
		brand.setStartPos(start);
		//每页条数
		brand.setPageSize(length);
		//查询总条数
		Long totalCount = brandService.queryTotalCount(brand);
		//查询每页数据
		List<Brand> listBrand = brandService.queryBrand(brand);
		//赋值传向前台
		Map<String, Object> map = new HashMap<>();
		map.put("draw",draw);
		map.put("recordsTotal",totalCount);
		map.put("recordsFiltered",totalCount);
		map.put("data",listBrand);
		return map;
	}
	/**
	 * <pre>toAddBrand(去添加)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午4:59:06    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午4:59:06    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toAddBrand")
	public String toAddBrand(){
		return "brand/add";
	}
	/**
	 * <pre>addBrand(添加)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:05:59    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:05:59    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("addBrand")
	@LogAnnotation("添加品牌")
	public String addBrand(Brand brand){
			brandService.addBrand(brand);
			return "redirect:/brand/toBrandList.jhtml";
	}
	
	/**
	 * <pre>deleteBrand(删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午5:26:39    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午5:26:39    
	 * 修改备注： </pre>
	 */
	@RequestMapping("deleteBrand")
	@ResponseBody
	@LogAnnotation("删除品牌")
	public ServiceResponse deleteBrand(Brand brand, HttpServletResponse response){
		return brandService.deleteBrand(brand.getId());
	}
	/**
	 * <pre>toUpdateBrand(回显)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:31:51    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:31:51    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toUpdateBrand")
	@ResponseBody
	public ModelAndView toUpdateBrand(Brand brand, HttpServletResponse response){
		ModelAndView mav = new ModelAndView("brand/toupdateBrand");
		Brand brandDB = brandService.queryBrandById(brand.getId());
		mav.addObject("brand",brandDB);
		return mav;
	}
	/**
	 * <pre>updateBrand(修改)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午6:45:38    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午6:45:38    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("updateBrand")
	@LogAnnotation("修改品牌")
	public String updateBrand(Brand brand){
			brandService.updateBrand(brand);
			return "redirect:/brand/toBrandList.jhtml";
	}
	/**
	 * <pre>deleteBatchBrand(批量删除)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2018年12月27日 下午8:01:15    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2018年12月27日 下午8:01:15    
	 * 修改备注： </pre>
	 */
	@RequestMapping("deleteBatchBrand")
	@ResponseBody
	@LogAnnotation("批量删除品牌")
	public ServiceResponse deleteBatchBrand(String ids,HttpServletResponse response){
		return brandService.deleteBatchBrand(ids);
	}
	/**
	 * <pre>queryBrandAll(查询品牌所有)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月9日 下午7:38:48    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月9日 下午7:38:48    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("list")
	public @ResponseBody ServiceResponse list(){
		List<Brand> brandList = brandService.queryBrandAll();
		return ServiceResponse.success(brandList);
	}
	/**
	 * <pre>toErrorJsp(这里用一句话描述这个方法的作用)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月21日 下午4:00:45    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月21日 下午4:00:45    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toErrorJsp")
	public String toErrorJsp(){
		return "error";
	}
}
