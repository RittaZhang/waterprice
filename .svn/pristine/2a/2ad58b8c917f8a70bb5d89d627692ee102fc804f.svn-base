package com.vp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vp.dao.DaoFactory;
import com.vp.dao.WorkerDao;
import com.vp.model.Worker;
import com.vp.util.Label;

public class WorkerAction extends SuperAction{
	private static final long serialVersionUID = 1L;
	private static WorkerDao workerDao = DaoFactory.getWorkerDao();
	private Worker worker;//保存用
	private String id;//要删除worker的id
	private Map<String,Object> dataMap;//要返回的json结果
	private Integer rowCount;//总记录条数
	private Integer currentPage;//当前页数
	private int pageSize = 15;//每页显示的记录数
	
	public WorkerAction(){
		dataMap = new HashMap<String,Object>();
	}
	
	public Worker getWorker() {
		return worker;
	}
	
	public void setWorker(Worker worker) {
		this.worker = worker;
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

	public String save(){
		if(worker!=null){
			if(workerDao.isExist(worker.getName())){
				dataMap.put("error", Label.getString("workeraction.hasexist"));
			}else if(workerDao.save(worker).getId()!=null){
				dataMap.put("success", Label.getString("workeraction.savedone"));
			}else{
				dataMap.put("error",Label.getString("workeraction.savefail"));
			}
			list();
			return SUCCESS;
		}
		return INPUT;
	}
	
	public String list(){
		if(currentPage == null) currentPage = 0;
		rowCount = workerDao.queryTotalCount();
		String sql = "select * from worker order by id asc limit "+pageSize*currentPage+","+pageSize;
		List<Worker> workers = workerDao.queryBySql(sql);
		dataMap.put("items", workers);
		dataMap.put("rowCount", rowCount);
		dataMap.put("pageSize", pageSize);
		dataMap.put("currentPage", currentPage);
		return SUCCESS;
	}
	
	public String delete(){
		if(id!=null){
			int deId = Integer.parseInt(id);
			workerDao.deleteById(deId);
			list();
			return SUCCESS;
		}
		return INPUT;
	}
	
	
}
