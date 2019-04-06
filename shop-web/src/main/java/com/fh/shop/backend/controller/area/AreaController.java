package com.fh.shop.backend.controller.area;

import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.biz.area.IAreaService;
import com.fh.shop.backend.po.area.Area;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("area")
public class AreaController {

    @Resource
    private IAreaService areaService;
    /**
     * 去展示页面
     */
    @RequestMapping("toAreaList")
    public String toAreaList(){
        return "area/areaList";
    }
    /**
     * 地区树查询
     */
    @RequestMapping("queryAreaList")
    @ResponseBody
    public ServiceResponse queryAreaList(){
        List<Area> areaList = areaService.queryAreaList();
        return ServiceResponse.success(areaList);
    }
    /**
     * 添加地区
     */
    @RequestMapping("addArea")
    @ResponseBody
    public ServiceResponse addArea(Area area){
        areaService.addArea(area);
        return ServiceResponse.success(area.getId());
    }
    /**
     * 删除地区
     */
    @RequestMapping("delArea")
    @ResponseBody
    public ServiceResponse delArea(@RequestParam("ids[]") List<Integer> ids){
        areaService.delArea(ids);
        return ServiceResponse.success();
    }
    /**
     * 根据id查询
     */
    @RequestMapping("queryAreaById")
    @ResponseBody
    public ServiceResponse queryAreaById(Integer id){
        Area area = areaService.queryAreaById(id);
        return ServiceResponse.success(area);
    }
    /**
     * 修改地区
     */
    @RequestMapping("updateArea")
    @ResponseBody
    public ServiceResponse updateArea(Area area){
        areaService.updateArea(area);
        return ServiceResponse.success();
    }
    /**
     * 根据pid查询
     */
    @RequestMapping("queryAreaByPid")
    @ResponseBody
    public ServiceResponse queryAreaByPid(Integer id){
        List<Area> areaList = areaService.queryAreaByPid(id);
        return ServiceResponse.success(areaList);
    }
}
