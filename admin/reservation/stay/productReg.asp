<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<!-- #include virtual="/admin/_common/_inc/topMenuGnb.asp" -->
</head>
<%
	Const letMenuCodeGroup = "2"
	Const letMenuCode = "2"
	Const dbTable = "TBL_STAY_PRODUCT"
	Dim strMode : strMode = "NEW"

	Dim pSeq : pSeq = Request("pSeq")
	Dim page : page = Request("page")

	DbOpen()

	If pSeq <> "" Then
		sql = ""
		sql = sql & "SELECT SP_NAME, SP_PRICE_1, SP_PRICE_2, SP_PRICE_3, SP_PRICE_4, SP_PRICE_5, SP_PRICE_6, SP_POINT, SP_POINT_UNIT, SP_USE, SP_STATE, SP_IMG_1, SP_IMG_2, SP_MEMO, SP_DATE "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & "AND SP_SEQ = " & pSeq & " "
		'print sql
		Set rs = dbconn.execute(sql)
		If Not rs.EOF Then
			pName = rs("SP_NAME")
			pPrice1 = rs("SP_PRICE_1")
			pPrice2 = rs("SP_PRICE_2")
			pPrice3 = rs("SP_PRICE_3")
			pPrice4 = rs("SP_PRICE_4")
			pPrice5 = rs("SP_PRICE_5")
			pPrice6 = rs("SP_PRICE_6")
			pPoint = rs("SP_POINT")
			pPointUnit = rs("SP_POINT_UNIT")
			pService = rs("SP_USE")
			pState = rs("SP_STATE")
			pImg1 = rs("SP_IMG_1")
			pImg2 = rs("SP_IMG_2")
			pMemo = rs("SP_MEMO")

			strMode = "EDIT"
		End If
		rs.close()
		Set rs = Nothing
	End If

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
							<h6 class="m-0 font-weight-bold text-primary">상품 등록/상세</h6>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<form name='frm' id='frm'method='POST' class='form-inline' role="form">
								<input type='TEXT' name='strMode' id='strMode' value="<%=strMode%>">
								<input type='TEXT' name='pSeq' id='pSeq' value='<%=pSeq%>'>

								<table class="table table-bordered table-hover" width="100%" cellspacing="0">
									<tbody>
										<tr>
											<th class='table-active'>상품명</th>
											<td class='col-8' colspan='3'>
												<div class="form-group">
													<input type='text' name='pName' id='pName' class='form-control col-lg-12 col-md-10 col-sm-6' value="<%=pName%>">
												</div>
											</td>
										</tr>
										<tr>
											<th class='table-active col-4'>가격<BR>비수기-평일(일~목)</th>
											<td><input type='text' name='pPrice1' id='pPrice1' class='form-control w-50' value="<%=pPrice1%>">원</td>
											<th class='table-active col-5'>가격<BR>비수기-주말(금~토), 휴일</th>
											<td><input type='text' name='pPrice2' id='pPrice2' class='form-control w-50' value="<%=pPrice2%>">원</td>
										</tr>
										<tr>
											<th class='table-active'>가격<BR>준성수기-평일(일~목)</th>
											<td><input type='text' name='pPrice3' id='pPrice3' class='form-control w-50' value="<%=pPrice3%>">원</td>
											<th class='table-active'>가격<BR>준성수기-주말(금~토), 휴일</th>
											<td><input type='text' name='pPrice4' id='pPrice4' class='form-control w-50' value="<%=pPrice4%>">원</td>
										</tr>
										<tr>
											<th class='table-active'>가격<BR>성수기-평일(일~목)</th>
											<td><input type='text' name='pPrice5' id='pPrice5' class='form-control w-50' value="<%=pPrice4%>">원</td>
											<th class='table-active'>가격<BR>성수기-주말(금~토), 휴일</th>
											<td><input type='text' name='pPrice6' id='pPrice6' class='form-control w-50' value="<%=pPrice6%>">원</td>
										</tr>
										<tr>
											<th class='table-active'>포인트</th>
											<td><input type='text' name='pPoint' id='pPoint' class='form-control w-50' value="<%=pPoint%>"></td>
											<th class='table-active'>포인트 단위</th>
											<td>
												<select name='pPointUnit' id='pPointUnit' class="form-select form-select-md w-50">
													<option value='W' <%If pPointUnit = "W" Then Response.Write "SELECTED" End If%>>원</option>
													<option value='P' <%If pPointUnit = "P" Then Response.Write "SELECTED" End If%>>%</option>
												</select>
											</td>
										</tr>
										<tr>
											<th class='table-active'>서비스 상태</th>
											<td>
												<select name='pService' id='pService' class="form-select form-select-md w-50">
													<option value='Y' <%If pService = "Y" Then Response.Write "SELECTED" End If%>>서비스</option>
													<option value='N' <%If pService = "N" Then Response.Write "SELECTED" End If%>>서비스 중지</option>
												</select>
											</td>
											<th class='table-active'>화면에 표시</th>
											<td>
												<select name='pState' id='pState' class="form-select form-select-md w-50">
													<option value='Y' <%If pState = "Y" Then Response.Write "SELECTED" End If%>>사용</option>
													<option value='N' <%If pState = "N" Then Response.Write "SELECTED" End If%>>삭제</option>
												</select>
											</td>
										</tr>
										<tr>
											<th class='table-active'>이미지1</th>
											<td><input type='file' name='pImg1' id='pImg1' class='form-control'></td>
											<th class='table-active'>이미지2</th>
											<td><input type='file' name='pImg2' id='pImg2' class='form-control'></td>
										</tr>
										<tr>
											<th class='table-active'>설명</th>
											<td colspan='3'><textarea class="form-control w-100" name='pMemo' id="pMemo" rows="3"><%=pMemo%></textarea></td>
										</tr>
									</tbody>
								</table>
								</form>
							</div>
						</div>
					</div>

					<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-2">
						<a class="btn btn-outline-primary" href="productList.asp?page=<%=page%>" role="button">목록</a>
							<button type="button" class="btn btn-success" onClick='javascript:goSave()'>저장</button>
							<%If strMode = "EDIT" Then%>
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
	function goSave(){
		
			//attach파일
			//var form = jQuery("#frm")[0];
			//var formData = new FormData(form);

			//일반
			var formData = $("#frm").serialize() ;

			$.ajax({
				type : 'post',
				url : 'productProc.asp',
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
						location.href="productList.asp";
					}else{
						alert("오류가 발생하였습니다. 다시 시도 바랍니다.");
					}
				}
			});
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