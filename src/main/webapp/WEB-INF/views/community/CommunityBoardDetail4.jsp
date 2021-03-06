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
		width:300px;
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
		<button type="button" name="category" id="" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">?????? ?????????</button><br/><br/>
		<button type="button"  name="category" id="board" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">?????? ?????????</button><br/><br/>
		<button type="button"  name="category" id="qna" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">Q&A ?????????</button><br/><br/>
		<button type="button"  name="category" id="chuchu" class="categoryFilter btn btn-primary btn-lg" style="width:150px;">?????? ?????????</button><br/>
		</p>
	</div>
	<div class="jumbotron" style="margin-left:20%; margin-right:10%; margin-top:0%">
  <h1 class="display-3">?????? : ${ board.title }</h1>
  <p class="lead">	????????? : ${board.id}<br/>
  					????????? : ${ board.regdate }<br/>
  					?????? ??? : ${ board.readcount } 
  					</p>
  <hr class="my-4">
  <p>${ board.content }</p>
  <p class="lead">
  		<c:if test="${board.id == member.id}">
  			<input type="button" id="detailUpdate" value="????????????" class="btn btn-primary btn-lg" />
			&nbsp;&nbsp;
			<input type="button" id="detailDelete" class="btn btn-primary btn-lg" value="????????????" />
		</c:if>			
		<c:if test="${ not searchOption }">	&nbsp;&nbsp;	
				<input type="button" value="????????????" class="btn btn-primary btn-lg" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }'"/>
		</c:if>
		<c:if test="${ searchOption }">&nbsp;&nbsp;
				<input type="button" value="????????????" class="btn btn-primary btn-lg" 
					onclick="javascript:window.location.href=
						'CommunityBoardList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
		</c:if>	
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span id="commend">
				<img src="resources/images/recommend.png" alt="????????????" />&nbsp;??????
				<span class="recommend" >(${ board.recommend })</span>
			</span>				

  </p>
  <table class="contentTable" style="text-align:left;">
	<tr >
		<td colspan="4" class="replyHeader">
		<div id="replyTitle" ><h3>?????? ?????????</h3></div>
		</td>
	</tr>
	<c:if test="${ empty replyList }" >
	<tr id="replyList">
		<td colspan="4">
		<div id="notReply">
			??? ?????? ?????? ?????? ????????? ???????????? ????????????.  
		</div>			
		</td>
	</tr>
	</c:if>
	<c:if test="${ not empty replyList }" >
	<tr id="replyList">
		<td colspan="4">		
		<table id="replyTable">
			<c:forEach var="reply" items="${ replyList }" >
			<tr id="reply_${ reply.no }" style="border-color: white; border-top:1px dashed;">
				<td>									
				<div class="replyUser">		
					<span class="member">????????? : ${ reply.replyid }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
						<c:if test="${reply.replymedic == 1 || reply.replymedic == 2}">
							<button type="button"  name="openModalBtn" id="openModalBtn" class="btn btn-primary btn-lg openModalBtn" 
							style="width:150px; height:50px;" data-toggle="modal" data-target="#myModal">????????????</button><br/>
						</c:if>
					</span>	
					
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
					        <button type="button" class="btn btn-primary" id="closeModalBtn">??????</button>
					      </div>
					    </div>
					  </div>
					</div>


					
					
				</div>
				<div class="replyModify">
					<span class="reply_date">
						???????????? : <fmt:formatDate value="${ reply.replydate}" 
							pattern="yyyy-MM-dd HH:mm:ss" /></span>

						
						
						<div id="replyrecommend">
							<span id="replycommend" class="replycommend" style="cursor: pointer;"  data-no="${ reply.no }">
								<img src="resources/images/replyrecommend.png" alt="????????????" />&nbsp;??????
								<span class="replyrecommend" >(${ reply.replyrecommend })</span>
							</span>
						</div>
						
				</div>	
				<div class="replyContent" id="div_${ reply.no }">
					<pre><span><br/>${ reply.replyContent }</span></pre>
				</div>
				<div>
					<c:if test="${reply.replyid == member.id }">	<br/>
						<a href="#" class="modifyReply" data-no="${ reply.no }">
						<img src="resources/images/addreply.png" alt="?????? ????????????"/></a>
						<a href="#" class=deleteReply data-no="${ reply.no }">
						<img src="resources/images/deletereply.png" alt="?????? ????????????"/></a>
					</c:if>
				</div>
				<br/>
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
			
			
			
			
			
			<c:if test="${ sessionScope.isLogin == true }">
			<table id="replyWriteTable">
				<tr>
					<td id="replyWriteTitle" colspan="2">
						<span>???????????? ????????? ?????? ?????? ????????? ??? ????????? ????????? ????????? ????????? ?????? ???????????????.</span>
					</td>
				</tr>
				<tr>
					<td id="replyWriteContent">
						<textarea name="replyContent" id="replyContent" rows="4"></textarea>
					</td>
					<td id="replyWriteImage">						
						<input type="image" src="resources/images/reply_btn_write.gif" 
							id="replyWriteButton" alt="?????? ??????" />
					</td>
				</tr>
			</table>
			</c:if>
		</form>	
</div>
	</div>	
	<!-- ?????? ??? -->
	


</article>