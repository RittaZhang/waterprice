package com.vp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vp.dao.DaoFactory;
import com.vp.dao.ZoneDao;
import com.vp.model.Zone;
import com.vp.util.Label;

public class ZoneAction extends SuperAction{
	private static final long serialVersionUID = 1L;
	private static ZoneDao zoneDao = DaoFactory.getZoneDao();
	private Zone zone;//保存用
	private String id;//要删除的zone的id
	private Map<String,Object> dataMap;//要返回的json结果
	private Integer rowCount;//总记录条数
	private Integer currentPage;//当前页数
	private int pageSize = 15;//每页显示的记录数
	public ZoneAction(){
		dataMap = new HashMap<String,Object>();
	}
	
	public Integer getRowCount() {
		return rowCount;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Zone getZone() {
		return zone;
	}
	public void setZone(Zone zone) {
		this.zone = zone;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public Map<String, Object> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	public String save(){
		System.out.println(zone.getName());
		if(zone!=null){
			if(zoneDao.isExist(zone.getName())){
				dataMap.put("error",Label.getString("zoneaction.hadexist"));
			}else if(zoneDao.save(zone).getId()!=null){
				dataMap.put("message",Label.getString("zoneaction.savedone"));
			}else{
				dataMap.put("error",Label.getString("zoneaction.savefail"));
			}
			list();
			return SUCCESS;
		}
		return INPUT;
	}
	
	public String list(){
		if(currentPage == null) currentPage = 0;
		rowCount = zoneDao.queryTotalCount();
		String sql = "select * from zone order by id asc limit "+pageSize*currentPage+","+pageSize;
		List<Zone> zones = zoneDao.queryBySql(sql);
		dataMap.put("items", zones);
		dataMap.put("rowCount", rowCount);
		dataMap.put("pageSize", pageSize);
		dataMap.put("currentPage", currentPage);
		return SUCCESS;
	}
	
	public String delete(){
		if(id!=null){
			int deId = Integer.parseInt(id);
			zoneDao.deleteById(deId);
			list();
			return SUCCESS;
		}
		return INPUT;
	}
}
