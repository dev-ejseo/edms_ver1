package com.smsoft.edms.pkg_user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserDAO {
	
	public List<Object> get_user(HashMap<String, Object> map) throws Exception;
	
	/*list count*/
	public int listCount(HashMap<String, Object> map) throws Exception;
	
	public int totalCount() throws Exception;
	
	public List<Object> Insert_user(Map<String, Object> m);
	
	public List<Object> Delete_user(ArrayList<String> arrayList);
	
}
