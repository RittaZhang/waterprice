package com.vp.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.PrivateCredentialPermission;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.WaterRecordDao;
import com.vp.dbconn.DBConnection;
import com.vp.dbconn.Db;
import com.vp.model.User;
import com.vp.model.WaterRecord;
import com.vp.util.ConstantUtil;
import com.vp.util.DateUtil;
import com.vp.util.SysSetting;

public class WaterRecordDaoImpl implements WaterRecordDao{
	//private static Connection conn = DBConnection.getConn();
	private static Logger logger = LogManager.getLogger(WaterRecordDaoImpl.class);
	@Override
	public WaterRecord save(WaterRecord record) {
		String sql = "insert into waterecord(user,month,swiftNumber,meterNumber,lastQuantity,lastCheckDate,nowQuantity,nowCheckDate,quantity,unitPrice,additionPrice,"
				      + "totalPrice,lastOwe,nowShouldCollect,nowRealCollect,nowOwe,collectUpper,meterReader,printDate,payMethod,tollCollector,status) "
				      + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		String sql2 = "select last_insert_id() as wid from waterecord limit 1";
		//更新swiftNumner
		int number = Integer.parseInt(ConstantUtil.curMonthSwiftNumber);
		String curMonthSwiftNumner = ConstantUtil.keep4(number);
		String swiftNumber = record.getSwiftNumber()+curMonthSwiftNumner;
		record.setSwiftNumber(swiftNumber);
		SysSetting ss = SysSetting.getInstance();
		ss.setItem("sys.curMonthSwiftNumber",ConstantUtil.keep4(number+1));
		ConstantUtil.update();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setString(1,record.getUser().getId());
			ps.setDate(2,DateUtil.convertUtilToSqlDate(record.getMonth()));
		    ps.setString(3,record.getSwiftNumber());
		    ps.setString(4, record.getMeterNumber());
		    ps.setInt(5, record.getLastQuantity());
		    ps.setDate(6,DateUtil.convertUtilToSqlDate(record.getLastCheckDate()));
		    ps.setInt(7, record.getNowQuantity());
		    ps.setDate(8,DateUtil.convertUtilToSqlDate(record.getNowCheckDate()));
		    ps.setInt(9, record.getQuantity());
		    ps.setDouble(10, record.getUnitPrice());
		    ps.setDouble(11, record.getAdditionPrice());
		    ps.setDouble(12, record.getTotalPrice());
		    ps.setDouble(13, record.getLastOwe());
		    ps.setDouble(14, record.getNowShouldCollect());
		    ps.setDouble(15, record.getNowRealCollect());
		    ps.setDouble(16, record.getNowOwe());
		    ps.setString(17, record.getCollectUpper());
		    ps.setString(18, record.getMeterReader());
		    ps.setDate(19, DateUtil.convertUtilToSqlDate(record.getPrintDate()));
		    ps.setString(20, record.getPayMethod());
		    ps.setString(21,record.getTollCollector());
		    ps.setInt(22,record.getStatus());
		    ps.executeUpdate();	
			ps.clearParameters();
			DBConnection.closeQuietly(ps);
			ps = conn.prepareStatement(sql2);
			rs = ps.executeQuery();
			if(rs!=null) {
				if(rs.next()){
					record.setId(rs.getInt("wid"));
				}
				//rs.close();
			}
			//ps.close();
		} catch(SQLException e) {
			logger.debug("----record保存出错,record.id----"+record.getId());
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return record;
	}

	@Override
	public int deleteById(Integer id) {
		String sql="delete from waterecord where id=?";
		PreparedStatement ps = null;
		Connection conn = null;
		try{
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int rows = ps.executeUpdate();
			return rows;
		}catch (SQLException e) {
			logger.debug("删除record出错，record.id="+id);
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(ps,conn);
		}
		return -1;
	}

	@Override
	public int update(WaterRecord record) {
		String sql = "update waterecord set user=?,month=?,swiftNumber=?,meterNumber=?,lastQuantity=?,lastCheckDate=?,nowQuantity=?,nowCheckDate=?,quantity=?,unitPrice=?,additionPrice=?,"
				+ "totalPrice=?,lastOwe=?,nowShouldCollect=?,nowRealCollect=?,nowOwe=?,collectUpper=?,meterReader=?,printDate=?,payMethod=?,tollCollector=?,status=? "
				+ "where id=? or (user=? and month=?)";
		return updateBySql(sql,record.getUser().getId(),record.getMonth(),record.getSwiftNumber(),record.getMeterNumber(),record.getLastQuantity(),record.getLastCheckDate()
				,record.getNowQuantity(),record.getNowCheckDate(),record.getQuantity(),record.getUnitPrice(),record.getAdditionPrice(),record.getTotalPrice()
				,record.getLastOwe(),record.getNowShouldCollect(),record.getNowRealCollect(),record.getNowOwe(),record.getCollectUpper(),record.getMeterReader()
				,record.getPrintDate(),record.getPayMethod(),record.getTollCollector(),record.getStatus(),record.getId(),record.getUser().getId(),record.getMonth());
	}

	@Override
	public int updateBySql(String sql, Object... params) {
		return Db.update(sql, params);
	}

	@Override
	public List<WaterRecord> queryBySql(String sql, Object... params) {
		List<WaterRecord> list=new ArrayList<WaterRecord>();
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try{
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
					WaterRecord record = new WaterRecord();
					User user = new User();
					user.setId(rs.getString("id"));
					user.setLastName(rs.getString("lastName"));
					user.setFirstName(rs.getString("firstName"));
					user.setType(rs.getString("type"));
					user.setAddress(rs.getString("address"));
					user.setZone(rs.getString("zone"));
					record.setUser(user);
					record.setId(rs.getInt(8));
					record.setMonth(rs.getDate("month"));
					record.setSwiftNumber(rs.getString("swiftNumber"));
					record.setMeterNumber(user.getId());
					record.setLastQuantity(rs.getInt("lastQuantity"));
					record.setLastCheckDate(rs.getDate("lastCheckDate"));
					record.setNowQuantity(rs.getInt("nowQuantity"));
					record.setNowCheckDate(rs.getDate("nowCheckDate"));
					record.setQuantity(rs.getInt("quantity"));
					record.setUnitPrice(rs.getDouble("unitPrice"));
					record.setAdditionPrice(rs.getDouble("additionPrice"));
					record.setTotalPrice(rs.getDouble("totalPrice"));
					record.setLastOwe(rs.getDouble("lastOwe"));
					record.setNowShouldCollect(rs.getDouble("nowShouldCollect"));
					record.setNowRealCollect(rs.getDouble("nowRealCollect"));
					record.setNowOwe(rs.getDouble("nowOwe"));
					record.setCollectUpper(rs.getString("collectUpper"));
					record.setMeterReader(rs.getString("meterReader"));
					record.setPrintDate(rs.getDate("printDate"));
					record.setPayMethod(rs.getString("payMethod"));
					record.setTollCollector(rs.getString("tollCollector"));
					record.setStatus(rs.getInt("status"));
					list.add(record);
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
	public List<WaterRecord> queryPrevRecords(List<WaterRecord> recordList,String month) {
		List<WaterRecord> prevRecords = new ArrayList<WaterRecord>();
		String sql = "select u.*,w.* from user u,waterecord w where u.id=w.user and user=? and month<? order by month desc limit 1";
		for(WaterRecord record:recordList){
			List<WaterRecord> prevs = queryBySql(sql,record.getUser().getId(),DateUtil.monthToSqlDate(month));
			if(prevs.size()>0){
				prevRecords.add(prevs.get(0));
			}
		}
		return prevRecords;
	}
	
	@Override
	public boolean isExist(WaterRecord record) {
		String sql = "select u.*,w.* from waterecord w join user u on u.id=w.user where w.id=? or (w.month=? and w.user=?)";
		List<WaterRecord> records = queryBySql(sql, record.getId(),DateUtil.convertUtilToSqlDate(record.getMonth()), record.getUser().getId());
		return records.size()>0?true:false;
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
					count = rs.getInt("count");
				}
				//rs.close();
			}
			//ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DBConnection.closeQuietly(rs, ps,conn);
		}
		return count;
	}

	@Override
	public int batchUpdateRealCollect(List<WaterRecord> wrList) {
		Connection conn = null;
		PreparedStatement ps = null;
		int rows = 0;
		String sql = "update waterecord set printDate=?,nowRealCollect=?,nowOwe=?,tollCollector=? where id=?";
		try {
			conn = DBConnection.getConn();
			ps = conn.prepareStatement(sql);
			for(WaterRecord wr:wrList){
				ps.setDate(1, DateUtil.convertUtilToSqlDate(wr.getPrintDate()));
				ps.setDouble(2, wr.getNowRealCollect());//本期实收
				ps.setDouble(3, wr.getNowOwe());//本期累欠
				ps.setString(4, wr.getTollCollector());//收费员
				ps.setInt(5, wr.getId());
				ps.addBatch();
			}
			rows = ps.executeBatch().length;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}finally{
			DBConnection.closeQuietly(ps, conn);
		}
		return rows;
	}
	@Override
	public WaterRecord queryPrevRecord(User user,String month){
		//List<WaterRecord> prevRecords = new ArrayList<WaterRecord>();
		String sql = "select u.*,w.* from user u,waterecord w where u.id=w.user and user=? and month<? order by month desc limit 1";
		List<WaterRecord> prevs = queryBySql(sql,user.getId(),DateUtil.monthToSqlDate(month));
		return prevs.size()>0?prevs.get(0):null;
	}
}
