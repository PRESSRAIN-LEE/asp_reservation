<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<script src="/common/_js/jquery-1.11.3.min.js?v=<%=cssJsVersion%>"></script>
<%	
	DbOpen()

	Dim spSeq : spSeq  = Request("spSeq")

	Dim dDate		' Date we're displaying calendar for
	Dim iDIM			' Days In Month
	Dim iDOW		' Day Of Week that month starts on
	Dim iCurrent		' Variable we use to hold current day of month as we write table
	Dim iPosition	' Variable we use to hold current position in table
	Dim j

	Dim y : y = iif(Request("year") = "", year(now), Request("year"))
	Dim m : m = iif(Request("month") = "", month(now), Request("month"))
	'Response.Write y
	'Response.Write m

	'If IsDate(Request.QueryString("date")) Then
		'dDate = CDate(Request.QueryString("date"))
	'Else
		If Request.QueryString("month") <> "" And Request.QueryString("year") <> "" Then
			dDate = CDate(Request.QueryString("month") & "-" & day(now) & "-" & Request.QueryString("year"))
		Else
			dDate = Date()
			If Len(Request.QueryString("month")) <> 0 Or Len(Request.QueryString("day")) <> 0 Or Len(Request.QueryString("year")) <> 0 Or Len(Request.QueryString("date")) <> 0 Then
				Response.Write "The date you picked was not a valid date.  The calendar was set to today's date.<BR><BR>"
			End If
		End If
	'End If

	iDIM = GetDaysInMonth(Month(dDate), Year(dDate))
	iDOW = GetWeekdayMonthStartsOn(dDate)
	iDOW1 = GetWeekdayMonthLastsOn(dDate)

	'달,년도 이동
	Function linkChange(tValue,numValue)
		dim tempYY, tempMM
		tempYY = y
		tempMM = m
		select case lcase(tValue)
			case "yy" tempYY = tempYY + numValue
			case "mm" tempMM = tempMM + numValue
		end select
		tempYY = cint(tempYY)
		tempMM = cint(tempMM)
		if tempMM < 1 then
			tempYY = tempYY - 1
			tempMM = 12
		elseif tempMM > 12 then
			tempYY = tempYY + 1
			tempMM = 1		
		end if
		if tempYY < 0 then
			tempYY = 0
		elseif tempYY > 9999 then
			tempYY = 9999
		end if
		linkChange = "year="&tempYY&"&month="&tempMM
	End Function


	'Dim queryWhere : queryWhere = "AND SP_USE = 'Y' "

	'Sub stayList()
		sql = ""
		sql = sql & "SELECT A.SP_SEQ, A.SP_NAME "
		'sql = sql & ", B.R_FROM, B.R_TO "
		'sql = sql & ", (SELECT R_FROM FROM TBL_RESERVATION WHERE 1=1 AND SP_SEQ = A.SP_SEQ) AS R_FROM "
		'sql = sql & ", (SELECT R_TO FROM TBL_RESERVATION WHERE 1=1 AND SP_SEQ = A.SP_SEQ) AS R_TO "
		sql = sql & "FROM TBL_STAY_PRODUCT A "
		'sql = sql & " LEFT OUTER JOIN TBL_RESERVATION B ON A.SP_SEQ = B.SP_SEQ "' AND R_FROM = '2023-07-07' AND R_TO = '2023-07-08' "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & queryWhere
		sql = sql & "AND SP_SEQ = '" & spSeq & "' "
		sql = sql & "ORDER BY A.SP_NAME ASC "
		'print sql
		'Response.End

		'sql = ""
		'sql = sql & "SELECT B.RD_RESERVE_DATE, C.R_STATE "
		'sql = sql & "FROM TBL_STAY_PRODUCT A "
		'sql = sql & "INNER JOIN TBL_RESERVATION_DATE B ON A.SP_SEQ = B.SP_SEQ "
		'sql = sql & "INNER JOIN TBL_RESERVATION C ON B.R_SEQ = C.R_SEQ "
		'sql = sql & "WHERE 1 = 1 "
		'sql = sql & "AND B.SP_SEQ = '" & spSeq & "' "
		'print sql

		Dim rsArray : rsArray = getAdoRsArray(sql)
	'End Sub
%>

<style>
	.holy {font-family: tahoma;font-size: 16px;color: #FF6C21;}
	.blue {font-family: tahoma;font-size: 16px;color: #0000FF;}
	.black {font-family: tahoma;font-size: 16px;color: #000000;}

	/*.today{color:#FFF000; background:#fff8cf !important}*/
	.today{color:#dfd8c6;}
	.Sun {color:#FF6C21}
	.Sat {color:#0000FF}

	.complete {color:#FFFFFF; background:#fff8cf !important}
	.possible {color:#FFFFFF; background:#000000 !important}
	.standBy {color:#FFFFFF; background:#fff8cf !important}
</style>

<div class="col-lg-12">
	<div class="row">
		<p>
			<a href="javascript:goMoveDate('<%=linkChange("mm", -1)%>')">&lt;</a>
			<span class="Ym"><%=Year(dDate) & "." & fnTwoDigit(Month(dDate))%></span>
			<a href="javascript:goMoveDate('<%=linkChange("mm", 1)%>')">&gt;</a>
		</p>
	</div>
	
	<div class="row">
		<div class='col-lg-12'>
			<table class='table table-bordered table-responsive'>
				<tr class="info">
					<th class='holy'>일</td>
					<th class='black'>월</th>
					<th class='black'>화</th>
					<th class='black'>수</th>
					<th class='black'>목</th>
					<th class='black'>금</th>
					<th class='blue'>토</th>
				</tr>
				<%
					If iDOW <> 1 Then
						Response.Write vbTab & "<tr>" & vbCrLf
						iPosition = 1
						Do While iPosition < iDOW
							Response.Write vbTab & vbTab & "<td class='empty'>&nbsp;</td>" & vbCrLf
							iPosition = iPosition + 1
						Loop
					End If

					r = 1
					iCurrent = 1
					iPosition = iDOW
					Do While iCurrent <= iDIM
						If iPosition = 1 Then
							Response.Write vbTab & "<tr>" & vbCrLf
						End If

						'//If iCurrent = Day(dDate) Then		'//오늘
						If Year(dDate) & Month(dDate) & iCurrent = Year(now) & Month(now) & Day(now) Then		'//오늘
							divClass = "today"
						Else
							Select Case Weekday(Month(dDate) & "-" & iCurrent & "-" & Year(dDate))
								Case "1"		'// 일요일
									divClass = "Sun"
									weekName = "일"
								Case "7"		'// 토요일
									divClass = "Sat"
									weekName = "토"
								Case "2"
									divClass = ""
									weekName = "월"
								Case "3"
									divClass = ""
									weekName = "화"
								Case "4"
									divClass = ""
									weekName = "수"
								Case "5"
									divClass = ""
									weekName = "목"
								Case "6"
									divClass = ""
									weekName = "금"
							End Select
						End If

						Response.Write vbTab & vbTab & "<td class='" & divClass & "' id='d_" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "'>"
						'Response.Write "<time><span class='Ym'>[" & Year(dDate) & "." & fnTwoDigit(Month(dDate)) & "]</span>" & iCurrent & "<span class='W'>(" & weekName & ")</span></time>"

						'Response.Write vbTab & vbTab & "<td class='" & divClass & "'>"
						'Response.Write "<time><span class='Ym'>[" & Year(dDate) & "." & fnTwoDigit(Month(dDate)) & "]</span>" & iCurrent & "<span class='W'>(" & weekName & ")</span></time>"

						If IsArray(rsArray) Then
							For j = LBound(rsArray, 2) To UBound(rsArray, 2)
								sql = ""
								sql = sql & "SELECT B.RD_RESERVE_DATE, C.R_STATE "
								sql = sql & "FROM TBL_STAY_PRODUCT A "
								sql = sql & "INNER JOIN TBL_RESERVATION_DATE B ON A.SP_SEQ = B.SP_SEQ "
								sql = sql & "INNER JOIN TBL_RESERVATION C ON B.R_SEQ = C.R_SEQ "
								sql = sql & "WHERE 1 = 1 "
								sql = sql & "AND B.SP_SEQ = " & rsArray(0, j) & " "
								If iCurrent >= 7 And iCurrent <= 9 Then
									'PRINT SQL & "<br>"
								End If

								Dim arrTemp : arrTemp = getAdoRsArray(sql)
								Dim reserveResult : reserveResult = "N"
								If IsArray(arrTemp) Then
									For k = LBound(arrTemp, 2) To UBound(arrTemp, 2)
										If arrTemp(0, k) = Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) Then
											'Response.Write "(완)"
											reserveResult = "Y"
											Select Case arrTemp(1, k)
												Case "1"
													reserveResultName = "예약완료"
												Case "2"
													reserveResultName = "예약대기"
												Case Else
													reserveResultName = ""
											End Select
											Exit For
										End If
										'Response.Write "<a href='javascript:goReserve();'>" & rsArray(1, j) & "</a><BR>"
									Next
								End If

								If reserveResult = "Y" Then
									'Response.Write rsArray(1, j) & "(" & reserveResultName & ")"
								Else
									'Response.Write "<a href=""javascript:goReserve('" & rsArray(0, j) & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "');"">" & rsArray(1, j) & "</a>"
								End If
								'Response.Write "<BR>"
								Response.Write "<span onClick=""javascript:goReserve('" & spSeq & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "');"" style='cursor:pointer;'>" & iCurrent & "</span>"
							Next
						End If
						Response.Write "</td>" & vbCrLf
				
						If iDIM <= iCurrent Then
							For k = iPosition To 6
								Response.Write vbTab & vbTab & "<td class='empty'>&nbsp;"
								Response.Write "</td>" & vbCrLf
							Next
						End If

						If iPosition = 7 Then
							Response.Write vbTab & "</tr>" & vbCrLf
							iPosition = 0
						End If

						iCurrent = iCurrent + 1
						iPosition = iPosition + 1
					Loop
				%>
			</table>

			<caption>
				<span style='background-color:#996633; padding:10px;'></span>예약 완료
				<span style='background-color:#66ccff; padding:10px;'></span>예약 대기
			</caption>
		</div>
	</div>
</div>

<%
	'DbClose()
%>
<script type="text/javascript">
<!--
	$(document).on('ready', function() {
		<%
		If IsArray(arrTemp) Then
			For k = LBound(arrTemp, 2) To UBound(arrTemp, 2)
				Select Case arrTemp(1, k)
					Case "1"
						dateBg = "#996633"		'//예약 완료
					Case "2"
						dateBg = "#66ccff"			'//예약 대기
					Case Else
						dateBg = "#ffffff"
				End Select
		%>
				$("#d_<%=arrTemp(0, k)%>").css("background-color", "<%=dateBg%>");
				//$("#d_<%=arrTemp(0, k)%>").remove("onClick");
				//$("#d_<%=arrTemp(0, k)%>").attr("onClick", "goReserve('a', 's')");
				//$("a").attr("href", "http://www.google.com/")
		<%
			Next
		End If
		%>
	});

	//날짜 선택 후 인원 선택
	function goReserve(pa1, pa2){
		alert(pa1);
		alert(pa2);
		return;

		//location.href='reservationInput.asp?spSeq=' + pa1 + '&reserveDate=' + pa2;
		var moveUrl = "stayReservationCalendar.asp?spSeq=" + pa1 + "&reserveDate=" + pa2;
		$.ajax( {
			url:moveUrl,
			success:function(data) {
				$('#member').html(data);
			}
		} );
	}

	//stayReservationCalendar_1.asp
	function goMoveDate(pa){
		var moveUrl = "stayReservationCalendarAjax.asp?" + pa + "&spSeq=<%=spSeq%>";
		$.ajax( {
			url:moveUrl,
			success:function(data) {
				$('#calendar').html(data);
			}
		} );
	}
//-->
</script>