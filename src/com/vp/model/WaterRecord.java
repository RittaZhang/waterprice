package com.vp.model;

import java.util.Date;

public class WaterRecord {
	private Integer id;
	private User user;				//用户
	private Date month;				//缴费的月份：格式：yyyy-MM
	private String swiftNumber;		//流水号
	private String meterNumber;		//表号
	private int lastQuantity;		//上次表数
	private Date lastCheckDate;		//上次查表日期
	private int nowQuantity;		//本次表数
	private Date nowCheckDate;		//本次查表日期
	private int quantity;			//用水量
	private double unitPrice;		//单价
	private double additionPrice;	//追缴水费
	private double totalPrice;		//金额
	private double lastOwe;			//上期累欠
	private double nowShouldCollect;//本期应收
	private double nowRealCollect;	//本期实收
	private double nowOwe;			//本期累欠
	private String collectUpper;	//应收大写
	private String meterReader;		//抄表员
	private Date printDate;			//打印日期
	private String payMethod;		//交给方式
	private String tollCollector;	//收费员
	private int status;				//状态
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getMonth() {
		return month;
	}
	public void setMonth(Date month) {
		this.month = month;
	}
	public String getSwiftNumber() {
		return swiftNumber;
	}
	public void setSwiftNumber(String swiftNumber) {
		this.swiftNumber = swiftNumber;
	}
	public String getMeterNumber() {
		return meterNumber;
	}
	public void setMeterNumber(String meterNumber) {
		this.meterNumber = meterNumber;
	}
	public int getLastQuantity() {
		return lastQuantity;
	}
	public void setLastQuantity(int lastQuantity) {
		this.lastQuantity = lastQuantity;
	}
	public Date getLastCheckDate() {
		return lastCheckDate;
	}
	public void setLastCheckDate(Date lastCheckDate) {
		this.lastCheckDate = lastCheckDate;
	}
	public int getNowQuantity() {
		return nowQuantity;
	}
	public void setNowQuantity(int nowQuantity) {
		this.nowQuantity = nowQuantity;
	}
	public Date getNowCheckDate() {
		return nowCheckDate;
	}
	public void setNowCheckDate(Date nowCheckDate) {
		this.nowCheckDate = nowCheckDate;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public double getAdditionPrice() {
		return additionPrice;
	}
	public void setAdditionPrice(double additionPrice) {
		this.additionPrice = additionPrice;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public double getLastOwe() {
		return lastOwe;
	}
	public void setLastOwe(double lastOwe) {
		this.lastOwe = lastOwe;
	}
	public double getNowShouldCollect() {
		return nowShouldCollect;
	}
	public void setNowShouldCollect(double nowShouldCollect) {
		this.nowShouldCollect = nowShouldCollect;
	}
	public double getNowRealCollect() {
		return nowRealCollect;
	}
	public void setNowRealCollect(double nowRealCollect) {
		this.nowRealCollect = nowRealCollect;
	}
	public double getNowOwe() {
		return nowOwe;
	}
	public void setNowOwe(double nowOwe) {
		this.nowOwe = nowOwe;
	}
	public String getCollectUpper() {
		return collectUpper;
	}
	public void setCollectUpper(String collectUpper) {
		this.collectUpper = collectUpper;
	}
	public String getMeterReader() {
		return meterReader;
	}
	public void setMeterReader(String meterReader) {
		this.meterReader = meterReader;
	}
	public Date getPrintDate() {
		return printDate;
	}
	public void setPrintDate(Date printDate) {
		this.printDate = printDate;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getTollCollector() {
		return tollCollector;
	}
	public void setTollCollector(String tollCollector) {
		this.tollCollector = tollCollector;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
