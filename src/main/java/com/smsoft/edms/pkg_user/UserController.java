package com.smsoft.edms.pkg_user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
	
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.bson.types.BasicBSONList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.smsoft.edms.pkg_user.UserDAO;
import com.sun.xml.fastinfoset.dom.DOMDocumentSerializer;

@Controller
public class UserController {

	@Inject
	UserDAO userdao;

	// search_option에 user_id, company_name 보내주면 됩니다
	@RequestMapping("pkg_user/user")
	public ModelAndView user(Model model, HttpSession session, @RequestParam(value = "keyword1", required = false) String search_person, HttpServletResponse response,
			@RequestParam(value = "keyword2", required = false) String search_company) throws Exception {
		
		String search_option;
		String search_keyword;
		
		// 담당자 검색
		if((search_person != "") && (search_company == "")) {
			
			search_option = "user_id";
			search_keyword = search_person;
			
		} else if((search_company != "") && (search_person == "")) {
			// 소속 검색
			
			search_option = "company_name";
			search_keyword = search_company;
		
		} else {
			search_option = "all";
			search_keyword = "";
		}
		
		session.setAttribute("search_option", search_option);
		session.setAttribute("search_keyword", search_keyword);

 		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", 0);
		map.put("end", 17);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);
		
		/* list count */
		int count = userdao.listCount(map);

		List<Object> list = userdao.get_user(map);

		ModelAndView mav = new ModelAndView();
		
		if (list.isEmpty() && search_keyword != "") {
			mav.addObject("msg", "검색 결과가 존재하지 않습니다."); 
			mav.addObject("url", "/pkg_user/user"); 
			mav.setViewName("include/redirect"); 
			
		} else {
		mav.addObject("listUser", list);
		mav.addObject("listCount", count);
		mav.setViewName("pkg_user/user");
		}
		return mav;
	}

	@RequestMapping("pkg_user/MoreData.do")
	public ModelAndView userMoreData(Model model, HttpSession session, @RequestParam int rowLength) throws Exception {
		
		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", rowLength + 20);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = userdao.get_user(map);
		
		/* list count */
		int count = userdao.listCount(map);
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("listUser", list);
		mav.addObject("listCount", count);
		mav.setViewName("pkg_user/user_paging");

		return mav;
	}

	@RequestMapping("pkg_user/MoreDataEnd.do")
	public ModelAndView userMoreDataEnd(Model model, HttpSession session, @RequestParam int rowLength) throws Exception {
		
		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");

		/* list count */
		int total_count = userdao.totalCount();

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", total_count);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = userdao.get_user(map);
		int count = userdao.listCount(map);

		ModelAndView mav = new ModelAndView();

		mav.addObject("listUser", list);
		mav.addObject("listCount", count);
		mav.setViewName("pkg_user/user_paging");

		return mav;
	}
	
	@SuppressWarnings("unchecked") 
	@RequestMapping(value = "pkg_user/Insert")
	public @ResponseBody String Insert_user(Model model, HttpServletRequest request, @RequestBody String param_list) throws IOException {

		// user_id = 사용자 id, user_pwd = 사용자 비밀번호, user_name = 사용자 이름
		// company_name = 소속회사명 , user_admin = 권한구분코드, user_tel = 연락처
		// use_yn = 사용여부, red_dt = 등록일자, end_dt = 해지일자

		// 사용여부가 N, end_dt가 null일때만 해지일자 업데이트 (두가지 만족)
		
		List<Map<String, Object>> list = new ArrayList<>();
		
	    List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
	    
	    resultMap = JSONArray.fromObject(param_list);
	    
	    Map<String, Object> map1 = null;
		
		for (Map<String, Object> map2 : resultMap) {
			
			map1 = new HashMap<>();
			
			map1.put("user_id", map2.get("user_id"));
			map1.put("user_pwd", map2.get("user_pwd"));
			map1.put("user_name", map2.get("user_name"));
			map1.put("company_name", map2.get("company_name"));
			map1.put("user_admin", map2.get("user_admin"));
			map1.put("user_tel", map2.get("user_tel"));
			map1.put("use_yn", map2.get("use_yn"));
			
			list.add(map1);
		}
		
		for (int i = 0; i < resultMap.size(); i++) {
			
			Map<String, Object> m = list.get(i);
			
			userdao.Insert_user(m);
		}

		return "pkg_user/user";
	}
	
	// 아이디만 넘겨주면 됩니다
	@RequestMapping(value="pkg_user/Delete", method = RequestMethod.POST)
	public String Delete_user(@RequestBody String[] id_array) throws IOException {
		
		String succ_msg = "succ";
		
		// test date (arrayList는 실제 받을 데이터, arrayList1은 test 데이터)
		
		String[] arrayParam = id_array;
		
		ArrayList<String> arrayList = new ArrayList<String>();
		
		for (int i = 0; i < arrayParam.length; i++) { 
			
			arrayList = new ArrayList<>();
			
			arrayList.add(arrayParam[i]);
			
			userdao.Delete_user(arrayList);
		}

		String url = "redirect:/pkg_user/user";
		
		return url;
	}
	
	@RequestMapping("pkg_user/user_home")
	public String user_home() {
		
		return "redirect:/pkg_barcode/barcode";
	}
	
}
