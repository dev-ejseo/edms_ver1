package com.smsoft.edms.pkg_history_log;

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

import com.smsoft.edms.pkg_history_log.HistoryLogDAO;

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
public class HistoryLogController {

	@Inject
	HistoryLogDAO historylogdao;

	@RequestMapping(value = "pkg_history_log/history_log") 
	public ModelAndView history(Model model, HttpSession session, @RequestParam(value = "keyword", required = false) String search_barcode) throws Exception {
		
		// rel_place = 출고처, ent_place = 입고처, barcode = 바코드
		
		String search_option;
		String search_keyword;
		
		if((search_barcode != null)) {
			// 바코드 검색 

			search_option = "BARCODE_INFO_Barcode";
			search_keyword = search_barcode;
			
			/*System.out.println(search_barcode);*/
			
		} else { 
			search_option = "all";
			search_keyword = "";
			
			/*System.out.println("22");*/
		}
		
		session.setAttribute("search_option", search_option);
		session.setAttribute("search_keyword", search_keyword);

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", 0);
		map.put("end", 20);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = historylogdao.get_history_log(map);
		
		/* list count */
		int count = historylogdao.listCount(map);
		
		/*System.out.println("list" + list);*/

		ModelAndView mav = new ModelAndView();
		
		if (list.isEmpty() && search_keyword != "") {
			mav.addObject("msg", "검색 결과가 존재하지 않습니다."); 
			mav.addObject("url", "/pkg_history_log/history_log"); 
			mav.setViewName("include/redirect"); 
			
			/*System.out.println("검색 결과가 존재하지 않습니다.");*/
			
		} else {
		mav.addObject("listHistory", list);
		mav.addObject("listCount", count);
		mav.setViewName("pkg_history_log/history_log");
		}
		return mav;
	}

	@RequestMapping("pkg_history_log/MoreData.do")
	public ModelAndView historyMoreData(Model model, HttpSession session, @RequestParam int rowLength) throws Exception {

		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", rowLength + 20);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = historylogdao.get_history_log(map);
		
		/* list count */
		int count = historylogdao.listCount(map);

		/*System.out.println("map = " + map);*/

		ModelAndView mav = new ModelAndView();

		mav.addObject("listHistory", list);
		mav.addObject("listCount", count);
		mav.addObject("rowLength", rowLength);
		
		mav.setViewName("pkg_history_log/history_log_paging");

		return mav;
	}

	@RequestMapping("pkg_history_log/MoreDataEnd.do")
	public ModelAndView barcodeMoreDataEnd(Model model, HttpSession session, @RequestParam int rowLength) throws Exception {
		
		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");
		
		int total_count = historylogdao.totalCount();

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", total_count);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		List<Object> list = historylogdao.get_history_log(map);
		
		/* list count */
		int count = historylogdao.listCount(map);

		/*System.out.println("map = " + map);*/

		ModelAndView mav = new ModelAndView();

		mav.addObject("listHistory", list);
		mav.addObject("listCount", count);
		mav.addObject("rowLength", rowLength);
		
		mav.setViewName("pkg_history_log/history_log_paging");

		return mav;
	}
}
