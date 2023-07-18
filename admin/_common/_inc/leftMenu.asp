<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
		<div class="sidebar-brand-icon rotate-n-15">
			<i class="fas fa-laugh-wink"></i>
		</div>
		<div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Nav Item - Dashboard -->
	<li class="nav-item">
		<a class="nav-link" href="index.html">
			<i class="fas fa-fw fa-tachometer-alt"></i>
			<span>Dashboard</span></a>
	</li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">
		Interface
	</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
			aria-expanded="true" aria-controls="collapseTwo">
			<i class="fas fa-fw fa-cog"></i>
			<span>Components</span>
		</a>
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Custom Components:</h6>
				<a class="collapse-item" href="buttons.html">Buttons</a>
				<a class="collapse-item" href="cards.html">Cards</a>
			</div>
		</div>
	</li>

	<!-- Nav Item - Utilities Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
			aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-fw fa-wrench"></i>
			<span>Utilities</span>
		</a>
		<div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Custom Utilities:</h6>
				<a class="collapse-item" href="utilities-color.html">Colors</a>
				<a class="collapse-item" href="utilities-border.html">Borders</a>
				<a class="collapse-item" href="utilities-animation.html">Animations</a>
				<a class="collapse-item" href="utilities-other.html">Other</a>
			</div>
		</div>
	</li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">
		Addons
	</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
			aria-expanded="true" aria-controls="collapsePages">
			<i class="fas fa-fw fa-folder"></i>
			<span>Pages</span>
		</a>
		<div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">Login Screens:</h6>
				<a class="collapse-item" href="login.html">Login</a>
				<a class="collapse-item" href="register.html">Register</a>
				<a class="collapse-item" href="forgot-password.html">Forgot Password</a>
				<div class="collapse-divider"></div>
				<h6 class="collapse-header">Other Pages:</h6>
				<a class="collapse-item" href="404.html">404 Page</a>
				<a class="collapse-item" href="blank.html">Blank Page</a>
			</div>
		</div>
	</li>

	<!-- Nav Item - Charts -->
	<li class="nav-item">
		<a class="nav-link" href="charts.html">
			<i class="fas fa-fw fa-chart-area"></i>
			<span>Charts</span></a>
	</li>

	<!-- Nav Item - Tables -->
	<li class="nav-item">
		<a class="nav-link" href="tables.html">
			<i class="fas fa-fw fa-table"></i>
			<span>Tables</span></a>
	</li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">
		개발자
	</div>

	<!-- Nav Item - 추가 -->
	
	<li class="nav-item <%=iif(letMenuCodeGroup = "1", "active", "")%>">
		<a class="nav-link" href="/admin/error/errorList.asp">
			<i class="fas fa-fw fa-list"></i>
			<span>에러List</span>
		</a>
	</li>

	<li class="nav-item <%=iif(letMenuCodeGroup = "2", "active", "")%>">
		<a class="nav-link <%=iif(letMenuCodeGroup <> "2", "collapsed", "")%>" href="#" data-toggle="collapse" data-target="#collapseReservation" aria-expanded="true" aria-controls="collapseReservation">
			<i class="fas fa-fw fa-calendar-alt"></i>
			<span>예약</span>
		</a>
		<div id="collapseReservation" class="collapse <%=iif(letMenuCodeGroup = "2", "show", "")%>" aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">숙박:</h6>
				<a class="collapse-item <%=iif(letMenuCode = "1", "active", "")%>" href="/admin/reservation/stay/reservationList.asp">예약 목록</a>
				<a class="collapse-item <%=iif(letMenuCode = "2", "active", "")%>" href="/admin/reservation/stay/productList.asp">상품 목록</a>
				<a class="collapse-item <%=iif(letMenuCode = "3", "active", "")%>" href="/admin/reservation/stay/peakList.asp">성수기 설정</a>
				<div class="collapse-divider"></div>
				<h6 class="collapse-header">미용실:</h6>
				<a class="collapse-item <%=iif(letMenuCode = "4", "active", "")%>" href="/admin/reservation/stay/reservationList.asp">예약 목록</a>
				<a class="collapse-item <%=iif(letMenuCode = "5", "active", "")%>" href="/admin/reservation/stay/productList.asp">상품 목록</a>
			</div>
		</div>
	</li>

	<!-- Divider -->
	<hr class="sidebar-divider d-none d-md-block">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>
</ul>