/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:UserServiceImpl.java 
 * 包名:com.fh.shop.backend.biz.user 
 * 创建日期:2019年1月7日下午4:03:06 
 * Copyright (c) 2019, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.biz.user;

import com.fh.core.util.COSUtil;
import com.fh.core.util.DateUtil;
import com.fh.core.util.MD5Util;
import com.fh.shop.backend.mapper.dept.IDeptMapper;
import com.fh.shop.backend.mapper.user.IUserMapper;
import com.fh.shop.backend.po.dept.Dept;
import com.fh.shop.backend.po.user.User;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：UserServiceImpl    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2019年1月7日 下午4:03:06    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2019年1月7日 下午4:03:06    
 * 修改备注：       
 * @version </pre>    
 */
@Service
public class UserServiceImpl implements IUserService {
	//注入user的 mapper
	@Autowired
	private IUserMapper userMapper;
	//注入dept的mapper
	@Autowired
	private IDeptMapper deptMapper;

	/* (验证密码)    
	 * @see com.fh.shop.backend.biz.user.IUserService#queryUserPwd(java.lang.String)    
	 */
	@Override
	public User queryUserPwd(String userName) {
		return userMapper.queryUserPwd(userName);
	}

	@Override
	public void addUser(User user) {
		String salt = UUID.randomUUID().toString();
		//密码加盐在次加MD5
		String pwdMD5 = MD5Util.getStringMD5(user.getUserPwd() + salt);
		user.setUserPwd(pwdMD5);
		user.setLoginTime(new Date());
		user.setLoginCount(0);
		user.setSalt(salt);
		user.setStatus(1);
		userMapper.addUser(user);
	}

	@Override
	public void updateLastLoginTime(User userDB) {
		userMapper.updateLastLoginTime(userDB);

	}

	@Override
	public void resetLoginCount(User user) {
		userMapper.resetLoginCount(user);
	}

	@Override
	public void updateUserErrorLoginTime(User user) {
		userMapper.updateUserErrorLoginTime(user);
	}



	@Override
	public void resetUserErrorLoginCount(Integer id) {
		userMapper.resetUserErrorLoginCount(id);
	}

	@Override
	public void updateUserStatus(Integer id) {
		userMapper.updateUserStatus(id);
	}

	@Override
	public void increaseUserErrorLoginCount(Integer id) {
		userMapper.increaseUserErrorLoginCount(id);
	}

	@Override
	public void cleanUserErrorLoginCount(Integer id) {
		userMapper.cleanUserErrorLoginCount(id);
	}

	@Override
	public void unLockUser(Integer id) {

	}


	@Override
	public List<User> queryUser(User user) {
		if (StringUtils.isNotEmpty(user.getIds())){
			List<Integer> idsList = new ArrayList<>();
			String[] idsArr = user.getIds().split(",");
			for (String id : idsArr) {
				idsList.add(Integer.parseInt(id));
			}
			user.setIdsList(idsList);
		}

		List<User> userList = userMapper.queryUser(user);
		for (User userDB : userList) {
			if (userDB.getBirthday() != null){
				userDB.setBirthdayStr(DateUtil.date2Str(userDB.getBirthday(),DateUtil.Y_M_D));
			}
		}
		return userList;
	}

	@Override
	public Long queryTotalCount(User user) {
		return userMapper.queryTotalCount(user);
	}

	@Override
	public void deleteUser(Integer id) {
		userMapper.deleteUser(id);
	}

	@Override
	public void deleteBatchUser(User user) {
		//用户的id集合
		List<Integer> idsList = new ArrayList<>();
		String[] idsArr = user.getIds().split(",");
		for (String id : idsArr) {
			idsList.add(Integer.parseInt(id));
		}
		//查询数据库用户的头像路径,循环删除服务器头像
		List<User> userList = userMapper.queryUserByIds(idsList);
		for (User userDB : userList) {
			COSUtil.deleteFile(userDB.getHeaderImage());
		}
		//根据ids删除数据库信息
		userMapper.deleteBatchUser(idsList);
	}

	@Override
	public User queryUserById(Integer id) {
		User userDB = userMapper.queryUserById(id);
		if (userDB.getBirthday()!=null){
			userDB.setBirthdayStr(DateUtil.date2Str(userDB.getBirthday(),DateUtil.Y_M_D));
		}
		return userDB;
	}

	@Override
	public void addUserInfo(User user) {
		//获取随机数
		String salt = UUID.randomUUID().toString();
		//密码加盐再加密
		String md5Pwd = MD5Util.getStringMD5(user.getUserPwd() + salt);
		//赋值
		user.setUserPwd(md5Pwd);
		user.setSalt(salt);
		//添加
		userMapper.addUserInfo(user);
	}

	@Override
	public void updateUserInfo(User user) {
		//判断是否修改了头像
		if(StringUtils.isNotEmpty(user.getHeaderImage())){
			//如果修改了图片，删除服务器老图片
			COSUtil.deleteFile(user.getOldHeadImgPath());
		}else {
			user.setHeaderImage(user.getOldHeadImgPath());
		}
		userMapper.updateUser(user);
		userMapper.updateUserInfo(user);
	}

	@Override
	public void updateBatchUserDept(User user) {
		List<Integer> idsList = new ArrayList<>();
		if (StringUtils.isNotEmpty(user.getIds())){
			String[] idsArr = user.getIds().split(",");
			for (String id : idsArr) {
				idsList.add(Integer.parseInt(id));
			}
			user.setIdsList(idsList);
		}
		userMapper.updateBatchUserDept(user);
	}

	@Override
	public List<User> queryUserByDeptIds(List<Integer> idList) {
		return userMapper.queryUserByDeptIds(idList);
	}

	@Override
	public XSSFWorkbook createWorkBook(Integer id) {
		XSSFWorkbook workbook = new XSSFWorkbook();
		//创建sheet
		buildSheet(id, workbook);
		return workbook;
	}

	public void buildSheet(Integer id, XSSFWorkbook workbook) {
		//根据选中的部门id查询数据
		List<Dept> deptList = deptMapper.queryDeptByPid(id);
		//循环创建sheet
		for (int i = 0; i < deptList.size(); i++) {
			XSSFSheet sheet = workbook.createSheet(deptList.get(i).getDeptName());
			//创建表头
			buildHeader(sheet);
			//创建表体
			buildBody(deptList, i, sheet);
		}
	}

	public void buildBody(List<Dept> deptList, int i, XSSFSheet sheet) {
		//查询数据
		//根据当前节点下的每个子节点查询所有子节点id
		List<Integer> idsList = new ArrayList<>();
		idsList.add(deptList.get(i).getId());
		List<Integer> addIdsList = queryChildIds(idsList);
		//根据所有子节点id查询用户表
		List<User> userList = userMapper.queryUserByDeptIds(addIdsList);
		//循环创建表体
		for (int j = 0; j < userList.size(); j++) {
			XSSFRow rowBody = sheet.createRow(j+1);
			rowBody.createCell(0).setCellValue(userList.get(j).getUserName());
			rowBody.createCell(1).setCellValue(userList.get(j).getRealName());
			rowBody.createCell(2).setCellValue(DateUtil.date2Str(userList.get(j).getBirthday(),DateUtil.Y_M_D));
			if (userList.get(j).getSex() == 1){
				rowBody.createCell(3).setCellValue("男");
			}else if (userList.get(j).getSex() == 0){
				rowBody.createCell(3).setCellValue("女");
			}
			rowBody.createCell(4).setCellValue(userList.get(j).getSalary());
			rowBody.createCell(5).setCellValue(userList.get(j).getDept().getDeptName());
		}
	}

	public void buildHeader(XSSFSheet sheet) {
		String[] headerArr = {"用户名","真实名","生日","性别","薪资","部门"};
		XSSFRow rowHeader = sheet.createRow(0);
		for (int j = 0; j < headerArr.length; j++) {
			rowHeader.createCell(j).setCellValue(headerArr[j]);
		}
	}

	List<Integer> childAllIdsList = new ArrayList<>();
	private  List<Integer> queryChildIds(List<Integer> idsList){
		List<Integer> childIdsList = new ArrayList<>();
		List<Dept> deptList = deptMapper.queryDeptByPids(idsList);
		if (deptList.size() != 0){
			for (int i = 0; i < deptList.size(); i++) {
				childIdsList.add(deptList.get(i).getId());
				childAllIdsList.add(deptList.get(i).getId());
			}
			queryChildIds(childIdsList);
		}
		return childAllIdsList;
	}

}
