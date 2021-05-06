<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/main_css.css" />
<script src="js/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="content">
		</div>
	<div class="tb">
		<div class="btn-group-vertical" id="button" style="margin: 10px;">
			<button type="button" name="MemberUpdate" id="MemberUpdate" class="btn btn-primary">개인정보 변경하기</button>
			<button type="button" name="MyContent" id="MyContent" class="btn btn-primary">나의 작성글</button>
			<button type="button" name="MemberDel" id="MemberDel" class="btn btn-primary">회원 탈퇴</button>
		</div>
	</div>
		<div class="container" style="width: 860px; min-width:400px; margin-top: -140px;">
			<div id="h2" class="row" style="text-align:center; margin:0 auto;">
				<h2 class="col-sm-8" style="margin-bottom: 30px;">구매내역</h2>
			</div>
			<div id="content">
				<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">금액</th>
						<th scope="col">날짜</th>
					</tr>
				</thead>
				<!-- 게시 글이 있는 경우 - 게시 글 리스트가 비어있지 않으면 -->
				<c:if test="${ not empty dList }">
				<c:forEach var="d" items="${ dList }" varStatus="status">
					<tr class="listTr">
						<td class="listTdTitle" style="text-align:left;"><a href="donationDetail.mvc?no=${ d.no }">${d.title }</a></td>
						<td class="listTdNo"><fmt:formatNumber value="${ d.money }" type="currency"/></td>
						<td class="listTdRegDate">${ d.date }</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="3" class="listPage">
						<ul class="pagination pagination-sm" style="margin-left: 45%">
							<c:if test="${ pageNum > 1 }">
								<li class="page-item">
									<a class="page-link" href="mypage.mvc?pageNum=${ pageNum - 1 }">&laquo;</a>
								</li>
							</c:if>
							<c:forEach var="i" begin="${ begin }" end="${ end }" step="1">
								<c:if test="${ i == pageNum}">
									<li class="page-item active">
										<a class="page-link" href="mypage.mvc?pageNum=${ i }"> ${ i } </a>
									</li>
								</c:if>
								<c:if test="${ i != pageNum}">
									<li class="page-item">
										<a class="page-link" href="mypage.mvc?pageNum=${ i }"> ${ i } </a>
									</li>
								</c:if>
							</c:forEach>
							<c:if test="${ pageNum < lastPage }">
								<li class="page-item">
									<a class="page-link" href="mypage.mvc?pageNum=${ pageNum + 1 }">&raquo;</a>
								</li>
							</c:if>
						</ul>
					</td>
				</tr>
				</c:if>
				<c:if test="${ empty dList }">
				<tr>
					<td colspan="2" class="listTdSpan">구매내역이 존재하지 않습니다.</td>
				</tr>
				</c:if>
			</table>
			</div>
		</div>
	</div>
</body>
</html>