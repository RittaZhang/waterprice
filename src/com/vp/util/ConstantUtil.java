package com.vp.util;

import java.util.Date;
/**
 * 提供常量的类
 * @author adu
 *
 */
public class ConstantUtil {
	public static String printTitle;//打印标题：乌拉街满族镇供水站水费收据
	public static String telephoneValue;//报修电话的值:97934
	public static String addressValue;//地址：乌拉街
	public static String printFooter;//打印表尾：乌拉街内
	public static String dbName;//数据库名称
	public static String dbPassword;//数据库密码
	public static String dbUserName;//数据库用户名
	public static String dbBasePath;//数据库安装bin路径
	public static String dbBackupPath;//数据库备份路径
	public static String dbBackupPrefix;//数据库备份名称前缀
	public static String normalPrice;//居民用水单价
	public static String businessPrice;//商业用水单价
	public static String normalLabel;//居民用水
	public static String businessLabel;//商业用水
	public static String operateDate;//操作的日期，也就是月份
	public static String curMonthSwiftNumber;//本月流水号
	static{
		update();
	}
	public static void update(){
		SysSetting ss = SysSetting.getInstance();
		normalLabel = ss.getItem("label.normal");
		businessLabel = ss.getItem("label.business");
		normalPrice = ss.getItem("unitprice.normal");
		businessPrice = ss.getItem("unitprice.business");
		printTitle = ss.getItem("table.header");
		telephoneValue = ss.getItem("table.telephone");
		addressValue = ss.getItem("table.address");
		printFooter = ss.getItem("table.footer");
		dbName = ss.getItem("db.name");
		dbPassword = ss.getItem("db.password");
		dbUserName = ss.getItem("db.userName");
		dbBasePath = ss.getItem("db.basePath");
		dbBackupPath = ss.getItem("db.backupPath");
		dbBackupPrefix = ss.getItem("db.backupFilePrefix");
		operateDate = ss.getItem("sys.operateDate");
		curMonthSwiftNumber = ss.getItem("sys.curMonthSwiftNumber");
	}
	/**
	 * 根据用户id生成流水号
	 * @param userId
	 * @return
	 */
	public static String createSwiftNumber(String userId){
		return "J"+DateUtil.formatToString(new Date(), "yyyyMMddHHmmss")+userId;
	}
	
	public static String keep4(int number){
		if(0<number&&number<10){
			return "000"+number;
		}else if(number<100){
			return "00"+number;
		}else if(number<1000){
			return "0"+number;
		}else if(number<10000){
			return ""+number;
		}else{
			return null;
		}
	}
}
