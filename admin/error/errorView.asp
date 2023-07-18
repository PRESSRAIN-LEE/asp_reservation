<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<!-- #include virtual="/admin/_common/_inc/topMenuGnb.asp" -->
</head>
<%
	Dim letMenuCodeGroup : letMenuCodeGroup = "1"
	Dim letMenuCode : letMenuCode = "1"
	Dim eSeq : eSeq = Request("eSeq")
	Dim page : page = Request("page")

	DbOpen()

	Dim dbTable : dbTable = "TBL_ERROR_LOG"

	sql = ""
	sql = sql & "SELECT E_DATE "
	sql = sql & ", E_PROCESSING_NAME,E_PROCESSING, E_PROCESSING_DATE, E_CATEGORY, E_FILE, E_LINE, E_COLUMN, E_MSG, E_SOURCE, E_REFERER, E_URL, E_IP "
	sql = sql & ", (SELECT CASE E_PROCESSING WHEN 'Y' THEN '처리 완료' "
	sql = sql & "												WHEN 'N' THEN '미처리' "
	sql = sql & "												WHEN 'D' THEN '삭제' "
	sql = sql & "												END ) AS E_PROCESSING1 "
	sql = sql & "FROM " & dbTable & " "
	sql = sql & "WHERE 1 = 1 "
	sql = sql & "AND E_SEQ = " & eSeq & " "
	'print sql
	Set rs = dbconn.execute(sql)
	If Not rs.EOF Then
		errorDate = rs("E_DATE")
		errorProcessing = rs("E_PROCESSING")
		errorProcessing1 = rs("E_PROCESSING1")
		errorProcessingName = rs("E_PROCESSING_NAME")
		errorProcessingDate = rs("E_PROCESSING_DATE")
		errorProcessingCategory = rs("E_CATEGORY")
		errorFile = rs("E_FILE")
		errorLine = rs("E_LINE")
		errorColumn = rs("E_COLUMN")
		errorMsg = rs("E_MSG")
		errorSource = rs("E_SOURCE")
		errorReferer = rs("E_REFERER")
		errorUrl = rs("E_URL")
		errorIp = rs("E_IP")
	End If
	rs.close()
	Set rs = Nothing

	DbClose()
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
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Error 상세</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<form name='frm' id='frm'method='POST'>
								<input type='HIDDEN' name='strMode' id='strMode'>
								<input type='HIDDEN' name='strProcessType' id='strProcessType'>
								<input type='HIDDEN' name='eSeq' id='eSeq' value='<%=eSeq%>'>
								<input type='HIDDEN' name='eProcessingName' id='eProcessingName' value='개발자1<%'=eProcessingName%>'>
								<table class="table table-dark table-bordered table-hover" width="100%" cellspacing="0">
									<tbody>
										<tr>
											<th class='table-active col-2'>날짜</th>
											<td class='col-4'><%=errorDate%></td>
											<th class='table-active col-2'>처리 상태</th>
											<td class='col-4'><%=errorProcessing1%></td>
										</tr>
										<tr>
											<th class='table-active'>처리자</th>
											<td><%=errorProcessingName%></td>
											<th class='table-active'>처리일</th>
											<td><%=errorProcessingDate%></td>
										</tr>
										<tr>
											<th class='table-active'>에러 범주</th>
											<td colspan='3'><%=errorProcessingCategory%></td>
										</tr>
										<tr>
											<th class='table-active'>에러 파일명</th>
											<td colspan='3' class='table-warning'><%=errorFile%></td>
										</tr>
										<tr>
											<th class='table-active'>에러 Line</th>
											<td class='table-warning'><%=errorLine%></td>
											<th class='table-active'>에러 Column</th>
											<td class='table-warning'><%=errorColumn%></td>
										</tr>
										<tr>
											<th class='table-active'>에러 내용</th>
											<td colspan='3' class='table-warning'><%=errorMsg%></td>
										</tr>
										<tr>
											<th class='table-active'>에러 소스</th>
											<td colspan='3' class='table-warning'><%=errorSource%></td>
										</tr>
										<tr>
											<th class='table-active'>이전 페이지</th>
											<td colspan='3'><%=errorReferer%></td>
										</tr>
										<tr>
											<th class='table-active'>사용자 IP</th>
											<td colspan='3'><%=errorIp%></td>
										</tr>
									</tbody>
								</table>
								</form>
							</div>
						</div>
					</div>

					<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-2">
						<a class="btn btn-outline-primary" href="errorList.asp?page=<%=page%>" role="button">목록</a>
						<%If errorProcessing = "N" Then%>
							<button type="button" class="btn btn-success" onClick='javascript:goProcess()'>처리</button>
						<%End If%>
						<%If errorProcessing = "Y" Then%>
							<button type="button" class="btn btn-outline-danger" onClick='javascript:goDel()'>삭제</button>
						<%End If%>
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
<script type="text/javascript">
<!--
	function goProcess(){
		if(confirm("에러 수정으로 완료 하시겠습니까?")){
			$("#strMode").val("PROCESS");
			$("#strProcessType").val("Y");

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
						alert("저장되었습니다.");
						location.reload();
					}else{
						alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
					}
				}
			});
		}
	}

	function goDel(){
		if(confirm("삭제 하시겠습니까?")){
			$("#strMode").val("PROCESS");
			$("#strProcessType").val("D");

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