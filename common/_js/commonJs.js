// Date(YYYY-MM-DD) + n일
function StringToDate(date, n) {
	let yyyy = date.substring(0, 4);
	let mm = date.substring(5, 7);
	let dd = date.substring(8, 10);
	mm = Number(mm) - 1;

	let stringNewDate = new Date(yyyy, mm, dd);
	stringNewDate.setDate(stringNewDate.getDate() + n);

	return stringNewDate.getFullYear() +
		"-" + ((stringNewDate.getMonth() + 1) > 9 ? (stringNewDate.getMonth() + 1).toString() : "0" + (stringNewDate.getMonth() + 1)) +
		"-" + (stringNewDate.getDate() > 9 ? stringNewDate.getDate().toString() : "0" + stringNewDate.getDate().toString());
}

function AddDays(date, days) {
    // date는 문자열로 받는다 ex, '2023-07-20'
    var result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}