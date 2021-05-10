<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <script src = "resources/js/formcheck.js"></script> -->
<article>
<div style="width:1080px;margin-left: auto; margin-right: auto;">
<form name="noticeupdateForm" id="noticeupdateForm" action="updateNotice"
	method="post">
	<input type="hidden" name="no" value="${ notice.no }" />
	<input type="hidden" name="pageNum" value="${ pageNum }" />
	
	<c:if test="${ searchOption }">
		<input type="hidden" name="type" value="${ type }" />
		<input type="hidden" name="keyword" value="${ word }" />
	</c:if>
<table class="table table-bordered" style="margin-left: auto; margin-right: auto; text-align:center;">
	<tr>
		<td colspan="4" class="boardTitle">
			<h2>게시 글 수정하기</h2>
		</td>
	</tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr>
		<th class="readTh">작성자</th>
		<td class="readTd">
			<input type="text" name="writer" id="writer" size="30" 
				maxlength="10" value="${ notice.writer }"/>
		</td>
		<th class="readTh">비밀번호</th>
		<td class="readTd">
			<input type="password" name="pass" id="pass" size="30" 
				maxlength="10" />
		</td>
	</tr>
	<tr>
		<th class="readTh">제&nbsp;&nbsp;목</th>
		<td class="readTd" colspan="3">
			<input type="text" name="title" id="title" size="50" 
				maxlength="50" value="${ notice.title }"/>
		</td>				
	</tr>
	<tr>
		<th class="form-group">내&nbsp;&nbsp;용</th>
		<td class="readTd" colspan="3">
			<textarea class="form-control" id="content" name="content" rows="20" 
				cols="80">${ notice.content } </textarea>
		</td>				
	</tr>
	<tr>
			<td colspan="4">&nbsp;</td></tr>
	<tr>
	<tr>	
		<td class="tdSpan" colspan="4">
			<button type="reset" class="btn btn-outline-primary" value="다시쓰기">다시쓰기</button>
			&nbsp;&nbsp;<button type="submit" class="btn btn-outline-primary" value="수정하기">수정하기</button>
			
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
</form>	
</div>		
</article>