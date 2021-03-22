package com.smsoft.edms.pkg_history;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.smsoft.edms.pkg_history.HistoryDAO;

// 바코드 import 2020-04-10 은주 추가
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeFactory;
import net.sourceforge.barbecue.BarcodeImageHandler;

@Controller
public class HistoryController {

	@Inject
	HistoryDAO historydao;
	
		@RequestMapping(value = "pkg_history/history")
		public String history(Model model, HttpSession session) throws Exception {

			return "pkg_history/history";
		}
		
	// search_option에 rel_place, ent_place, barcode 보내주면 됩니다 
	@RequestMapping(value = "pkg_history/history_search")
	public ModelAndView history_search(Model model, HttpSession session, String search_barcode) throws Exception {
		
		// rel_place = 출고처, ent_place = 입고처, barcode = 바코드
		String search_option;
		String search_keyword;
		
		if((search_barcode != null)) {
			// 바코드 검색 

			search_option = "barcode";
			search_keyword = search_barcode;
			
		} else { 
			search_option = "all";
			search_keyword = "";
		}
		
		session.setAttribute("search_option", search_option);
		session.setAttribute("search_keyword", search_keyword);

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = historydao.get_history(map);
		
		ModelAndView mav = new ModelAndView();
		
		if (list.isEmpty()) {
			mav.addObject("msg", "검색 결과가 존재하지 않습니다."); 
			mav.addObject("url", "/pkg_history/history"); 
			mav.setViewName("include/redirect"); 
			
			System.out.println("검색 결과가 존재하지 않습니다.");
			
		} else {
		mav.addObject("listHistory", list);
		mav.setViewName("pkg_history/history_search");
		}
		return mav;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping("pkg_history/Insert")
	public @ResponseBody String Insert_history(HttpServletRequest request, HttpSession session, @RequestBody String param_list) throws Exception {

		// barcode = 바코드, user_id = 담당자
		// rel_metro = 출고광역지역, rel_area = 출고기초지역, rel_place = 출고처, rel_dt = 출고일
		// ent_metro = 입고광역지역, ent_area = 입고기초지역, ent_place = 입고처, ent_dt = 입고일
		// V = 전압, A = 전류, SOC = 잔량, Kwh = 용량
		
		String now_userid = (String)session.getAttribute("user_id");

		// test data (list는 실제 받을 데이터, list1은 test 데이터)
		List<Map<String, Object>> list = new ArrayList<>();
		
		List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
		 
		Map<String, Object> map1 = new HashMap<>();
		
		resultMap = JSONArray.fromObject(param_list);
		
		String succ_msg = "succ";
		String fail_msg = "fail";
		
		// 제일 최근 바코드 가져오기
		int barcode_num = historydao.barcode_num();
		int barcode_pluscount = 1;
		
		for (Map<String, Object> map2 : resultMap) {
			
			map1 = new HashMap<>();
			
			if(map2.get("barcode").equals("1")) {
				map1.put("barcode", String.format("%012d", barcode_num+barcode_pluscount));
				barcode_num ++;
			} else {
				map1.put("barcode", map2.get("barcode"));
			}
			
			if(map2.get("user_id").equals("1")) {
				map1.put("user_id", now_userid);
			} else {
				map1.put("user_id", map2.get("user_id"));
			}
			
			map1.put("bat_kind", map2.get("bat_kind"));
			map1.put("rel_metro", map2.get("rel_metro"));
			map1.put("rel_area", map2.get("rel_area"));
			map1.put("rel_place", map2.get("rel_place"));
			map1.put("rel_dt", map2.get("rel_dt"));
			map1.put("ent_metro", map2.get("ent_metro"));
			map1.put("ent_area", map2.get("ent_area"));
			map1.put("ent_place", map2.get("ent_place"));
			map1.put("ent_dt", map2.get("ent_dt"));
			map1.put("V", map2.get("V"));
			map1.put("A", map2.get("A"));
			map1.put("SOC", map2.get("SOC"));
			map1.put("Kwh", map2.get("Kwh"));
			map1.put("car_type", map2.get("car_type"));
			map1.put("mileage", map2.get("mileage"));

			list.add(map1);
		}
		
		for (int i = 0; i < resultMap.size(); i++) {

			Map<String, Object> m = list.get(i);

			String m_barcode = (String) m.get("barcode");
			String getfileAbsolute = null;

			// 바코드 생성
			try {

				Barcode barcode_de = BarcodeFactory.createCode128B(m_barcode);
				barcode_de.setBarHeight(40);

				File file = new File("C:\\barcode" + File.separator + barcode_de + ".PNG");

				getfileAbsolute = file.getAbsolutePath();

				BarcodeImageHandler.savePNG(barcode_de, file);

			} catch (Exception e) {
				e.printStackTrace();
			}

			// barcode_local = getfileAbsolute
			historydao.Insert_history(m, getfileAbsolute);

		}

		// 리스트에 데이터가 없을 때
		if (list.size() == 0) {
			return fail_msg;
		} else {
			return succ_msg;
		}

	}
}
