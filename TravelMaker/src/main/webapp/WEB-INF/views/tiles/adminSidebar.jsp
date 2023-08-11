<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Navigation
	================================================== -->

<!-- Responsive Navigation Trigger -->
<a href="#" class="dashboard-responsive-nav-trigger"><i
	class="fa fa-reorder"></i> Dashboard Navigation</a>

<div class="dashboard-nav">
	<div class="dashboard-nav-inner">

		<ul data-submenu-title="유저">
			<li><a href="/admin/manage/member"><i class="sl sl-icon-people"></i> 회원 조회</a></li>
			<li><a href="/admin/manage/host"><i class="sl sl-icon-user-follow"></i> 호스트 관리</a></li>
			<li><a href="/admin/manage/blame"><i class="sl sl-icon-user-follow"></i> 신고 관리</a></li>
		</ul>

		<ul data-submenu-title="매출">
			<li><a href="/admin/manage/revenue"><i class="sl sl-icon-chart"></i> 매출 관리</a></li>
			<li><a href="/admin/manage/event"><i class="sl sl-icon-star"></i> 이벤트 관리</a></li>
		</ul>

		<ul data-submenu-title="문의">
			<li><a href="/admin/inquiry/list"><i class="sl sl-icon-user"></i> 문의사항 관리</a></li>
			<li><a href="/admin/faq/list"><i class="sl sl-icon-user"></i> FAQ 관리</a></li>
		</ul>

	</div>
</div>
<!-- Navigation / End -->