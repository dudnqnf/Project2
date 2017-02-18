function check(filter, val, msg) {
	if (filter.test(val))
		return true;
	else
		return false;
}

function number_check(val){
	return check(/^[0-9]+$/, val);
}

function age_check(val){
	return check(/^([0-9][0-9]|[0-9])/, val);
}

function name_check(val){
	return check(/^[가-힝]{2,}$/, val);
}

function email_check(val){
	return check(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i, val);
}

function password_check(val){
	return check(/^[a-z0-9]{6,15}$/, val);
}

function phone_number_check(val){
	return check(/^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/, val);
}

