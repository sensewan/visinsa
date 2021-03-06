<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="resources/js/reply.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ff8e46244db2f93a41ed12dafcdd41e5&libraries=services"></script>

<style>
	
	.disTab{
		margin: 0px auto;
		width: 100%;
		height: 600px;
		overflow: auto;
	}
	
	#table1 {
            width: 100%;
            margin-left: auto;
            margin-right: auto;
            /* background-color: rgba( 255, 255, 255, 1 ); */
        }
       
    .text-muted{
    	display: inline-block;
    	position: relative;
    	text-align: right;
    	margin-top:5px;
    	left : 10px
     }   
	
	.modal{
		margin-top:50px;
	}
	
	.modal-content{
		width:800px;
	}
	
	.content_info{
		width:1200px;
		margin: 0 auto;
	}
	
	.content_wrap{
		margin-top: 80px;
	}
	
	.content{
		height:600px;
	}
	
	.content::after{
		opacity : 0.8;
		height: 600px;
	}
	.div_page_title{
		width:1200px;
		margin: 0 auto;
		margin-top : 10px;
		
	}
	
	.page_title{
		color: #5a5a5a;
    	font-weight: bold;
    	font-size: x-large;
    	margin-left : 10px;
	}
	
	.div_page_title > hr{
		background-color: #5a5a5a;
	    border: 0;
	    height: 2px;
	}
	
</style>

<article>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="no" value="${ board.no }"/>
	<input type="hidden" name="pass" id="rPass" />
	<input type="hidden" name="pageNum" value="${ pageNum }" />	
	<%-- 
		검색 리스트에서 들어온 요청일 경우 다시 keyword에 해당하는 
		검색 리스트로 돌려보내기 위해서 아래의 파라미터가 필요하다.
	 --%>
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
		<td class="contentTd">${ board.writer }</td>
		<td class="contentTh">작성일</td>
		<td class="contentTd"><fmt:formatDate value="${ board.regDate }" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>		
	</tr>
	<tr>		
		<td class="contentTh">비밀번호</td>
		<td class="contentTd"><input type="text" name="pass" id="pass"></td>
		<td class="contentTh">조회수</td>
		<td class="contentTd">${ board.readCount }</td>
	</tr>	
	<tr>
		<td class="contentTh">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
		<td class="contentTd" colspan="3">
		<c:if test="${ empty board.file1 }">
			첨부파일 없음
		</c:if>
		<c:if test="${ not empty board.file1 }">
			<a href="fileDownload?fileName=${ board.file1 }">file1 다운로드</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="fileDownload?fileName=${ fileName }">fileName 다운로드</a>
		</c:if>
		</td>		
	</tr>
	<tr>		
		<td class="readContent" colspan="4">
			<pre>${ board.content }</pre>
			<img alt="그림" src="resources/upload/601e6cfb-e7fc-4c8e-8061-9c6d43dc86ff_vi1.png" />
		</td>
	</tr>	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	
<!-- 	
	지도테스트1
	<tr>
		<td>
		<a href="#" class="dept">지도지도</a>
		지도
			<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Modal title</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p>지도가 나와야 함</p>
							<div id="map" style="width:500px;height:400px;"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</td>		
		
	</tr>
	
	지도테스트2
	<tr>
		<td>
		<a href="#" class="dept">지도2</a>
		지도
			<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Modal title</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p>지도가 나와야 함</p>
							<div id="map" style="width:500px;height:400px;"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</td>		
		
	</tr>
	 -->
	 
	 
	<!-- 지도테스트3 -->
	<tr>
		<td>
			<div id="map" style="width:500px;height:400px;">지도3</div>
		</td>		
		
	</tr>
	
	
	
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" value="수정하기"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />
			<%-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려 보낸다. --%>
			<c:if test="${ not searchOption }">		
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href=
						'boardList?pageNum=${ pageNum }'"/>
			</c:if>
			<%-- 
				검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. 
			--%>
			<c:if test="${ searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href=
						'boardList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
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
			<span id="thank">
				<img src="resources/images/smile.png" alt="땡큐"/>&nbsp;땡큐
				<span class="recommend">(${ board.thank })</span>
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
					<span class="member">${ reply.replyWriter }</span>	
				</div>
				<div class="replyModify">
					<span class="reply_date">
						<fmt:formatDate value="${ reply.regDate}" 
							pattern="yyyy-MM-dd HH:mm:ss" /></span>
					<a href="#" class="modifyReply" data-no="${ reply.no }">
						<img src="resources/images/reply_btn_modify.gif" alt="댓글 수정하기"/></a>
					<a href="#" class=deleteReply data-no="${ reply.no }">
						<img src="resources/images/reply_btn_delete.gif" alt="댓글 삭제하기"/></a>
					<a href="javascript:reportReply('${ reply.no }')">
						<img src="resources/images/reply_btn_notify.gif" alt="신고하기"/></a>
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
			<input type="hidden" name="replyWriter" 
				value="${ sessionScope.member.id }" />			
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
		</form>	
	</div>
	
</article>

<script>
	
<%-- 모달 레이어 팝업 --%>


	   
   var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
   var options = { //지도를 생성할 때 필요한 기본 옵션
		   center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
		   level: 3 //지도의 레벨(확대, 축소 정도)
   };

   var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	
   
</script>