<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<!-- #include virtual="/admin/_common/_inc/topMenuGnb.asp" -->
<style type="text/css">
body {
    color: #000;
    overflow-x: hidden;
    height: 100%;
    background-color: #F9A825 !important;
    background-repeat: no-repeat;
}

.container {
  padding-top: 120px;
  padding-bottom: 120px;
}

input {
    padding: 10px 15px !important;
    border: 1px solid lightgrey !important;
    border-radius: 10px;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #2C3E50;
    font-size: 14px;
    letter-spacing: 1px;
    position: relative;
}

input:focus {
    -moz-box-shadow: none !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    border: 1px solid #512DA8;
    outline-width: 0;
}

::placeholder {
    color: #BDBDBD;
    opacity: 1;
}

:-ms-input-placeholder {
    color: #BDBDBD;
}

::-ms-input-placeholder {
    color: #BDBDBD;
}

button:focus {
    -moz-box-shadow: none !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    outline-width: 0;
}

.datepicker {
  background-color: #fff;
  border: none;
  border-radius: 0 !important;
}

.datepicker-dropdown {
  top: 0;
  left: 0;
}

.datepicker table tr td.today, span.focused {
  border-radius: 50% !important;
  background-image: linear-gradient(#FFF3E0, #FFE0B2);
}

.datepicker table tr td.today.range {
  background-image: linear-gradient(#eeeeee, #eeeeee) !important;
  border-radius: 0 !important;
}

/*Weekday title*/
thead tr:nth-child(3) th {
  font-weight: bold !important;
  padding-top: 10px;
  padding-bottom: 10px;
}

.dow, .old-day, .day, .new-day {
  width: 40px !important;
  height: 40px !important;
  border-radius: 0px !important;
}

.old-day:hover, .day:hover, .new-day:hover, .month:hover, .year:hover, .decade:hover, .century:hover {
  border-radius: 50% !important;
  background-color: #eee;
}
/*
.active {
  border-radius: 50% !important;
  background-image: linear-gradient(#90CAF9, #64B5F6) !important;
  color: #fff !important;
}*/

.range-start, .range-end {
  border-radius: 50% !important;
  background-image: linear-gradient(#FFA726, #FFA726) !important;
}

.prev, .next, .datepicker-switch {
  border-radius: 0 !important;
  padding: 10px 10px 10px 10px !important;
  text-transform: uppercase;
  font-size: 14px;
  opacity: 0.8;
}

.prev:hover, .next:hover, .datepicker-switch:hover {
  background-color: inherit !important;
  opacity: 1;
}

.btn-black {
  background-color: #37474F !important;
  color: #fff !important;
  width: 100%;
}

.btn-black:hover {
  color: #fff !important;
  background-color: #000 !important;
}
</style>
</head>
<%
	Dim letMenuCodeGroup : letMenuCodeGroup = "2"
	Dim letMenuCode : letMenuCode = "3"

	DbOpen()

	Dim peakYear : peakYear = iif(Request("peakYear") = "", year(now), Request("peakYear"))

	Dim dbTable : dbTable = "TBL_STAY_PEAK"
	Dim queryWhere : queryWhere = ""
	queryWhere = queryWhere & "AND SP_YEAR = '" & peakYear & "' "
	queryWhere = queryWhere & "AND SP_STATE = 'Y' "

	'//Array 버전
	'Sub stayList()
		sql = ""
		sql = sql & "SELECT SP_SEQ, SP_YEAR, SP_TYPE, SP_FROM, SP_TO, SP_STATE "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & queryWhere
		sql = sql & ""
		'Response.Write "sql: " & sql
		Dim arrTmp : arrTmp = getAdoRsArray(sql)
		'If IsArray(arrTmp) Then
		'	Dim j
		'	For j=0 To UBound(arrTmp, 2) 	'로우수만큼 for문 실행
				'aLink = " onClick='javascript:goView(" & arrTmp(0, j) & ");' style='cursor:pointer;'"
				'Response.Write "<tr>"
				'Response.Write "	<td " & aLink & "></td>"
				'Response.Write "	<td " & aLink & ">" & arrTmp(1, j) & "</td>"
				'Response.Write "	<td " & aLink & ">" & arrTmp(5, j) & "</td>"
				'Response.Write "	<td " & aLink & ">" & arrTmp(3, j) & "</td>"
				'Response.Write "	<td " & aLink & ">" & arrTmp(4, j) & "</td>"
				'Response.Write "	<td>"
				'Response.Write "		<a href='javascript:goDel(" & arrTmp(0, j) & ");' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>"
				'Response.Write "	</td>"
				'Response.Write "</tr>"
		'	Next
		'End If
	'End Sub

	Function fnStay(arg1, arg2)
		If IsArray(arrTmp) Then
			'Response.Write "arg1: " & arg1 & "<BR>"
			'Response.Write "arg2: " & arg2 & "<BR>"
			'Dim j
			'For j=0 To UBound(arrTmp, 2) 	'로우수만큼 for문 실행
				fnStay = arrTmp(arg1, arg2)
			'Next
		End If
	End Function
	'Response.Write "fnStay : " & fnStay(3, 3)

	'//연도 불러오기
	Function comboPeakYear(arg)
		sql = ""
		sql = sql & "SELECT DISTINCT(SP_YEAR) AS SP_YEAR "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & "AND SP_STATE = 'Y'"
		set rs = dbconn.execute(sql)
		Dim combo : combo = ""
		If rs.EOF Then
			combo = combo & "<option value='" & year(now) & "'>" & year(now) & "년</option>"
		Else
			Do while Not rs.eof
				spYear = rs("SP_YEAR")
				If CInt(peakYear) = spYear Then
					combo = combo & "<option value='" & rs("SP_YEAR") & "' SELECTED>" & spYear & "년</option>"
				Else
					combo = combo & "<option value='" & rs("SP_YEAR") & "'>" & spYear & "년</option>"
				End If
			rs.MoveNext
			Loop
			If CInt(peakYear) = (spYear + 1) Then
				combo = combo & "<option value='" & spYear + 1 & "' SELECTED>" & spYear + 1 & "년</option>"
			Else
				combo = combo & "<option value='" & spYear + 1 & "'>" & spYear + 1 & "년</option>"
			End If
			If CInt(year(now)) < (spYear) Then
				combo = combo & "<option value='" & year(now) + 1 & "'>" & year(now) + 1 & "년</option>"
			Else
				combo = combo & "<option value='" & year(now) + 1 & "'>" & year(now) + 1 & "년</option>"
			End If
		End If
		rs.Close
		Set rs = Nothing

		comboPeakYear = combo
	End Function
%>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<!-- #include virtual="/admin/_common/_inc/leftMenu.asp" -->
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<!-- #include virtual="/admin/_common/_inc/topMenuLnb.asp" -->
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">성수기 설정</h6>
						</div>
						<div class="card-body">
							<form name='frm' id='frm' method='POST' class='form-inline'>
							<input type='HIDDEN' name='strMode' id='strMode'>
							<input type='HIDDEN' name='spSeq' id='spSeq'>
							<div class='col-2'>
								<select name='peakYear' id='peakYear' class="form-select form-select-lg mb-3">
									<%=comboPeakYear(peakYear)%>
								</select>
							</div>

							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th class="col-3">구분</th>
											<th>기간</th>
											<th class="col-2">&nbsp;</th>
										</tr>
									</thead>
									<tbody>
									<%'Call stayList()%>

									<%
									For i = 0 To 2
										Select Case (i+1)
											Case "1"
												peakTypeName = "비수기"
											'Case "2"
											'	peakTypeName = "비수기-주말(금~토), 휴일"
											Case "2"
												peakTypeName = "준성수기"
											'Case "4"
											'	peakTypeName = "준성수기-주말(금~토), 휴일"
											Case "3"
												peakTypeName = "성수기"
											'Case "6"
											'	peakTypeName = "성수기-주말(금~토), 휴일"
										End Select
									%>
									<input type='TEXT' name='peakType' value="<%=i+1%>">
									<tr>
										<td><%=peakTypeName%></td>
										<td>
											<div class="input-group input-daterange">
												<input type="text" class="form-control col-3 col-md-4" name='peakTermFrom' value="<%=fnStay(3, i)%>" READONLY>
												~
												<input type="text" class="form-control col-3 col-md-4" name='peakTermTo' value="<%=fnStay(4, i)%>" READONLY>
											</div>
										</td>
										<td>
											<a href='javascript:goDel(<%=fnStay(0, i)%>);' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>
									<%
									Next
									%>
									<!--
									<tr>
										<td>비수기-주말(금~토), 휴일</td>
										<td><input type="text" class="form-control peak_term" name="daterange" value="<%%>"  /></td>
										<td>
											<a href='javascript:goDel();' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>
									<tr>
										<td>준성수기-평일(일~목)</td>
										<td></td>
										<td>
											<a href='javascript:goDel();' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>
									<tr>
										<td>준성수기-주말(금~토), 휴일</td>
										<td></td>
										<td>
											<a href='javascript:goDel();' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>
									<tr>
										<td>성수기-평일(일~목)</td>
										<td></td>
										<td>
											<a href='javascript:goDel();' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>
									<tr>
										<td>성수기-주말(금~토), 휴일</td>
										<td></td>
										<td>
											<a href='javascript:goDel();' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>
										</td>
									</tr>-->
									</tbody>
								</table>
							</div>
							</form>

							<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-2">
								<button type="button" class="btn btn-success" onClick='javascript:goSave()'>저장</button>
							</div>

						</div>
					</div>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<!-- #include virtual="/admin/_common/_inc/footer.asp" -->
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>

<!-- #include virtual="/admin/_common/_inc/incBody.asp" -->
<%
	DbClose()
%>
<!--
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

<script type="text/javascript">
<!--
	$(document).ready(function(){
		$('.input-daterange').datepicker({
			format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
			startDate: '0d',			//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
			//endDate: '+10d',			//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
			autoclose : true,			//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
			calendarWeeks : true,	//캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
			clearBtn : false,			//날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
			//datesDisabled : ['2019-06-24','2019-06-26'],		//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
			//daysOfWeekDisabled : [0,6],		//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
			//daysOfWeekHighlighted : [3],		//강조 되어야 하는 요일 설정
			//disableTouchKeyboard : false,		//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
			//immediateUpdates: false,				//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
			//multidate : false,						//여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
			//multidateSeparator :",",				//여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
			//templates : {
			//	leftArrow: '&laquo;',
			//	rightArrow: '&raquo;'
			//}, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
			//showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
			//title: "테스트",		//캘린더 상단에 보여주는 타이틀
			todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
			toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
			//weekStart : 0 ,			//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
			language : "ko"			//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
		});

		/*
		$(function() {
			//$('input[name="daterange"]').daterangepicker({
			$('.peak_term').daterangepicker({
				"startDate": "2023-07-03",
				"endDate": "2023-07-04",
				opens: 'center',
				locale: {
					format: 'YYYY-MM-DD'
				}
			});
		});
		*/
	});

	function goView(pa){
		location.href='errorView.asp?eSeq=' + pa + '&page=<%=intNowPage%>';
	}

	function goSave(){
		$("#strMode").val("SAVE");

		//attach파일
		//var form = jQuery("#frm")[0];
		//var formData = new FormData(form);

		//일반
		var formData = $("#frm").serialize() ;

		$.ajax({
			type : 'post',
			url : 'peakProc.asp',
			data : formData,
			dataType : 'html',

			//processData : false, 
			//contentType : false,

			error: function(xhr, status, error){
				//alert(error);
				alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
			},
			success : function(data){
				if (data == "Y"){
					alert("저장되었습니다.");
					location.reload();
				}else if(data = "NO_DIR"){
					alert("접근경로 오류입니다.");
				}else{
					alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
				}
			}
		});
	}

	function goDel(pa){
		if(confirm("삭제 하시겠습니까?")){
			$("#strMode").val("DELETE");
			$("#spSeq").val(pa);

			//attach파일
			//var form = jQuery("#frm")[0];
			//var formData = new FormData(form);

			//일반
			var formData = $("#frm").serialize() ;

			$.ajax({
				type : 'post',
				url : 'peakProc.asp',
				data : formData,
				dataType : 'html',

				//processData : false, 
				//contentType : false,

				error: function(xhr, status, error){
					//alert(error);
					alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
				},
				success : function(data){
					if (data == "Y"){
						alert("삭제되었습니다.");
						location.reload();
					}else{
						alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
					}
				}
			});
		}
	}
//-->
</script>
</body>
</html>