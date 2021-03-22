package com.smsoft.edms.pkg_dashboard;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository("DashboardDAO")
public class DashboardDAOImpl implements DashboardDAO {

	@Resource(name = "sqlSession")
	@Inject
	SqlSession sqlsession;

	@Override
	public List<Object> dashboard_termDateChart(String area, String warehouse, String nowtime, String beforeMonth) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("area", area);
		map.put("nowtime", nowtime);
		map.put("beforeMonth", beforeMonth);

		if (warehouse.equals("In")) {

			return sqlsession.selectList("pkg_dashboard.In_termDateChart", map);
		
		} else {
			
			return sqlsession.selectList("pkg_dashboard.Out_termDateChart", map);
		}

	}
	
	@Override
	public List<Object> dashboard_termAreaChart(String area, String warehouse, String nowtime, String beforeMonth) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("area", area);
		map.put("nowtime", nowtime);
		map.put("beforeMonth", beforeMonth);

		if (warehouse.equals("In")) {

			/*System.out.println("입고");*/

			return sqlsession.selectList("pkg_dashboard.In_termAreaChart", map);
		
		} else {
			
			/*System.out.println("출고");*/
			
			return sqlsession.selectList("pkg_dashboard.Out_termAreaChart", map);
		}
	}

	@Override
	public List<Object> dashboard_pieChart_bat(String area) {
		
		return sqlsession.selectList("pkg_dashboard.bat_pieChart", area);
	}

	@Override
	public List<Object> dashboard_pieChart_area(String area) {
		
		return sqlsession.selectList("pkg_dashboard.area_pieChart", area);
	}

}
