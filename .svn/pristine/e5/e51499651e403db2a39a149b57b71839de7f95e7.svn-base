package com.vp.dao;

import java.util.List;

import com.vp.model.Zone;

public interface ZoneDao {
	/**
	 * 保存Zone方法
	 * @param zone
	 * @return
	 */
	public Zone save(Zone zone);
	/**
	 * 根据name删除zone
	 * @param name
	 * @return 影响的行数
	 */
	public int deleteByName(String name);
	/**
	 * 根据id删除zone
	 * @param name
	 * @return 影响的行数
	 */
	public int deleteById(Integer id);
	/**
	 * 查询所有的zone
	 * @return
	 */
	public List<Zone> queryAll();
	/**
	 * 根据name判断是否已经存在
	 * @param name
	 * @return
	 */
	public boolean isExist(String name);
	/**
	 * 根据sql查询zone
	 * @param sql
	 * @param params
	 * @return
	 */
	public List<Zone> queryBySql(String sql,Object... params);
	/**
	 * @param params
	 * @return
	 */
	public int queryTotalCount();
}
