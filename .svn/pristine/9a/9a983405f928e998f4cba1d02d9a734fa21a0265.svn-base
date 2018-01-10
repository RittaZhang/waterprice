package com.vp.dao;

import java.util.List;

import com.vp.model.User;
/**
 * @author adu
 *
 */
public interface UserDao {
	/**
	 * 保存用户方法
	 * @param user
	 * @return 保存后带有ID的用户对象
	 */
	public User save(User user);
	/**
	 * 根据ID删除用户
	 * @param id
	 * @return 影响的行数
	 */
	public int deleteById(String id);
	/**
	 * 更新用户方法
	 * @param user
	 * @return 影响的行数
	 */
	public int update(User user);
	/**
	 * 根据sql语句，并传入特定参数来更新user
	 * @param sql 例如:"update user set lastName=?,firstName=? where id=?"
	 * @param params 根据sql语句设置参数,注意顺序
	 * @return
	 */
	public int updateBySql(String sql,Object... params);
	/**
	 * 根据sql语句查询user
	 * @param 例如 "sql select * from user where zone=?"
	 * @param params 根据sql语句设置参数，注意顺序
	 * @return
	 */
	public List<User> queryBySql(String sql, Object... params);
	/**
	 * 根据id查找用户
	 * @param id
	 * @return
	 */
	public User queryById(String id);
	/**
	 * 根据sql查询结果的数量
	 * @param sql 必须是"select count(id) from user having condition..."
	 * @param params
	 * @return 
	 */
	public int queryCountBySql(String sql,Object... params);
	/**
	 * 查询所有的user
	 * @return
	 */
	public List<User> queryAll();
	/**
	 * 根据id判断是否已经存在
	 * @param name
	 * @return
	 */
	public boolean isExist(String id);
	/**
	 * 根据sql语句查询带有最近缴费月份的user
	 * @param 例如 "sql select * from user where zone=?"
	 * @param params 根据sql语句设置参数，注意顺序
	 * @return
	 */
	public List<User> queryUser(String sql, Object... params);
	
}
