package com.vp.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.util.ConstantUtil;
import com.vp.util.DateUtil;
import com.vp.util.SysSetting;

import java.util.Map;
import java.util.HashMap;
/**
 * 处理与系统设置相关的逻辑
 * @author adu
 *
 */
public class SettingAction extends SuperAction {
	private static final long serialVersionUID = 1L;
	private static Logger logger = LogManager.getLogger(SettingAction.class);
    public Map<String,Object> dataMap;
	private String orinPassword;
	private String newPassword;
	private String rePassword;
	private String normal;
	private String business;
	private String tbHeader;
	private String telephone;
	private String address;
	private String footer;
	private String operateDate;
	SysSetting ss = SysSetting.getInstance();
	String syspwd = ss.getItem("sys.password");
    
	public SettingAction(){
		dataMap = new HashMap<String,Object>();
	}
	public Map<String, Object> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	public String getOrinPassword() {
		return orinPassword;
	}
	public void setOrinPassword(String orinPassword) {
		this.orinPassword = orinPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getRePassword() {
		return rePassword;
	}
	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}	
	public String getNormal() {
		return normal;
	}
	public void setNormal(String normal) {
		this.normal = normal;
	}
	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public String getTbHeader() {
		return tbHeader;
	}
	public void setTbHeader(String tbHeader) {
		this.tbHeader = tbHeader;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getFooter() {
		return footer;
	}
	public void setFooter(String footer) {
		this.footer = footer;
	}
	public String getOperateDate() {
		return operateDate;
	}
	public void setOperateDate(String operateDate) {
		this.operateDate = operateDate;
	}
	public String resetPassword(){
		if(orinPassword.equals(syspwd)){
			ss.setItem("sys.password", newPassword);
			session.removeAttribute("valid");
			return SUCCESS;
		}else{
			return INPUT;
		}

	}
	public String validatePwd(){
		if(orinPassword != null){
			if(orinPassword.equals(syspwd)){
				dataMap.put("correct",true);
			}else{
				dataMap.put("correct",false);
			}
			return SUCCESS;
		}
		return INPUT;
	}
	
	public String preSet(){
		normal = ss.getItem("unitprice.normal");
		business = ss.getItem("unitprice.business");
		tbHeader = ss.getItem("table.header");
		telephone = ss.getItem("table.telephone");
		address = ss.getItem("table.address");
		footer = ss.getItem("table.footer");
		operateDate = DateUtil.dateToMonth(ss.getItem("sys.operateDate"));
		return "setting";
	}
	
	public String saveSet(){
		if(normal!=null)
			ss.setItem("unitprice.normal", normal);
		if(business!=null)
			ss.setItem("unitprice.business", business);
		if(tbHeader!=null)
			ss.setItem("table.header", tbHeader);
		if(telephone!=null)
			ss.setItem("table.telephone", telephone);
		if(address!=null)
			ss.setItem("table.address", address);
		if(footer!=null)
			ss.setItem("table.footer", footer);
		if(operateDate!=null){
			ss.setItem("sys.operateDate", DateUtil.monthToDate(operateDate));
			ss.setItem("sys.curMonthSwiftNumber", "0001");
		}
		ConstantUtil.update();
		return "index"; 
	}

}
