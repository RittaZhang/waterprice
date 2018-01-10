package com.vp.util;

import java.util.ArrayList;
import java.util.List;

import com.vp.dao.DaoFactory;
import com.vp.model.Worker;

public class WorkerUtil {
	public static List<String> getAllWorkers(){
		List<Worker> workerList = getWorkerList();
		List<String> workers = new ArrayList<String>();
		for(Worker worker : workerList){
			workers.add(worker.getName());
		}
		return workers;
	}
	
	public static List<Worker> getWorkerList(){
		return DaoFactory.getWorkerDao().queryAll();
	}

}
