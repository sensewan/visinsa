<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<form name="writeForm" action="CommunitywriteProcess" id="writeForm" 
	method="post" enctype="multipart/form-data">
<input type="hidden" id="nickName" name="nickName" value="${member.nickName}">
<input type="hidden" id="medic" name="medic" value="${member.medic}">	
	
	<table class="readTable">
		<tr>
			<td colspan="4" class="boardTitle">
				<h2>게시 글 쓰기</h2>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td class="readTh"> 
				게시할 곳 : 
				<input type="radio" value="board" name="category" id="category" checked> 자유게시판
				<input type="radio" value="qna" name="category" id="category" > Q&A 게시판
				<input type="radio" value="chuchu" name="category" id="category" > 추천게시판
				
			</td>
			
		</tr>		
		<tr>
			<td class="readTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			<td class="readTd" colspan=3>
				<input type="text" name="title" size="90" id="title" maxlength="50"/>
			</td>
		</tr>			
		<tr>
			<td class="readTh">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			<td class="readTd" colspan="3">
				<textarea name="content" id="content" rows="20" cols="80"></textarea>
			</td>
		</tr>	
		
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="tdSpan"><input type="reset" value="다시쓰기"/>
				&nbsp;&nbsp;<input type="submit" value="등록하기" />
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href='CommunityBoardList'"/></td>
		</tr>
	</table>
</form>
</article>