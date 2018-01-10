package com.vp.util;

import java.util.ArrayList;
import java.util.List;

import com.vp.dao.DaoFactory;
import com.vp.model.Zone;

public class ZoneUtil {
	
	/**
	 * 返回所有的片儿的名字的集合
	 * @return
	 */
	public static List<String> getAllZones(){
		List<Zone> zoneList = getZoneList();
		List<String> zones = new ArrayList<String>();
		for(Zone z:zoneList){
			zones.add(z.getName());
		}
		return zones;
	}
	
	public static List<Zone> getZoneList(){
		return DaoFactory.getZoneDao().queryAll();
	}
}
