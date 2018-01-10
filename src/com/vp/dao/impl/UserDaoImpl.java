package com.vp.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.DaoFactory;
import com.vp.dao.UserDao;
import com.vp.dao.WaterRecordDao;
import com.vp.dbconn.DBConnection;
import com.vp.dbconn.Db;
import com.vp.model.User;

public class UserDaoImpl implements UserDao{
	//private static Connection conn = DBConnection.getConn();
	private static Logger logger = LogManager.getLogger(UserDaoImpl.class);
	@Override
	public User save(User user){
		String sql = null;
		if(user.getFirstName()==null){
			user.setFirstName("");
		}
		String userid = user.getId().trim();
		if(userid.length()==1){
			user.setId("000"+userid);
		}else if(userid.length()==2){
			user.setId("00"+userid);
		}else if(userid.length()==3){
			user.setId("0"+userid);
		}else {
			user.setId(userid);
		}
		if(isNotExist(user.getId())){//如果不存在
			sql = "insert into user(id,lastName,firstName,type,address,zone,valid) values(?,?,?,?,?,?,?)";
			Db.save(sql, user.getId(),user.getLastName(),user.getFirstName(),user.getType(),user.getAddress(),user.getZone(),1);
		}else{
			sql = "update user set lastName=?,firstName=?,type=?,address=?,zone=?,valid=? where id=?";
			Db.save(sql, user.getLastName(),user.getFirstName(),user.getType(),user.getAddress(),user.getZone(),1,user.getId());
		}
		System.out.println(sql);
		return user;
	}

	@Override
	public int deleteById(String id) {
		WaterRecordDao recordDao = DaoFactory.getWaterRecordDao();
		String recordCountSql = "select count(id) as count from waterecord where user='"+id+"'";
		int rc = recordDao.queryCountBySql(recordCountSql);
		String sql = null;
		if(rc==0){
			sql = "delete from user where id=?";
		}else{
			sql = "update user set valid=0 where id=?";
		}
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1,id);
			int rows = ps.executeUpdate();
			return rows;
		} catch (SQLException e) {
			logger.debug("删除user出错，user.id="+id);
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(ps,conn);
		}
		return -1;
	}

	@Override
	public int update(User user) {
		if(user.getFirstName()==null){
			user.setFirstName("");
		}
		String sql = "update user set lastName=?,firstName=?,type=?,address=?,zone=? where id=?";
		return updateBySql(sql,user.getLastName(),user.getFirstName(),user.getType(),user.getAddress(),user.getZone(),user.getId());
	}

	@Override
	public int updateBySql(String sql, Object... params) {
		return Db.update(sql, params);
	}

	@Override
	public List<User> queryBySql(String sql, Object... params) {
		List<User> list=new ArrayList<User>();
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			if(params.length>0){
				for(int i=0;i<params.length;i++){
					ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			if(rs!=null){	
				while(rs.next()){
					User user=new User();
					user.setId(rs.getString("id"));
					user.setLastName(rs.getString("lastName"));
					user.setFirstName(rs.getString("firstName"));
					user.setType(rs.getString("type"));
					user.setAddress(rs.getString("address"));
					user.setZone(rs.getString("zone"));
					list.add(user);
				}
				//rs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return list;
	}

	@Override
	public int queryCountBySql(String sql, Object... params) {
		int count = 0;
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			if(params.length>0){
				for(int i=0;i<params.length;i++){
					ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			if(rs!=null){	
				if(rs.next()){
					count = rs.getInt(1);
				}
				//rs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return count;
	}

	@Override
	public List<User> queryAll() {
		return queryBySql("select * from user");
	}

	@Override
	public User queryById(String id) {
		List<User> users = queryBySql("select * from user where id=?",id);
		return users.size()>0?users.get(0):null;
	}

	@Override
	public boolean isExist(String id) {
		String sql = "select * from user where valid=1 and id=?";
		List<User> users = Db.query(sql,id);
		return users.size()>0?true:false;
	}
	public boolean isNotExist(String id) {
		String sql = "select * from user where id=?";
		List<User> users = Db.query(sql,id);
		return users.size()==0?true:false;
	}

	@Override
	public List<User> queryUser(String sql, Object... params) {
		List<User> list=new ArrayList<User>();
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			if(params.length>0){
				for(int i=0;i<params.length;i++){
					ps.setObject(i+1, params[i]);
				}
			}
			rs = ps.executeQuery();
			if(rs!=null){	
				while(rs.next()){
					User user=new User();
					user.setId(rs.getString("id"));
					user.setLastName(rs.getString("lastName"));
					user.setFirstName(rs.getString("firstName"));
					user.setType(rs.getString("type"));
					user.setAddress(rs.getString("address"));
					user.setZone(rs.getString("zone"));
					user.setLatestMonth(rs.getDate("latestMonth"));
					list.add(user);
				}
				//rs.close();
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return list;
	}
}
