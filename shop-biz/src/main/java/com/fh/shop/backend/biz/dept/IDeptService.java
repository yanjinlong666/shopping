package com.fh.shop.backend.biz.dept;

import com.fh.shop.backend.po.dept.Dept;

import java.util.List;

public interface IDeptService {
    List<Dept> queryDeptList();

    void addDept(Dept dept);

    void delDept(List idList);

    void updateDept(Dept dept);

    Dept queryDeptById(Integer id);


    List<Dept> queryDeptByPid(Integer id);

    List<Integer> queryDeptIdsByPids(List<Integer> childDeptPidList);
}
