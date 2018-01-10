package com.vp.filter;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("过滤器销毁。。。");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		String uri = req.getRequestURI();
		StringBuffer url = req.getRequestURL();
		String relativeURL = url.substring(url.lastIndexOf("/"));
		Map<String,String[]> paramMap = req.getParameterMap();
		int len = paramMap.size();
		if(len>0){
			int i = 0;
			for(String key:paramMap.keySet()){
				String[] values = paramMap.get(key);
				for(int j=0;j<values.length;j++){
					if(i == 0){
						relativeURL += "?"+key+"="+values[j];
					}else{
						relativeURL += "&"+key+"="+values[j];
					}
					i++;
				}
			}
		}
		String basePath = "http://localhost:"+req.getServerPort()+req.getContextPath();
		HttpSession session = req.getSession();
		String valid = (String)session.getAttribute("valid");
		if("1".equals(valid)){//已经登陆
			if(uri.endsWith("login")||uri.endsWith("login.jsp")||uri.endsWith("index.jsp")||uri.endsWith("waterprice/")||uri.endsWith("waterprice")){
				System.out.println(uri);
				resp.sendRedirect("WaterRecordAction_recordInput");//进入主界面
			}else{
				chain.doFilter(req, resp);
			}
		}else{//未登陆
			if(uri.endsWith("login.jsp")||uri.endsWith("login")||uri.contains("img")||uri.contains("js")||uri.contains("css")){
				chain.doFilter(req, resp);
			}else{
				resp.sendRedirect(basePath+"/login.jsp?retURL="+URLEncoder.encode(relativeURL, "utf-8"));//进入登陆界面
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("过滤器实例化。。。");
	}

}
