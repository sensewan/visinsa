<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<form name="productWriteForm" action="productWriteProcess" id="productWriteForm" 
	method="post" enctype="multipart/form-data">
	
	<!-- String productCode, String productName, String typicalIngredient, String typicalFunction, int productPrice,
			String productBrand, String productExplain, -->
	
	<div class="row" style="width: 800px; margin: 50px auto;">
		<h2 class="text-center" style="width: 100%">상품 정보 등록하기</h2>
	</div>

	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품명</span>
		  </div>
		  <input type="text" name="productName" id="productName" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="상품명을 입력해 주세요">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품코드</span>
		  </div>
		  <input type="text" name="productCode" id="productCode" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="상품코드를 입력해 주세요">
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">대표성분</span>
		  </div>
		  <input type="text" name="typicalIngredient" id="typicalIngredient" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="대표성분을 입력해 주세요">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">대표기능</span>
		  </div>
		  <input type="text" name="typicalFunction" id="typicalFunction" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="대표기능을 입력해 주세요">
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">상품가격</span>
		  </div>
		  <input type="number" name="productPrice" id="productPrice" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="상품가격을 입력해 주세요">
		  <div class="input-group-prepend" style="margin-left: 15px;">
		    <span class="input-group-text text-right" id="inputGroup-sizing-default" style="width: 95px;  text-indent: 10px;">브랜드</span>
		  </div>
		  <input type="text" name="productBrand" id="productBrand" class="form-control" aria-label="Sizing example input" 
		  	aria-describedby="inputGroup-sizing-default" placeholder="브랜드를 입력해 주세요">
		</div>
	</div>
	
	<div class="row" style="width: 800px; margin: 20px auto;">
		<div class="input-group">
		  <div class="input-group-prepend">
		    <span class="input-group-text text-right" style="width: 150px; text-indent: 10px;">상품 설명</span>
		  </div>
		  <textarea class="form-control" name="productExplain" id="productExplain" rows="15"></textarea>
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
	    	<button type="submit" class="btn btn-success" id="btn-write">등록하기</button>	    	
	    	<button type="button" class="btn btn-info" id="btn-list"
	    		onclick="location.href='productList?pageNum=${pageNum}'">목록보기</button>
	   </div>
   </div>
	

</form>
</article>