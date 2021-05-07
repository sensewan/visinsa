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
			<button type="button" class="btn btn-primary">장바구니</button>
			<button type="button" name="MemberDel" id="MemberDel" class="btn btn-primary">회원 탈퇴</button>
		</div>
	</div>
		<div class="container" style="width: 860px; min-width:400px; margin-top: -140px;">
			<div id="h2" class="row" style="text-align:center; margin:0 auto;">
				<h2 class="col-sm-8" style="margin-bottom: 30px;">장바구니</h2>
			</div>
			<div id="content">
				<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">상품</th>
						<th scope="col">금액</th>
						<th scope="col">개수</th>
						<th scope="col">합계</th>
					</tr>
				</thead>
				<!-- 게시 글이 있는 경우 - 게시 글 리스트가 비어있지 않으면 -->
				<c:if test="${ not empty basket }">
				<c:forEach var="b" items="${ basket }" varStatus="status">
					<tr class="listTr">
						<td class="listTdTitle" style="text-align:left;"><a href="productDetail?no=${ b.num }">${b.productName }</a></td>
						<td class="listTdNo"><fmt:formatNumber value="${ b.productPrice }" type="currency"/></td>
						<td class="listTdRegDate">${ b.count }개</td>
						<td class="listTdNo"><fmt:formatNumber value="${ b.price }" type="currency"/></td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty basket }">
				<tr>
					<td colspan="4" class="listTdSpan">담은 상품이 존재하지 않습니다.</td>
				</tr>
				</c:if>
			</table>
			</div>
		</div>
	</div>
</body>
</html>