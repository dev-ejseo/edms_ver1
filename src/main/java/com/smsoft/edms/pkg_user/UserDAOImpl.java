package com.smsoft.edms.pkg_user;

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

import com.smsoft.edms.pkg_user.UserDAO;

@Repository("UserDAO")
public class UserDAOImpl implements UserDAO {

	@Resource(name = "sqlSession")

	@Inject
	SqlSession sqlsession;

	@Override
	public List<Object> get_user(HashMap<String, Object> map) throws Exception {

		return sqlsession.selectList("pkg_user.get_user", map);
	}

	/* list count */
	@Override
	public int listCount(HashMap<String, Object> map) throws Exception {

		return sqlsession.selectOne("pkg_user.listCount", map);
	}
	
	@Override
	public int totalCount() throws Exception {
		return sqlsession.selectOne("pkg_user.totalCount");
	}

	@Override
	public List<Object> Insert_user(Map<String, Object> m) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("m", m);

		return sqlsession.selectList("pkg_user.insert_user", map);
	}

	@Override
	public List<Object> Delete_user(ArrayList<String> arrayList) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("deletelist", arrayList);

		return sqlsession.selectList("pkg_user.delete_user", map);

	}

}
