package com.smsoft.edms.pkg_barcode;

import java.util.HashMap;
import java.util.List;


public interface BarcodeDAO {
	
	/*barcode list*/
	public List<Object> get_barcode(HashMap<String, Object> map) throws Exception;
	
	/*list count*/
	public int listCount(HashMap<String, Object> map) throws Exception;
	
	public int totalCount() throws Exception;
}
