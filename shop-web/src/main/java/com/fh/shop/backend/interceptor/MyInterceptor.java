/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:MyInterceptor.java 
 * 包名:com.fh.shop.backend.interceptor 
 * 创建日期:2019年1月7日下午7:30:56 
 * Copyright (c) 2019, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.interceptor;

import com.fh.core.util.CookieUtil;
import com.fh.core.util.RedisUtil;
import com.fh.shop.backend.po.user.User;
import com.fh.shop.backend.util.SystemConstant;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：MyInterceptor    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2019年1月7日 下午7:30:56    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2019年1月7日 下午7:30:56    
 * 修改备注：       
 * @version </pre>    
 */
public class MyInterceptor extends HandlerInterceptorAdapter{

	/* (最终执行的方法)    
	 * @see org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)    
	 */
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (执行方法之后执行)    
	 * @see org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.web.servlet.ModelAndView)    
	 */
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (请求执行方法之前执行)    
	 * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)    
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		String requestURI = request.getRequestURI();
		/*if(requestURI.endsWith("login.jhtml")||requestURI.endsWith("toAddUser.jhtml")||requestURI.endsWith("addUser.jhtml")){
			return true;
		}*/
		if (SystemConstant.WHITE_LIST.contains(requestURI)){
			return true;
		}
		//登录成功继续执行当前请求
		//User userDB = (User) request.getSession().getAttribute("userDB");
		//获取cookie里的钥匙
		String fh_id = CookieUtil.readCookie(request, "fh_id");
		//重新设置生命周期30分钟
		RedisUtil.expire(SystemConstant.REDIS_USERINFO_KEY_PREFIX+fh_id,SystemConstant.USERINFO_EXPIRATION_TIME);
		if (StringUtils.isEmpty(fh_id)) {
			response.sendRedirect("/index.jsp");
			return false;
		}
		String userDB = RedisUtil.get(SystemConstant.REDIS_USERINFO_KEY_PREFIX+fh_id);
		if (userDB==null) {
			response.sendRedirect("/index.jsp");
			return false;
		}
		//登陆成功用户信息放进本地session用于页面展示
		Gson gson = new Gson();
		User user = gson.fromJson(userDB, User.class);
		request.getSession().setAttribute("userDB",user);
		return true;
	}
}
