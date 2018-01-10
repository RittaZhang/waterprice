package com.vp.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.ZoneDao;
import com.vp.dbconn.DBConnection;
import com.vp.dbconn.Db;
import com.vp.model.Zone;

public class ZoneDaoImpl implements ZoneDao {
	private static Logger logger = LogManager.getLogger(ZoneDaoImpl.class);
	@Override
	public Zone save(Zone zone) {
		String sql = "insert into zone(name) values(?)";
		String sql2 = "select last_insert_id() as wid from zone limit 1";
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1, zone.getName());
			ps.executeUpdate();	
			ps.clearParameters();
			DBConnection.closeQuietly(ps);
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			if(rs!=null) {
				if(rs.next()){
					zone.setId(rs.getInt("wid"));
				}
				//rs.close();
			}
		} catch (SQLException e) {
			logger.debug("----zone保存出错,zone.id----"+zone.getId());
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs,ps,conn);
		}
		return zone;
	}

	@Override
	public int deleteByName(String name) {
		String sql="delete from zone where name=?";
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1,name);
			int rows = ps.executeUpdate();
			return rows;		
		} catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(ps,conn);
		}
		return -1;
	}

	@Override
	public List<Zone> queryAll() {
		List<Zone> list=new ArrayList<Zone>();
		String sql="select * from zone";
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs!=null){	
				while(rs.next()){
					Zone zone=new Zone();
					zone.setId(rs.getInt("id"));
					zone.setName(rs.getString("name"));
					list.add(zone);
				}
				//rs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs,ps,conn);
		}
		return list;
	}

	@Override
	public int deleteById(Integer id) {
		String sql="delete from zone where id=?";
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			int rows = ps.executeUpdate();
			return rows;		
		} catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(ps,conn);
		}
		return -1;
	}

	@Override
	public boolean isExist(String name) {
		String sql = "select * from zone where name=?";
		List<Zone> zones = Db.query(sql, name);
		System.out.println("zones.length--"+zones.size());
		return zones.size()>0?true:false;
	}

	@Override
	public List<Zone> queryBySql(String sql, Object... params) {
		return Db.query(sql, params);
	}

	@Override
	public int queryTotalCount() {
		String sql = "select count(*) as count from zone";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		try{
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs!=null){
				while(rs.next()){
					count = rs.getInt("count");
				}
			}
		}catch(SQLException e){
			throw new RuntimeException(e);
		}finally{
			DBConnection.closeQuietly(rs, ps, conn);
		}
		return count;
	}
	
}
