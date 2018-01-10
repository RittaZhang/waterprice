package com.vp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/**
 * 用于和日期格式化转换相关的工具类
 * @author adu
 *
 */
public class DateUtil {
	private final static int VIRGULE = 1;	// 表示'/'分隔符
	private final static int HYPHEN = 2;	// 表示'-'分隔符
	private DateUtil(){}
	
	/**
	 * 将日期格式化为月份
	 * @param d
	 * @return String 'yyyy-MM'
	 */
	public static String dateToMonth(java.util.Date d){
		if(d == null) return null;
		return formatToString(d,"yyyy-MM");
	}
	/**
	 * 
	 * @param date 'yyyy-MM-dd'
	 * @return String 'yyyy-MM'
	 */
	public static String dateToMonth(String date){
		return date.substring(0,date.lastIndexOf("-"));
	}
	/**
	 * 
	 * @param month yyyy-MM
	 * @return String yyyy-MM-01
	 */
	public static String monthToDate(String month){
		return month + "-01";
	}
	public static java.util.Date monthToUtilDate(String month){
		return parseDateFromString(monthToDate(month));
	}
	/**
	 * 
	 * @param month 'yyyy-MM'
	 * @return java.sql.Date
	 */
	public static java.sql.Date monthToSqlDate(String month){
		return convertUtilToSqlDate(monthToUtilDate(month));
	}
	/**
	 * 获取date的前几个月的日期
	 * @param date
	 * @param m
	 * @return
	 */
	public static java.util.Date addMonths(java.util.Date date,int m){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, m);
		return calendar.getTime();
	}
	/**
	 * convert the Util date type to SQL date type
	 * @param date
	 * @return java.sql.Date
	 */
	public static java.sql.Date convertUtilToSqlDate(java.util.Date date){
		if(date==null) return null;
		return new java.sql.Date(date.getTime());
	}
	public static java.sql.Timestamp convertUtilToSqlTimestamp(java.util.Date date){
		if(date == null) return null;
		return new java.sql.Timestamp(date.getTime());
	}
	/**
	 * convert the SQL date type to util date type
	 * @param date the sql date will be converted
	 * @return java.util.Date
	 */
	public static java.util.Date convertSqlToUtilDate(java.sql.Date date){
		if(date == null) return null;
		return new java.util.Date(date.getTime());
	}
	/**
	 * get current date with String type
	 * @return like '2015-08-14'
	 */
	public static String getCurDateString(){
		return formatDateString(new Date());
	}
	/**
	 * get current date and time with String type
	 * @return like '2015-08-14 00:00:00'
	 */
	public static String getCurDateTimeString(){
		return formatDateTimeString(new Date());
	}
	/**
	 * format a date to date type String
	 * @param date the date will be formated
	 * @return String like '2015-08-14'
	 */
	public static String formatDateString(java.util.Date date){
		return formatDateString(date,HYPHEN);
	}
	/**
	 * format a date to a date type string
	 * @param date the date will be formated
	 * @param operator could be DateUtil.VIRGULE:'/' or DateUtil.HYPHEN:'-'
	 * @return String like '2014-08-14' or '2014/08/14' depend on operator parameter
	 */
	public static String formatDateString(java.util.Date date,final int operator){
		String fmt = "";
		if(operator == VIRGULE){
			fmt = "yyyy/MM/dd";
		}else if(operator == HYPHEN){
			fmt = "yyyy-MM-dd";
		}
		return formatToString(date,fmt);
	}
	/**
	 * format a datetime to date type String
	 * @param date the date will be formated
	 * @return String like '2015-08-14 00:00:00'
	 */
	public static String formatDateTimeString(java.util.Date date){
		return formatDateTimeString(date,HYPHEN);
	}
	/**
	 * format a date to a datetime type string
	 * @param date the date will be formated
	 * @param operator could be DateUtil.VIRGULE:'/' or DateUtil.HYPHEN:'-'
	 * @return String like '2014-08-14 00:00:00' or '2014/08/14 00:00:00' depend on operator parameter
	 */
	public static String formatDateTimeString(java.util.Date date,final int operator){
		String fmt = "";
		if(operator == VIRGULE){
			fmt = "yyyy/MM/dd HH:mm:ss";
		}else if(operator == HYPHEN){
			fmt = "yyyy-MM-dd HH:mm:ss";
		}
		return formatToString(date,fmt);
	}
	/**
	 * format a Date to String with format
	 * @param date
	 * @param fmt
	 * @return a String and the type depend on fmt parameter
	 */
	public static String formatToString(java.util.Date date,String fmt){
		if(date==null) return "";
		return new SimpleDateFormat(fmt).format(date);
	}
	/**
	 * parse a string to datetime type
	 * @param fs such as : '2014-03-05 03:21:58' or '2014/03/05 03:21:58'
	 * @return java.util.Date
	 */
	public static java.util.Date parseDateTimeFromString(String fs){
		if(fs.indexOf("/")>0){
			return parseDateTimeFromString(fs,VIRGULE);
		}else{
			return parseDateTimeFromString(fs,HYPHEN);
		}
	}
	/**
	 * parse a string to datetime type
	 * @param fs such as : '2014-03-05 03:21:58' or '2014/03/05 03:21:58'
	 * @param operator could be DateUtil.VIRGULE:'/' or DateUtil.HYPHEN:'-'
	 * @return java.util.Date
	 */
	public static java.util.Date parseDateTimeFromString(String fs,final int operator){
		String fmt = "";
		if(operator == VIRGULE){
			fmt = "yyyy/MM/dd HH:mm:ss";
		}else if(operator == HYPHEN){
			fmt = "yyyy-MM-dd HH:mm:ss";
		}
		return parseFromString(fs,fmt);
	}
	/**
	 * parse a string to date type
	 * @param fs such as : '2014-03-05' or '2014/03/05'
	 * @return java.util.Date
	 */
	public static java.util.Date parseDateFromString(String fs){
		if(fs.indexOf("/")>0){
			return parseDateFromString(fs,VIRGULE);
		}else{
			return parseDateFromString(fs,HYPHEN);
		}
	}
	/**
	 * parse a string to date type
	 * @param fs such as : '2014-03-05' or '2014/03/05'
	 * @param operator could be DateUtil.VIRGULE:'/' or DateUtil.HYPHEN:'-'
	 * @return java.util.Date
	 */
	public static java.util.Date parseDateFromString(String fs,final int operator){
		String fmt = "";
		if(operator == VIRGULE){
			fmt = "yyyy/MM/dd";
		}else if(operator == HYPHEN){
			fmt = "yyyy-MM-dd";
		}
		return parseFromString(fs,fmt);
	}
	/**
	 * parse a string to a date type
	 * @param 	 	fmt specify the date format
	 * @param fs 	the string of you want to parse
	 * @return		java.util.Date
	 */
	public static java.util.Date parseFromString(String fs,String fmt){
		SimpleDateFormat sdf = new SimpleDateFormat(fmt);
		try {
			return sdf.parse(fs);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
}
