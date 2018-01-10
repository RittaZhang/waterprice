package com.vp.dao;

import java.util.List;

import com.vp.model.User;
import com.vp.model.WaterRecord;

import net.sf.json.JSONArray;

public interface WaterRecordDao {
	/**
	 * 保存用水记录
	 * @param record 要保存的记录
	 * @return
	 */
	public WaterRecord save(WaterRecord record);
	/**
	 * 根据id删除用水记录
	 * @param id
	 * @return
	 */
	public int deleteById(Integer id);
	/**
	 * 更新用水记录
	 * @param record
	 * @return
	 */
	public int update(WaterRecord record);
	/**
	 * 更新用水记录
	 * @param sql
	 * @param params
	 * @return
	 */
	public int updateBySql(String sql,Object... params);
	/**
	 * 根据sql语句查询
	 * @param sql
	 * @param params
	 * @return
	 */
	public List<WaterRecord> queryBySql(String sql,Object... params);
	/**
	 * 查询recordList中这些记录上一次录入的记录
	 * @param recordList 用水记录
	 * @return 相应的上一次的用水记录
	 */
	public List<WaterRecord> queryPrevRecords(List<WaterRecord> recordList,String month);
	/**
	 * 判断记录是否已经存在
	 * sql语句: select u.*,w.* from waterecord w join user u on u.id=w.user where w.id=? or (w.month=? and w.user=?)
	 * @param record 
	 * @return
	 */
	public boolean isExist(WaterRecord record);
	/**
	 * 根据sql语句查询记录数量
	 * @param sql 除了select和结果没有limit 之外，与查询语句相同
	 * : "select count(u.id) as count from user u left join waterecord w 
	 * @param params
	 * @return
	 */
	public int queryCountBySql(String sql,Object... params);
	/**
	 * 批量更新实收水费
	 * @param wrList
	 * @return
	 */
	public int batchUpdateRealCollect(List<WaterRecord> wrList);
	/**
	 * 根据user查询最近一次缴费记录
	 * @param user
	 * @param month
	 * @return
	 */
	public WaterRecord queryPrevRecord(User user,String month);
}
