package com.smsoft.edms.pkg_login;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.smsoft.edms.pkg_login.LoginDAO;
import com.smsoft.edms.pkg_login.LoginDTO;

@Controller
public class LoginController {

	@Inject
	LoginDAO logindao;

	
	@RequestMapping("/")
	public String home1(Model model, HttpSession session) {
		return "pkg_login/home";
	}

	@RequestMapping("home")
	public String home2(Model model, HttpSession session) {
		return "pkg_login/home";
	}

	// 로그인
	@RequestMapping("login")
	public String login(Model model, HttpSession session, String user_id, String user_pwd, HttpServletResponse response) throws IOException {

		LoginDTO logindto = logindao.login(user_id, user_pwd);

		if (logindto == null) {
			// 로그인 실패시
			
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다."); 
			model.addAttribute("url", "/"); 
			
			return "include/redirect"; 
		} else {
			// 로그인 성공
			// 아이디 사용여부 Y만 로그인 가능
			if ((logindto.getUse_yn()).equals("N")) {
				
				model.addAttribute("msg", "사용하지 않는 계정입니다."); 
				model.addAttribute("url", "/"); 
				
				return "include/redirect"; 
			} else {
				// 관리자 사용자 구별, 관리자 Y logindto.getUser_admin()
				
				session.setAttribute("user_id", logindto.getUser_id());
				session.setAttribute("user_admin", logindto.getUser_admin());
				
				return "pkg_dashboard/dashboard"; 
			}

		}

	}

	// 로그아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
		return "redirect:/";
	}
}
