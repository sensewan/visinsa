<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.donation_img {
		width: 700px;
	}

</style>
<!-- 쓰기는 관리자 모드에서 보이게 하고 세부 정보 보기의 하단부에 수정, 삭제 버튼과 같이 있음 -->
<div class="container">
	<c:if test="${ not empty productList }">
		
		<div class="row" style="width: 1110px; margin-top: 20px;">
		<c:forEach var="b" items="${productList }" varStatus="status">
		  <div class="col-sm-6" style="width: 555px; height:400px; margin-top: 30px;">
		  
		    <div class="card" style="width: 300px; height: 260px">
		    
		      <div class="card-header"><h6 class="card-title">${ b.productName }</h6></div>
		      		    	
		      <div class="card-body">		       
		        <p><img src="resources/upload/${ b.image }" class="card-img-top" alt="..."></p>
		        <p class="card-text">${ b.productExplain }</p>
		        <a class="btn btn-success" href="productDetail?no=${ b.no }&pageNum=${ currentPage }">내용보기 >></a>		        
		      </div>
		      
		    </div>
		  </div>
		 </c:forEach>
		 </div>
		 		
	</c:if>
	<c:if test="${ empty productList }">
		<div class="row">
			<div>상품이 존재하지 않습니다.</div>
		</div>
	</c:if>
	
	<!-- 아래는 관리자 모드에서만 보임 -->
	<c:if test="${sessionScope.member.id == 'admin' && sessionScope.member.seller == '1'}">
	<div class="card" style="border: none; width: 1080px; margin-bottom: 50px;">		
		<div class="card-body" style="text-align: center;">
			<button type="button" class="btn btn-info btn-lg btn-block" id="btn-write"
	    		onclick="location.href='productWriteForm'">상품등록하기</button>	    	
	   </div>
	</div>
	</c:if>
		<nav aria-label="Page navigation example" style="width: 1080px; margin-top: 50px; margin-bottom: 50px;">
		  <ul class="pagination justify-content-center">
		  <c:if test="${ startPage > pageGroup }">
		  	<li class="page-item">
		   		<a class="page-link" href="productList?pageNum=${ startPage - pageGroup }">이전</a>
		   	</li>
		  </c:if>	    
		  <c:forEach var="i" begin="${ startPage }" end="${ endPage }">
		  	<c:if test="${ i == currentPage }">
				<li class="page-item active"><span class="page-link">${ i }</span></li>
			</c:if>			
			<c:if test="${ i != currentPage }">
				<li class="page-item"><a class="page-link" href="productList?pageNum=${ i }">${ i }</a></li>			
			</c:if>		
		  </c:forEach>
		  <c:if test="${ endPage < pageCount }">
		    <li class="page-item">
		      <a class="page-link" href="productList?pageNum=${ startPage + pageGroup }">다음</a>
		    </li>		
		  </c:if>    
		  </ul>
		</nav>		
</div>