<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="resources/js/formcheck.js"></script>
<style type="text/css">

	.leftnav {
		list-style-type: none;
		background-color: #ccc;
		width: 25%;
		padding: 0;
		margin:  0;
		margin-top: 80%;
		position: fixed;
		height: 100%;
		overflow: auto;
	}

	li a {
		text-decoration: none;
		display: block;
		color: #000;
		padding: 8px 15px 8px 15px;
		font-weight: bold;
	}

	li a.communitycategory {
		background-color: tomato;
		color: #fff;
	}

	li a:hover:not(.communitycategory) {
		background-color: #333;
		color: #fff;
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
	<form name="categoryForm" id="categoryForm" action="CommunityBoardList">
		<input type="hidden" name="category" id="catfilter" >
	</form>
<article class="body">
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

<div style="width:1080px;margin-left:25%;">
<h2 style="font-color:blue;">게시 글 리스트</h2>
<table class="table table-hover" style="margin-left: 0px;">

	<%-- 검색 요청일 경우만 아래를 화면에 표시 한다. --%>
	<c:if test="${ searchOption }">
	<tr>
		<td colspan="5" id="searchComment">
			"${ keyword  }" 검색 결과</td>
	</tr>
	<tr>
		<%-- 검색 요청일 경우 일반 게시 글 리스트로 이동할 수 있도록 링크를 설정했다. --%>
		<td colspan="2" class="boardListLink"><a href="CommunityBoardList">리스트</a></td>
		<c:if test="${ sessionScope.isLogin == true }">
		<td colspan="3" class="listWrite"><a href="writeForm">글쓰기</a></td>
		</c:if>
	</tr>	
	</c:if>
	<c:if test="${ not searchOption }">
	<tr>			
		<c:if test="${ sessionScope.isLogin == true}">
		<td colspan="3" class="listWrite"><a href="writeForm">글쓰기</a></td>
		</c:if>
	</tr>
	</c:if>
	<tr>
		<th class="listThNo">NO</th>
		<th class="listThNo">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
		<th class="listThTitle">제목</th>
		<th class="listThWriter">작성자</th>
		<th class="listThRegDate">작성일</th>
		<th class="listThReadCount">조회 수</th>
		<th class="listThReadCount">추천 수</th>
	</tr>
<%-- 
	검색 요청 이면서 검색된 리스트가 존재할 경우
	게시 글 상세보기로 링크를 적용할 때 type과 keyword 
	파라미터를 적용해 링크를 설정한다. 
--%>	
<c:if test="${ searchOption and not empty CommunityBoardList }">
	<c:forEach var="b" items="${ CommunityBoardList }" varStatus="status">		
	<tr class="listTr">
		<td class="listTdNo">${ b.no  }</td>
		<c:if test="${b.medic == 0 }">
		<td class="listTdNo"></td>
		</c:if>
		<c:if test="${b.medic == 1 }">
		<td class="listTdNo"><img src="resources/images/doctor.png"></td>
		</c:if>
		<c:if test="${b.medic == 2 }">
		<td class="listTdNo"><img src="resources/images/druggist.png"></td>
		</c:if>
		
		<td class="listTdTitle">
			<%--  
			/* IE에서 링크로 요청 시 파라미터에 한글이 포함되면 IE는 URLEncoding을
			 * 하지 않고 서버로 전송하는데 톰캣 7.06x 버전에서 정상적으로 동작하던
			 * 것이 7.07x 버전에서는 Invalid character found in the request 
			 * target 이라는 에러가 발생한다. 이 문제를 해결하기 위해 Service에서
			 * keyword를 java.net 패키지의 URLEncoder 클래스를 이용해 
			 * URLEncoding을 처리하였다.
			 * 크롬 브라우저는 링크로 요청 시 파라미터에 한글이 포함되어 있으면 브라우저 
			 * 주소창에는 한글 그대로 표시되지만 UTF-8로 URLEncoding을 해준다.
			 **/
			--%>			
			<a href="CommunityBoardDetail?no=${ b.no }&pageNum=${ currentPage }&category=${ b.category }
				&type=${ type }&keyword=${ keyword }">${ b.title }</a>
		</td>
		<td class="listTdWriter">${ b.id }</td>
		<td class="listTdRegDate"><fmt:formatDate value="${ b.regdate }" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>
		<td class="listTdReadCount">${ b.readcount }</td>
		<td class="listTdReadCount">&nbsp;&nbsp;${b.recommend }</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="5">

		 	<c:if test="${ startPage > pageGroup }">
				<a href="CommunityBoardList?pageNum=${ startPage - pageGroup }&category=${ category }
					&type=${ type }&keyword=${ keyword }">[이전]</a>
			</c:if>	
			<%--
			/* 현재 페이지 그룹의 startPage 부터 endPage 만큼 반복하면서
		 	 * 현재 페이지와 같은 그룹에 속한 페이지를 화면에 출력하고 링크를 설정한다.
		 	 * 현재 페이지는 링크를 설정하지 않는다.
		 	 **/
		 	--%>
			<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
				<c:if test="${ i == currentPage }">
					[ ${ i } ]
				</c:if>			
				<c:if test="${ i != currentPage }">
					<a href="CommunityBoardList?pageNum=${ i }&type=${ type }&category=${ category }
						&keyword=${ keyword }">[ ${ i } ]</a>
				</c:if>			
			</c:forEach>
			<%-- 
			/* 현재 페이지 그룹의 마지막 페이지가 전체 페이지 보다 작다는 것은
			 * 다음 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
			 * pageGroup을 플러스 하여 링크를 설정하면 다음 페이지 그룹의
			 * startPage로 이동할 수 있다.
		 	 **/
		 	 --%>
			<c:if test="${ endPage < pageCount }">
				<a href="CommunityBoardList?pageNum=${ startPage + pageGroup }&category=${ category }
					&type=${ type }&keyword=${ keyword }">[다음]</a>
			</c:if>		
		</td>
		
		<td colspan="5">
			<form name="searchForm" id="searchForm" >
				<select name="type" id="type">						
					<option value="title">제목</option>
					<option value="id">아이디</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="keyword" id="keyword" />
				<input type="submit" value="검색" />
			</form>
		</td>
		
	</tr>
</c:if>	
<%-- 
	일반 게시 글 리스트 요청 이면서 게시 글 리스트가 존재할 경우
	게시 글 상세보기로 링크를 적용할 때 type과 keyword 
	파라미터는 필요 없다. 
--%>	
<c:if test="${ not searchOption and not empty CommunityBoardList }">
	<c:forEach var="b" items="${ CommunityBoardList }" varStatus="status">		
	<tr class="listTr">
		<td class="listTdNo">${ b.no  }</td>
		<c:if test="${b.medic == 0 }">
		<td class="listTdNo"></td>
		</c:if>
		<c:if test="${b.medic == 1 }">
		<td class="listTdNo"><img src="resources/images/doctor.png"></td>
		</c:if>
		<c:if test="${b.medic == 2 }">
		<td class="listTdNo"><img src="resources/images/drug.png"></td>
		</c:if>
		
		<td class="listTdTitle">
			<a href="CommunityBoardDetail?no=
				${ b.no }&pageNum=${ currentPage }&category=${ b.category }" >${ b.title }</a>
		</td>
		<td class="listTdWriter">${ b.id }</td>
		<td class="listTdRegDate"><fmt:formatDate value="${ b.regdate }" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>
		<td class="listTdReadCount">&nbsp;&nbsp;${ b.readcount }</td>
		<td class="listTdReadCount">&nbsp;&nbsp;${ b.recommend }</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="5" >
			<%--
			/* 현재 페이지 그룹의 시작 페이지가 pageGroup보다 크다는 것은
			 * 이전 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
			 * pageGroup을 마이너스 하여 링크를 설정하면 이전 페이지 그룹의
			 * startPage로 이동할 수 있다.
		 	 **/
		 	 --%>
		 	<c:if test="${ startPage > pageGroup }"> 
				<a href="CommunityBoardList?pageNum=${ startPage - pageGroup }">
					[이전]</a>
			</c:if>	
			<%--
			/* 현재 페이지 그룹의 startPage 부터 endPage 만큼 반복하면서
		 	 * 현재 페이지와 같은 그룹에 속한 페이지를 화면에 출력하고 링크를 설정한다.
		 	 * 현재 페이지는 링크를 설정하지 않는다.
		 	 **/
		 	--%>
			<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
				<c:if test="${ i == currentPage }">
					[ ${ i } ]
				</c:if>			
				<c:if test="${ i != currentPage }">
					<a href="CommunityBoardList?pageNum=${ i }">[ ${ i } ]</a>
				</c:if>			
			</c:forEach>
			<%-- 
			/* 현재 페이지 그룹의 마지막 페이지가 전체 페이지 보다 작다는 것은
			 * 다음 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
			 * pageGroup을 플러스 하여 링크를 설정하면 다음 페이지 그룹의
			 * startPage로 이동할 수 있다.
		 	 **/
		 	 --%>
			<c:if test="${ endPage < pageCount }">
				<a href="CommunityBoardList?pageNum=${ startPage + pageGroup }">
					[다음]</a>
			</c:if>		
		</td>
		
		<td colspan="5">
			<form name="searchForm" id="searchForm" >
				<select name="type" id="type">						
					<option value="title">제목</option>
					<option value="id">아이디</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="keyword" id="keyword" />
				<input type="submit" value="검색" />
			</form>
		</td>
		
	</tr>
</c:if>
<%-- 검색 요청이면서 검색된 리스트가 존재하지 않을 경우 --%>
<c:if test="${ searchOption and empty CommunityBoardList }">
	<tr>
		<td colspan="5" class="listTdSpan">
			"${ keyword }"가 포함된 게시 글이 존재하지 않습니다.</td>
	</tr>
</c:if>
<%-- 일반 게시 글 리스트 요청이면서 게시 글 리스트가 존재하지 않을 경우 --%>
<c:if test="${ not searchOption and empty CommunityBoardList }">
	<tr>
		<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
	</tr>
</c:if>
</table>
</div>

</article>



