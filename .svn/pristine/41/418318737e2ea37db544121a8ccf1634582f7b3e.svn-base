package com.vp.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

public class SysSetting {
	private static String fileName = "/conf.properties";
	private static String filePath;
	private static SysSetting setting;
	private SysSetting(){
		try {
			filePath = SysSetting.class.getClassLoader().getResource("").toURI().getPath().substring(1);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	/**
	 * 获取系统设定实例
	 * @return
	 */
	public static SysSetting getInstance(){
		if(setting == null){
			setting = new SysSetting();
		}
		return setting;
	}
	/**
	 * 根据key设置item的值
	 * @param key
	 * @param value
	 */
	public void setItem(String key,String value) {
		try {
			if(getItem(key).equals(value)) return;
			InputStream in = new FileInputStream(filePath + fileName);
			Properties property = new Properties();
			property.load(in);
			OutputStream out = new FileOutputStream(filePath+fileName);
			in.close();
			property.setProperty(key, value);
			property.store(out, "update key:"+key);
			out.close();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}
	/**
	 * 获取item的值
	 * @param key
	 * @return
	 */
	public String getItem(String key){
		try{
			InputStream in = new FileInputStream(filePath + fileName);
			Properties property = new Properties();
			property.load(in);
			in.close();
			return property.getProperty(key);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
