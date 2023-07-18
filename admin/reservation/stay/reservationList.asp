<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<!-- #include virtual="/admin/_common/_inc/topMenuGnb.asp" -->
</head>
<%
	Dim letMenuCodeGroup : letMenuCodeGroup = "2"
	Dim letMenuCode : letMenuCode = "1"

	DbOpen()

	Dim intNowPage : intNowPage = Request.QueryString("page")
    Dim intPageSize : intPageSize = 10
    Dim intBlockPage : intBlockPage = 5
	Dim intTotalCount, intTotalPage

	Dim dbTable : dbTable = "TBL_RESERVATION"
	Dim queryWhere : queryWhere = ""
	queryWhere = queryWhere & "AND R_TYPE IN ('STAY') "

	Call intTotal()

	'//Array 버전
	Sub errorList1()
		sql = ""
		sql = sql & "SELECT E_SEQ, E_DATE, E_PROCESSING, E_PROCESSING_NAME, E_PROCESSING_DATE, E_CATEGORY, E_FILE, E_LINE, E_MSG, E_SOURCE, E_REFERER, E_URL, E_IP "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & ""
		sql = sql & ""
		Dim arrTmp : arrTmp = getAdoRsArray(sql)
		If IsArray(arrTmp) Then
			Response.Write "A"
			For i=0 To UBound(arrTmp, 2) 	'로우수만큼 for문 실행
				aLink = " onClick='javascript:goView(" & arrTmp(0, i) & ");' style='cursor:pointer;'"
				Response.Write "<tr>"
				Response.Write "	<td " & aLink & "></td>"
				Response.Write "	<td " & aLink & ">" & arrTmp(1, i) & "</td>"
				Response.Write "	<td " & aLink & ">" & arrTmp(8, i) & "</td>"
				Response.Write "	<td " & aLink & ">" & arrTmp(3, i) & "</td>"
				Response.Write "	<td " & aLink & ">" & arrTmp(4, i) & "</td>"
				Response.Write "	<td></td>"
				Response.Write "</tr>"
			Next
		End If
	End Sub

	'//페이징 버전
	Sub reservationList()
		Dim listNum : listNum = (intTotalCount-MoveCount)

		sql = ""
		sql = sql & "SELECT " & TopCount & " R_SEQ, R_NAME, R_PHONE, P_NAME, P_PRICE, R_DAYS, R_FROM, R_TO, R_MEMO, R_DATE, R_TYPE "
		sql = sql & ", (SELECT CASE R_STATE WHEN 'Y' THEN '처리 완료' "
		sql = sql & "												WHEN 'N' THEN '미처리' "
		sql = sql & "												WHEN 'D' THEN '삭제' "
		sql = sql & "												END ) AS R_STATE "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & queryWhere
		sql = sql & "ORDER BY R_SEQ DESC "
		'Print sql
		Set rs = dbconn.execute(sql)
		If Not rs.eof Then
			If listNum <= 0 And intNowPage > 1 Then
				Response.redirect "errorList.asp?page=" & intNowPage - 1
			Else
				rs.move MoveCount
			End If
			Do while not rs.eof
				aLink = " onClick='javascript:goView(" & rs("R_SEQ") & ");' style='cursor:pointer;'"
				Response.Write "<tr>"
				Response.Write "	<td " & aLink & ">" & listNum & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("R_NAME") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("R_NAME") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("R_NAME") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("R_NAME") & "</td>"
				Response.Write "	<td>"
				If isnull(rs("R_NAME")) Then
					Response.Write "&nbsp;"
				Else
					Response.Write "		<a href='javascript:goDel(" & rs("R_SEQ") & ");' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>"
				End If
				Response.Write "	</td>"
				Response.Write "</tr>"

				listNum = listNum - 1
				rs.movenext
			Loop

			rs.close()
			set rs = nothing
		End If
	End Sub
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
							<h6 class="m-0 font-weight-bold text-primary">예약 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th class="col-1">No</th>
											<th class="col-2">예약자명</th>
											<th class="col-1">연락처</th>
											<th class="col-2">숙소명</th>
											<th class="col-1">금액</th>
											<th class="col-1">숙박일수</th>
											<th class="col-2">숙박기간</th>
											<th class="col-1">예약상태</th>
											<th class="col-1">&nbsp;</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>No</th>
											<th>예약자명</th>
											<th>연락처</th>
											<th>숙소명</th>
											<th>금액</th>
											<th>숙박일수</th>
											<th>숙박기간</th>
											<th>예약상태</th>
											<th>&nbsp;</th>
										</tr>
									</tfoot>
									<tbody>
									<%Call reservationList()%>
									</tbody>
								</table>
							</div>

							<nav aria-label="Page navigation">
								<%Call adminPaging("")%>
							</nav>
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


<form name='frm' id='frm' method='POST'>
<input type='TEXT' name='strMode' id='strMode'>
<input type='TEXT' name='strProcessType' id='strProcessType'>
<input type='TEXT' name='eSeq' id='eSeq'>
<input type='TEXT' name='eProcessingName' id='eProcessingName' value='개발자2<%'=eProcessingName%>'>
</form>

<!-- #include virtual="/admin/_common/_inc/incBody.asp" -->
<%
	DbClose()
%>
<script type="text/javascript">
<!--
	function goView(pa){
		location.href='errorView.asp?eSeq=' + pa + '&page=<%=intNowPage%>';
	}

	function goDel(pa){
		if(confirm("삭제 하시겠습니까?")){
			$("#strMode").val("PROCESS");
			$("#strProcessType").val("D");
			$("#eSeq").val(pa);

			//attach파일
			//var form = jQuery("#frm")[0];
			//var formData = new FormData(form);

			//일반
			var formData = $("#frm").serialize() ;

			$.ajax({
				type : 'post',
				url : 'errorProc.asp',
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