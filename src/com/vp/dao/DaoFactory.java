package com.vp.dao;

import com.vp.dao.impl.UserDaoImpl;
import com.vp.dao.impl.WaterRecordDaoImpl;
import com.vp.dao.impl.WorkerDaoImpl;
import com.vp.dao.impl.ZoneDaoImpl;
/**
 * DAO工厂类，负责提供相应的DAO实例
 * @author adu
 *
 */
public class DaoFactory {
	private DaoFactory(){}
	
	private static UserDao userDao;
	private static WorkerDao workerDao;
	private static ZoneDao zoneDao;
	private static WaterRecordDao recordDao;
	public static UserDao getUserDao(){
		if(userDao == null) userDao = new UserDaoImpl();
		return userDao;
	}
	public static WorkerDao getWorkerDao(){
		if(workerDao == null) workerDao = new WorkerDaoImpl();
		return workerDao;
	}
	public static ZoneDao getZoneDao(){
		if(zoneDao == null) zoneDao = new ZoneDaoImpl();
		return zoneDao;
	}
	public static WaterRecordDao getWaterRecordDao(){
		if(recordDao == null) recordDao = new WaterRecordDaoImpl();
		return recordDao;
	}
}
