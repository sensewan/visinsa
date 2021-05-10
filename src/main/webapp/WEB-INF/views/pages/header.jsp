<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 헤더영역 -->
	<div class="header" >
		<div>
			<div class="login_bar" style="float: right;">
				<c:if test="${ not empty member }">
					<span>${member.nickName}님</span>
				</c:if>
				
				<span class="login_m">
					<c:choose>
						<c:when test="${ sessionScope.isLogin == true }">
							<a href='MyPage'>MyPage&nbsp;⎥&nbsp;</a><a href='basket'>장바구니[${countBasket}]&nbsp;⎥&nbsp;</a><a href='logout'>로그아웃</a>
						</c:when>
						<c:when test="${ sessionScope.isLogin != true }">
							<a href='SignUp'>회원가입&nbsp;⎥&nbsp;</a><a href='login'>로그인</a>
						</c:when>
					</c:choose>
				</span>
			</div>
			<div style="text-align: center;">
			  <a class="navbar-brand" href="main" id="logo">
			  	<img src="resources/images/logo.png" style="width: 200px;">
			  </a>
			</div>
		</div>
	
		<!-- 네비게이션 -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarColor01">
		    <ul class="navbar-nav mr-auto" id=nav_ul>
		      <li class="nav-item active">
		        <a class="nav-link" href="home">Home</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="best">BEST</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="kakao">건강정보</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="productList">비타민</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="Community">커뮤니티</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="noticeList">공지사항</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="boardList">테스트</a>
		      </li>
		    </ul>
		    
		  </div>
		</nav>
		
	</div> <!-- 헤더 끝-->