package com.fh.shop.backend.mapper.dept;

import com.fh.shop.backend.po.dept.Dept;

import java.util.List;

public interface IDeptMapper {

    List<Dept> queryDeptList();

    void addDept(Dept dept);

    void delDeptByIds(List idList);

    void updateDept(Dept dept);

    Dept queryDeptById(Integer id);

    List<Dept> queryDeptByPids(List idList);

    List<Dept> queryDeptByPid(Integer id);
}
