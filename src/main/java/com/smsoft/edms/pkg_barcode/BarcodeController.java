package com.smsoft.edms.pkg_barcode;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.smsoft.edms.pkg_barcode.BarcodeDAO;

// barcode print 은주 추가
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintException;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.Size2DSyntax;
import javax.print.attribute.standard.MediaSize;

@Controller
public class BarcodeController {

	@Inject
	BarcodeDAO barcodeDao;

	// search_option에 USER_INFO_user_id, Barcode 보내주면 됩니다
	@RequestMapping("pkg_barcode/barcode")
	public ModelAndView barcode(Model model, HttpSession session,
			@RequestParam(value = "keyword1", required = false) String search_person,
			@RequestParam(value = "keyword2", required = false) String search_barcode) throws Exception {

		// Barcode = 바코드 , USER_INFO_user_id = 담당자
		String search_option;
		String search_keyword;

		// 바코드 검색
		if ((search_person == "") && (search_barcode != "")) {

			search_option = "Barcode";
			search_keyword = search_barcode;

		} else if ((search_barcode == "") && (search_person != "")) {
			// 담당자 검색

			search_option = "USER_INFO_user_id";
			search_keyword = search_person;

		} else {
			search_option = "all";
			search_keyword = "";
		}

		session.setAttribute("search_option", search_option);
		session.setAttribute("search_keyword", search_keyword);

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", 0);
		map.put("end", 19);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		/* barcode list */
		List<Object> list = barcodeDao.get_barcode(map);

		/* list count */
		int count = barcodeDao.listCount(map);

		ModelAndView mav = new ModelAndView();
		
		if (list.isEmpty() && search_keyword != "") {
			mav.addObject("msg", "검색 결과가 존재하지 않습니다."); 
			mav.addObject("url", "/pkg_barcode/barcode"); 
			mav.setViewName("include/redirect"); 
			
		} else {
		mav.addObject("listBarcode", list);
		mav.addObject("listCount", count);
		mav.setViewName("pkg_barcode/barcode");
		}
		return mav;
	}

	@RequestMapping("pkg_barcode/MoreData.do")
	public ModelAndView barcodeMoreData(Model model, HttpSession session, @RequestParam int rowLength)
			throws Exception {

		// Barcode = 바코드 , USER_INFO_user_id = 담당자
		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", rowLength + 20);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		/* barcode list */
		List<Object> list = barcodeDao.get_barcode(map);

		/* list count */
		int count = barcodeDao.listCount(map);

		ModelAndView mav = new ModelAndView();

		mav.addObject("listBarcode", list);
		mav.addObject("listCount", count);
		mav.addObject("rowLength", rowLength);

		mav.setViewName("pkg_barcode/barcode_paging");

		return mav;
	}

	@RequestMapping("pkg_barcode/MoreDataEnd.do")
	public ModelAndView barcodeMoreDataEnd(Model model, HttpSession session, @RequestParam int rowLength)
			throws Exception {

		String search_option = (String) session.getAttribute("search_option");
		String search_keyword = (String) session.getAttribute("search_keyword");

		int total_count = barcodeDao.totalCount();

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("start", rowLength + 1);
		map.put("end", total_count);
		map.put("search_option", search_option);
		map.put("search_keyword", search_keyword);

		/* barcode list */
		List<Object> list = barcodeDao.get_barcode(map);

		/* list count */
		int count = barcodeDao.listCount(map);

		ModelAndView mav = new ModelAndView();

		mav.addObject("listBarcode", list);
		mav.addObject("listCount", count);
		mav.addObject("rowLength", rowLength);

		mav.setViewName("pkg_barcode/barcode_paging");

		return mav;
	}

	// 바코드 인쇄
	@RequestMapping("pkg_barcode/barcode_print")
	public void barcode_print(@RequestParam(value = "", required = false) String filelocal, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		FileReader fr;

		try {
			
			fr = new FileReader(filelocal);

			response.setCharacterEncoding("UTF-8");
			response.getWriter().print("출력 성공.");

			System.out.println("출력 성공.");
			
		} catch (FileNotFoundException e) {
	
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print("해당 파일이 존재하지 않습니다.");

			System.out.println("해당 파일이 존재하지 않습니다.");
			
		}
	}
}
