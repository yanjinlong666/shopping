/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:BaseController.java 
 * 包名:com.fh.shop.backend.controller 
 * 创建日期:2018年12月26日下午8:20:27 
 * Copyright (c) 2018, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：BaseController    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2018年12月26日 下午8:20:27    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2018年12月26日 下午8:20:27    
 * 修改备注：       
 * @version </pre>    
 */
public class BaseController {
	public void outJson(String json,HttpServletResponse response){
		PrintWriter writer = null;
		//设置响应给客户端的类型为json对象,并设置编码格式
		response.setContentType("application/json;charset=utf-8");
		try {
			//通过response获得writer
			writer = response.getWriter();
			//通过write将字符串响应给客户端
			writer.write(json);
			//清空
			writer.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(writer!=null){
				writer.close();//关流
				writer=null;
			}
		}
	}
	public void outJson1(String json,HttpServletResponse response) throws IOException{
		PrintWriter writer = response.getWriter();
		writer.write(json);
		writer.flush();
		writer.close();
	}
	//获得根路径
	public String getRootPath(HttpServletRequest request) {
		String rootPath = request.getServletContext().getRealPath("/");
		return rootPath;
	}
	
}
