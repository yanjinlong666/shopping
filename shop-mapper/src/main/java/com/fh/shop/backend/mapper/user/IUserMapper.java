/** 
 * <pre>项目名称:shop-admin-mady1 
 * 文件名称:IUserMapper.java 
 * 包名:com.fh.shop.backend.mapper.user 
 * 创建日期:2019年1月7日下午4:03:31 
 * Copyright (c) 2019, 1040046150@qq.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.backend.mapper.user;

import com.fh.shop.backend.po.user.User;

import java.util.List;

/** 
 * <pre>项目名称：shop-admin-mady1    
 * 类名称：IUserMapper    
 * 类描述：    
 * 创建人：yjl 17737518686@163.com
 * 创建时间：2019年1月7日 下午4:03:31    
 * 修改人：yjl 17737518686@163.com
 * 修改时间：2019年1月7日 下午4:03:31    
 * 修改备注：       
 * @version </pre>    
 */
public interface IUserMapper {

	/** <pre>queryUserPwd(验证密码)   
	 * 创建人：yjl 17737518686@163.com
	 * 创建时间：2019年1月7日 下午4:09:50    
	 * 修改人：yjl 17737518686@163.com
	 * 修改时间：2019年1月7日 下午4:09:50    
	 * 修改备注： 
	 * @param userName
	 * @return</pre>    
	 */
	User queryUserPwd(String userName);

    void addUser(User user);

	void updateUser(User userDB);

    void updateLastLoginTime(User userDB);

	void resetLoginCount(User user);

    void updateUserErrorLoginTime(User user);


	void updateUserErrorLoginCount(Integer id);

	void resetUserErrorLoginCount(Integer id);

	void updateUserStatus(Integer id);

	void increaseUserErrorLoginCount(Integer id);

	void cleanUserErrorLoginCount(Integer id);

    void unLockUser(Integer id);

	List<User> queryUser(User user);

    Long queryTotalCount(User user);

	void deleteUser(Integer id);

	void deleteBatchUser(List idsList);

    User queryUserById(Integer id);

    void deleteBatchUserByDeptId(List idList);

    void addUserInfo(User user);

	void updateUserInfo(User user);

	void updateBatchUserDept(User user);

    List<User> queryUserByDeptIds(List<Integer> idList);

	List<User> queryUserByIds(List<Integer> idsList);
}
