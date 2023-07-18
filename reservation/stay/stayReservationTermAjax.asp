<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	DbOpen()

	Dim spSeq : spSeq = Request("spSeq")
	Dim reserveDate : reserveDate = Request("reserveDate")
	dbReserveDate = reserveDate

	If spSeq = "" Then
		'Response.Write "객실을 선택하세요."
		'Response.End
	End If

	If reserveDate = "" Then
		'Response.Write "날짜를 선택하세요."
		'Response.End
	End If

	If spSeq <> "" And reserveDate <> "" Then
		sql = ""
		sql = sql & "SELECT TOP 1 B.RD_RESERVE_DATE, C.R_STATE, CONVERT(INT, RIGHT(B.RD_RESERVE_DATE, 2)) AS RD_RESERVE_DATE_1  "
		sql = sql & "FROM TBL_STAY_PRODUCT A "
		sql = sql & "INNER JOIN TBL_RESERVATION_DATE B ON A.SP_SEQ = B.SP_SEQ "
		sql = sql & "INNER JOIN TBL_RESERVATION C ON B.R_SEQ = C.R_SEQ "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & "AND B.SP_SEQ = '" & spSeq & "' "
		sql = sql & "AND B.RD_RESERVE_DATE >= '" & reserveDate & "' "
		sql = sql & "ORDER BY B.RD_RESERVE_DATE ASC "
		Response.Write "sql: "& sql
		Set rs = dbconn.execute(sql)
		If Not rs.eof Then
			dbReserveDate = rs("RD_RESERVE_DATE")
		Else
			dbReserveDate = reserveDate
		End If

		selectedDate = DateDiff("D", reserveDate, dbReserveDate)

	End If
%>
<div class="recent-blog mb-30">
	<div class="recent-blog-content">
		<%If spSeq <> "" Then%>
			<p><span>객실명: </span><span></span></p>
		<%End If%>
		<%If reserveDate <> "" Then%>
			<p><span>날짜: </span><span></span></p>
		<%End If%>


		<select name='' id='' class='form-control'>
			<option value=''>==선택==</option>
			<%'For d = CDate(reserveDate) To CDate(dbReserveDate) %>
			<%For d = 1 To selectedDate %>
			<option value=''><%=d%>박<%=d+1%>일</option>
			<%Next%>
			<option value=''>2박3일</option>
			<option value=''>3박4일</option>
		</select>
	</div>
</div>

<%
	DbClose()
%>