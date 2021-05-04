<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String seid = (String) session.getAttribute("sessionID");
%>
<script src="resources/js/reply.js"></script>
<article>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="no" value="${ board.no }"/>	
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
		<td class="contentTd" colspan="3">${ board.title }</td>		
	</tr>
	<tr>
		<td class="contentTh">글쓴이</td>
		<td class="contentTd">${ board.id }</td>
		<td class="contentTh">작성일</td>
		<td class="contentTd"><fmt:formatDate value="${ board.regdate }" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>		
	</tr>
	<tr>		
		<td class="contentTh">조회수</td>
		<td class="contentTd">${ board.readcount }</td>
	</tr>	
	<tr>		
		<td class="readContent" colspan="4">
			<pre>${ board.content }</pre>
		</td>
	</tr>	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" value="수정하기"/>
			&nbsp;&nbsp;
			<c:if test="${board.id == member.id}">
			<input type="button" id="detailDelete" value="삭제하기" />
			</c:if>			
			<%-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려 보낸다. --%>
			<c:if test="${ not searchOption }">		
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }'"/>
			</c:if>
			<%-- 
				검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. 
			--%>
			<c:if test="${ searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
				<%-- 
					위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
					않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
				--%>		
			</c:if>				
		</td>
	</tr>
	

	<tr>
		<td colspan="4" class="replyHeader">
		<div id="recommend">
			<span id="commend">
				<img src="resources/images/recommend.png" alt="추천하기" />&nbsp;추천
				<span class="recommend" >(${ board.recommend })</span>
			</span> |
			<span id="replyWrite">
				&nbsp;댓글쓰기
			</span>					
		</div>
		<div id="replyTitle"><h3>이 글에 대한 댓글 리스트</h3></div>
		</td>
	</tr>
	<c:if test="${ empty replyList }" >
	<tr id="replyList">
		<td colspan="4">
		<div id="notReply">
			이 게시 글에 대한 댓글이 존재하지 않습니다.  
		</div>			
		</td>
	</tr>
	</c:if>
	<c:if test="${ not empty replyList }" >
	<tr id="replyList">
		<td colspan="4">		
		<table id="replyTable">
			<c:forEach var="reply" items="${ replyList }" >
			<tr id="reply_${ reply.no }">
				<td>									
				<div class="replyUser">						
					<span class="member">${ reply.replyid }</span>	
				</div>
				<div class="replyModify">
					<span class="reply_date">
						<fmt:formatDate value="${ reply.replydate}" 
							pattern="yyyy-MM-dd HH:mm:ss" /></span>
					<a href="#" class="modifyReply" data-no="${ reply.no }">
						<img src="resources/images/reply_btn_modify.gif" alt="댓글 수정하기"/></a>
					<a href="#" class=deleteReply data-no="${ reply.no }">
						<img src="resources/images/reply_btn_delete.gif" alt="댓글 삭제하기"/></a>
						
						
						<div id="replyrecommend">
							<span id="replycommend" class="replycommend" style="cursor: pointer;"  data-no="${ reply.no }">
								<img src="resources/images/replyrecommend.png" alt="추천하기" />&nbsp;추천
								<span class="replyrecommend" >(${ reply.replyrecommend })</span>
							</span>
						</div>
						
				</div>	
				<div class="replyContent" id="div_${ reply.no }">
					<pre><span>${ reply.replyContent }</span></pre>
				</div>
				</td>
			</tr>	
			
			</c:forEach>
		</table>				
		</td>
	</tr>	
	</c:if>
	</table>	
	<div id="replyForm">
		<form name="replyWriteForm" id="replyWriteForm">				
			<input type="hidden" name="bbsNo" value="${ board.no }"/>
			<input type="hidden" name="replyid" 
				value="${ sessionScope.member.id }" />			
			<c:if test="${ sessionScope.isLogin == true }">
			<table id="replyWriteTable">
				<tr>
					<td id="replyWriteTitle" colspan="2">
						<span>악의적인 댓글은 예고 없이 삭제될 수 있으며 글쓰기 제한과 아이디 삭제 처리됩니다.</span>
					</td>
				</tr>
				<tr>
					<td id="replyWriteContent">
						<textarea name="replyContent" id="replyContent" rows="4"></textarea>
					</td>
					<td id="replyWriteImage">						
						<input type="image" src="resources/images/reply_btn_write.gif" 
							id="replyWriteButton" alt="댓글 입력" />
					</td>
				</tr>
			</table>
			</c:if>
		</form>	
	</div>	
</article>