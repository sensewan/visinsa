<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<article>
<div style="width:1080px;margin-left: auto; margin-right: auto;">
<table class="table .table-striped" style="text-align:center; margin-left: auto; margin-right: auto;">
	<tr>
		<td class="boardTitle" colspan="5">
			<h2>공 지 사 항</h2>
		</td>
	</tr>
	<tr>
		<td colspan="5">
			<form name="searchForm" id="noticeSearchForm">
				<select name="type" id="type">						
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="keyword" id="keyword" />
				<input type="submit" value="검색" />
			</form>
		</td>
	</tr>
	<%-- 검색 요청일 경우만 아래를 화면에 표시 한다. --%>
	<c:if test="${ searchOption }">
	<tr>
		<td colspan="5" id="searchComment">
			"${ word  }" 검색 결과</td>
	</tr>
	<tr>
		<%-- 검색 요청일 경우 일반 게시 글 리스트로 이동할 수 있도록 링크를 설정했다. --%>
		<td colspan="2" class="noticeListLink"><a href="noticeList">리스트</a></td>
	 	<td colspan="3" class="listWrite text-left"><a href="noticewriteForm">공지사항 작성</a></td>
	 	
	</tr>	
	</c:if>
	<c:if test="${ not searchOption }">
	<tr>			
		 <td colspan="5" class="listWrite text-left"><a href="noticewriteForm">공지사항 작성</a></td>
	</tr>
	</c:if>
	<tr class="table-primary">
		<th class="listThNo text-center"></th>
		<th class="listThTitle text-center ">제목</th>
		<th class="listThWriter text-center">작성자</th>
		<th class="listThRegDate text-center">작성일</th>
		<th class="listThHits text-center">조회수</th>
	</tr>
<%-- 
	검색 요청 이면서 검색된 리스트가 존재할 경우
	게시 글 상세보기로 링크를 적용할 때 type과 keyword 
	파라미터를 적용해 링크를 설정한다. 
--%>	
<c:if test="${ searchOption and not empty noticeList }">
<c:forEach var="n" items="${ noticeList }" varStatus="status">
   			<c:if test="${n.state == 1 }">
         		<tr class="container text-danger">
		            <td class="text-danger"><img src="resources/images/mustread.png"></td>
		            <td class="listTdTitle text-danger">
            			<a class="text-danger" href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }">${ n.title }</a>
         			</td>
         			<td class="listTdWriter text-danger">${ n.writer }</td>
         			<td class="listTdRegDate text-danger"><fmt:formatDate value="${ n.regDate }"
         				pattern="yyyy-MM-dd HH:mm:ss" /></td>
         			<td class="listTdHits text-danger">${ n.hits }</td>
         		</tr>
   			</c:if>
   			
   			<c:if test="${n.state == 2 }">
         		<tr class="container text-warning">
		            <td class="text-warning"><img src="resources/images/mustread.png"></td>
		            <td class="listTdTitle text-warning">
            			<a class="text-warning" href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }">${ n.title }</a>
         			</td>
         			<td class="listTdWriter text-warning">${ n.writer }</td>
         			<td class="listTdRegDate text-warning"><fmt:formatDate value="${ n.regDate }"
         				pattern="yyyy-MM-dd HH:mm:ss" /></td>
         			<td class="listTdHits text-warning">${ n.hits }</td>
         		</tr>
   			</c:if>
   
   			<c:if test="${n.state ==0 }">
         		<tr class="listTr">
		            <td class="listTdNo">일반</td>
		            <td class="listTdTitle">
            			<a href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }" >${ n.title }</a>
         			</td>
			         <td class="listTdWriter">${ n.writer }</td>
			         <td class="listTdRegDate"><fmt:formatDate value="${ n.regDate }"
			         	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			         <td class="listTdHits">${ n.hits }</td>
         		</tr>
   			</c:if>
   	</c:forEach>
	
	<tr>
	<td colspan="5" class="listPage">
		<nav aria-label="Page navigation example" style="width: 1080px; margin-top: 50px; margin-bottom: 50px;">
			<ul class="pagination justify-content-center">
		<c:if test="${ startPage > pageGroup }">
			<li class="page-item">
		   		<a class="page-link" href="noticeList?pageNum=${ startPage - pageGroup }">이전</a>
		   	</li>
		</c:if>
		
	<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
		<c:if test="${ i == currentPage }">
			<li class="page-item active"><span class="page-link">${ i }</span></li>
		</c:if>

		<c:if test="${ i != currentPage }">
			<li class="page-item"><a class="page-link" href="noticeList?pageNum=${ i }">${ i }</a></li>
		</c:if>
	</c:forEach>
	
	<c:if test="${ endPage < pageCount }">
			<li class="page-item">
		      <a class="page-link" href="noticeList?pageNum=${ startPage + pageGroup }">다음</a>
		    </li>
			</c:if>
				</ul>
			</nav>
				<pre>운영 원칙과 맞지 않는 글은 게시판 관리자에 의해 게시글 목록에서 제외될 수 있습니다.</pre>
		</td>
	</tr>
</c:if>	

<c:if test="${ not searchOption and not empty noticeList }">
	
	
		<c:forEach var="n" items="${ noticeList }" varStatus="status">
   			<c:if test="${n.state == 1 }">
         		<tr class="container text-danger">
		            <td class="text-danger"><img src="resources/images/mustread.png"></td>
		            <td class="listTdTitle text-danger">
            			<a class="text-danger" href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }">${ n.title }</a>
         			</td>
         			<td class="listTdWriter text-danger">${ n.writer }</td>
         			<td class="listTdRegDate text-danger"><fmt:formatDate value="${ n.regDate }"
         				pattern="yyyy-MM-dd HH:mm:ss" /></td>
         			<td class="listTdHits text-danger">${ n.hits }</td>
         		</tr>
   			</c:if>
   			
   			<c:if test="${n.state == 2 }">
         		<tr class="container text-warning">
		            <td class="text-warning"><img src="resources/images/mustread.png"></td>
		            <td class="listTdTitle text-warning">
            			<a class="text-warning" href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }">${ n.title }</a>
         			</td>
         			<td class="listTdWriter text-warning">${ n.writer }</td>
         			<td class="listTdRegDate text-warning"><fmt:formatDate value="${ n.regDate }"
         				pattern="yyyy-MM-dd HH:mm:ss" /></td>
         			<td class="listTdHits text-warning">${ n.hits }</td>
         		</tr>
   			</c:if>
   
   			<c:if test="${n.state ==0 }">
         		<tr class="listTr">
		            <td class="listTdNo">일반</td>
		            <td class="listTdTitle">
            			<a href="noticeDetail?no=
         					${ n.no }&pageNum=${ currentPage }" >${ n.title }</a>
         			</td>
			         <td class="listTdWriter">${ n.writer }</td>
			         <td class="listTdRegDate"><fmt:formatDate value="${ n.regDate }"
			         	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			         <td class="listTdHits">${ n.hits }</td>
         		</tr>
   			</c:if>
   	</c:forEach>

	<tr>
	<td colspan="5" class="listPage">
		<nav aria-label="Page navigation example" style="width: 1080px; margin-top: 50px; margin-bottom: 50px;">
			<ul class="pagination justify-content-center">
		<c:if test="${ startPage > pageGroup }">
			<li class="page-item">
		   		<a class="page-link" href="noticeList?pageNum=${ startPage - pageGroup }">이전</a>
		   	</li>
		</c:if>
		
	<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
		<c:if test="${ i == currentPage }">
			<li class="page-item active"><span class="page-link">${ i }</span></li>
		</c:if>

		<c:if test="${ i != currentPage }">
			<li class="page-item"><a class="page-link" href="noticeList?pageNum=${ i }">${ i }</a></li>
		</c:if>
	</c:forEach>
	
	<c:if test="${ endPage < pageCount }">
			<li class="page-item">
		      <a class="page-link" href="noticeList?pageNum=${ startPage + pageGroup }">다음</a>
		    </li>
			</c:if>
				</ul>
			</nav>
				<pre>운영 원칙과 맞지 않는 글은 게시판 관리자에 의해 게시글 목록에서 제외될 수 있습니다.</pre>
		</td>
	</tr>
</c:if>
<%-- 
	일반 게시 글 리스트 요청 이면서 게시 글 리스트가 존재할 경우
	게시 글 상세보기로 링크를 적용할 때 type과 keyword 
	파라미터는 필요 없다. 
--%>	
<%-- 검색 요청이면서 검색된 리스트가 존재하지 않을 경우 --%>
<c:if test="${ searchOption and empty  noticeList }">
	<tr>
		<td colspan="5" class="listTdSpan">
			"${ keyword }"가 포함된 게시 글이 존재하지 않습니다.</td>
	</tr>
</c:if>
<%-- 일반 게시 글 리스트 요청이면서 게시 글 리스트가 존재하지 않을 경우 --%>
<c:if test="${ not searchOption and empty noticeList }">
	<tr>
		<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
	</tr>
</c:if>
</table>
</div>

</article>