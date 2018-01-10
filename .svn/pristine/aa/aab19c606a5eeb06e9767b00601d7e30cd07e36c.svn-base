package com.vp.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.DaoFactory;
import com.vp.dao.UserDao;
import com.vp.dao.WaterRecordDao;
import com.vp.model.User;
import com.vp.model.WaterRecord;
import com.vp.util.ConstantUtil;
import com.vp.util.DateUtil;
import com.vp.util.Label;
import com.vp.util.WorkerUtil;
import com.vp.util.ZoneUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class WaterRecordAction extends SuperAction {
	private static final long serialVersionUID = 1L;
	private static Logger logger = LogManager.getLogger(UserAction.class);
	private static WaterRecordDao recordDao = DaoFactory.getWaterRecordDao();
	private static UserDao userDao = DaoFactory.getUserDao();
	private WaterRecord record;//保存用
	private Map<String,Object> dataMap;//要返回的json结果
	private List<String> zoneList;
	private List<String> workerList;
	private List<WaterRecord> recordList;
	private Boolean entered;//水量录入复选框
	private String month;//月份
	private String userId;//通过userId查询用水录入表
	private String userZone;//通过userZone查询用水录入表
	private String userType;//通过userZone查询用水录入表
	private String selectMeterReader;//选择的抄表员	
	private String selectCollector;//选择的收费员
	private String checkDate;
	private String printDate;
	private Integer id;
	private Integer rowCount;//总记录条数
	private Integer currentPage;//当前页数
	private int pageSize = 4;//每页显示的记录数
	private Integer rows;//当前页记录数
	private String jsonStr;
	private String order;
	private String by;
	private Integer billPageSize = 15;
	private Integer noinputPageSize = 15;
	private String fromPage;
	
	public String getFromPage() {
		return fromPage;
	}
	public void setFromPage(String fromPage) {
		this.fromPage = fromPage;
	}
	public Integer getNoinputPageSize() {
		return noinputPageSize;
	}
	public void setNoinputPageSize(Integer noinputPageSize) {
		this.noinputPageSize = noinputPageSize;
	}
	public Integer getBillPageSize() {
		return billPageSize;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getBy() {
		return by;
	}
	public void setBy(String by) {
		this.by = by;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getJsonStr() {
		return jsonStr;
	}
	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}
	public String getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}
	public String getPrintDate() {
		return printDate;
	}
	public void setPrintDate(String printDate) {
		this.printDate = printDate;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
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
	public WaterRecord getRecord() {
		return record;
	}
	public void setRecord(WaterRecord record) {
		this.record = record;
	}
	public Map<String, Object> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	public List<String> getZoneList() {
		return zoneList;
	}
	public void setZoneList(List<String> zoneList) {
		this.zoneList = zoneList;
	}
	public List<String> getWorkerList() {
		return workerList;
	}
	public void setWorkerList(List<String> workerList) {
		this.workerList = workerList;
	}
	public List<WaterRecord> getRecordList() {
		return recordList;
	}
	public void setRecordList(List<WaterRecord> recordList) {
		this.recordList = recordList;
	}
	public Boolean getEntered() {
		return entered;
	}
	public void setEntered(Boolean entered) {
		this.entered = entered;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserZone() {
		return userZone;
	}
	public void setUserZone(String userZone) {
		this.userZone = userZone;
	}
	public String getSelectMeterReader() {
		return selectMeterReader;
	}
	public void setSelectMeterReader(String selectMeterReader) {
		this.selectMeterReader = selectMeterReader;
	}
	public String getSelectCollector() {
		return selectCollector;
	}
	public void setSelectCollector(String selectCollector) {
		this.selectCollector = selectCollector;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public WaterRecordAction(){
		if(dataMap == null){
			dataMap = new HashMap<String,Object>();
		}
	}
	public String save(){
		if(record!=null){
			if(recordDao.isExist(record)){//已经存在、更新
				if(recordDao.update(record)>0){
					dataMap.put("message", Label.getString("recordaction.updatedone"));
				}else{
					dataMap.put("message", Label.getString("recordaction.updatefail"));
				}
				
			}else{
				WaterRecord wr = recordDao.save(record);
				if(wr.getId()!=null){//保存
					dataMap.put("message", Label.getString("recordaction.savedone"));
					dataMap.put("swiftNumber", wr.getSwiftNumber());
				}else{
					dataMap.put("message", Label.getString("recordaction.savefail"));
				}
			}
		}
		return SUCCESS;
	}
	/*
	 * 已收费页面
	 */
	public String queryRecord() throws UnsupportedEncodingException{
		deleteCookies();
		zoneList = ZoneUtil.getAllZones();
		workerList = WorkerUtil.getAllWorkers();
		if(month == null){
			month = DateUtil.dateToMonth(ConstantUtil.operateDate);
		}
		String sql = "select u.*,w.* from user u left join waterecord w on u.id=w.user";
		String countSql = "select count(u.id) as count from user u left join waterecord w on u.id=w.user";
		if(month!=null){
			sql += " and w.month='"+DateUtil.monthToSqlDate(month)+"'";
			countSql += " and w.month='"+DateUtil.monthToSqlDate(month)+"'";
		}
		//String sql = "select u.*,w.* from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where 1=1";
		//String countSql = "select count(u.id) as count from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where 1=1";
		sql += " where 1=1";
		countSql += " where 1=1";
		if(userZone!=null && !userZone.equals("")){
			sql+=" and u.zone='"+userZone+"' ";
			countSql += " and u.zone='"+userZone+"' ";
			Cookie cookie = new Cookie("userZone",URLEncoder.encode(userZone, "utf-8"));
			response.addCookie(cookie);
		}
		if(userId!=null && !userId.equals("")){
			sql += " and u.id='"+userId+"' ";
			countSql += " and u.id='"+userId+"' ";
			Cookie cookie = new Cookie("userId",URLEncoder.encode(userId, "utf-8"));
			response.addCookie(cookie);
		}
		if(checkDate!=null&&checkDate!=""){
			sql += " and w.nowCheckDate='"+checkDate+"' ";
			countSql += " and w.nowCheckDate='"+checkDate+"' ";
			Cookie cookie = new Cookie("checkDate",checkDate);
			response.addCookie(cookie);
		}
		if(printDate!=null&&printDate!=""){
			sql += " and w.printDate='"+printDate+"' ";
			countSql += " and w.printDate='"+printDate+"' ";
			Cookie cookie = new Cookie("printDate",printDate);
			response.addCookie(cookie);
		}
		if(currentPage == null){
			currentPage = 0;
		}
		if(by == null){
			by = "u.id";
		}
		if(order==null){
			order ="asc";
		}
		Cookie cookie_1 = new Cookie("currentPage",currentPage.toString());
		response.addCookie(cookie_1);
		Cookie cookie_2 = new Cookie("by",URLEncoder.encode(by, "utf-8"));
		response.addCookie(cookie_2);
		Cookie cookie_3 = new Cookie("order",order);
		response.addCookie(cookie_3);
		Cookie cookie_4 = new Cookie("fromPage","billview");
		response.addCookie(cookie_4);
		sql+=" and u.id in (select user from waterecord";
		if(month!=null)
			sql += " where month='"+DateUtil.monthToSqlDate(month)+"'";
		if(order!=null&&by!=null){
			sql += ") order by "+by+" "+order+" limit "+billPageSize*currentPage+","+billPageSize;
			countSql+=" and u.id in (select user from waterecord";
		}else{
			sql += ") order by u.id,month asc limit "+billPageSize*currentPage+","+billPageSize;
			countSql+=" and u.id in (select user from waterecord";
		}
		if(month!=null)
			countSql += " where month='"+DateUtil.monthToSqlDate(month)+"'";
		countSql += ")";
		recordList=recordDao.queryBySql(sql);
		rowCount = recordDao.queryCountBySql(countSql);
		rows = recordList.size();
		return "billview";
	}
	/*public String queryRecord(){
		zoneList = ZoneUtil.getAllZones();
		workerList = WorkerUtil.getAllWorkers();
		if(month == null){
			month = DateUtil.dateToMonth(ConstantUtil.operateDate);
		}
		String sql = "select u.*,w.* from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where 1=1";
		String countSql = "select count(u.id) as count from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where 1=1";
		if(userZone!=null && !userZone.equals("")){
			sql+=" and u.zone='"+userZone+"' ";
			countSql += " and u.zone='"+userZone+"' ";
		}
		if(userId!=null && !userId.equals("")){
			sql += " and u.id='"+userId+"' ";
			countSql += " and u.id='"+userId+"' ";
		}
		if(currentPage == null){
			currentPage = 0;
		}
		if(entered == null || entered == false){//查询未录入
			sql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"') order by u.id asc limit 4";
			countSql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"')";
		}else{//查询已录入
			sql+=" and u.id in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"') order by u.id asc limit "+pageSize*currentPage+","+pageSize;
			countSql+=" and u.id in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"')";
		}
		recordList=recordDao.queryBySql(sql);
		rowCount = recordDao.queryCountBySql(countSql);
		rows = recordList.size();
		if(entered==null||!entered){
			List<WaterRecord> prevRecordList = recordDao.queryPrevRecords(recordList,month);
			for(WaterRecord curRecord : recordList){
				boolean hasPrev = false;
				for(WaterRecord prevRecord : prevRecordList){
					if(curRecord.getUser().getId().equals(prevRecord.getUser().getId())){
						curRecord.setLastQuantity(prevRecord.getNowQuantity());
						curRecord.setLastCheckDate(prevRecord.getNowCheckDate());
						curRecord.setLastOwe(prevRecord.getNowOwe());
						hasPrev = true;
						break;
					}
				}
				//如果没有上次查表记录
				if(!hasPrev){
					curRecord.setLastQuantity(0);
					curRecord.setLastCheckDate(null);
					curRecord.setLastOwe(0);
				}
				//设置单价
				if(curRecord.getUser().getType().equals(ConstantUtil.normalLabel)){
					curRecord.setUnitPrice(Double.parseDouble(ConstantUtil.normalPrice));
				}
				if(curRecord.getUser().getType().equals(ConstantUtil.businessLabel)){
					curRecord.setUnitPrice(Double.parseDouble(ConstantUtil.businessPrice));
				}
				//流水号生成
				curRecord.setSwiftNumber(ConstantUtil.createSwiftNumber(curRecord.getUser().getId()));
				//设置日期
				curRecord.setPrintDate(new Date());
				//设置本次查表时间
				curRecord.setNowCheckDate(new Date());
				//获取抄表员
				if(selectMeterReader == null || selectMeterReader.equals("")){
					curRecord.setMeterReader(workerList.get(0));
				}else{
					curRecord.setMeterReader(selectMeterReader);
				}
				//获取收费员
				if(selectCollector == null || selectCollector.equals("")){
					curRecord.setTollCollector(workerList.get(0));
				}else{
					curRecord.setTollCollector(selectCollector);
				}
			}
		}
		return SUCCESS;
	}*/
	/**
	 * 用水录入页面
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String recordInput() throws UnsupportedEncodingException{
		zoneList = ZoneUtil.getAllZones();
		workerList = WorkerUtil.getAllWorkers();
		if(month == null){
			month = DateUtil.dateToMonth(ConstantUtil.operateDate);
		}
		String sql = "select u.*,w.* from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where u.valid=1";
		String countSql = "select count(u.id) as count from user u left join waterecord w on u.id=w.user and w.month='"+DateUtil.monthToSqlDate(month)+"' where u.valid=1";
		if(userZone!=null && !userZone.equals("")){
			sql+=" and u.zone='"+userZone+"' ";
			countSql += " and u.zone='"+userZone+"' ";
			Cookie cookie = new Cookie("userZone",URLEncoder.encode(userZone, "utf-8"));
			response.addCookie(cookie);
		}
		if(userType!=null && !userType.equals("")){
			sql+=" and u.type='"+userType+"' ";
			countSql += " and u.type='"+userType+"' ";
			Cookie cookie = new Cookie("userType",URLEncoder.encode(userType, "utf-8"));
			response.addCookie(cookie);
		}
		if(userId!=null && !userId.equals("")){
			sql += " and u.id='"+userId+"' ";
			countSql += " and u.id='"+userId+"' ";
			Cookie cookie = new Cookie("userId",URLEncoder.encode(userId, "utf-8"));
			response.addCookie(cookie);
		}
		if(currentPage == null){
			currentPage = 0;
		}
		if(by == null){
			by = "u.id";
		}
		if(order == null){
			order = "asc";
		}
		Cookie cookie_1 = new Cookie("currentPage",currentPage.toString());
		response.addCookie(cookie_1);
		Cookie cookie_2 = new Cookie("by",URLEncoder.encode(by, "utf-8"));
		response.addCookie(cookie_2);
		Cookie cookie_3 = new Cookie("order",order);
		response.addCookie(cookie_3);
		Cookie cookie_4 = new Cookie("fromPage","noinput");
		response.addCookie(cookie_4);
		//if(entered == null || entered == false){//查询未录入
			sql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"') order by u.id asc limit 4";
			countSql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"')";
		//}
		recordList=recordDao.queryBySql(sql);
		rowCount = recordDao.queryCountBySql(countSql);
		rows = recordList.size();
		if(recordList.size()>0&&rowCount>0){
			List<WaterRecord> prevRecordList = recordDao.queryPrevRecords(recordList,month);
			for(WaterRecord curRecord : recordList){
				boolean hasPrev = false;
				for(WaterRecord prevRecord : prevRecordList){
					if(curRecord.getUser().getId().equals(prevRecord.getUser().getId())){
						curRecord.setLastQuantity(prevRecord.getNowQuantity());
						curRecord.setNowQuantity(prevRecord.getNowQuantity());
						curRecord.setLastCheckDate(prevRecord.getNowCheckDate());
						curRecord.setLastOwe(prevRecord.getNowOwe());
						hasPrev = true;
						break;
					}
				}
				//如果没有上次查表记录
				if(!hasPrev){
					curRecord.setLastQuantity(0);
					curRecord.setLastCheckDate(null);
					curRecord.setLastOwe(0);
				}
				//设置单价
				if(curRecord.getUser().getType().equals(ConstantUtil.normalLabel)){
					curRecord.setUnitPrice(Double.parseDouble(ConstantUtil.normalPrice));
				}
				if(curRecord.getUser().getType().equals(ConstantUtil.businessLabel)){
					curRecord.setUnitPrice(Double.parseDouble(ConstantUtil.businessPrice));
				}
				//流水号生成
				curRecord.setSwiftNumber(ConstantUtil.createSwiftNumber(curRecord.getUser().getId()));
				//设置日期
				curRecord.setPrintDate(new Date());
				//设置本次查表时间
				curRecord.setNowCheckDate(new Date());
				//获取抄表员
				if(selectMeterReader == null || selectMeterReader.equals("")){
					if(workerList.size()>0) curRecord.setMeterReader(workerList.get(0));
				}else{
					curRecord.setMeterReader(selectMeterReader);
				}
				//获取收费员
				if(selectCollector == null || selectCollector.equals("")){
					if(workerList.size()>0) curRecord.setTollCollector(workerList.get(0));
				}else{
					curRecord.setTollCollector(selectCollector);
				}
				curRecord.setPayMethod(Label.getString("billdetail.cash"));//默认收费方式
			}
		}
		return SUCCESS;
	}
	public String detail(){
		zoneList = ZoneUtil.getAllZones();
		workerList = WorkerUtil.getAllWorkers();
		if(id!=null){
			String sql = "select u.*,w.* from user u,waterecord w where u.id=w.user and w.id=?";
			List<WaterRecord> wrList = recordDao.queryBySql(sql, id);
			if(wrList.size()>0){
				record = wrList.get(0);
				return "billdetail";
			}
		}
		if(fromPage!=null){
			Cookie cookie = new Cookie("fromPage",fromPage);
			response.addCookie(cookie);
		}
		return ERROR;
		
	}
	
	public String batchSave(){
		List<WaterRecord> wrList = new ArrayList<WaterRecord>();
		JSONArray array = JSONArray.fromObject(jsonStr);
		for(Object obj:array){
			JSONObject object = JSONObject.fromObject(obj);
			WaterRecord wr = new WaterRecord();
			wr.setId(object.getInt("id"));
			wr.setNowShouldCollect(object.getDouble("nowShouldCollect"));//本期应收
			wr.setNowRealCollect(object.getDouble("nowRealCollect"));//本期实收
			wr.setTollCollector(object.getString("tollCollector"));
			wr.setPrintDate(DateUtil.parseDateFromString(object.getString("printDate")));
			//计算本期累欠
			BigDecimal should = new BigDecimal(Double.toString(wr.getNowShouldCollect()));
			BigDecimal real = new BigDecimal(Double.toString(wr.getNowRealCollect()));
			BigDecimal nowOwe =  should.subtract(real);
			wr.setNowOwe(nowOwe.doubleValue());
			wrList.add(wr);
			System.out.println(object.getString("tollCollector"));
		}
		int rows = recordDao.batchUpdateRealCollect(wrList);
		if(rows == wrList.size()){
			dataMap.put("message", Label.getString("recordaction.updatedone"));
		}else{
			dataMap.put("message", Label.getString("recordaction.updatefail"));
		}
		return SUCCESS;
	}
	
	public String recordAdd(){
		zoneList = ZoneUtil.getAllZones();
		workerList = WorkerUtil.getAllWorkers();
		if(month == null){
			month = DateUtil.dateToMonth(ConstantUtil.operateDate);
		}
		User user = userDao.queryById(userId);
		WaterRecord prevRecord  = recordDao.queryPrevRecord(user, month);
		if(record == null) record = new WaterRecord();
		record.setUser(user);
		if(prevRecord!=null){
			record.setLastQuantity(prevRecord.getNowQuantity());
			record.setNowQuantity(prevRecord.getNowQuantity());
			record.setLastCheckDate(prevRecord.getNowCheckDate());
			record.setLastOwe(prevRecord.getNowOwe());
		}else{
			record.setLastQuantity(0);
			record.setLastCheckDate(null);
			record.setLastOwe(0);
		}
		//设置单价
		if(record.getUser().getType().equals(ConstantUtil.normalLabel)){
			record.setUnitPrice(Double.parseDouble(ConstantUtil.normalPrice));
		}
		if(record.getUser().getType().equals(ConstantUtil.businessLabel)){
			record.setUnitPrice(Double.parseDouble(ConstantUtil.businessPrice));
		}
		//流水号生成
		record.setSwiftNumber(ConstantUtil.createSwiftNumber(record.getUser().getId()));
		//设置日期
		record.setPrintDate(new Date());
		//设置本次查表时间
		record.setNowCheckDate(new Date());
		//获取抄表员
		if(selectMeterReader == null || selectMeterReader.equals("")){
			if(workerList.size()>0) record.setMeterReader(workerList.get(0));
		}else{
			record.setMeterReader(selectMeterReader);
		}
		//获取收费员
		if(selectCollector == null || selectCollector.equals("")){
			if(workerList.size()>0) record.setTollCollector(workerList.get(0));
		}else{
			record.setTollCollector(selectCollector);
		}
		record.setPayMethod(Label.getString("billdetail.cash"));//默认收费方式
		return "billdetail";
	}
	
	public String goBack() throws UnsupportedEncodingException{
		Cookie[] cookies = request.getCookies();
		for(Cookie ckie:cookies){
			if("userType".equals(ckie.getName())) userType = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("userZone".equals(ckie.getName())) userZone = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("userId".equals(ckie.getName())) userId =ckie.getValue();
			if("checkDate".equals(ckie.getName())) checkDate =ckie.getValue();
			if("printDate".equals(ckie.getName())) printDate =ckie.getValue();
			if("currentPage".equals(ckie.getName())) currentPage = Integer.valueOf(ckie.getValue());
			if("by".equals(ckie.getName())) by = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("order".equals(ckie.getName())) order = ckie.getValue();
			if("fromPage".equals(ckie.getName())) fromPage = ckie.getValue();
			response.addCookie(ckie);//删除cookie
		}
		if("noinput".equals(fromPage)) return "noinput_back";
		else if("billview".equals(fromPage)) return queryRecord();
		else return ERROR;
	}
	
	public void deleteCookies(){
		Cookie[] cookies = request.getCookies();
		for(Cookie ck:cookies){
			if("JSESSIONID".equals(ck.getName())) continue;
			ck = new Cookie(ck.getName(),null);
			ck.setMaxAge(0);//立即删除cookie
			response.addCookie(ck);
		}
	}
}