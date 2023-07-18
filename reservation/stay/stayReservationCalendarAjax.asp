<!-- #include virtual="/common/_inc/incGlobal.asp" -->
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

	sql = ""
	sql = sql & "SELECT B.RD_RESERVE_DATE, C.R_STATE, CONVERT(INT, RIGHT(B.RD_RESERVE_DATE, 2)) AS RD_RESERVE_DATE_1  "
	sql = sql & "FROM TBL_STAY_PRODUCT A "
	sql = sql & "INNER JOIN TBL_RESERVATION_DATE B ON A.SP_SEQ = B.SP_SEQ "
	sql = sql & "INNER JOIN TBL_RESERVATION C ON B.R_SEQ = C.R_SEQ "
	sql = sql & "WHERE 1 = 1 "
	sql = sql & "AND B.SP_SEQ = '" & spSeq & "' "
	Dim rsArray : rsArray = getAdoRsArray(sql)
%>

<style>
	.d_8 {font-family: tahoma;font-size: 6px;color: #FF6C21;}
	.d_9 {font-family: tahoma;font-size: 10px;color: #FF6C21;}

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
						'Response.Write vbTab & vbTab & "<td class='A " & divClass & "' id='d_" & iCurrent & "'>"
						'Response.Write "<time><span class='Ym'>[" & Year(dDate) & "." & fnTwoDigit(Month(dDate)) & "]</span>" & iCurrent & "<span class='W'>(" & weekName & ")</span></time>"

						'Response.Write vbTab & vbTab & "<td class='" & divClass & "'>"
						'Response.Write "<time><span class='Ym'>[" & Year(dDate) & "." & fnTwoDigit(Month(dDate)) & "]</span>" & iCurrent & "<span class='W'>(" & weekName & ")</span></time>"

						Dim reserveResult : reserveResult = "N"
						If IsArray(rsArray) Then
							For k = LBound(rsArray, 2) To UBound(rsArray, 2)
								If rsArray(0, k) = Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) Then
									'Response.Write "(완)"
									reserveResult = "Y"
									reserveState = rsArray(1, k)
									Select Case rsArray(1, k)
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
						Else
							reserveState = ""
						End If

						If reserveResult = "Y" Then
							'Response.Write rsArray(1, j) & "(" & reserveResultName & ")"
							'Response.Write "A"
							Response.Write "<span onClick=""javascript:goReserve2('" & spSeq & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "', 'Y');"" style='cursor:pointer;'>" & iCurrent & "</span>"
						Else
							'Response.Write "B"
							Response.Write "<span onClick=""javascript:goReserve2('" & spSeq & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "', 'N');"" style='cursor:pointer;'>" & iCurrent & "</span>"
							'Response.Write "<a href=""javascript:goReserve('" & rsArray(0, j) & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "');"">" & rsArray(1, j) & "</a>"
						End If
						'Response.Write "<BR>" & iCurrent
						'Response.Write "<span onClick=""javascript:goReserve2('" & spSeq & "', '" & Year(dDate) & "-" & fnTwoDigit(Month(dDate)) & "-" & fnTwoDigit(iCurrent) & "', '" & reserveState & "');"" style='cursor:pointer;'>" & iCurrent & "</span>"

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
	$(document).ready(function() {
		var className = ""
		//$(".A").addClass("d_9");
		<%
		If IsArray(rsArray) Then
			For k = LBound(rsArray, 2) To UBound(rsArray, 2)
				Select Case rsArray(1, k)
					Case "1"
						dateBg = "#996633"		'//예약 완료
					Case "2"
						dateBg = "#66ccff"			'//예약 대기
					Case Else
						dateBg = "#ffffff"
				End Select

		%>
				$("#d_<%=rsArray(0, k)%>").css("background-color", "<%=dateBg%>");
				//alert("d_<%=rsArray(2, k)%>");
				//$("#d_<%=rsArray(2, k)%>").addClass("d_8");
				
				<%If rsArray(0, k) <= date() Then%>
				//$("#d_<%=rsArray(2, k)%>").addClass("d_8");
				<%Else%>
				//$("#d_<%=rsArray(2, k)%>").addClass("d_9");
				<%End If%>

				console.log(<%=rsArray(2, k)%>);
				//$("td").addClass("d_<%=rsArray(2, k)%>");

				className = $('#d_<%=rsArray(2, k)%>').attr('class');
				//alert(className);

				//$("#d_<%=rsArray(0, k)%>").removeAttr("onclick");
				//$("#d_<%=rsArray(0, k)%>").attr("onclick", "").unbind('click');
				//$("#d_<%=rsArray(0, k)%>").attr("onclick", "goReserve1('', '')");
				//$("a").attr("href", "http://www.google.com/")
		<%
			Next
		Else
		%>
				
				//$(".A").addClass("d_9");
				
		<%
		End If
		%>
//alert(className);
//$("#d_8").addClass("d_8");
//var className = $('#d_8').attr('class');
  //  alert(className);

		for (i = 1; i < <%=iCurrent%>; i++){
			//console.log(i + "::" + $("#d_" + i).text())
			//if(i == $("#d_" + i).text()){
			if($("#d_" + i).text() == $(".A").eq(i-1).text()){
				//console.log("A: " + i);
				//console.log($(".d_" + i).text())
				//$("#d_"+i).css("background-color", "#dddddd");
				//break;
			
			}else{
				//console.log("AA");
			//	$("#d_<%'=rsArray(2, k)%>").css("background-color", "<%=dateBg%>");
			}
		}
	});


	//날짜 선택 후 인원 선택하러 가기
	function goReserve2(pa1, pa2, pa3){
		if(pa3 == "Y"){
			alert("이미 예약되었습니다.");
		}else{
			if(pa2 <= "<%=date()%>"){
				alert("예약 불가");
				return;
			}else{
				//location.href='reservationInput.asp?spSeq=' + pa1 + '&reserveDate=' + pa2;
				var moveUrl = "stayReservationTermAjax.asp?spSeq=" + pa1 + "&reserveDate=" + pa2;
				$.ajax( {
					url:moveUrl,
					success:function(data) {
						$('#term').html(data);
						$('#member').html("");
					}
				});
			}
			goMemberSelect();
		}
	}

	//stayReservationCalendarAjax.asp
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