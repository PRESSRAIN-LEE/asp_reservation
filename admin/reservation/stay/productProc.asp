<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	DbOpen()

	Const dbTable = "TBL_STAY_PRODUCT"

	Dim strMode : strMode = SQLInject(Request("strMode"))
	Dim pSeq : pSeq = SQLInject(Request("pSeq"))

	Dim pName : pName = SQLInject(Request("pName"))
	Dim pPrice1 : pPrice1 = SQLInject(Request("pPrice1"))
	Dim pPrice2 : pPrice2 = SQLInject(Request("pPrice2"))
	Dim pPrice3 : pPrice3 = SQLInject(Request("pPrice3"))
	Dim pPrice4 : pPrice4 = SQLInject(Request("pPrice4"))
	Dim pPrice5 : pPrice5 = SQLInject(Request("pPrice5"))
	Dim pPrice6 : pPrice6 = SQLInject(Request("pPrice6"))
	Dim pPointUnit : pPointUnit = SQLInject(Request("pPointUnit"))
	Dim pPoint : pPoint = SQLInject(Request("pPoint"))
	Dim pService : pService = SQLInject(Request("pService"))
	Dim pState : pState = SQLInject(Request("pState"))
	Dim pImg1 : pImg1 = SQLInject(Request("pImg1"))
	Dim pImg2 : pImg2 = SQLInject(Request("pImg2"))
	Dim pMemo : pMemo = SQLInject(Request("pMemo"))

	Dim sql

	dbconn.Errors.clear

	dbconn.BeginTrans()

	Select Case strMode
		Case "NEW"
			sql = ""
			sql = sql & "INSERT INTO " & dbTable & " ( SP_NAME, SP_PRICE_1, SP_PRICE_2, SP_PRICE_3, SP_PRICE_4, SP_PRICE_5, SP_PRICE_6, SP_POINT, SP_POINT_UNIT, SP_USE, SP_STATE, SP_IMG_1, SP_IMG_2, SP_MEMO "
			sql = sql & ") VALUES ( "
			sql = sql & " '" & pName & "' "
			sql = sql & ", '" & pPrice1 & "', '" & pPrice2 & "', '" & pPrice3 & "', '" & pPrice4 & "', '" & pPrice5 & "', '" & pPrice6 & "' "
			sql = sql & ", '" & pPoint & "', '" & pPointUnit & "' "
			sql = sql & ", '" & pService & "', '" & pState & "', '" & pImg1 & "', '" & pImg2 & "', '" & pMemo & "' "
			sql = sql & ")"
			Call AdoConnExecute(sql)

			'sql = ""
			'sql = sql & "INSERT INTO " & dbTable & " ( SP_NAME, SP_PRICE_1, SP_PRICE_2, SP_PRICE_3, SP_PRICE_4, SP_PRICE_5, SP_PRICE_6, SP_POINT, SP_POINT_UNIT, SP_USE, SP_STATE, SP_IMG_1, SP_IMG_2, SP_MEMO "
			'sql = sql & ") VALUES ( "
			'sql = sql & " '? "
			'sql = sql & ", ?, ?, ?, ?, ?, ? "
			'sql = sql & ", ?, ? "
			'sql = sql & ", ?, ?, ?, ?, ? "
			'sql = sql & ")"
			'set objCommand = Server.CreateObject("ADODB.Command") 
			'objCommand.ActiveConnection = dbconn
			'objCommand.CommandType = 1
			'objCommand.CommandText = sql 
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_NAME", adVarChar, adParamInput, 50, SQLInject(pName))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_1", adInteger, adParamInput, , SQLInject(pPrice1))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_2", adInteger, adParamInput, , SQLInject(pPrice2))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_3", adInteger, adParamInput, , SQLInject(pPrice3))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_4", adInteger, adParamInput, , SQLInject(pPrice4))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_5", adInteger, adParamInput, , SQLInject(pPrice5))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_PRICE_6", adInteger, adParamInput, , SQLInject(pPrice6))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_POINT", adDecimal, adParamInput, , SQLInject(pPoint))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_POINT_UNIT", adVarChar, adParamInput, 1, SQLInject(pPointUnit))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_USE", adVarChar, adParamInput, 1, SQLInject(pService))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_STATE", adVarChar, adParamInput, 1, SQLInject(pState))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_IMG_1", adVarChar, adParamInput, 50, SQLInject(pImg1))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_IMG_2", adVarChar, adParamInput, 50, SQLInject(pImg2))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_MEMO", adVarChar, adParamInput, 8000, SQLInject(pMemo))
			'objCommand.Parameters.Append objCommand.CreateParameter("SP_SEQ", adInteger, adParamInput, 20, b)
			'objCommand.Execute(,,adCmdTableDirect)

			If dbconn.Errors.count > 0 Then
				dbconn.RollbackTrans()

				Response.Write "N"
				Response.End
			Else
				dbconn.CommitTrans()
				Response.Write "Y"
			End If
		Case "EDIT"
			sql = ""
			sql = sql & "UPDATE " & dbTable & " SET "
			sql = sql & "SP_NAME = '" & pName & "' "
			sql = sql & ", SP_PRICE_1 = '" & pPrice1 & "' "
			sql = sql & ", SP_PRICE_2 = '" & pPrice2 & "' "
			sql = sql & ", SP_PRICE_3 = '" & pPrice3 & "' "
			sql = sql & ", SP_PRICE_4 = '" & pPrice4 & "' "
			sql = sql & ", SP_PRICE_5 = '" & pPrice5 & "' "
			sql = sql & ", SP_PRICE_6 = '" & pPrice6 & "' "
			sql = sql & ", SP_POINT = '" & pPoint & "' "
			sql = sql & ", SP_POINT_UNIT = '" & pPointUnit & "' "
			sql = sql & ", SP_USE = '" & pService & "' "
			sql = sql & ", SP_STATE = '" & pState & "' "
			sql = sql & ", SP_IMG_1 = '" & pImg1 & "' "
			sql = sql & ", SP_IMG_2 = '" & pImg1 & "' "
			sql = sql & ", SP_MEMO = '" & pMemo & "' "
			sql = sql & "WHERE 1 = 1 "
			sql = sql & "AND SP_SEQ = " & pSeq & " "
			Call AdoConnExecute(sql)
			If dbconn.Errors.count > 0 Then
				dbconn.RollbackTrans()

				Response.Write "N"
				Response.End
			Else
				dbconn.CommitTrans()
				Response.Write "Y"
			End If
		Case "DEL"
			sql = ""
			sql = sql & "UPDATE " & dbTable & " SET "
			sql = sql & " SP_STATE = '" & pState & "' "
			sql = sql & "WHERE 1 = 1 "
			sql = sql & "AND SP_SEQ = " & pSeq & " "
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
	End Select

	DbClose()
%>