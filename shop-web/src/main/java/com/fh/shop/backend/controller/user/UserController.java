/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:UserController.java 
 * 包名:com.fh.shop.backend.controller.user 
 * 创建日期:2019年1月7日下午4:01:53 
 * Copyright (c) 2019, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.controller.user;

import com.fh.core.common.ResponseEnum;
import com.fh.core.common.ServiceResponse;
import com.fh.core.util.*;
import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.biz.dept.IDeptService;
import com.fh.shop.backend.biz.user.IUserService;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.po.user.User;
import com.fh.shop.backend.util.SystemConstant;
import com.google.gson.Gson;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：UserController    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2019年1月7日 下午4:01:53    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2019年1月7日 下午4:01:53    
 * 修改备注：       
 * @version </pre>    
 */

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

	//注入user的Service
	@Resource
	private IUserService userService;
	//注入部门的service
	@Resource
	private IDeptService deptService;
	//记录日志
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);


	/**
	 * 安全退出
	 */
	@RequestMapping("/safeExit")
	public String safeExit(HttpServletRequest request,HttpServletResponse response){
		//获取cookie的钥匙
		String fh_id = CookieUtil.readCookie(request, SystemConstant.COOKIE_KEY);
		//清空redis中登陆的用户信息
		if(StringUtils.isNotEmpty(fh_id)){
			RedisUtil.expire(SystemConstant.REDIS_USERINFO_KEY_PREFIX+fh_id,0);
			//清空cookie
			CookieUtil.deleteCookie(response,SystemConstant.COOKIE_KEY,"fh.admin",0);
		}
		return "redirect:/index.jsp";
	}

	/**
	 * <pre>login(登陆)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月7日 下午4:05:55    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月7日 下午4:05:55    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("/login")
	@LogAnnotation("登陆系统")
	@ResponseBody
	public ServiceResponse login(User user, HttpServletRequest request) throws ParseException {
		//当前时间
		Date dateNow = new Date();
		Date curTime = DateUtil.str2Date(DateUtil.date2Str(dateNow, DateUtil.FULL_DATE), DateUtil.Y_M_D);
		String userName = user.getUserName();
		String userPwd = user.getUserPwd();
		String imgCode = user.getImgCode();
		//非空验证
		if (StringUtils.isEmpty(userName)||StringUtils.isEmpty(userPwd)||StringUtils.isEmpty(imgCode)) {
				return ServiceResponse.error(ResponseEnum.ERROR_NAMEORPWD_IMGCODE_EMPTY);
		}
		//session验证码验证
//		String imgCodeSession = (String) request.getSession().getAttribute(SystemConstant.IMGCODE);
//		if (!imgCode.equals(imgCodeSession)){
//			return ServiceResponse.error(ResponseEnum.ERROR_IMGCODE);
//		}
		//redis验证码
		String fh_id = CookieUtil.readCookie(request, SystemConstant.COOKIE_KEY);
		String scode = RedisUtil.get(SystemConstant.REDIS_CODE_KEY_PREFIX + fh_id);
		if (!imgCode.equals(scode)){
			return ServiceResponse.error(ResponseEnum.ERROR_IMGCODE);
		}

		//账号验证
		//账号是否存在
		User userDB = userService.queryUserPwd(userName);
		if (userDB==null) {
			return ServiceResponse.error(ResponseEnum.ERROR_USERNAME);
		}
		//账号是否锁定
		if (userDB.getStatus()==SystemConstant.USER_LOCK_STATUS){
			return ServiceResponse.error(ResponseEnum.LOCK_USER_STATUS);
		}
		//密码是否正确
		if (!userDB.getUserPwd().equals(MD5Util.getStringMD5(userPwd+userDB.getSalt()))) {
			//记录错误登陆时间
			user.setErrorLastLoginTime(dateNow);
			user.setId(userDB.getId());
			userService.updateUserErrorLoginTime(user);
			//是否第一次错误登陆
			if(userDB.getErrorLastLoginTime()==null){
				userService.resetUserErrorLoginCount(userDB.getId());
				return ServiceResponse.error(ResponseEnum.ERROR_USERPWD);
			}
			//判断是否同一天
			Date errorLastLoginTime = DateUtil.str2Date(DateUtil.date2Str(userDB.getErrorLastLoginTime(), DateUtil.FULL_DATE), DateUtil.Y_M_D);
			//如果是同一天
			if (!curTime.after(errorLastLoginTime)){
				//等于2，说明是第三次
				if(userDB.getErrorLoginCount()==SystemConstant.LOCK_ERROR_COUNT-1){
					userService.updateUserStatus(userDB.getId());
				}
				//小于三次,错误次数加1
				userService.increaseUserErrorLoginCount(userDB.getId());
			}else{
				//如果不是同一天
				userService.resetUserErrorLoginCount(userDB.getId());
			}
			return ServiceResponse.error(ResponseEnum.ERROR_USERPWD);
		}
		//登陆成功用户信息放进session
		//request.getSession().setAttribute(SystemConstant.USER_SESSION, userDB);
		//登陆成功用户信息放进redis，不放密码,盐
		userDB.setUserPwd("");
		userDB.setSalt("");
		Gson gson = new Gson();
		String json = gson.toJson(userDB);
		RedisUtil.set(SystemConstant.REDIS_USERINFO_KEY_PREFIX+fh_id,json);
		RedisUtil.expire(SystemConstant.REDIS_USERINFO_KEY_PREFIX+fh_id,SystemConstant.USERINFO_EXPIRATION_TIME);
		//登陆成功清空redis中验证码
		RedisUtil.expire(SystemConstant.REDIS_CODE_KEY_PREFIX+fh_id,0);

		//登陆成功
		//记录本次登陆时间(loginTime即下次登陆时拿到的最后一次登陆时间)
		user.setId(userDB.getId());
		user.setLoginTime(dateNow);
		userService.updateLastLoginTime(user);
		//如果第一次登陆
		if (userDB.getLoginTime()==null){
			//重置登陆次数为1
			userDB.setLoginTime(new Date());
			userDB.setLoginCount(1);
			userService.resetLoginCount(userDB);
			return ServiceResponse.success();
		}
		//重置错误登陆次数为0
		userService.cleanUserErrorLoginCount(userDB.getId());
		//更新登陆次数
		Date lastTime = DateUtil.str2Date(DateUtil.date2Str(userDB.getLoginTime(), DateUtil.FULL_DATE),DateUtil.Y_M_D);

		//如果不是同一天登陆
		if (curTime.after(lastTime)){
			//重置登陆次数为1
			userDB.setLoginCount(1);
			userService.resetLoginCount(userDB);
		}else{
			//加1
			userDB.setLoginCount(userDB.getLoginCount()+1);
			userService.resetLoginCount(userDB);
		}
		return ServiceResponse.success();

		//登录成功
		/*SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");
		String lastLoginTime = sim.format(userDB.getLoginTime());
		String loginTime = sim.format(new Date());
		if (lastLoginTime.equals(loginTime)){
			userDB.setLoginCount(userDB.getLoginCount()+1);
		}else{
			userDB.setLoginCount(1);
		}
		userDB.setLastLoginTime(userDB.getLoginTime());
		request.getSession().setAttribute("userDB", userDB);
		//更新上次登陆时间和登陆次数
		userDB.setLoginTime(new Date());
		userService.updateUser(userDB);
		return ServiceResponse.success();*/
		
		/*//判断前台值是否为空
		if(StringUtils.isNotEmpty(userPwd)&&StringUtils.isNotEmpty(userName)){
			//查询密码
			User userDB = userService.queryUserPwd(userName);
			//判断账号是否能查到
			if (userDB!=null) {
				//判断密码是否正确
				if(userDB.getUserPwd().equals(userPwd)){
					map.put("code", 200);
					request.getSession().setAttribute("userDB", userDB);
				}else{
					map.put("code", 1002);
					map.put("msg", "密码错误");
				}
			}else{
				map.put("code", 1001);
				map.put("msg", "查不到该用户");
			}
		}else{
			map.put("code", 1000);
			map.put("msg", "用户名或密码不能为空");
		}
		return map;*/
	}
	/**
	 * <pre>toLogin(去成功主页面)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月7日 下午4:34:31    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月7日 下午4:34:31    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toMain")
	public String toMain(){
		return "main/main";
	}
	/**
	 * 工具类获取验证码 否
	 */
	/*@RequestMapping("getImgCode")
	public void getImgCode(){
		ValidateUtil.createImage();
	}*/
	//去注册页面
	@RequestMapping("toAddUser")
	public String toAddUser(){
		return "user/add";
	}
	/**
	 * 注册用户
	 */

	@RequestMapping("addUser")
	@ResponseBody
	public ServiceResponse addUser(User user,HttpServletRequest request) {
		String userName = user.getUserName();
		String userPwd = user.getUserPwd();
		String imgCode = user.getImgCode();
		//非空判断
		if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(userPwd) || StringUtils.isEmpty(imgCode)) {
			return ServiceResponse.error(ResponseEnum.ERROR_NAMEORPWD_IMGCODE_EMPTY);
		}
		//验证码判断
		if (!request.getSession().getAttribute(SystemConstant.IMGCODE).equals(imgCode)) {
			return ServiceResponse.error(ResponseEnum.ERROR_IMGCODE);
		}
		//添加进数据库
		userService.addUser(user);
		return ServiceResponse.success();
	}
	/**
	 * 添加用户
	 */
	@RequestMapping("addUserInfo")
	@ResponseBody
	public ServiceResponse addUserInfo(User user){
		userService.addUserInfo(user);
		return ServiceResponse.success();
	}

	/**
	 * 根据id查询用户 回显
	 */
	@RequestMapping("queryUserById")
	@ResponseBody
	public ServiceResponse queryUserById(Integer id){
		User userDB = userService.queryUserById(id);
		return ServiceResponse.success(userDB);
	}

	/**
	 * 解除账户锁定
	 * @param
	 * @return
	 */
	@RequestMapping("unLockUser")
	@ResponseBody
	public ServiceResponse unLockUser(User user){
		userService.unLockUser(user.getId());
		System.out.println(user.getId());
		return ServiceResponse.success();
	}
	/**
	 * 查询
	 */
	@RequestMapping("queryUser")
	@ResponseBody
	public Map queryUser(Integer start, Integer length, Integer draw, User user){
	    //分页参数赋值
	    user.setStartPos(start);
	    user.setPageSize(length);
	    //查询总条数
        Long totalCount = userService.queryTotalCount(user);
        //查询分页数据
		List<User> userList = userService.queryUser(user);
		//传向前台
        Map<String,Object> map = new HashMap<>();
        map.put("draw",draw);
        map.put("recordsFiltered",totalCount);
        map.put("recordsTotal",totalCount);
        map.put("data",userList);
		return map;
	}
    /**
     * 去用户展示页面
     */
    @RequestMapping("toUserList")
    public String toUserList(){
        return "user/userList";
    }
    /**
     * 删除用户
     */
    @RequestMapping("deleteUser")
	@ResponseBody
    public ServiceResponse deleteUser(Integer id){
        userService.deleteUser(id);
        return ServiceResponse.success();
    }
    /**
     * 批量删除用户
     */
    @RequestMapping("deleteBatchUser")
	@ResponseBody
    public ServiceResponse deleteBatchUser(User user){
        userService.deleteBatchUser(user);
        return ServiceResponse.success();
    }
	/**
	 * 修改
	 */
	@RequestMapping("updateUserInfo")
	@ResponseBody
	public ServiceResponse updateUserInfo(User user){
		userService.updateUserInfo(user);
		return ServiceResponse.success();
	}
	/**
	 * 批量修改用户所在部门
	 */
	@RequestMapping("updateBatchUserDept")
	@ResponseBody
	public ServiceResponse updateBatchUserDept(User user){
		userService.updateBatchUserDept(user);
		return ServiceResponse.success();
	}

	/**
	 * 根据部门导出excel
	 */
	@RequestMapping("exportExcelByDept")
	public void exportExcelByDept(String idsStr,HttpServletResponse response,Integer id){
		//后台处理方式
		//调用service创建workbook对象
		XSSFWorkbook workbook = userService.createWorkBook(id);
		//调用工具类下载
		FileUtil.excelDownload(workbook,response);


		/*//前台处理方式 分割得到每个子节点的子子孙孙
		String[] idsChild = idsStr.split(";");
		XSSFWorkbook workbook = new XSSFWorkbook();
		//循环创建sheet
		for (int i = 0; i < idsChild.length; i++) {
			//分割每个子节点的存放子子孙孙id的数组 第一个就是sheet名
			String[] idsChildren = idsChild[i].split(",");
			Integer childId = Integer.valueOf(idsChildren[0]);
			//根据子节点id查询部门名
			Dept childDept = deptService.queryDeptById(childId);
			XSSFSheet sheet = workbook.createSheet(childDept.getDeptName());
			XSSFRow rowHead = sheet.createRow(0);
			//创建第一行
			String[] rowHeadArr = {"用户名","用户真实名字"};
			for (int j = 0; j < rowHeadArr.length; j++) {
				XSSFCell cell = rowHead.createCell(j);
				cell.setCellValue(rowHeadArr[j]);
			}
			//创建主体
			List<Integer> idsList = new ArrayList<>();
			for (String child : idsChildren) {
				idsList.add(Integer.parseInt(child));
			}
			List<User> userList = userService.queryUserByDeptIds(idsList);
			for (int j = 0; j < userList.size(); j++) {
				//循环创建行
				XSSFRow rowBody = sheet.createRow(j+1);
				XSSFCell cellUserName = rowBody.createCell(0);
				cellUserName.setCellValue(userList.get(j).getUserName());
				XSSFCell cellUserRealName = rowBody.createCell(1);
				cellUserRealName.setCellValue(userList.get(j).getRealName());
			}
		}
		//将workbook转为指定格式
		FileUtil.excelDownload(workbook,response);*/

	}

}
