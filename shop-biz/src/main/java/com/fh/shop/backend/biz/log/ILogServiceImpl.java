package com.fh.shop.backend.biz.log;

import com.fh.shop.backend.mapper.log.ILogMapper;
import com.fh.shop.backend.po.Log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ILogServiceImpl implements ILogService {
    @Autowired
    private ILogMapper logMapper;

    @Override
    public Long queryTotalCount(Log log) {
        return logMapper.queryTotalCount(log);
    }

    @Override
    public List<Log> queryLog(Log log) {
        return logMapper.queryLog(log);
    }

    @Override
    public void addLog(Log logInfo) {
        logMapper.addLog(logInfo);
    }
}
