<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- <script src = "resources/js/formcheck.js"></script> -->
<article>
<div style="width:1080px;margin-left: auto; margin-right: auto;">
	<form name="checkForm" id="checkForm" style="text-align:center; margin-left: auto; margin-right: auto;">
		<input type="hidden" name="no" id="no" value="${ notice.no }"/>
		<input type="hidden" name="pass" id="rPass"/>
		<input type="hidden" name="pageNum" value="${ pageNum }" />
		
		<c:if test="${ searchOption }">
			<input type="hidden" name="type" value="${ type }" />
			<input type="hidden" name="keyword" value="${ word }" />
		</c:if>
	</form>	
	<table class="table table-bordered" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td colspan="4" class="boardTitle">
			<h2>${ notice.title }</h2>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		
		<tr>
			<td class="contentTh">작성자</td>
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
			<button type="button" class="btn btn-outline-primary" id="noticeUpdate" value="수정하기">수정하기</button>
			&nbsp;&nbsp;<button type="button" class="btn btn-outline-primary" id="noticeDelete" value="삭제하기">삭제하기</button>
			
			<c:if test="${ not searchOption }">
			&nbsp;&nbsp;<button type="button" class="btn btn-outline-primary" value="목록보기"
				onclick="javascript:window.location.href=
					'noticeList?pageNum=${ pageNum }'">목록보기</button>
			</c:if>
			
			<c:if test="${ searchOption }">
			&nbsp;&nbsp;<button type="button" class="btn btn-outline-primary" value="목록보기"
				onclick="javascript:window.location.href=
				'noticeList?pageNum=${ pageNum }&type=${ type }&keyword=${keyword }'">목록보기</button>
			</c:if>
			</td>
		</tr>
	</table>
	</div>	
</article>