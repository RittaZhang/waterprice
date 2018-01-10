package com.vp.dbconn;
/**
 * 实现数据库的备份与还原
 * http://www.tuicool.com/articles/BrmMF3
 * http://www.iteye.com/problems/94239
 */
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.vp.util.ConstantUtil;
import com.vp.util.SysSetting;

public class DbUtils {
	private static String userName;//数据库用户名
	private static String password;//数据库密码
	private static String dbName;//要备份的数据库名称
	private static String dbBasePath;//数据库安装bin路径
	private static String backupPath;//数据库备份路径
	private static String backupName;//数据库备份名称(绝对路径)
	private static String namePrefix;
	private DbUtils(){}
	/**
	 * 从属性文件读取备份所需的参数
	 */
	public static void initParams(){
		SysSetting ss = SysSetting.getInstance();
		userName = ss.getItem("db.userName");
		password = ss.getItem("db.password");
		dbName = ss.getItem("db.name");
		dbBasePath = ss.getItem("db.basePath");
		backupPath = ss.getItem("db.backupPath");
		File f = new File(backupPath);
		if(!f.exists()){
			f.mkdirs();//如果备份保存路径不存在，则创建目录
		}
		namePrefix = ss.getItem("db.backupFilePrefix");;
	}
	/**
	 * 数据库备份
	 * @return 备份后保存文件的绝对路径
	 */
	public static String backup(){
		initParams();//实例化所需的各种参数
		backupName = backupPath + "/"+makeBackupName();//备份文件的绝对路径
		System.out.println(backupName);
		String cmd = dbBasePath + "/mysqldump --default-character-set=utf8 -u" + userName + " -p" + password + " " + dbName;
		System.out.println(cmd);
		Runtime rt = Runtime.getRuntime();
		BufferedReader br = null;
		BufferedWriter bw = null;
		InputStream in = null;
		try {
			Process process = rt.exec(cmd);
			in = process.getInputStream();
			br = new BufferedReader(new InputStreamReader(in,"utf8"));
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(backupName)),"utf8"));
			char[] buff = new char[2048];
			int len;
			while((len=br.read(buff,0, 2048))>0){
				bw.write(buff,0,len);
			}
			bw.flush();
			try {
				if(process.waitFor() == 0){//表示线程正常终止
					System.out.println("备份成功！");
					return backupName;
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} catch (IOException e) {
			System.out.println("备份输出异常");
			e.printStackTrace();
		}finally{
			try {
				if(bw!=null){
					bw.close();
				}
				if(br!=null){
					br.close();
				}
				if(in!=null){
					in.close();
				}
			} catch (IOException e) {
				System.out.println("输入输出流关闭出现异常！");
				e.printStackTrace();
			}
		}
		return null;
	}
	/**
	 * 数据库备份还原
	 * @param fileName 备份文件的完整路径，如：E:/backup/供水厂数据_201512261754.sql
	 * @return 是否还原成功
	 */
	public static boolean restore(String fileName){
		return restore(new File(fileName));
	}
	/**
	 * 数据库备份还原
	 * @param file 要被还原的sql文件对象
	 * @return 是否还原成功
	 */
	public static boolean restore(File file){
		initParams();
		//createDB();
		String cmd = dbBasePath + "/mysql --default-character-set=utf8 " + "-u" + userName + " -p" + password + " " + dbName;
		System.out.println("还原cmd:"+cmd);
		Runtime rt = Runtime.getRuntime();
		BufferedReader br = null;
		BufferedWriter bw = null;
		try {
			Process process = rt.exec(cmd);
			OutputStream out = process.getOutputStream();//控制台作为输出流
			bw = new BufferedWriter(new OutputStreamWriter(out,"utf8"));
			InputStream in = new FileInputStream(file);//从备份文件读取数据，作为输入流
			br = new BufferedReader(new InputStreamReader(in,"utf8"));
			char[] buff = new char[2048];
			int len;
			while((len=br.read(buff, 0, 2048))>-1){
				bw.write(buff, 0, len);
			}
			bw.flush();
			out.close();
			bw.close();
			in.close();
			br.close();
			buff = null;
			try {
				if(process.waitFor()==0){
					System.out.println("还原完成！");
					process.destroy();
					return true;
				}
			} catch (InterruptedException e) {
				System.out.println("还原中断异常！");
				e.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 构造备份名称
	 * @return
	 */
	public static String makeBackupName(){
		String bName = namePrefix + "_";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		bName += sdf.format(new Date());
		bName += ".sql";
		return bName;
	}
	/**
	 * 创建数据库
	 */
	public static void createDB(){
		String cmd = dbBasePath + "/mysqladmin -u" + userName + " -p" + password+" create "+dbName;
		System.out.println(cmd);
		Runtime rt = Runtime.getRuntime();
		try {
			rt.exec(cmd);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
