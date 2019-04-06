package com.fh.shop.backend.biz.log;

import com.fh.shop.backend.po.Log.Log;

import java.util.List;

public interface ILogService {
    Long queryTotalCount(Log log);

    List<Log> queryLog(Log log);

    void addLog(Log logInfo);
}
