package com.fh.shop.backend.biz.area;

import com.fh.shop.backend.mapper.area.IAreaMapper;
import com.fh.shop.backend.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AreaServiceImpl implements IAreaService {

    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public List<Area> queryAreaList() {
        return areaMapper.queryAreaList();
    }

    @Override
    public void addArea(Area area) {
        areaMapper.addArea(area);
    }

    @Override
    public void delArea(List<Integer> ids) {
        areaMapper.delArea(ids);
    }

    @Override
    public Area queryAreaById(Integer id) {
        return areaMapper.queryAreaById(id);
    }

    @Override
    public void updateArea(Area area) {
        areaMapper.updateArea(area);
    }

    @Override
    public List<Area> queryAreaByPid(Integer pid) {
        return areaMapper.queryAreaByPid(pid);
    }
}
