<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#search{
		margin-top: 30px;
		margin-bottom: -20px;
	}
	
	#searchResult{
		text-align: right;
	    width: 355px;
	    height: 80px;
	    margin-top: 30px;
	    float: right;
	    padding-right: 10px;
	    margin-right: -37px;
	}

</style>

<script>
$(function() {
	
	// 상품 검색하기
	$("#ProductSearchForm").on("submit", function() {
		var keyword = $("#keyword").val();
		if(keyword.length <= 0) {
			alert("검색어가 입력되지 않았습니다.\n검색어를 입력해주세요");
			return false;
		}		
		$(this).attr("method", "post");
		$(this).attr("action", "productList");		
	});	
	
});
</script>

<div class="container">

	<!-- 검색바 -->
	<div id="search">
		<form name="ProductSearchForm" id="ProductSearchForm">
			<select name="type" id="type" class="btn btn-success disabled">
				<option value="productName">상품명</option>
				<option value="typicalIngredient">대표성분</option>
				<option value="typicalFunction">대표기능</option>
				<option value="productBrand">브랜드</option>
			</select> 
			<input type="text" class="btn btn-secondary" name="keyword" id="keyword" /> 
			<input type="submit" class="btn btn-success disabled" value="검색" />
		</form>
	</div>
	
		<%-- 검색 요청일 경우만 아래를 화면에 표시 한다. --%>
		<c:if test="${ searchOption }">
		<div class="alert alert-dismissible alert-primary" id="searchResult">
			<p>	"${ word  }" 검색 결과입니다.</p>
			<p><a href="productList">상품 리스트</a></p>
		</div>
		</c:if>
	
	
	


	<%-- 
		*** 검색 요청 이면서 검색된 상품이 존재할 경우 ***
		상품 상세보기 링크에 type과 keyword 파라미터를 적용해 설정한다. 
	--%>
	<c:if test="${ searchOption and not empty productList }">
		<div class="row justify-content-center" style="width: 1200px; margin-top: 20px;">
		<c:forEach var="b" items="${productList }" varStatus="status">
		  <div class="col-sm-4" style="width: 400px; height:400px; margin-top: 30px; margin-bottom: 50px;">
		  
		    <div class="card" style="width: 350px; height: 450px">
		    
		      <div class="card-header"><h6 class="card-title">${ b.productName }</h6></div>
		      		    	
		      <div class="card-body">		       
		        <a href="productDetail?no=${ b.no }&pageNum=${ currentPage }&type=${ type }&keyword=${ keyword }">
		        	<img src="resources/upload/${ b.image }" class="card-img-top" style="width:300px; height: 290px; " alt="..."/>
		        </a>		        
		        <p class="card-text">제조사: ${ b.productBrand }</p>
		        <p class="card-text"><fmt:formatNumber value="${ b.productPrice }" type="currency"/></p>
		        
		      </div>
		      
		    </div>
		  </div>
		 </c:forEach>
		 </div>
		 
 		<nav aria-label="Page navigation example" style="width: 1080px; margin-top: 50px; margin-bottom: 50px;">
		  <ul class="pagination justify-content-center">
		  <c:if test="${ startPage > pageGroup }">
		  	<li class="page-item">
		   		<a class="page-link" href="productList?pageNum=${ startPage - pageGroup }&type=${ type }&keyword=${ keyword }">&laquo;</a>
		   	</li>
		  </c:if>	    
		  <c:forEach var="i" begin="${ startPage }" end="${ endPage }">
		  	<c:if test="${ i == currentPage }">
				<li class="page-item active"><span class="page-link">${ i }</span></li>
			</c:if>			
			<c:if test="${ i != currentPage }">
				<li class="page-item">
					<a class="page-link" href="productList?pageNum=${ i }
						&type=${ type }&keyword=${ keyword }">${ i }</a>
				</li>			
			</c:if>		
		  </c:forEach>
		  <c:if test="${ endPage < pageCount }">
		    <li class="page-item">
		      <a class="page-link" href="productList?pageNum=${ startPage + pageGroup }&type=${ type }&keyword=${ keyword }">&raquo;</a>
		    </li>		
		  </c:if>    
		  </ul>
		</nav>		
		 		
	</c:if>
	
	
	<!-- *** 일반 게시글 요청이면서 상품이 존재하는 경우 (type, keyword 파라미터 필요 없음) *** -->
	<c:if test="${ not searchOption and not empty productList }">
		<div class="row justify-content-center" style="width: 1200px; margin-top: 20px;">
		<c:forEach var="b" items="${productList }" varStatus="status">
		  <div class="col-sm-4" style="width: 400px; height:400px; margin-top: 30px; margin-bottom: 50px;">
		  
		    <div class="card" style="width: 350px; height: 450px">
		    
		      <div class="card-header"><h6 class="card-title">${ b.productName }</h6></div>
		      		    	
		      <div class="card-body">		       
		        <a href="productDetail?no=${ b.no }&pageNum=${ currentPage }">
		        	<img src="resources/upload/${ b.image }" class="card-img-top" style="width:300px; height: 290px; " alt="..."/>
		        </a>		        
		        <p class="card-text">제조사: ${ b.productBrand }</p>
		        <p class="card-text"><fmt:formatNumber value="${ b.productPrice }" type="currency"/></p>
		        
		      </div>
		      
		    </div>
		  </div>
		 </c:forEach>
		 </div>
		 
 		<nav aria-label="Page navigation example" style="width: 1080px; margin-top: 50px; margin-bottom: 50px;">
		  <ul class="pagination justify-content-center">
		  <c:if test="${ startPage > pageGroup }">
		  	<li class="page-item">
		   		<a class="page-link" href="productList?pageNum=${ startPage - pageGroup }">&laquo;</a>
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
		      <a class="page-link" href="productList?pageNum=${ startPage + pageGroup }">&raquo;</a>
		    </li>		
		  </c:if>    
		  </ul>
		</nav>		
		 		
	</c:if>
	
	
	
	
	
	<%-- 검색 요청이면서 검색된 상품이 존재하지 않을 경우 --%>
	<c:if test="${ searchOption and empty productList }">
		<div class="row" style="margin-top: 150px; margin-left: 380px;">
			<div>상품이 존재하지 않습니다.</div>
		</div>
	</c:if>
	
	
	<%-- 일반 요청이면서 검색된 상품이 존재하지 않을 경우 --%>
	<c:if test="${not searchOption and empty productList }">
		<div class="row" style="margin-top: 150px; margin-left: 380px;">
			<div>상품이 존재하지 않습니다.</div>
		</div>
	</c:if>
	
	
	
	
	<!-- 아래는 관리자 모드 및 판매자에서만 보임 -->
	<c:if test="${sessionScope.member.id == 'admin' || sessionScope.member.seller == '1'}">
	<div class="card" style="border: none; width: 1080px; margin-bottom: 50px;">		
		<div class="card-body" style="text-align: center;">
			<button type="button" class="btn btn-info btn-lg btn-block" id="btn-write"
	    		onclick="location.href='productWriteForm'">상품등록하기</button>	    	
	   </div>
	</div>
	</c:if>
	
</div>