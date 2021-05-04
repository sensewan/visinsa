<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src = "resources/js/formcheck.js"></script>
<article>
	<form name="checkForm" id="checkForm">
		<input type="hidden" name="no" id="no" value="${ notice.no }"/>
		<input type="hidden" name="pass" id="rPass" />
		<input type="hidden" name="pageNum" value="${ pageNum }" />
		
		<c:if test="${ searchOption }">
			<input type="hidden" name="type" value="${ type }" />
			<input type="hidden" name="keyword" value="${ word }" />
		</c:if>
	</form>	
	<table class="contentTable">
		<tr>
			<td colspan="4" class="boardTitle">
				<h2>게시 글 상세보기</h2>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td class="contentTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			<td class="contentTd" colspan="3">${ notice.title }</td>
		</tr>
		<tr>
			<td class="contentTh">글쓴이</td>
			<td class="contentTd">${ notice.writer }</td>
			<td class="contentTh">작성일</td>
			<td class="contentTd"><fmt:formatDate value="${ notice.regDate }"
				pattern="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
			<td class="contentTh">비밀번호</td>
			<td class="contentTd"><input type="password" name="pass" id="pass"></td>
			<td class="contentTh">조회수</td>
			<td class="contentTd">${ notice.hits }</td>
		</tr>
		<tr>
			<td class="readContent" colspan="4">
				<pre>${ notice.content }</pre>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" value="수정하기"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />
			
			<c:if test="${ not searchOption }">
			&nbsp;&nbsp;<input type="button" value="목록보기"
				onclick="javascript:window.location.href=
					'noticeList?pageNum=${ pageNum }'"/>
			</c:if>
			
			<c:if test="${ searchOption }">
			&nbsp;&nbsp;<input type="button" value="목록보기"
				onclick="javascript:window.location.href=
				'noticeList?pageNum=${ pageNum }&type=${ type }&keyword=${keyword }'">
			</c:if>
			</td>
		</tr>
	</table>	
</article>