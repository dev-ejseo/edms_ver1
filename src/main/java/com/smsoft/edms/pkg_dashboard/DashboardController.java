package com.smsoft.edms.pkg_dashboard;

import javax.servlet.http.HttpSession;
import javax.inject.Inject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.smsoft.edms.pkg_dashboard.DashboardDAO;

@Controller
public class DashboardController {

	SimpleDateFormat Dateformat = new SimpleDateFormat("yyyy-MM-dd");

	@Inject
	DashboardDAO dashboarddao;

	@RequestMapping("pkg_dashboard/dashboard")
	public String home(Model model, HttpSession session) {
		
		return "pkg_dashboard/dashboard";
	}

	// 한달 기준 한달 전까지의 기간별 차트
	@RequestMapping("pkg_dashboard/termDateChart")
	public @ResponseBody ModelAndView dashboard_termDateChart(Model model,
			@RequestParam(value = "", required = false) String area,
			@RequestParam(value = "", required = false) String warehouse) {
		
		switch (area) {
		case "Gangwon":
			area = "강원도";
			break;
		case "Seoul":
			area = "서울특별시";
			break;
		case "Gyeonggi":
			area = "경기도";
			break;
		case "Incheon":
			area = "인천광역시";
			break;
		case "North Chungcheong":
			area = "충청북도";
			break;
		case "South Chungcheong":
			area = "충청남도";
			break;
		case "Sejong":
			area = "세종특별자치시";
			break;
		case "Daejeon":
			area = "대전광역시";
			break;
		case "North Gyeongsang":
			area = "경상북도";
			break;
		case "Daegu":
			area = "대구광역시";
			break;
		case "South Gyeongsang":
			area = "경상남도";
			break;
		case "Ulsan":
			area = "울산광역시";
			break;
		case "Busan":
			area = "부산광역시";
			break;
		case "North Jeolla":
			area = "전라북도";
			break;
		case "South Jeolla":
			area = "전라남도";
			break;
		case "Gwangju":
			area = "광주광역시";
			break;
		case "Jeju":
			area = "제주도";
			break;
		}

		// nowtime = 오늘 날짜, beforeMonth = 한달전날짜
		Date time = new Date();
		String nowtime = Dateformat.format(time);

		Calendar onemonth = Calendar.getInstance();
		onemonth.add(Calendar.MONTH, -1);
		String beforeMonth = Dateformat.format(onemonth.getTime());

		List<Object> data_list = dashboarddao.dashboard_termDateChart(area, warehouse, nowtime, beforeMonth);
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("data_list", data_list);
		mav.addObject("area_name", area);
		mav.addObject("warehouse", warehouse);
		mav.setViewName("pkg_dashboard/period_battery");

		return mav;
	}

	// 한달 기준 한달 전까지의 지역별 차트
	@RequestMapping("pkg_dashboard/termAreaChart")
	public @ResponseBody ModelAndView dashboard_termAreaChart(Model model,
			@RequestParam(value = "", required = false) String area,
			@RequestParam(value = "", required = false) String warehouse) {
		
		switch (area) {
		case "Gangwon":
			area = "강원도";
			break;
		case "Seoul":
			area = "서울특별시";
			break;
		case "Gyeonggi":
			area = "경기도";
			break;
		case "Incheon":
			area = "인천광역시";
			break;
		case "North Chungcheong":
			area = "충청북도";
			break;
		case "South Chungcheong":
			area = "충청남도";
			break;
		case "Sejong":
			area = "세종특별자치시";
			break;
		case "Daejeon":
			area = "대전광역시";
			break;
		case "North Gyeongsang":
			area = "경상북도";
			break;
		case "Daegu":
			area = "대구광역시";
			break;
		case "South Gyeongsang":
			area = "경상남도";
			break;
		case "Ulsan":
			area = "울산광역시";
			break;
		case "Busan":
			area = "부산광역시";
			break;
		case "North Jeolla":
			area = "전라북도";
			break;
		case "South Jeolla":
			area = "전라남도";
			break;
		case "Gwangju":
			area = "광주광역시";
			break;
		case "Jeju":
			area = "제주도";
			break;
		}

		// nowtime = 오늘 날짜, beforeMonth = 한달전날짜
		Date time = new Date();
		String nowtime = Dateformat.format(time);

		Calendar onemonth = Calendar.getInstance();
		onemonth.add(Calendar.MONTH, -1);
		String beforeMonth = Dateformat.format(onemonth.getTime());
		
		List<Object> area_list = dashboarddao.dashboard_termAreaChart(area, warehouse, nowtime, beforeMonth);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("area_list", area_list);
		mav.addObject("area_name", area);
		mav.addObject("warehouse", warehouse);
		mav.setViewName("pkg_dashboard/region_battery");

		return mav;
	}

	// 해당 지역으로 입고된 배터리의 용량별 분포 데이터
	@RequestMapping("pkg_dashboard/pieChart_bat")
	public @ResponseBody ModelAndView dashboard_pieChart_bat(Model model,
			@RequestParam(value = "", required = false) String area) {

		// area = 지역
		switch (area) {
		case "Gangwon":
			area = "강원도";
			break;
		case "Seoul":
			area = "서울특별시";
			break;
		case "Gyeonggi":
			area = "경기도";
			break;
		case "Incheon":
			area = "인천광역시";
			break;
		case "North Chungcheong":
			area = "충청북도"; 
			break;
		case "South Chungcheong":
			area = "충청남도";
			break;
		case "Sejong":
			area = "세종특별자치시";
			break;
		case "Daejeon":
			area = "대전광역시";
			break;
		case "North Gyeongsang":
			area = "경상북도";
			break;
		case "Daegu":
			area = "대구광역시";
			break;
		case "South Gyeongsang":
			area = "경상남도";
			break;
		case "Ulsan":
			area = "울산광역시";
			break;
		case "Busan":
			area = "부산광역시";
			break;
		case "North Jeolla":
			area = "전라북도";
			break;
		case "South Jeolla":
			area = "전라남도";
			break;
		case "Gwangju":
			area = "광주광역시";
			break;
		case "Jeju":
			area = "제주도";
			break;
		}

		List<Object> list = dashboarddao.dashboard_pieChart_bat(area);
		
		ModelAndView mav = new ModelAndView();

		mav.addObject("list", list);
		mav.addObject("area_name", area);
		mav.setViewName("pkg_dashboard/capacity_distribute");

		return mav;
	}

	// 해당 지역으로 출고한 지역 분포 데이터
	@RequestMapping("pkg_dashboard/pieChart_area")
	public @ResponseBody ModelAndView dashboard_pieChart_area(Model model,
			@RequestParam(value = "", required = false) String area) {

		switch (area) {
		case "Gangwon":
			area = "강원도";
			break;
		case "Seoul":
			area = "서울특별시";
			break;
		case "Gyeonggi":
			area = "경기도";
			break;
		case "Incheon":
			area = "인천광역시";
			break;
		case "North Chungcheong":
			area = "충청북도";
			break;
		case "South Chungcheong":
			area = "충청남도";
			break;
		case "Sejong":
			area = "세종특별자치시";
			break;
		case "Daejeon":
			area = "대전광역시";
			break;
		case "North Gyeongsang":
			area = "경상북도";
			break;
		case "Daegu":
			area = "대구광역시";
			break;
		case "South Gyeongsang":
			area = "경상남도";
			break;
		case "Ulsan":
			area = "울산광역시";
			break;
		case "Busan":
			area = "부산광역시";
			break;
		case "North Jeolla":
			area = "전라북도";
			break;
		case "South Jeolla":
			area = "전라남도";
			break;
		case "Gwangju":
			area = "광주광역시";
			break;
		case "Jeju":
			area = "제주도";
			break;
		}

		List<Object> list = dashboarddao.dashboard_pieChart_area(area);
		ModelAndView mav = new ModelAndView();

		mav.addObject("list", list);
		mav.addObject("area_name", area);
		mav.setViewName("pkg_dashboard/region_distribute");

		return mav;
	}
}
