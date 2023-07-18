<%
	Function cstConnString
		Const DB_IP = "127.0.0.1"			'//DB 아이피
		Const DB_NAME = "PRESSRAIN"	'//DB 명
		Const DB_ID = "pressrain"			'//DB 아이디
		Const DB_PW = "01053137358"		'//DB 비번

		cstConnString = "provider=sqloledb;data source=" & DB_IP & "; initial catalog=" & DB_NAME & "; uid=" & DB_ID & "; pwd=" & DB_PW & ""
	End Function
%>