package com.vp.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import com.vp.dbconn.DbUtils;
import com.vp.util.Label;
public class DbAction extends SuperAction{
	private static final long serialVersionUID = 1L;
	private Map<String, Object> dataMap;
	private File file;//要被还原的sql文件
	private String testParam;
	public DbAction(){
		dataMap = new HashMap<String,Object>();
	}
	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	
	public String getTestParam() {
		return testParam;
	}
	public void setTestParam(String testParam) {
		this.testParam = testParam;
	}
	/**
	 * 数据库备份action
	 * @return
	 */
	public String backup(){
		String backupName = DbUtils.backup();
		System.out.println(backupName);
		dataMap.put("backupName", backupName);
		dataMap.put("message", Label.getString("dbaction.backupdone"));
		return SUCCESS;
	}
	/**
	 * 数据库还原action
	 * @return
	 */
	public String restore(){
		DbUtils.restore(file);
		dataMap.put("message",Label.getString("dbaction.retoredone"));
		return SUCCESS;
	}
}
