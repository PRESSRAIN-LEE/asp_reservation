<!-- #include virtual="/common/_inc/incGlobal.asp" -->
 <%
	DbOpen()

'	Option Explicit 
	'On Error Resume Next

'	Dim su1, su2, hap, div
'	su1 = 100 : su2 = 0 : hap = su1 + su2 : div = su1 / su2
'
'	Response.Write "두 수의 더하기" &  hap & "<BR>"
'	Response.Write "두 수의 나누기" & div & "<BR>"
'
'	Response.Write "" & Err.Column   & "<BR>"
'
'	If Err.Number > 0 Then
'		Response.Write "에러 발생"
'	Else
'		Response.Write "에러 없음"
'	End If
%>
​
<%
	Set lastErr = Server.GetLastError 

	Response.write "Date :" & Date() &"<br>"
	Response.Write("Description = " & lastErr.Description) 
	Response.Write("<br>File = " & lastErr.File)
	Response.Write("<br>source = " & lastErr.source)
	Response.Write("<br>Line = " & lastErr.Line)
	Response.Write("<br>Column = " & lastErr.Column)
	Response.Write("<br>Number = " & lastErr.Number)
	Response.Write("<br>Code = " & lastErr.aspCode)
	Response.Write("<br>Category = " & lastErr.Category)&"<br>"
	response.write "REMOTE_ADDR : " & request.ServerVariables("REMOTE_ADDR") &"<br>"
	response.write "HTTP_USER_AGENT : " & request.ServerVariables("HTTP_USER_AGENT") &"<br>"
	response.write "HTTP_REFERER : " & request.ServerVariables("HTTP_REFERER") &"<br>"
	response.write "URL : " & request.ServerVariables("URL") & "<br>" 
	response.write "SCRIPT_NAME : " & request.ServerVariables("SCRIPT_NAME") &"<br>"
	response.write "HTTP_HOST : "& request.ServerVariables("HTTP_HOST") & "<br>"
	'response.write "all_raw : " & request.ServerVariables("all_raw") &"<br>"

	Dim sql : sql = ""
	'sql = sql & "INSERT INTO TBL_ERROR_LOG (E_CATEGORY, E_FILE, E_LINE, E_COLUMN, E_MSG, E_SOURCE, E_REFERER, E_URL, E_IP "
	'sql = sql & ") VALUES ( "
	'sql = sql & " '" & lastErr.Category & "' "
	'sql = sql & ", '" & lastErr.File & "' "
	'sql = sql & ", '" & lastErr.Line & "' "
	'sql = sql & ", '" & lastErr.Column & "' "
	'sql = sql & ", '" & ConvertText(lastErr.Description) & "' "
	'sql = sql & ", '" & lastErr.source & "' "
	'sql = sql & ", '" & request.ServerVariables("HTTP_REFERER") & "' "
	'sql = sql & ", '" & request.ServerVariables("URL") & "' "
	'sql = sql & ", '" & request.ServerVariables("REMOTE_ADDR") & "' "
	'sql = sql & ")"
	'Response.Write "SQL: " & SQL
	'AdoConnExecute(sql)

	'///////////////////////////////////////////////////////
	sql = sql & "INSERT INTO TBL_ERROR_LOG (E_CATEGORY, E_FILE, E_LINE, E_COLUMN, E_MSG, E_SOURCE, E_REFERER, E_URL, E_IP "
	sql = sql & ") VALUES ( "
	sql = sql & " ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ", ? "
	sql = sql & ")"

	set objCommand = Server.CreateObject("ADODB.Command") 
	objCommand.ActiveConnection = dbconn
	'objCommand.CommandType = 1
	objCommand.CommandText = sql 
	objCommand.Parameters.Append objCommand.CreateParameter("E_CATEGORY", adVarChar, adParamInput, 500, SQLInject(lastErr.Category))
	objCommand.Parameters.Append objCommand.CreateParameter("E_FILE", adVarChar, adParamInput, 50, SQLInject(lastErr.File))
	objCommand.Parameters.Append objCommand.CreateParameter("E_LINE", adVarChar, adParamInput, 10, SQLInject(lastErr.Line))
	objCommand.Parameters.Append objCommand.CreateParameter("E_COLUMN", adVarChar, adParamInput, 10, SQLInject(lastErr.Column))
	objCommand.Parameters.Append objCommand.CreateParameter("E_MSG", adVarChar, adParamInput, 500, SQLInject(lastErr.Description))
	objCommand.Parameters.Append objCommand.CreateParameter("E_SOURCE", adVarChar, adParamInput, 500, SQLInject(lastErr.source))
	objCommand.Parameters.Append objCommand.CreateParameter("E_REFERER", adVarChar, adParamInput, 500, SQLInject(request.ServerVariables("HTTP_REFERER")))
	objCommand.Parameters.Append objCommand.CreateParameter("E_URL", adVarChar, adParamInput, 50, SQLInject(request.ServerVariables("URL")))
	objCommand.Parameters.Append objCommand.CreateParameter("E_IP", adVarChar, adParamInput, 20, SQLInject(request.ServerVariables("REMOTE_ADDR")))
	'objCommand.Parameters.Append objCommand.CreateParameter("SP_SEQ", adInteger, adParamInput, 20, b)
	objCommand.Execute()
%>

<%
'Dim objErrorInfo
'Set objErrorInfo = Server.GetLastError

'Response.Write("ASPCode = " & objErrorInfo.ASPCode) &"<br>"
'Response.Write("ASPDescription = " & objErrorInfo.ASPDescription) &"<br>"
'Response.Write("Category = " & objErrorInfo.Category) &"<br>"
'Response.Write("Column = " & objErrorInfo.Column) &"<br>"
'Response.Write("Description = " & objErrorInfo.Description) &"<br>"
'Response.Write("File = " & objErrorInfo.File) &"<br>"
'Response.Write("Line = " & objErrorInfo.Line) &"<br>"
'Response.Write("Number = " & objErrorInfo.Number) &"<br>"
'Response.Write("Source = " & objErrorInfo.Source) &"<br>"
%>