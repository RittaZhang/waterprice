package com.vp.dbconn;
/**
 * 数据库操作通用类
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.config.status.StatusConfiguration;

public class Db {
	//private static Connection conn = DBConnection.getConn();
	private static Logger logger = LogManager.getLogger(Db.class);
	/**
	 * 根据sql，和参数更新表
	 * @param sql
	 * @param params
	 * @return
	 */
	public static int update(String sql, Object... params) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			if(params.length>0){
				for(int i=0;i<params.length;i++){
					ps.setObject(i+1, params[i]);
				}
			}
			int rows = ps.executeUpdate();
			return rows;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeQuietly(ps,conn);
		}
		return -1;
	}
	/**
	 * 根据sql和参数从表中查询结果
	 * @param sql
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> List<T> query(String sql,Object... params){
		List<T> result = new ArrayList<T>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			for(int i=0;i<params.length;i++){
				ps.setObject(i+1, params[i]);
			}
			rs = ps.executeQuery();
			ResultSetMetaData metaData = rs.getMetaData();
			int colAmount = metaData.getColumnCount();
			if (colAmount > 1) {
				while (rs.next()) {
					Map<String, Object> map = new HashMap<String,Object>();
					for (int i=0; i<colAmount; i++) {
						map.put(metaData.getColumnName(i+1), rs.getObject(i + 1));
					}
					result.add((T)map);
				}
			}else if(colAmount == 1) {
				while (rs.next()) {
					Map<String, Object> map = new HashMap<String,Object>();
					map.put(metaData.getColumnName(1), rs.getObject(1));
					result.add((T)map);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeQuietly(rs, ps,conn);
		}
		return result;
	}
	/**
	 * 根据sql和参数保存到数据到数据库
	 * @param sql
	 * @param params
	 * @return 影响的行数
	 */
	public static int save(String sql,Object... params){
		return update(sql,params);
	}
	/**
	 * 根据sql和参数从数据库删除数据
	 * @param sql
	 * @param params
	 * @return 影响的行数
	 */
	public static int delete(String sql,Object params){
		return update(sql,params);
	}
	static final void closeQuietly(ResultSet rs, Statement st,Connection conn) {
		if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		if (st != null) {try {st.close();} catch (SQLException e) {}}
		if (conn != null) {try {conn.close();} catch (SQLException e) {}}
	}
	static final void closeQuietly(Statement st,Connection conn) {
		if (st != null) {try {st.close();} catch (SQLException e) {}}
		if (conn != null) {try {conn.close();} catch (SQLException e) {}}
	}
}
