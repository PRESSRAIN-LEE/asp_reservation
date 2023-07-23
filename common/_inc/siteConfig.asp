<%
	Const rootDir = "/"

	'//랜덤 css, js파일 버전
	Randomize
	Dim cssJsVersion : cssJsVersion = Rnd()

	'//
	Dim defaultReserveDate : defaultReserveDate = DateAdd("d", 10, Date())

	'//포인트 사용 여부 (Y/N)
	Const setPointUse = "Y"

	'//포인트 사용 최저금액 섧정
	Const setPointMin = 0
%>