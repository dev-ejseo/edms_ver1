package com.smsoft.edms.pkg_history;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class HistoryDAOImpl implements HistoryDAO {

	@Resource(name = "sqlSession")

	@Inject
	SqlSession sqlsession;

	@Override
	public List<Object> get_history(HashMap<String, Object> map) throws Exception {
		
		/*System.out.println("map = " + map);*/
		
		return sqlsession.selectList("pkg_history.get_history", map);
	}

	@Override
	public List<Object> Insert_history(Map<String, Object> m, String getfileAbsolute) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("m", m);
		map.put("getfileAbsolute", getfileAbsolute);

		System.out.println("map: " + map);

		return sqlsession.selectList("pkg_history.insert_history", map);

	}

	/*@Override
	public List<Object> Delete_history(ArrayList<String> arrayList) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("deletelist", arrayList);

		return sqlsession.selectList("pkg_history.delete_history", map);

	}*/

	/* list count */
	/*@Override
	public int listCount(HashMap<String, Object> map) throws Exception {

		return sqlsession.selectOne("pkg_history.listCount", map);
	}*/

	/*@Override
	public int totalCount() throws Exception {
		
		return sqlsession.selectOne("pkg_history.totalCount");
	}*/

	@Override
	public int barcode_num() throws Exception {
		
		return sqlsession.selectOne("pkg_history.barcodeNum");
	}

}
