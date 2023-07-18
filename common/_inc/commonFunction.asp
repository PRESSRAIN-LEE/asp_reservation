<!-- METADATA TYPE="typeLib"  NAME="ADODB Type Library" UUID="00000205-0000-0010-8000-00AA006D2EA4" -->
<Object RUNAT="Server" PROGID="ADODB.Connection" ID="DbConn"></Object>
<%
	'// 디비열기
	Function DbOpen()
		'dim cstConnString	'//디비커넥션변수

		If DbConn.State = adStateClosed Then
			DbConn.open cstConnString
		End If
	End Function

	'// 디비닫기
	Function DbClose()
		If DbConn.State = adStateOpen Then
			DbConn.Close()
		End If
	End Function

	'// 문자열 출력
	Sub Print(ByVal strText)
		Response.Write strText & "<br>"
	End Sub

	'// 쿼리 실행
	Sub AdoConnExecute(ByVal strQuery)
		'Print strQuery
		DbConn.Execute strQuery, , adCmdText + adExecuteNoRecords
	End Sub


	'// 쿼리 실행후 레코드셋 배열로 반환 없음 Null 반환
	Function getAdoRsArray(ByVal strQuery)
		Dim objAdoRs, arrSelectData
		'Print strQuery
		Set objAdoRs = DbConn.Execute(strQuery)'Server.CreateObject("ADODB.RecordSet")
		'objAdoRs.Open strQuery, DbConn, adOpenForwardOnly, adLockReadOnly, adCmdText
		If Not (objAdoRs.EOF And objAdoRs.BOF) Then
			arrSelectData = objAdoRs.GetRows()
		Else
			arrSelectData = Null
		End If
		'objAdoRs.Close
		Set objAdoRs = Nothing

		getAdoRsArray = arrSelectData
	End Function

	'// 쿼리 실행후 스칼라값 반환 없음 Null 반환
	Function getAdoRsScalar(ByVal strQuery)
		Dim objAdoRs, strValue
		'Print strQuery
		Set objAdoRs = DbConn.Execute(strQuery)'Server.CreateObject("ADODB.RecordSet")

		'objAdoRs.Open strQuery, DbConn, adOpenForwardOnly, adLockReadOnly, adCmdText
		If Not (objAdoRs.EOF And objAdoRs.BOF) Then
			strValue = objAdoRs(0)
		Else
			strValue = Null
		End If
		'objAdoRs.Close
		Set objAdoRs = Nothing

		getAdoRsScalar = strValue
	End Function


	'/////////////페이징 관련/////////////////////////
	'## 조건에 만족하는 카운트 반환
	Sub intTotal()
		If Len(intNowPage) = 0 Then
			intNowPage = 1
    	End If

		Dim strSQL, objRs
		strSQL = "SELECT COUNT(*) "
		strSQL = strSQL & ", CEILING(CAST(COUNT(*) AS FLOAT) / " & intPageSize & ") "
		strSQL = strSQL & " FROM " & dbTable
	 	If len(queryWhere) > 0 Then
			strSQL = strSQL & " WHERE 1 = 1 " & queryWhere
		End If
		Set objRs = DbConn.Execute(strSQL)'Server.CreateObject("ADODB.RecordSet")

		intTotalCount = objRs(0)
		intTotalPage = objRs(1)

		objRs.close
		Set objRs = Nothing
	End Sub

	'## 페이징에서 조건에 맞는 최대 행의수 리턴
	Function TopCount
		TopCount = "TOP " & intNowPage * intPageSize
	End Function

	'## 설정된 변수값을 토대로 한 현재페이지 레코드 값 반환
	Function MoveCount
		MoveCount = (intNowPage - 1) * intPageSize
	End Function

	'## 전체글 과 현재 페이지 보기
	Function NavCount
		NavCount = "전체 "&intTotalCount&"개&nbsp;&nbsp;&nbsp;&nbsp;현재페이지 "&intNowPage&"/"&intTotalPage&""
	End Function

	'//페이징 - 사용자용
	Sub userPaging(byval plusString)
		Dim intTemp, intLoop
		intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

		Response.Write "<ul class='pagination justify-content-center'>"
		If intTemp = 1 Then
			Response.Write "<li class='page-item'><a class='page-link lh-sm' href='javascript:;' aria-label='Previous'><span aria-hidden='true'>«</span><span class='sr-only'>Previous</span></a></li>"		'//이전
			'Response.Write "<a href='javascript:;' class='first_btn'>Prev</a>"		'//이전
		Else
			Response.Write "<li class='page-item'><a class='page-link lh-sm' href=""?"&GetString("page=" & intTemp - intBlockPage)&""" aria-label='Previous'><span aria-hidden='true'>«</span><span class='sr-only'>Previous</span></a></li>"		'//이전
			'Response.Write "<a href=""?"&GetString("page=" & intTemp - intBlockPage)&""" class='first_btn'>Prev</a>"		'//이전
		End If
		intLoop = 1
		Do Until intLoop > intBlockPage Or intTemp > intTotalPage
			If intTemp = CInt(intNowPage) Then
				'Response.Write "	<li class='active'><a href='javascript:;'>" & intTemp & "</a></li>"
				Response.Write "<li class='page-item active'><a class='page-link lh-sm' href='javascript:;'>" & intTemp & "</a></li>"
			Else
				'Response.Write "	<li><a href=""?"&GetString("page=" & intTemp & plusString)&""">" & intTemp & "</a></li>"
				Response.Write "<li class='page-item'><a class='page-link lh-sm' href=""?"&GetString("page=" & intTemp & plusString)&""">" & intTemp & "</a></li>"
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop

		Dim lastPage: lastPage = 0

		If intTotalPage >= lastPage Then lastPage = 1 Else lastPage = intTotalPage End If

		If intTemp > intTotalPage Then
			'Response.Write "<a href='javascript:;' class='last_btn'>Next</a>"		'//다음
			Response.Write "<li class='page-item'><a class='page-link lh-sm' href='javascript:;' aria-label='Next'><span aria-hidden='true'>»</span><span class='sr-only'>Next</span></a></li>"		'//다음
		Else
			'Response.Write "<a href=""?"&GetString("page=" & intTemp)&""" class='last_btn'>Next</a>"		'//다음
			Response.Write "<li class='page-item'><a class='page-link lh-sm' href=""?"&GetString("page=" & intTemp)&""" aria-label='Next'><span aria-hidden='true'>»</span><span class='sr-only'>Next</span></a></li>"		'//다음
		End If
		Response.Write "</ul>"
	End Sub

	'////////////////////////////////////////////////////
	Sub userPaging_old_version(byval plusString)
		Dim intTemp, intLoop
		intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

		If intTemp = 1 Then
			Response.Write "<a href='javascript:;' class='first_btn'>Prev</a>"		'//이전
		Else
			Response.Write "<a href=""?"&GetString("page=" & intTemp - intBlockPage)&""" class='first_btn'>Prev</a>"		'//이전
		End If
		Response.Write "<ul>"
		intLoop = 1
		Do Until intLoop > intBlockPage Or intTemp > intTotalPage
			If intTemp = CInt(intNowPage) Then
				Response.Write "	<li class='active'><a href='javascript:;'>" & intTemp & "</a></li>"
			Else
				Response.Write "	<li><a href=""?"&GetString("page=" & intTemp & plusString)&""">" & intTemp & "</a></li>"
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop
		Response.Write "</ul>"

		Dim lastPage: lastPage = 0

		If intTotalPage >= lastPage Then lastPage = 1 Else lastPage = intTotalPage End If

		If intTemp > intTotalPage Then
			Response.Write "<a href='javascript:;' class='last_btn'>Next</a>"		'//다음
		Else
			Response.Write "<a href=""?"&GetString("page=" & intTemp)&""" class='last_btn'>Next</a>"		'//다음
		End If
	End Sub

	'//페이징 - 관리자용
	Sub adminPaging(byval plusString)
		Dim intTemp, intLoop
		intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1

		Response.Write "<ul class='pagination justify-content-end'>"
		If intTemp = 1 Then
			Response.Write "	<li class='page-item'><a class='page-link' href='javascript:;' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>"	'//이전
		Else
			Response.Write "	<li class='page-item'><a class='page-link' href=""?"&GetString("page=" & intTemp - intBlockPage)&""" aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>"	'//이전
		End If
		'Response.Write "<a href=""?"&GetString("page=1")&""" class=""imgPage""  style=""margin-right:0;""><img src=""/avanplus/_master/img/imgFirst.png"" alt=""처음""></a>"
		'Response.Write "<a href=""?"&GetString("page=" & intTemp)&""" class=""imgPage"" style=""margin-right:8px; margin-left:0;""><img src=""/avanplus/_master/img/imgPrev.png"" alt=""이전"" ></a>"

		intLoop = 1
		Do Until intLoop > intBlockPage Or intTemp > intTotalPage
			If intTemp = CInt(intNowPage) Then
				'Response.Write "<a href=""#"" class=""active"">" & intTemp &"</a>"
				Response.Write "	<li class='page-item active'><a class='page-link' href='javascript:;'>" & intTemp & "</a></li>"
			Else
				'Response.Write"<a href=""?"&GetString("page=" & intTemp & plusString)&""">"& intTemp & "</a>"
				Response.Write "	<li class='page-item'><a class='page-link' href=""?"&GetString("page=" & intTemp & plusString)&""">" & intTemp & "</a></li>"
			End If
			intTemp = intTemp + 1
			intLoop = intLoop + 1
		Loop

		Dim lastPage: lastPage = 0

		If intTotalPage >= lastPage Then lastPage = 1 Else lastPage = intTotalPage End If

		If intTemp > intTotalPage Then
			Response.Write "	<li class='page-item'><a class='page-link' href='javascript:;' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"	'//다음
		Else
			Response.Write "	<li class='page-item'><a class='page-link' href=""?"&GetString("page=" & intTemp)&""" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>"	'//다음
		End If

		'Response.Write "<a href=""?"&GetString("page=" & intTemp - 1)&""" class=""imgPage""  style=""margin-left:8px; margin-right:0;""><img src=""/avanplus/_master/img/imgNext.png"" alt=""다음"" ></a>"
		'Response.Write "<a href=""?"&GetString("page=" & lastPage)&""" class=""imgPage""  style=""margin-left:0px""><img src=""/avanplus/_master/img/imgLast.png"" alt=""끝""></a>"
		Response.Write "</ul>"
	End Sub


	'*********** 스트링관련 ************
	'##	현재페이지의 스트링값을 받는 함수
	Function GetString(ByVal addString)
      	Dim UrlString, split_UrlString, i_UrlString, chkword_UrlString
		Dim split_addString, i_addString, chkword_addString
		Dim stringEquleChk
		If InStr(request.serverVariables("QUERY_STRING"), "#") > 1 Then
			UrlString = Split(request.serverVariables("QUERY_STRING"), "#")(0)
		Else
			UrlString = request.serverVariables("QUERY_STRING")
		End If

		If Trim(UrlString)="" or isnull(Trim(UrlString)) Then
			GetString = addString
		ElseIf Not isnull(Trim(urlString)) And isnull(Trim(addString)) Then
			GetString = urlString
		Else
			split_UrlString = Split(UrlString,"&")
			split_addString = Split(addString,"&")

			For i_UrlString = 0 To Ubound(split_UrlString)
				If split_UrlString(i_UrlString) <> "" then
					chkword_UrlString = Split(split_UrlString(i_UrlString),"=")(0)
					chkword_UrlString = LCase(chkword_UrlString)
					chkword_UrlString = Trim(chkword_UrlString)
					stringEquleChk = "n"
					For i_addString = 0 to Ubound(split_addString)
						chkword_addString = Split(split_addString(i_addString),"=")(0)
						chkword_addString = LCase(chkword_addString)
						chkword_addString = Trim(chkword_addString)
						If chkword_UrlString = chkword_addString Then
							stringEquleChk = "y"
						End If
					'response.Write Ubound(split_addString)
					'response.Write("["&chkword_UrlString&"/"&chkword_addString&"|"&stringEquleChk&"]")
					Next
					If stringEquleChk = "n" Then
						GetString = GetString & Trim(split_UrlString(i_UrlString)) & "&"
					End If
					'response.Write("///"&i_UrlString&""&i_addString&stringEquleChk)
				End If
			Next
			GetString = GetString & addString 
		End If

		'// 한번사용하고 소멸하는 Temp 스트링을 없애는 처리 추가
		'// 예를들어 tmep=1234&ttt=1233 인경우 ttt=1233 변환

		Dim TEMPI, TEMPI2, SPLIT_GETSTRING, TEMPWORD, GetString2
		SPLIT_GETSTRING = SPLIT(GetString,"&")
		For TEMPI = 0 To Ubound(SPLIT_GETSTRING)
			If SPLIT_GETSTRING(TEMPI) <> "" Then
				TEMPWORD = Split(SPLIT_GETSTRING(TEMPI),"=")(0)
				TEMPWORD = lcase(TEMPWORD)
				TEMPWORD = Trim(TEMPWORD)

				If TEMPWORD = "temp" Then
				Else
					GetString2 = GetString2 & Trim(SPLIT_GETSTRING(TEMPI)) & "&"
				End If
				GetString = GetString2
			end if
		Next
	End Function

	'//SQL Injection
	' Array, Replace를 이용한 방법
	Function SQLInject(strWords)
		Dim BadChars, newChars
		BadChars = Array ("--", ";", "/*", "*/", "@@", "@", "@variable", "@@variable",_
				  "char", "nchar", "varchar", "nvarchar",_
				  "alter", "begin", "cast", "create", "cursor",_
				  "declare", "delete", "drop", "end", "exec",_
				  "execute", "fetch", "insert", "kill", "open",_
				  "select", "sys", "sysobjects", "syscolumns", "union",_
				  "table", "update", "xp_")
		newChars = strWords

		For i = 0 To UBound(BadChars)
			newChars = Replace(newChars, BadChars(i), "")
		Next

		newChars = Replace(newChars, "'", "''")
		newChars = Replace(newChars, " ", "")
		newChars = Replace(newChars, "|", "''")
		newChars = Replace(newChars, "\""", "|")
		newChars = Replace(newChars, "|", "''")

		SQLInject = newChars
	End Function

	' 정규식 객체를 이용한 방법
	Function SQLInJect2(strWords)
		Dim BadChars, newChars, tmpChars, regEx, i
		BadChars = Array( _
			"select(.*)(from|with|by){1}", _
			"insert(.*)(into|values){1}", _
			"update(.*)set", _
			"delete(.*)(frm|with){1}", _
			"drop(.*)(from|aggre|role|assem|key|cert|cont|credential|data|endpoint|event|fulltext|function|index|login|type|schema|procedure|que|remote|role|route|sign|stat|syno|table|trigger|user|view|xml){1}", _
			"alert(.*)(application|assem|key|author|cert|credential|data|endpoint|fulltext|function|index|login|type|schema|procedure|que|remote|role|route|serv|table|user|view|xml){1}", _
			"xp_", "sp_", "restore\s", "grant\s", "revoke\s", "dbcc", "dump", "use\s", "set\s", "truncate\s", "backup\s", "load\s", "save\s", "shutdown", _
			"cast(.*)\(", "convert(.*)\(", "execute\s", "updatetext", "writetext", "reconfigure", "union", "@variable", "@@variable", _
			"/\*", "\*/", ";", "\-\-", "\[", "\]", "char(.*)\(", "nchar(.*)\("  )
		newChars = strWords

		For i = 0 To UBound(BadChars)
			Set regEx = New RegExp ' 정규식 객체의 인스턴스 생성
				regEx.Pattern = BadChars(i)
				regEx.IgnoreCase = True
				regEx.Global = True
				newChars = regEx.Replace(newChars,"")
			Set regEx = Nothing
		Next

		newChars = Replace(newChARS, "'", "''")

		SQLInject2 = newChars
	End Function
	'//SQL Injection

	'// 문자열 텍스트화
	Function ConvertText(ByVal strContent)
		strContent = Replace(strContent, "'", """")
		strContent = Replace(strContent, "&", "&amp;")
		strContent = Replace(strContent, "<", "&lt;")
		strContent = Replace(strContent, ">", "&gt;")
		strContent = Replace(strContent, Chr(34), "&quot;")
		strContent = Replace(strContent, Chr(13)&Chr(10), "<br>")
		strContent = Replace(strContent, "  ", "&nbsp;&nbsp;")
		ConvertText = strContent
	End Function

	'//값이 없을때 공백처리(3항연산)
	Function iif(i, j, k)
		If i Then iif = j Else iif = k
	End Function

	'//한자리 숫자를 두자리 숫자로 변환 (예: 1 -> 01)
	Function fnTwoDigit(ByVal arg)
		If Len(arg) = 1 Then
			arg = "0" & arg
		End If
		fnTwoDigit = arg
	End Function


	'//calendar관련
	Function GetDaysInMonth(iMonth, iYear)
		Dim dTemp
		dTemp = DateAdd("d", -1, DateSerial(iYear, iMonth + 1, 1))
		GetDaysInMonth = Day(dTemp)
	End Function

	Function GetWeekdayMonthStartsOn(dAnyDayInTheMonth)
		Dim dTemp
		dTemp = DateAdd("d", -(Day(dAnyDayInTheMonth) -1), dAnyDayInTheMonth)
		GetWeekdayMonthStartsOn = WeekDay(dTemp)
	End Function

	Function GetWeekdayMonthLastsOn(dAnyDayInTheMonth)
		Dim dTemp
		dTemp = DateAdd("d", -(Day(dAnyDayInTheMonth) +1), dAnyDayInTheMonth)
		GetWeekdayMonthLastsOn = WeekDay(dTemp)
	End Function

	Function SubtractOneMonth(dDate)
		SubtractOneMonth = DateAdd("m", -1, dDate)
	End Function

	Function AddOneMonth(dDate)
		AddOneMonth = DateAdd("m", 1, dDate)
	End Function
	'//calendar관련
%>