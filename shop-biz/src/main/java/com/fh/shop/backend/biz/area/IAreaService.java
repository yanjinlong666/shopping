package com.fh.shop.backend.biz.area;

import com.fh.shop.backend.po.area.Area;

import java.util.List;

public interface IAreaService {

    List<Area> queryAreaList();

    void addArea(Area area);

    void delArea(List<Integer> ids);

    Area queryAreaById(Integer id);

    void updateArea(Area area);

    List<Area> queryAreaByPid(Integer pid);
}
