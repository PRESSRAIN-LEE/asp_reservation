<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	DbOpen()

	Dim spSeq : spSeq = Request("spSeq")
	Dim reserveDate : reserveDate = Request("reserveDate")

	If spSeq = "" Then
		Response.Write "객실을 선택하세요."
		Response.End
	End If

	If reserveDate = "" Then
		Response.Write "날짜를 선택하세요."
		Response.End
	End If

		sql = ""
		sql = sql & "SELECT "
		sql = sql & "FROM "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & "AND "
		sql = sql & ""
	
%>
<select name='' id='' class='form-control'>
	<option value=''>==선택==</option>
	<option value=''>1박2일</option>
	<option value=''>2박3일</option>
	<option value=''>3박4일</option>
</select>

<%
	DbClose()
%>