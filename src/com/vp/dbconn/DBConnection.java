package com.vp.dbconn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * 主要是提供与数据库的连接对象
 * @author adu
 *
 */
public class DBConnection {
	//private static final ThreadLocal<Connection> threadConnection = new ThreadLocal<Connection>();
	private DBConnection(){}
	
	public static Connection getConn(){
		Connection conn = null;
			try {
				//if(conn == null||conn.isClosed()){
					Context ctxt = (Context)new InitialContext().lookup("java:comp/env");
					DataSource ds = (DataSource)ctxt.lookup("jdbc/mysql");
					try {
						conn = ds.getConnection();
						//threadConnection.set(conn);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				//}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return conn;
	}
	public static final void closeQuietly(ResultSet rs, Statement st,Connection conn) {
		if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		if (st != null) {try {st.close();} catch (SQLException e) {}}
		if (conn != null) {try {conn.close();} catch (SQLException e) {}}
	}
	public static final void closeQuietly(ResultSet rs, Statement st) {
		if (rs != null) {try {rs.close();} catch (SQLException e) {}}
		if (st != null) {try {st.close();} catch (SQLException e) {}}
	}
	public static final void closeQuietly(Statement st,Connection conn) {
		if (st != null) {try {st.close();} catch (SQLException e) {}}
		if (conn != null) {try {conn.close();} catch (SQLException e) {}}
	}
	public static final void closeQuietly(Statement st) {
		if (st != null) {try {st.close();} catch (SQLException e) {}}
	}
}
