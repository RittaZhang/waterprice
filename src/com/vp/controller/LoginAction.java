package com.vp.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.vp.dao.DaoFactory;
import com.vp.dao.UserDao;
import com.vp.dbconn.DbUtils;
import com.vp.util.Label;
import com.vp.util.SysSetting;

public class LoginAction extends SuperAction{
	private static final long serialVersionUID = 1L;
	private static Logger logger = LogManager.getLogger(LoginAction.class);
	private String password;
	private String errorMessage;
	private String retURL;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	public String getRetURL() {
		return retURL;
	}

	public void setRetURL(String retURL) {
		this.retURL = retURL;
	}

	public String login(){
		SysSetting ss = SysSetting.getInstance();
		String syspwd = ss.getItem("sys.password");
		if(syspwd.equals(password)){
			session.setAttribute("valid", "1");
			/*if("0".equals(ss.getItem("concat.flag"))){
				UserDao udao = DaoFactory.getUserDao();
				String sql1 = "update user set lastName=(select concat(lastName,firstName))";
				String sql2 = "update user set firstName=''";
				udao.updateBySql(sql1);
				udao.updateBySql(sql2);
				ss.setItem("concat.flag", "1");//本段代码不再需要，因为原本姓名是分开的，后来要合并到lastName上，所以。。。
			}*/
			return SUCCESS;
		}else{
			errorMessage = Label.getString("loginaction.pwdwrong");
			return INPUT;
		}
	
	}
	
	public String logout(){
		new Thread(new Runnable(){
			@Override
			public void run() {
				DbUtils.backup();
			}
		}).start();//退出时启动一个线程强制备份
		session.removeAttribute("valid");
		return INPUT;
	}
}
