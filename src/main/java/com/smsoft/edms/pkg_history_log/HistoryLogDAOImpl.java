package com.smsoft.edms.pkg_history_log;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class HistoryLogDAOImpl implements HistoryLogDAO {

	@Resource(name = "sqlSession")

	@Inject
	SqlSession sqlsession;

	@Override
	public List<Object> get_history_log(HashMap<String, Object> map) throws Exception {
		
		return sqlsession.selectList("pkg_history_log.get_history_log", map);
	}

	/* list count */
	@Override
	public int listCount(HashMap<String, Object> map) throws Exception {

		return sqlsession.selectOne("pkg_history_log.listCount", map);
	}

	@Override
	public int totalCount() throws Exception {
		
		return sqlsession.selectOne("pkg_history_log.totalCount");
	}

	@Override
	public int barcode_num() throws Exception {
		
		return sqlsession.selectOne("pkg_history_log.barcodeNum");
	}

}
