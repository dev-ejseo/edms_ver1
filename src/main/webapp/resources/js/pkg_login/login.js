function fn_onlyEngNum(obj) {
	$("#" + obj).val($("#" + obj).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/g, ''));
}

function fn_onlyNum(obj) {
	$("#" + obj).val($("#" + obj).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힝|A-Za-z]/g, ''));
}