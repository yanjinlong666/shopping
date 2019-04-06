package com.fh.shop.backend.controller.dept;

import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.biz.dept.IDeptService;
import com.fh.shop.backend.po.dept.Dept;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("dept")
public class DeptController {
    @Resource(name = "deptService")
    private IDeptService deptService;

    /**
     * 查询部门tree
     */
    @RequestMapping("queryDeptList")
    public ServiceResponse queryDeptList(){
        List<Dept> deptList = deptService.queryDeptList();
        return ServiceResponse.success(deptList);
    }
    /**
     * 添加部门
     */
    @RequestMapping("addDept")
    public ServiceResponse addDept(Dept dept){
        deptService.addDept(dept);
        //id值回填
        return ServiceResponse.success(dept.getId());
    }
    /**
     * 删除部门
     */
    @RequestMapping("delDept")
    public ServiceResponse delDept(@RequestParam("ids[]") List idsList){
        deptService.delDept(idsList);
        return ServiceResponse.success();
    }
    /**
     * 修改
     */
    @RequestMapping("updateDept")
    public ServiceResponse updateDept(Dept dept){
        deptService.updateDept(dept);
        return ServiceResponse.success();
    }
    /**
     * 修改回显
     */
    @RequestMapping("queryDeptById")
    public ServiceResponse queryDeptById(Dept dept){
        Dept deptDB = deptService.queryDeptById(dept.getId());
        return ServiceResponse.success(deptDB);
    }
}
