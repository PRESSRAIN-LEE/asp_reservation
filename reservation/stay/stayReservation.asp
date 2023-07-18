<!-- #include virtual="/common/_inc/incGlobal.asp" -->
<%
	Dim topMenuCodeGroup : topMenuCodeGroup = "1"
	Dim topMenuCode : topMenuCode = "2"

	DbOpen()

	Dim intNowPage : intNowPage = Request.QueryString("page")
    Dim intPageSize : intPageSize = 10
    Dim intBlockPage : intBlockPage = 5
	Dim intTotalCount, intTotalPage

	Dim dbTable : dbTable = "TBL_STAY_PRODUCT"
	Dim queryWhere : queryWhere = ""

	Call intTotal()

	Sub stayList()
		sql = ""
		sql = sql & "SELECT * "
		sql = sql & "FROM " & dbTable & " "
		sql = sql & "WHERE 1 = 1 "
		sql = sql & "ORDER BY SP_NAME ASC "
		sql = sql & ""
		Set rs = dbconn.execute(sql)
		If Not rs.eof Then
			rs.move MoveCount
			Do while not rs.eof
				Response.Write "<div class='col-md-6 col-lg-12 col-xl-6'>"
				Response.Write "	<div class='single-blog mb-40 wow fadeInUp' data-wow-delay='.2s' onClick='javascript:goSelectDate(" & rs("SP_SEQ") & ");' style='cursor:pointer;'>"
				'Response.Write "		<div class='blog-img'>"
				'Response.Write "			<span class='date-meta'>15 June, 2025</span>"
				'Response.Write "		</div>"
				Response.Write "		<div class='blog-content'>"
				Response.Write "			<h4>" & rs("SP_NAME") & "</h4>"
				Response.Write "			<p>" & rs("SP_MEMO") & "</p>"
				Response.Write "		</div>"
				Response.Write "	</div>"
				Response.Write "</div>"
				rs.movenext
			Loop

			rs.close()
			set rs = Nothing
		End If
	End Sub
%>
<!doctype html>
<html class="no-js" lang="">
<head>
	<!-- #include virtual="/common/_inc/head.html" -->
	<!--<link rel="stylesheet" href="../../common/_css/page.css?v=<%=cssJsVersion%>">-->
</head>
<body>
	
	<!-- ========================= preloader start ========================= -->
	<div class="preloader">
		<div class="loader">
			<div class="ytp-spinner">
				<div class="ytp-spinner-container">
					<div class="ytp-spinner-rotator">
						<div class="ytp-spinner-left">
							<div class="ytp-spinner-circle"></div>
						</div>
						<div class="ytp-spinner-right">
							<div class="ytp-spinner-circle"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- preloader end -->

	<!-- ========================= header start ========================= -->
	<header class="header bg-white navbar-area">
		<!-- #include virtual="/common/_inc/header.html" -->
	</header>
	<!-- ========================= header end ========================= -->

	<!-- ========================= page-banner-section start ========================= -->
	<section class="page-banner-section pt-10 pb-10 img-bg" style="background-image:url(/img/bg/common-bg.svg)">
		<div class="container">
			<div class="row">
				<div class="col-xl-12">
					<div class="banner-content">
						<h2 class="text-white">예약</h2>
						<div class="page-breadcrumb">
							<nav aria-label="breadcrumb">
								<ol class="breadcrumb">
									<li class="breadcrumb-item" aria-current="page"><a href="javascript:void(0)">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">예약</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ========================= page-banner-section end ========================= -->

	<!-- ========================= service-section start ========================= -->
	<section id="blog" class="service-section pt-130 pb-100">
		<div class="container">
			<div class="row">
				<div class="col-xl-8 col-lg-7">
					<div class="left-side-wrapper">
						<div class="row">
							<%Call stayList()%>
						</div>

						<div class="col-auto mx-auto mt-40">
							<nav class="mt-5" aria-label="Page navigation example">
								<%Call userPaging("")%>
							</nav>
						</div>
					</div>
				</div>

				<!--우측-->
				<div class="col-xl-4 col-lg-5">
					<div class="sidebar-wrapper">
						<div class="sidebar-box recent-blog-box mb-10">
							<h5 class='mb-3'>날짜 선택</h5>
							<div class="recent-blog-items">
								<div class="recent-blog mb-0" id='calendar'>
									<%'server.execute("stayReservationCalendar.asp")%>
									<!-- include file="stayReservationCalendar.asp" -->
								</div>
							</div>
						</div>
					</div>

					<div class="sidebar-wrapper">
						<div class="sidebar-box recent-blog-box mb-10">
							<h4 class='mb-3'>기간 선택</h4>
							<div class="recent-blog-items">
								<div class="recent-blog mb-0" id='term'>
									<!-- include file="stayReservationTermAjax.asp" -->
								</div>
							</div>
						</div>
					</div>

					<div class="sidebar-wrapper">
						<div class="sidebar-box recent-blog-box mb-10">
							<h4 class='mb-3'>인원 선택</h4>
							<div class="recent-blog-items">
								<div class="recent-blog mb-0" id='member'>
									<!-- include file="stayReservationMemberAjax.asp" -->
								</div>
							</div>
						</div>
					</div>

					<div class="sidebar-box mb-10">
						<h4>Follow On</h4>
						<div class="footer-social-links">
							<ul class="d-flex justify-content-start">
								<li><a href="javascript:void(0)"><i class="lni lni-facebook-filled"></i></a></li>
								<li><a href="javascript:void(0)"><i class="lni lni-twitter-filled"></i></a></li>
								<li><a href="javascript:void(0)"><i class="lni lni-linkedin-original"></i></a></li>
								<li><a href="javascript:void(0)"><i class="lni lni-instagram-filled"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
				<!--우측-->
			</div>
		</div>
	</section>
	<!-- ========================= service-section end ========================= -->

	<!-- ========================= client-logo-section start ========================= -->
	<section class="client-logo-section pt-70 pb-130">
		<div class="container">
			<div class="client-logo-wrapper">
				<div class="client-logo-carousel d-flex align-items-center justify-content-between">
					<div class="client-logo">
						<img src="/img/client-logo/uideck-logo.svg" alt="">
					</div>
					<div class="client-logo">
						<img src="/img/client-logo/pagebulb-logo.svg" alt="">
					</div>
					<div class="client-logo">
						<img src="/img/client-logo/lineicons-logo.svg" alt="">
					</div>
					<div class="client-logo">
						<img src="/img/client-logo/graygrids-logo.svg" alt="">
					</div>
					<div class="client-logo">
						<img src="/img/client-logo/lineicons-logo.svg" alt="">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ========================= client-logo-section end ========================= -->

	<!-- ========================= footer start ========================= -->
	<!-- #include virtual="/common/_inc/footer.asp" -->
	<!-- ========================= footer end ========================= -->

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top">
		<i class="lni lni-arrow-up"></i>
	</a>
	<!-- ========================= scroll-top ========================= -->

	<!-- ========================= JS here ========================= -->
	<!-- ========================= JS here ========================= -->
	<!-- #include virtual="/common/_inc/bottom_script.asp" -->
<%
	DbClose()
%>

<script type="text/javascript">
<!--
$(document).on('ready', function() {
	//달력 날짜 선택
	var moveUrl = "stayReservationCalendarAjax.asp";
	$.ajax( {
		url:moveUrl,
		success:function(data) {
			$('#calendar').html(data);
		}
	});

	//기간선택
	goTermSelect();

	//인원선택
	goMemberSelect();
});

	//달력 날짜 선택
	function goSelectDate(pa){
		//$('#term').html("");
		//$('#member').html("");
		goTermSelect();
		goMemberSelect();

		var moveUrl = "stayReservationCalendarAjax.asp?spSeq=" + pa;
		$.ajax( {
			url:moveUrl,
			success:function(data) {
				$('#calendar').html(data);
			}
		} );
	}

	//기간선택
	function goTermSelect(){
		var moveUrl = "stayReservationTermAjax.asp";
		$.ajax( {
			url:moveUrl,
			success:function(data) {
				$('#term').html(data);
			}
		});
	}

	//인원선택
	function goMemberSelect(){
		var moveUrl = "stayReservationMemberAjax.asp";
		$.ajax( {
			url:moveUrl,
			success:function(data) {
				$('#member').html(data);
			}
		});
	}
//-->
</script>
</body>
</html>