package com.smsoft.edms.pkg_login;

import com.smsoft.edms.pkg_login.LoginDTO;

public interface LoginDAO {
	
	public LoginDTO login(String user_id, String user_pwd);

}
