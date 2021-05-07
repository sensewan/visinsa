<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="resources/js/formcheck.js"></script>
<article>
<form name="noticewriteForm" action="noticewriteProcess" id="noticewriteForm" 
	method="post">
	<table class="table table-bordered" style="margin-left: auto; margin-right: auto;">
		<tr>
			<td colspan="4" class="boardTitle">
				<h2>게시 글 쓰기</h2>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td class="readTh">작성자</td>
			<td class="readTd">
				<input type="text" name="writer" size="30" id="writer" maxlength="10"/>
			</td> 
			<td class="readTh">비밀번호</td>
			<td class="readTd">
				<input type="password" name="pass" size="30" id="pass" 
					maxlength="10"/>
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
			<td class=".radio-inline">
  				<input type="radio" name="state" id="inlineRadio1" value="1"> 필독 게시글
			</td>
			<td class=".radio-inline">
  				<input type="radio" name="state" id="inlineRadio2" value="2"> 공지 게시글
			</td>
			<td class=".radio-inline">
  				<input type="radio" name="state" id="inlineRadio3" value="0"> 일반 게시글
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="tdSpan"><input type="reset" value="다시쓰기"/>
				&nbsp;&nbsp;<input type="submit" value="등록하기" />
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href='noticeList'"/></td>
		</tr>
	</table>
</form>
</article>