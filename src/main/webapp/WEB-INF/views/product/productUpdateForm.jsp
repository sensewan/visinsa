<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>


$(function () {
	// 이미지 첨부시 이미지명 보여지게 하기
	$("#image").change(function (e) {
		var fileValue = $("#image").val();
		var start= fileValue.lastIndexOf("\\");
		var uploadName = fileValue.substr(start+1);
		console.log("인덱스찾기: ", start);
		console.log("문자열자른결과: ", uploadName);
		$("label[for='image']").text(uploadName);
	})

	
});
</script>


<article>
<form name="ProductUpdateForm" id="ProductUpdateForm" action="updateProductProcess" method="post"
	enctype="multipart/form-data">
	<%--
		no는 DB에서 게시 글을 수정하기 위해 필요하고 pageNum은 게시 글이 
		수정된 후에 이전에 사용자가 머물렀던 게시 글 리스트의 동일한 페이지로
		보내기 위해 필요한 정보이다.  
	--%>
	<input type="hidden" name="no" value="${ product.no }" />
	<input type="hidden" name="pageNum" value="${ pageNum }" />
	<%-- 
		검색 요청일 경우 다시 keyword에 해당하는 검색 리스트로
		돌려보내기 위해서 아래의 파라미터가 필요하다.
	 --%>
	<c:if test="${ searchOption }">
		<input type="hidden" name="type" value="${ type }" />
		<input type="hidden" name="keyword" value="${ word }" />
	</c:if>		
	
<!--String productCode, String productName, String typicalIngredient, String typicalFunction, int productPrice,
			String productBrand, String productExplain,-->	
			
	
	<div class="row" style="width: 800px; margin: 50px auto;">
		<h2 class="text-center" style="width: 100%">상품 정보 수정하기</h2>
	</div>

	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품명</span>
		  </div>
		  <input type="text" name="productName" id="productName" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.productName }">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품코드</span>
		  </div>
		  <input type="text" name="productCode" id="productCode" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.productCode }" >
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">대표성분</span>
		  </div>
		  <input type="text" name="typicalIngredient" id="typicalIngredient" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.typicalIngredient }">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">대표기능</span>
		  </div>
		  <input type="text" name="typicalFunction" id="typicalFunction" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.typicalFunction }">
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품가격</span>
		  </div>
		  <input type="number" name="productPrice" id="productPrice" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.productPrice }">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">브랜드</span>
		  </div>
		  <input type="text" name="productBrand" id="productBrand" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" value="${ product.productBrand }">
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" style="width: 150px; text-indent: 10px;">상품 설명</span>
		  </div>
		  <textarea class="form-control" name="productExplain" id="productExplain" rows="15">${ product.productExplain }</textarea>
		</div>
	</div>
	
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroupFileAddon01" style="width: 150px; text-indent: 10px;">상품 이미지 선택</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" name="image" class="custom-file-input" id="image" aria-describedby="inputGroupFileAddon01"/>
		    <label class="custom-file-label" for="image" id="fileName" >여기를 클릭하면 이미지를 선택할 수 있습니다.</label>
		  </div>
		</div>
	</div>	
	
	<div class="card" style="border: none; width: 800px; margin: 20px auto;">		
	    <div class="card-body" style="text-align: center;">
	    	<button type="submit" class="btn btn-success" id="btn-write">수정하기</button>
	    	
			<%-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려보낸다. --%>
			<c:if test="${ not searchOption }">		
	    	<button type="button" class="btn btn-info" id="btn-list"
	    		onclick="location.href='productList?pageNum=${pageNum}'">목록보기</button>
			</c:if>
			<%-- 검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. --%>
			<c:if test="${ searchOption }">
	    	<button type="button" class="btn btn-info" id="btn-list"
	    		onclick="location.href='productList?pageNum=${pageNum}&type=${ type }&keyword=${ keyword }'">목록보기</button>
				<%-- 
					위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
					않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
				--%>		
			</c:if>		    	

	   </div>
   </div>
	
</form>			
</article>