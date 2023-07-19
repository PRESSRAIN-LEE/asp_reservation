<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	DbOpen()

	Dim spSeq : spSeq = Request("spSeq")
	Dim reserveDate : reserveDate = Request("reserveDate")
	Dim stayPerson : stayPerson = 0

	sql = ""
	sql = sql & "SELECT SP_NAME, SP_PERSON "
	sql = sql & "FROM TBL_STAY_PRODUCT "
	sql = sql & "WHERE 1 = 1 "
	sql = sql & "AND SP_SEQ = '" & spSeq & "' "
	'Print sql
	Set rs = dbconn.execute(sql)
	If Not rs.eof Then
		stayName = rs("SP_NAME")
		stayPerson = rs("SP_PERSON")
	End If

	rs.Close
	Set rs = Nothing

	DbClose()
%>
<select name='' id='' class='form-select form-select-lg' aria-label=".form-select-lg">
	<option value=''>==선택==</option>
	<%For m = 1 To stayPerson%>
	<option value='<%=m%>'><%=m%>명</option>
	<%Next%>
</select>