package com.vp.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.WorkerDao;
import com.vp.dbconn.DBConnection;
import com.vp.dbconn.Db;
import com.vp.model.Worker;
public class WorkerDaoImpl implements WorkerDao{
	//private static Connection conn = DBConnection.getConn();
	private static Logger logger = LogManager.getLogger(WorkerDaoImpl.class);
	@Override
	public Worker save(Worker worker) {
		String sql = "insert into worker(name) values(?)";
		String sql2 = "select last_insert_id() as wid from worker limit 1";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1, worker.getName());
			ps.executeUpdate();
			ps.clearParameters();
			DBConnection.closeQuietly(ps);
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			if(rs!=null){
				if(rs.next()){
					worker.setId(rs.getInt("wid"));
				}
				//rs.close();
			}
		} catch (SQLException e) {
			logger.debug("----worker保存出错,worker.id----"+worker.getId());
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return worker;
	}

	@Override
	public int deleteById(Integer id) {
		String sql="delete from worker where id=?";
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
	public int deleteByName(String name) {
		String sql="delete from worker where name=?";
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
	public List<Worker> queryAll() {
		List<Worker> list=new ArrayList<Worker>();
		String sql="select * from worker";
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs!=null){
				while(rs.next()){
					Worker worker=new Worker();
					worker.setId(rs.getInt("id"));
					worker.setName(rs.getString("name"));
					list.add(worker);
				}
				rs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs,ps,conn);
		}
		return list;
	}

	@Override
	public boolean isExist(String name) {
		String sql="select * from worker where name=?";
		List<Worker> workerList = Db.query(sql, name);
		System.out.println("zones.length--"+ workerList.size());
		return workerList.size()>0?true:false;
		
	}

	@Override
	public List<Worker> queryBySql(String sql, Object... params) {
		return Db.query(sql, params);
	}

	@Override
	public int queryTotalCount() {
		String sql = "select count(*) as count from worker";
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
