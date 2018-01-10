package com.vp.util;

import java.util.ResourceBundle;

public class Label {
	
	private static String baseName = "messages";
	private static ResourceBundle conf = null;
	
	public static String getString(String key){
		if(conf == null){
			conf = ResourceBundle.getBundle(baseName);
		}
		return conf.getString(key);
	}
}
