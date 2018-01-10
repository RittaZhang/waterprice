package com.vp.dao;

import java.util.List;

import com.vp.model.Worker;

public interface WorkerDao {
	/**
	 * 保存worker方法
	 * @param worker
	 * @return
	 */
	public Worker save(Worker worker);
	/**
	 * 根据ID删除worker
	 * @param id
	 * @return 影响的行数
	 */
	public int deleteById(Integer id);
	/**
	 * 根据name删除
	 * @param name
	 * @return
	 */
	public int deleteByName(String name);
	/**
	 * 查询所有的worker
	 * @return
	 */
	public List<Worker> queryAll();
	/**
	 * 根据name判断是否已经存在
	 * @param name
	 * @return
	 */
	public boolean isExist(String name);
	/**
	 * 根据sql查询worker
	 * @param sql
	 * @param params
	 * @return
	 */
	public List<Worker> queryBySql(String sql,Object... params);
	/**
	 * @param params
	 * @return
	 */
	public int queryTotalCount();
}
