<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<article>

<div style="width:960px; margin:auto;">
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">상품명</th>
				<th scope="col">연령대</th>
				<th scope="col">판매량</th>
			</tr>
		</thead>
		
		<c:if test="${ not empty topAge20 }">
		<c:forEach var="t" items="${ topAge20 }" varStatus="status">
			<tr class="listTr">
				<td class="listTdTitle" style="text-align:left;">${ t.productName }</td>
				<td class="listTdNo">${ t.age }</td>
				<td class="listTdNo">${ t.count }</td>
			</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${ not empty topAge30 }">
		<c:forEach var="t" items="${ topAge30 }" varStatus="status">
			<tr class="listTr">
				<td class="listTdTitle" style="text-align:left;">${ t.productName }</td>
				<td class="listTdNo">${ t.age }</td>
				<td class="listTdNo">${ t.count }</td>
			</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${ not empty topAge40 }">
		<c:forEach var="t" items="${ topAge40 }" varStatus="status">
			<tr class="listTr">
				<td class="listTdTitle" style="text-align:left;">${ t.productName }</td>
				<td class="listTdNo">${ t.age }</td>
				<td class="listTdNo">${ t.count }</td>
			</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${ not empty topAge50 }">
		<c:forEach var="t" items="${ topAge50 }" varStatus="status">
			<tr class="listTr">
				<td class="listTdTitle" style="text-align:left;">${ t.productName }</td>
				<td class="listTdNo">${ t.age }</td>
				<td class="listTdNo">${ t.count }</td>
			</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${ not empty topAge60 }">
		<c:forEach var="t" items="${ topAge60 }" varStatus="status">
			<tr class="listTr">
				<td class="listTdTitle" style="text-align:left;">${ t.productName }</td>
				<td class="listTdNo">${ t.age }</td>
				<td class="listTdNo">${ t.count }</td>
			</tr>
		</c:forEach>
		</c:if>
		
	</table>
</div>

</article>