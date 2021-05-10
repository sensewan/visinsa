<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<article>
<form name="writeForm" action="CommunitywriteProcess" id="writeForm" 
	method="post" enctype="multipart/form-data">
<input type="hidden" id="id" name="id" value="${member.id}">
<input type="hidden" id="medic" name="medic" value="${member.medic}">	
	
	<table class="table table-bordered" style="margin-left: auto; margin-right: auto; text-align:left;">
		<tr>
			<td colspan="4" class="boardTitle">
				<h2>게시 글 쓰기</h2>
			</td>
		</tr>	
		
		<tr>
			<td class="readTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			<td class="readTd" colspan=3 >
				<input type="text" name="title" size="90" id="title" maxlength="50" style="margin-left:100px; width:450px;"/>
			</td>
		</tr>			
		<tr>
			<td class="readTh">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			<td class="readTd" colspan="3">
				<textarea name="content" id="content" rows="20" cols="80" style="margin-left:100px; width:450px;"></textarea>
			</td>
		</tr>	
	
		<tr>
			<td class="readTh" colspan="4">&nbsp;
			<p style="margin-left:20%;">게시할 곳 : 
				<input type="radio" value="board" name="category" id="category" checked> 자유게시판
				<input type="radio" value="qna" name="category" id="category" > Q&A 게시판
				<c:if test="${member.medic != 0}">
				<input type="radio" value="chuchu" name="category" id="category" > 추천게시판
				<p>
				</c:if></td>
		</tr>
		<tr>
			<td colspan="4" class="tdSpan" >
			<p style="margin-left:20%;">
							<button type="reset" class="btn btn-primary btn-lg" value="다시쓰기">다시쓰기</button>
				&nbsp;&nbsp;<button type="submit" class="btn btn-primary btn-lg" value="등록하기">등록하기</button>
				&nbsp;&nbsp;<button type="button" class="btn btn-primary btn-lg" value="목록보기" 
					onclick="javascript:window.location.href='CommunityBoardList'">목록보기</button>
					<p>
		</tr>
	</table>
</form>
</article>