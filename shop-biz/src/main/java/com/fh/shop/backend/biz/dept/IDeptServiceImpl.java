package com.fh.shop.backend.biz.dept;

import com.fh.core.util.CacheManager;
import com.fh.shop.backend.mapper.dept.IDeptMapper;
import com.fh.shop.backend.mapper.user.IUserMapper;
import com.fh.shop.backend.po.dept.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("deptService")
public class IDeptServiceImpl implements IDeptService {

    @Autowired
    private IDeptMapper deptMapper;

    @Autowired
    private IUserMapper userMapper;

    @Override
    public List<Dept> queryDeptList() {
        //获取缓存对象
        CacheManager instance = CacheManager.getInstance();
        //判断如果缓存中有值直接返回
        Object deptList = instance.getObj("deptList");
        if (deptList != null){
            return (List<Dept>) deptList;
        }
        //如果缓存没值查询数据
        List<Dept> deptListDB = deptMapper.queryDeptList();
        //放进缓存
        instance.putObj("deptList",deptListDB,10);
        return deptListDB;
    }

    @Override
    public void addDept(Dept dept) {
        deptMapper.addDept(dept);
        //清空缓存
        CacheManager.getInstance().remove("deptList");
    }

    @Override
    public void delDept(List idList) {
        //删除部门
        deptMapper.delDeptByIds(idList);
        //清空缓存
        CacheManager.getInstance().remove("deptList");
        //删除该部门下所有用户
        userMapper.deleteBatchUserByDeptId(idList);

        /*//递归方法
        //批量删除节点
        deptMapper.delDeptByIds(idList);
        //批量查询当前节点的子节点
        List<Dept> deptList = deptMapper.queryDeptByPids(idList);
        //判断是否有子节点
        List<Integer> idsList = new ArrayList<>();
        if(deptList.size()!=0){
            for (Dept dept : deptList) {
                idsList.add(dept.getId());
            }
            delDept(idsList);
        }*/
    }

    @Override
    public void updateDept(Dept dept) {
        deptMapper.updateDept(dept);
        //清空缓存
        //CacheManager.getInstance().remove("deptList");
    }

    @Override
    public Dept queryDeptById(Integer id) {
        return deptMapper.queryDeptById(id);
    }



    @Override
    public List<Dept> queryDeptByPid(Integer id) {
        return deptMapper.queryDeptByPid(id);
    }

    @Override
    public List<Integer> queryDeptIdsByPids(List<Integer> childDeptPidList) {
        return null;
    }
}
