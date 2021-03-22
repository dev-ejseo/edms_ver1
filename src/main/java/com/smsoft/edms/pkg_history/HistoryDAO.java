package com.smsoft.edms.pkg_history;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface HistoryDAO {
	
	public List<Object> get_history(HashMap<String, Object> map) throws Exception;
	
	public List<Object> Insert_history(Map<String, Object> m, String getfileAbsolute);
	
	/*public List<Object> Delete_history(ArrayList<String> arrayList);*/
	
	/*list count*/
	/*public int listCount(HashMap<String, Object> map) throws Exception;*/
	
	/*public int totalCount() throws Exception;*/
	
	public int barcode_num() throws Exception;
}
