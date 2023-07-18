<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	'On Error Resume Next

	DbOpen()

	Dim dbTable : dbTable = "TBL_ERROR_LOG"
	Dim strMode : strMode = Request("strMode")
	Dim strProcessType : strProcessType = Request("strProcessType")
	Dim eSeq : eSeq = Request("eSeq")
	Dim eProcessingName : eProcessingName = Request("eProcessingName")
	Dim sql
	
	'Dim DbErrCnt : DbErrCnt = 0

	dbconn.Errors.clear

	dbconn.BeginTrans()

	Select Case strMode
		Case "PROCESS"
			sql = ""
			sql = sql & "UPDATE " & dbTable & " SET "
			sql = sql & "E_PROCESSING = '" & strProcessType & "' "
			sql = sql & ", E_PROCESSING_NAME = N'" & eProcessingName & "' "
			sql = sql & ", E_PROCESSING_DATE = getdate() "
			sql = sql & "WHERE E_SEQ = " & eSeq & " "
			Call AdoConnExecute(sql)
			'DbErrCnt = DbErrCnt + dbconn.errors.count
			 If dbconn.Errors.count > 0 Then
				' 오류 발생시 Rollback 처리
				dbconn.RollbackTrans()

				'Set objError = Server.CreateObject("ADODB.Error")
				'For Each objError In dbconn.Errors
					'Response.Write (objerror.Description)  '에러문 출력
				'Next
				'objError.close
				'Set objError=Nothing

				Response.Write "N"
			Else
				' 오류가 없는 경우 commit 처리
				dbconn.CommitTrans()
				Response.Write "Y"
			End If
		'Case "DELETE"
		'	sql = ""
		'	sql = sql & "UPDATE " & dbTable & " SET "
		'	sql = sql & "E_PROCESSING = 'D' "
		'	sql = sql & ", E_PROCESSING_NAMEz = N'" & eProcessingName & "' "
		'	sql = sql & ", E_PROCESSING_DATE = getdate() "
		'	sql = sql & "WHERE E_SEQ = " & eSeq & " "
		'	Call AdoConnExecute(sql)
		'	'DbErrCnt = DbErrCnt + dbconn.errors.count
		'	 If dbconn.Errors.count > 0 Then
		'		' 오류 발생시 Rollback 처리
		'		dbconn.RollbackTrans()

		'		'Set objError = Server.CreateObject("ADODB.Error")
		'		'For Each objError In dbconn.Errors
		'			'Response.Write (objerror.Description)  '에러문 출력
		'		'Next
		'		'objError.close
		'		'Set objError=Nothing

		'		Response.Write "N"
		'	Else
		'		' 오류가 없는 경우 commit 처리
		'		dbconn.CommitTrans()
		'		Response.Write "Y"
		'	End If
		Case Else
			Response.Write "NO_DIR"
			Response.End
	End Select

	DbClose()

	' 에러처리 중단
   'On Error Goto 0
%>