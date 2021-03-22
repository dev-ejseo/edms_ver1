package com.smsoft.edms.pkg_interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("user_id");
		
		if(userid == null) {
			System.out.println("Interceptor : Session Check Fail");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('시간이 초과 되었습니다.');location.href='/';</script>");
			out.flush();
			
			return false;
		
		} else {
			return super.preHandle(request, response, handler);
		}

	}

}
