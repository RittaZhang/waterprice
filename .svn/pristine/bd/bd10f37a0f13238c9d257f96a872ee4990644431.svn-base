package com.vp.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

/**
 * 处理和用户管理相关的逻辑
 * 包括用户添加，修改，删除，查询显示等
 * @author adu
 *
 */
public class UserAction extends SuperAction{
	private static final long serialVersionUID = 1L;
	private static Logger logger = LogManager.getLogger(UserAction.class);
	private static UserDao userdao=DaoFactory.getUserDao();
	private static WaterRecordDao recordDao = DaoFactory.getWaterRecordDao();
    public Map<String,Object> dataMap;
	private List<User> userList;
	private String userId;//添加用户时要验证的id
	private User user;//要添加的user
	private String id;//要删除或编辑user的id
	private List<String> zoneList;
	private List<String> workerList;
	private String month;//月份
	private String selectMeterReader;//选择的抄表员	
	private String selectCollector;//选择的收费员
	private String selId;//通过该id查询user
	private String userType;//通过该type查询user	
	private String userZone;//通过该zone查询user
	private boolean editable;
	private Integer rowCount;//总记录条数
	private Integer currentPage;//当前页数
	private int pageSize=15;//每页显示的记录数
	private Integer rows;//当前页记录数
	private String message;//页面提示信息
	private String by;
	private String order;
	private List<WaterRecord> recordList;//get set方法
	private Integer recordPageSize = 10;//get方法
	private Integer noinputPageSize = 15;
	
	public UserAction(){
		dataMap = new HashMap<String,Object>();
	}
	public Map<String, Object> getDataMap() {
		return dataMap;
	}
	
	public List<String> getWorkerList() {
		return workerList;
	}
	public void setWorkerList(List<String> workerList) {
		this.workerList = workerList;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
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
	public Integer getNoinputPageSize() {
		return noinputPageSize;
	}
	public void setRecordPageSize(Integer recordPageSize) {
		this.recordPageSize = recordPageSize;
	}
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<String> getZoneList() {
		return zoneList;
	}

	public void setZoneList(List<String> zoneList) {
		this.zoneList = zoneList;
	}

	public String getSelId() {
		return selId;
	}

	public void setSelId(String selId) {
		this.selId = selId;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getUserZone() {
		return userZone;
	}

	public void setUserZone(String usetZone) {
		this.userZone = usetZone;
	}

	public boolean isEditable() {
		return editable;
	}

	public void setEditable(boolean editable) {
		this.editable = editable;
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

	public Integer getPageSize() {
		return pageSize;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	public String getBy() {
		return by;
	}
	public void setBy(String by) {
		this.by = by;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public List<WaterRecord> getRecordList() {
		return recordList;
	}
	public void setRecordList(List<WaterRecord> recordList) {
		this.recordList = recordList;
	}
	public Integer getRecordPageSize() {
		return recordPageSize;
	}
	public String validateUser(){
		if(userId!=null){
			if(userdao.isExist(userId)){
				dataMap.put("correct",false);//该账户已存在
			}else{
				dataMap.put("correct",true);
			}
			return SUCCESS;
		}
		return INPUT;
	}
	
	public String saveUser(){
		if(userdao.isExist(user.getId())){//已存在，编辑
			userdao.update(user);
			dataMap.put("message", Label.getString("recordaction.updatedone"));
			return SUCCESS;		
		}else{//表示数据库中不存在，添加
			if(userdao.save(user).getId() != null){
				zoneList = ZoneUtil.getAllZones();
				message = Label.getString("useraction.user") + user.getLastName() + user.getFirstName() + Label.getString("useraction.adddone");
				dataMap.put("message", message);
				//user = new User();
				editable = true;
				return SUCCESS;		
			}
		}
		return INPUT;
	}
	
	public String preEdit() throws UnsupportedEncodingException{
		zoneList=ZoneUtil.getAllZones();
		if(id!=null){//从编辑链接跳转过来
			editable = false;//表示id不可编辑
			user = userdao.queryById(id);
			if(currentPage == null){
				currentPage = 0;
			}
			if(by == null){
				by = "w.month";
			}
			if(order == null){
				order = "desc";
			}
			String sql = "select u.*,w.* from user u,waterecord w where u.id=w.user and w.user='"+id+"' ";
			sql += " order by " + by + " " + order + " limit " + recordPageSize*currentPage +","+ recordPageSize;
			String countSql = "select count(u.id) as count from  user u,waterecord w where u.id=w.user and w.user='"+id+"' ";
			recordList = recordDao.queryBySql(sql);
			rowCount=userdao.queryCountBySql(countSql);
		}else{//从添加用户过来
			editable = true;//表示id可编辑
		}
		return INPUT;
	}
	
	public String deleteUser(){
		if(id!=null){
			zoneList=ZoneUtil.getAllZones();
			userdao.deleteById(id);
			return "searchUser";
		}
		return "searchUser";
	}
	
	public String searchUser() throws UnsupportedEncodingException{
		deleteCookies();
		zoneList=ZoneUtil.getAllZones();
		String sql="select u.*,w.latestMonth from user u left join (select user,max(month) as latestMonth from waterecord group by user) w on u.id=w.user where valid=1";
		String countSql = "select count(id) from user where valid=1 ";
		
		if(selId!=null && !selId.equals("")){
			sql+=" and u.id='"+selId+"' ";
			countSql+=" and id='"+selId+"' ";
			Cookie cookie = new Cookie("selId",URLEncoder.encode(selId, "utf-8"));
			response.addCookie(cookie);
		}
		if(userType!=null && !userType.equals("")){
			sql+=" and u.type='"+userType+"' ";
			countSql+=" and type='"+userType+"' ";
			Cookie cookie = new Cookie("userType",URLEncoder.encode(userType, "utf-8"));
			response.addCookie(cookie);
		}
		if(userZone!=null && !userZone.equals("")){
			sql+=" and u.zone='"+userZone+"' ";
			countSql+=" and zone='"+userZone+"' ";
			Cookie cookie = new Cookie("userZone",URLEncoder.encode(userZone, "utf-8"));
			response.addCookie(cookie);
		}
		if(currentPage == null){
			currentPage = 0;
		}
		if(by == null){
			by = "id";
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
		Cookie cookie_4 = new Cookie("fromPage","userview");
		response.addCookie(cookie_4);
		int fromIndex = currentPage * pageSize;
		sql+=" order by " + by + " " + order + " limit " + fromIndex +","+ pageSize;
		userList=userdao.queryUser(sql);
		rowCount=userdao.queryCountBySql(countSql);
		System.out.println("sql user========"+sql);
		if(userList.size() == 0 ){
			message = Label.getString("useraction.nodata");
		}
		return SUCCESS;
	}
	public String noInput() throws UnsupportedEncodingException{
		deleteCookies();
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
		if(order==null){
			order ="asc";
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
			sql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"') order by "+by+" "+order+" limit "+noinputPageSize*currentPage+","+noinputPageSize;
			countSql+=" and u.id not in (select user from waterecord where month='"+DateUtil.monthToSqlDate(month)+"')";
		//}
		System.out.println(sql);
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
		return "noinput";
	}
	/**
	 * 返回或取消按钮的事件处理
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String goBack() throws UnsupportedEncodingException{
		Cookie[] cookies = request.getCookies();
		String fromPage = "";
		for(Cookie ckie:cookies){
			if("selId".equals(ckie.getName())) selId = ckie.getValue();
			if("userType".equals(ckie.getName())) userType = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("userZone".equals(ckie.getName())) userZone = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("currentPage".equals(ckie.getName())) currentPage = Integer.valueOf(ckie.getValue());
			if("by".equals(ckie.getName())) by = URLDecoder.decode(ckie.getValue(), "utf-8");
			if("order".equals(ckie.getName())) order = ckie.getValue();
			if("fromPage".equals(ckie.getName())) fromPage = ckie.getValue();
			response.addCookie(ckie);//删除cookie
		}
		if("userview".equals(fromPage)) return searchUser();
		else if("noinput".equals(fromPage)) return noInput();
		else return ERROR;
	}
	/**
	 * 删除cookie
	 */
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
