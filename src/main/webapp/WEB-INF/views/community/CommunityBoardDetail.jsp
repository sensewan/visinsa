<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String seid = (String) session.getAttribute("sessionID");
%>
<script src="resources/js/reply.js"></script>
<script src="resources/js/modal.js"></script>

<style type="text/css">
	#c_btn1 {
		margin-left: 80%;
	}
	
	.thumbnail {
		position: relative;
		padding-top: 100%; /* 1:1 ratio */
		overflow: auto;
	}
	
	img {
		position: relative;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		max-width: 80%;
		height: auto;
	}
	
	td, th {
		border: 1px solid black;
		border-left: hidden;
		border-right: hidden;
	}
	
	#counter {
		position: absolute;
		bottom: 52px;
		right: 8px;
		background: rgba(42, 229, 148, 0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em;
	}
	
	.div_page_title {
		width: 1200px;
		margin: 0 auto;
		margin-top: 10px;
	}
	
	.page_title {
		color: #5a5a5a;
		font-weight: bold;
		font-size: x-large;
		margin-left: 10px;
	}
	
	.div_page_title>hr {
		background-color: #5a5a5a;
		border: 0;
		height: 2px;
	}
	
	#table1 {
	    width: 70%;
	    margin-top: 10px;
	    margin-left: auto;
	    margin-right: auto;
	}
	.footer{
	    position: relative;
	}
	
	
	.btn-outline-secondary{
	    font-size: smaller;
	    padding: 5px;
	}
	
	#replyTable {
		width: 880px;
		margin: 10px auto;
	}
	
	#replyTable td{
		border-bottom: grey;
	}
	
	.replyUser {
		width: 880px;
	}
	.replyUser > span {
		display: inline-block;
	}
	.replyUser > .member {
		width: 300px;
	}
	.replyUser > .reply_date {
		width: 420px;
	}
	
	#replyForm {
		display: none;
	
	}
	
	input[id="menuicon"] {
		display:none;
	}
	input[id="menuicon"] + label {
		display:block;
		width:60px;
		height:40px;
		position:relative;
		cursor:pointer;
	}
	input[id="menuicon"] + label span {
		display:block;
		position:absolute;
		width:100%;
		height:5px;
		border-radius:30px;
		background:#000;
		transition:all .35s;
	}
	input[id="menuicon"] + label span:nth-child(1) {
		top:0;
	}
	input[id="menuicon"] + label span:nth-child(2) {
		top:50%;
		transform:translateY(-50%);
	}
	input[id="menuicon"] + label span:nth-child(3) {
		bottom:0;
	}
	
	input[id="menuicon"]:checked + label span:nth-child(1) {
		top:50%;
		transform:translateY(-50%) rotate(45deg);
	}
	input[id="menuicon"]:checked + label span:nth-child(2) {
		opacity:0;	
	}
	input[id="menuicon"]:checked + label span:nth-child(3) {
		bottom:50%;
		transform:translateY(50%) rotate(-45deg);	
	}
	
	input[id="menuicon"] {display:none;}
	input[id="menuicon"] + label {display:block;margin:30px;width:60px;height:50px;position:relative;cursor:pointer;}
	input[id="menuicon"] + label span {display:block;position:absolute;width:100%;height:5px;border-radius:30px;background:#000;transition:all . 35s;}
	input[id="menuicon"] + label span:nth-child(1) {top:0;}
	input[id="menuicon"] + label span:nth-child(2) {top:50%;transform:translateY(-50%);}
	input[id="menuicon"] + label span:nth-child(3) {bottom:0;}
	input[id="menuicon"]:checked + label {z-index:2;}
	input[id="menuicon"]:checked + label span {background:#fff;}
	input[id="menuicon"]:checked + label span:nth-child(1) {top:50%;transform:translateY(-50%) rotate(45deg);}
	input[id="menuicon"]:checked + label span:nth-child(2) {opacity:0;}
	input[id="menuicon"]:checked + label span:nth-child(3) {bottom:50%;transform:translateY(50%) rotate(-45deg);}
	
	
	div[class="sidebar"] {
		width:200px;
		height:100%;
		background:white;
		position:fixed;
		top:0;
		left:-300px;
		z-index:1;
		transition:all .35s;
		margin-top:20%;
		text-align:center;
		
	}
	input[id="menuicon"]:checked + label + div {
		left:0;
	}
	
</style>
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

	<input type="checkbox" id="menuicon">
	<label for="menuicon">
		<span></span>
		<span></span>
		<span></span>
	</label>
	<div class="sidebar">
		<p style="line-height:250%;">
		<br/>
		<button type="button" name="category" id="" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">전체 게시판</button><br/><br/>
		<button type="button"  name="category" id="board" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">자유 게시판</button><br/><br/>
		<button type="button"  name="category" id="qna" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">Q&A 게시판</button><br/><br/>
		<button type="button"  name="category" id="chuchu" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">추천 게시판</button><br/>
		</p>
	</div>
	<div class="wrap" style="display: ; margin-left:5%;">
		<table class="table table-hover" id="table1">
			<tr class="table-secondary">
				<td colspan="4" class="boardTitle" style="text-align:center;"><h2>QnA 상세보기</h2></td>
			</tr>
			
			<tr>
				<td colspan="4"></td>
			</tr>
			<tr>
				<td class="table-info">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="contentTdSpan" colspan="3">${ board.title }</td>		
			</tr>
			
			<tr>
				<td class="table-info">글쓴이</td>
				<td class="contentTd">${ board.id }</td>
				<td class="table-info">작성일</td>
				<td class="contentTd"><fmt:formatDate value="${ board.regdate }" 
					pattern="yyyy-MM-dd HH:mm:ss" /></td>		
			</tr>
			<tr>		
				<td class="table-info">조회수</td>
				<td class="contentTd">${ board.readcount }</td>
			</tr>
			
			<tr>		
				<td class="readContent" colspan="4" style="border: none; font-size:larger;">
					<pre>${ board.content }</pre>
				</td>
			</tr>	
			
			
			<tr>
				<td colspan="4" style="text-align: center; border: none; border-bottom: double; border-bottom-color: aquamarine;">
					<c:if test="${board.id == member.id}">
			  			<input type="button" id="detailUpdate" value="수정하기" class="btn btn-primary btn-lg" />
						&nbsp;&nbsp;
						<input type="button" id="detailDelete" class="btn btn-primary btn-lg" value="삭제하기" />
					</c:if>			
				
					
					<!-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려보낸다. -->
					<c:if test="${ not searchOption }">		
						&nbsp;&nbsp;<input type="button" value="목록보기" class="btn btn-primary btn-lg" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }'"/>
					</c:if>
					
					<!-- 검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. -->
					<c:if test="${ searchOption }">
						&nbsp;&nbsp;<input type="button" value="목록보기" class="btn btn-primary btn-lg" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
						<!-- 
							위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
							않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
						-->		
					</c:if>			
					
					<span id="commend" style="margin-left:100px;">
						<img src="resources/images/recommend.png" alt="추천하기" />좋아요 !
						<span class="recommend" >(${ board.recommend })</span>
					</span>		
				</td>
			</tr>
			
			<!-- 댓글 리스트 출력 부분 -->
			<tr>
				<td colspan="4" class="replyHeader" style="text-align: center;">
					<div id="recommend" style="text-align: right">	
						<span id="replyWrite" class="badge badge-pill badge-warning" style="cursor: pointer;" >
							&nbsp;댓글쓰기
						</span>					
					</div>
					<div id="replyTitle"><h3>댓글 리스트</h3></div>
				</td>
			</tr>
			<c:if test="${ empty replyList }" >
			<tr id="replyList">
				<td colspan="4">
					<div id="notReply">
						댓글이 존재하지 않습니다.  
					</div>			
				</td>
			</tr>
			</c:if>
			<c:if test="${ not empty replyList }" >
			<tr id="replyList">
				<td colspan="4" style="border-top: double; border-top-color: aquamarine;">		
				<table id="replyTable">
					<c:forEach var="reply" items="${ replyList }" >
						<tr id="reply_${ reply.no }">
							<td>									
							<div class="replyUser">						
								<span class="member">작성자: &nbsp;&nbsp;${ reply.replyid }
									<c:if test="${reply.replymedic == 1 || reply.replymedic == 2}">
										<button type="button"  name="openModalBtn" id="openModalBtn" class="btn btn-primary btn-lg openModalBtn" 
										style="width:150px; height:50px;" data-toggle="modal" data-target="#myModal">위치보기</button><br/>
											<div id="modalBox" class="modal fade" id="MyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
						  						<div class="modal-dialog" role="document">
											    <div class="modal-content">
											      <div class="modal-header">
											        <h5 class="modal-title">${reply.replybusinessName }</h5>
											        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
											          <span aria-hidden="true"></span>
											        </button>
											      </div>
											      <div class="modal-body">
											      	<p>${reply.replybusinessAdd }
											      	</p>
											      </div>
											      <div class="modal-footer">
											        <button type="button" class="btn btn-primary" id="closeModalBtn">확인</button>
											      </div>
											    </div>
											  </div>
											</div>
									</c:if>
									

					
								</span>	
				
								<span class="reply_date">
									<fmt:formatDate value="${ reply.replydate}" 
										pattern="yyyy-MM-dd HH:mm:ss" /></span>
								<c:if test="${ reply.replyid == member.id}">
									<a href="#" class="modifyReply" data-no="${ reply.no }">
									<img src="resources/images/addreply.png" alt="댓글 수정하기"/></a>&nbsp;&nbsp;&nbsp;
									<a href="#" class=deleteReply data-no="${ reply.no }">
									<img src="resources/images/deletereply.png" alt="댓글 삭제하기"/></a>
								</c:if> 
							</div>	
							<div class="replyContent" id="div_${ reply.no }">
								<pre style="margin-top: 5px"><span>${ reply.replyContent }</span></pre>
							</div>
							
						<div id="replyrecommend">
							<span id="replycommend" class="replycommend" style="cursor: pointer;"  data-no="${ reply.no }">
								<img src="resources/images/replyrecommend.png" alt="추천하기" />&nbsp;추천
								<span class="replyrecommend" >(${ reply.replyrecommend })</span>
							</span>
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
					
					<input type="hidden" name="replyid" value="${ sessionScope.member.id }" />
					<input type="hidden" name="replymedic" value="${sessionScope.member.medic }" />
					<input type="hidden" name="replybusinessName" value="${sessionScope.member.businessName }" />
					<input type="hidden" name="replybusinessAdd" value="${sessionScope.member.businessAdd }" />
					
					<table id="replyWriteTable" style="text-align: center;">
						<tr>
							<td id="replyWriteTitle" colspan="2" style="border-bottom: hidden; border-top: 1px dashed mediumseagreen;">
								<span>댓글은 마음의 창입니다.</span>
							</td>
						</tr>
						<tr>
							<td id="replyWriteContent" style="border-bottom: hidden;">
								<textarea name="replyContent" id="replyContent" rows="4" cols="100"></textarea>
							</td>
							<td id="replyWriteImage" style="border-bottom: hidden;">						
								<input type="image" src="image/reply_btn_write.gif" 
									id="replyWriteButton" alt="댓글 입력" />
							</td>
						</tr>
					</table>
				</form>	
			</div>	
	
	</div>

</article>