<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	'On Error Resume Next

	DbOpen()

	Dim dbTable : dbTable = "TBL_STAY_PEAK"
	
	Dim strMode : strMode = Request("strMode")
	Dim peakYear : peakYear = Request("peakYear")
	Dim peakType : peakType = Request("peakType")
	Dim peakTermFrom : peakTermFrom = Request("peakTermFrom")
	Dim peakTermTo : peakTermTo = Request("peakTermTo")
	Dim spSeq : spSeq = Request("spSeq")

	Dim sql

	dbconn.Errors.clear

	dbconn.BeginTrans()

	Select Case strMode
		Case "SAVE"
			For i = 1 to Request("peakType").count
				sql = ""
				sql = sql & "SELECT COUNT(*) CNT "
				sql = sql & "FROM " & dbTable & " "
				sql = sql & "WHERE 1 = 1 "
				sql = sql & "AND SP_TYPE = '" & i & "' "
				sql = sql & "AND SP_YEAR = '" & peakYear & "' "
				sql = sql & "AND SP_STATE = 'Y' "
				Set rs = dbconn.execute(sql)
				If rs("CNT") = 0 Then
					sql = ""
					sql = sql & "INSERT INTO " & dbTable & " ( SP_YEAR, SP_TYPE, SP_FROM, SP_TO "
					sql = sql & ") VALUES ( "
					sql = sql & " '" & peakYear & "' "
					sql = sql & ", '" & i & "' "
					sql = sql & ", '" & Request("peakTermFrom")(i) & "' "
					sql = sql & ", '" & Request("peakTermTo")(i) & "' "
					sql = sql & ")"
				Else
					sql = ""
					sql = sql & "UPDATE " & dbTable & " SET "
					sql = sql & "SP_FROM = '" & Request("peakTermFrom")(i) & "' "
					sql = sql & ", SP_TO = '" & Request("peakTermTo")(i) & "' "
					sql = sql & "WHERE 1 = 1 "
					sql = sql & "AND SP_TYPE = '" & i & "' "
					sql = sql & "AND SP_YEAR = '" & peakYear & "' "
				End If
				'Response.Write "sql: " & sql & "<BR>"
				Call AdoConnExecute(sql)
			Next

			If dbconn.Errors.count > 0 Then
				dbconn.RollbackTrans()

				'Set objError = Server.CreateObject("ADODB.Error")
				'For Each objError In dbconn.Errors
					'Response.Write (objerror.Description)  '에러문 출력
				'Next
				'objError.close
				'Set objError=Nothing
				Response.Write "N"
				Response.End
			Else
				dbconn.CommitTrans()
				Response.Write "Y"
			End If

			rs.Close
			Set rs = Nothing
		Case "DELETE"
			sql = ""
			sql = sql & "UPDATE " & dbTable & " SET "
			sql = sql & "SP_FROM = '' "
			sql = sql & ", SP_TO = '' "
			sql = sql & "WHERE 1 = 1 "
			sql = sql & "AND SP_SEQ = " & spSeq & " "
			'Response.Write "sql: " & sql & "<BR>"
			Call AdoConnExecute(sql)
			If dbconn.Errors.count > 0 Then
				dbconn.RollbackTrans()

				'Set objError = Server.CreateObject("ADODB.Error")
				'For Each objError In dbconn.Errors
					'Response.Write (objerror.Description)  '에러문 출력
				'Next
				'objError.close
				'Set objError=Nothing
				Response.Write "N"
				Response.End
			Else
				dbconn.CommitTrans()
				Response.Write "Y"
			End If
		Case Else
			Response.Write "NO_DIR"
			Response.End
	End Select

	DbClose()
%>