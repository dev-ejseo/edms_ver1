package com.smsoft.edms.pkg_dashboard;

import java.util.List;

public interface DashboardDAO {
	
	public List<Object> dashboard_termDateChart(String area, String warehouse, String nowtime, String beforeMonth);
	
	public List<Object> dashboard_termAreaChart(String area, String warehouse, String nowtime, String beforeMonth);
	
	public List<Object> dashboard_pieChart_bat(String area);
	
	public List<Object> dashboard_pieChart_area(String area);

}
