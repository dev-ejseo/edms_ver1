package com.smsoft.edms.pkg_login;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smsoft.edms.pkg_login.LoginDTO;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Resource(name = "sqlSession")
	@Inject
	SqlSession sqlsession;

	@Override
	public LoginDTO login(String user_id, String user_pwd) {
		
		LoginDTO dto = null;
		
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("user_id", user_id);
			map.put("user_pwd", user_pwd);
			
			dto = sqlsession.selectOne("pkg_login.loginCheck", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
