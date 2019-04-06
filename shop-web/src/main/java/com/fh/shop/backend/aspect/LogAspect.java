package com.fh.shop.backend.aspect;

import com.fh.core.common.ServiceResponse;
import com.fh.core.common.WebContext;
import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.biz.log.ILogService;
import com.fh.shop.backend.po.Log.Log;
import com.fh.shop.backend.po.user.User;
import com.fh.shop.backend.util.SystemConstant;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Date;

public class LogAspect {

    //注入log service
    @Resource
    private ILogService logService;

    private static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);

    public Object doLog(ProceedingJoinPoint pjp){
        //获取类名
        String className = pjp.getTarget().getClass().getName();
        //获取方法名
        String methodName = pjp.getSignature().getName();
        //获取request
        HttpServletRequest request = WebContext.getRequestThreadLocal();
        //获取返回值类型
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        String returnType = methodSignature.getReturnType().getName();
        //获取注解
        Method method = methodSignature.getMethod();
        String content = null;
        if (method.isAnnotationPresent(Annotation.class)){
            LogAnnotation annotation = method.getAnnotation(LogAnnotation.class);
            content = annotation.value();
        }
        String userName = "errorLogin";
        Object result = null;
        try {
            long startTime = System.currentTimeMillis();
            result = pjp.proceed();
            long endTime = System.currentTimeMillis();
            //获取session里用户信息
            User userDB = (User) request.getSession().getAttribute(SystemConstant.USER_SESSION);
            if (userDB!=null){
                userName = userDB.getUserName();
            }
            LOGGER.info("用户{}操作了{}类的{}()方法",userName,className,methodName);
            //存进数据库
            Log log = new Log();
            log.setUserName(userName);
            log.setInfo("操作了"+className+"类的"+methodName+"()方法");
            log.setCreateTime(new Date());
            log.setExecuteTime((int) (endTime-startTime));
            log.setStatus(SystemConstant.STATUS_SUCCESS);
            log.setContent(content);
            logService.addLog(log);
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            //异常信息记录
            //获取session里用户信息
            User userDB = (User) request.getSession().getAttribute(SystemConstant.USER_SESSION);
            if (userDB!=null){
                userName = userDB.getUserName();
            }
            LOGGER.error("用户{}操作了{}类的{}()方法",userName,className,methodName);
            //存进数据库
            Log log = new Log();
            log.setUserName(userName);
            log.setInfo("操作了"+className+"类的"+methodName+"()方法");
            log.setCreateTime(new Date());
            log.setExecuteTime(SystemConstant.EXECUTE_TIME_ERROR);
            log.setStatus(SystemConstant.STATUS_ERROR);
            log.setContent(content);
            logService.addLog(log);
            //根据返回值类型跳转
            if (returnType.contains("string")){
                return "error";
            }else{
                return ServiceResponse.error();
            }
        }
        return result;
    }
}
