package com.smsoft.edms.pkg_history_log;

import java.util.HashMap;
import java.util.List;

public interface HistoryLogDAO {
	
	public List<Object> get_history_log(HashMap<String, Object> map) throws Exception;
	
	/*list count*/
	public int listCount(HashMap<String, Object> map) throws Exception;
	
	public int totalCount() throws Exception;
	
	public int barcode_num() throws Exception;
}
