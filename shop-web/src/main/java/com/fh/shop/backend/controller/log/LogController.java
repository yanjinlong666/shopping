package com.fh.shop.backend.controller.log;

import com.fh.core.util.DateUtil;
import com.fh.shop.backend.biz.log.ILogService;
import com.fh.shop.backend.po.Log.Log;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("log")
public class LogController {
    @Resource
    private ILogService logService;
    /**
     * 查询
     */
    @RequestMapping("queryLog")
    @ResponseBody
    public Map queryLog(Log log, Integer start, Integer length, Integer draw){
        Map<String,Object> map = new HashMap<>();
        log.setStartPos(start);
        log.setPageSize(length);
        Long totalCount = logService.queryTotalCount(log);
        List<Log> logList = logService.queryLog(log);
        //日期处理
        for (Log logDB : logList) {
            logDB.setCreateTimeStr(DateUtil.date2Str(logDB.getCreateTime(),DateUtil.FULL_DATE));
        }
        map.put("draw",draw);
        map.put("recordsTotal",totalCount);
        map.put("recordsFiltered",totalCount);
        map.put("data",logList);
        return map;
    }
    /**
     * 去展示页面
     */
    @RequestMapping("toLogList")
    public String toLogList(){
        return "log/list";
    }
}
