package com.fh.shop.backend.mapper.log;

import com.fh.shop.backend.po.Log.Log;

import java.util.List;

public interface ILogMapper {

    Long queryTotalCount(Log log);

    List<Log> queryLog(Log log);

    void addLog(Log logInfo);
}
