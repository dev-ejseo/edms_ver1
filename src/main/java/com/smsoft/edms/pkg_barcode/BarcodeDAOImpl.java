package com.smsoft.edms.pkg_barcode;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public class BarcodeDAOImpl implements BarcodeDAO{
	
	@Resource(name = "sqlSession")
	
	@Inject
	SqlSession sqlsession;
	
	/*barcode list*/
	@Override
	public List<Object> get_barcode(HashMap<String, Object> map) throws Exception {
		
		return sqlsession.selectList("pkg_barcode.get_barcode", map);
	}
	
	/*list count*/
	@Override
	public int listCount(HashMap<String, Object> map) throws Exception {
		
		return sqlsession.selectOne("pkg_barcode.listCount", map);
	}

	@Override
	public int totalCount() throws Exception {
		
		return sqlsession.selectOne("pkg_barcode.totalCount");
	}
}
