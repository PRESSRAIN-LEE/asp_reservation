<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<!-- #include virtual="/admin/_common/_inc/topMenuGnb.asp" -->
</head>
<%
	Const letMenuCodeGroup = "2"
	Const letMenuCode = "2"
	Const dbTable = "TBL_STAY_PRODUCT"

	DbOpen()

	Dim intNowPage : intNowPage = Request.QueryString("page")
    Dim intPageSize : intPageSize = 10
    Dim intBlockPage : intBlockPage = 5
	Dim intTotalCount, intTotalPage
	Dim queryWhere : queryWhere = ""
	queryWhere = queryWhere & "AND SP_STATE IN ('Y') "

	Call intTotal()

'a = "@variable, @@variable, union -- 1 from "
'Response.Write "SQLInject: " & SQLInject(a) & "<BR>"
'Response.Write "SQLInject2: " & SQLInject2(a)

	Sub productList()
		Dim listNum : listNum = (intTotalCount-MoveCount)

		sql = ""
		sql = sql & "SELECT " & TopCount & " SP_SEQ, SP_NAME, SP_PRICE_1, SP_PRICE_2, SP_PRICE_3, SP_PRICE_4, SP_PRICE_5, SP_PRICE_6, SP_POINT, SP_POINT_UNIT, SP_USE, SP_IMG_1, SP_IMG_2, SP_MEMO, SP_DATE "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & queryWhere
		'sql = sql & "AND SP_NAME = ? "
		'sql = sql & "AND SP_SEQ = ? "
		sql = sql & "ORDER BY SP_SEQ DESC "
		'Print sql
		'set objCommand = Server.CreateObject("ADODB.Command") 
		'objCommand.ActiveConnection = dbconn
		''objCommand.CommandType = 1
		'objCommand.CommandText = sql 
		'objCommand.Parameters.Append objCommand.CreateParameter("SP_NAME", adVarChar, adParamInput, 20, a)
		'objCommand.Parameters.Append objCommand.CreateParameter("SP_SEQ", adInteger, adParamInput, 20, b)
		'Set rs = objCommand.Execute()

		Set rs = dbconn.execute(sql)
		If Not rs.eof Then
			If listNum <= 0 And intNowPage > 1 Then
				Response.redirect "productList.asp?page=" & intNowPage - 1
			Else
				rs.move MoveCount
			End If
			Do while not rs.eof
				aLink = " onClick='javascript:goView(" & rs("SP_SEQ") & ");' style='cursor:pointer;'"
				Response.Write "<tr>"
				Response.Write "	<td " & aLink & ">" & listNum & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_NAME") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_1") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_2") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_3") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_4") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_5") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_PRICE_6") & "</td>"
				Response.Write "	<td " & aLink & ">" & rs("SP_DATE") & "</td>"
				Response.Write "	<td>"
				Response.Write "		<a href='javascript:goDel(" & rs("SP_SEQ") & ");' class='btn btn-danger btn-circle btn-sm'><i class='fas fa-trash'></i></a>"
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
							<h6 class="m-0 font-weight-bold text-primary">Error 목록</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th class="col-1">No</th>
											<th class="col-3">상품명</th>
											<th class="col-1">금액1</th>
											<th class="col-1">금액2</th>
											<th class="col-1">금액3</th>
											<th class="col-1">금액4</th>
											<th class="col-1">금액5</th>
											<th class="col-1">금액6</th>
											<th class="col-1">등록일</th>
											<th class="col-1">&nbsp;</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>No</th>
											<th>상품명</th>
											<th>금액1</th>
											<th>금액2</th>
											<th>금액3</th>
											<th>금액4</th>
											<th>금액5</th>
											<th>금액6</th>
											<th>등록일</th>
											<th>&nbsp;</th>
										</tr>
									</tfoot>
									<tbody>
									<%Call productList()%>
									</tbody>
								</table>
							</div>

							<div class="gap-2  justify-content-md-end mb-2">
								<a class="btn btn-sm btn-primary" href="productReg.asp" role="button">신규 등록</a>
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

<!-- #include virtual="/admin/_common/_inc/incBody.asp" -->
<%
	DbClose()
%>
<script type="text/javascript">
<!--
	function goView(pa){
		location.href='productReg.asp?pSeq=' + pa + '&page=<%=intNowPage%>';
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