<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>

count = "";

$(function() {
	
	// 기본 선택된 값 넣어 놓기
	count = $("#count option:selected").text();

    $("#count").on("change" ,function(){
        count = $("#count option:selected").text();  //셀렉트박스의 선택한 텍스트 보여주기 위해
        console.log('변경되는 카운트: ',count);
     });


	// 게시글 수정버튼 클릭시
	$("#detailProductUpdate").on("click", function() {
		
		$("#checkForm").attr("action", "updateProduct");
		$("#checkForm").submit();
	});
	

	
	//장바구니 담기
	$("#basket").on("click", function() {
		//count = $("#count2").val();
		console.log('장바구니용 카운트:', count);
		$.ajax({
			url : "${pageContext.request.contextPath}/addBasket?num=${ product.no }&id=${ member.id }&productCode=${ product.productCode }&count=" + count,
			type : "get",
			success : function(data) {
				var result = confirm("장바구니에 담았습니다.\n장바구니를 확인하시겠습니까?");
				if(result) {
					location.href="basket";
				}
			}
		});
	});
	

	// 게시글 삭제하기
	$("#detailDelete").on("click", function() {
			
/* 		var pass = $("#pass").val();
		if(pass.length <= 0) {
			alert("게시 글을 수정하려면 비밀번호를 입력해주세요");
			return false;
		} */
		
		$("#checkForm").attr("action", "deleteProduct");
		$("#checkForm").attr("method", "post");
		$("#checkForm").submit();
	});
	
});
</script>

<style>
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
</style>

<article>

<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="no" value="${ product.no }"/>
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


<table class="table table-hover" id="table1">
	<tr class="table-secondary">
		<td colspan="4" class="boardTitle" style="text-align:center;">
			<h2>상품 상세보기</h2>
		</td>
	</tr>
	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	
	<tr>
		<td class="table-info" style="width: 110px;">상품명</td>
		<td class="contentTdSpan" colspan="3">${ product.productName }</td>		
	</tr>
	<tr>
		<td class="table-info" style="width: 110px;">브랜드</td>
		<td class="contentTd" style="width: 200px;">${ product.productBrand }</td>
		<td class="table-info" style="width: 110px;">등록일</td>
		<td class="contentTd"><fmt:formatDate value="${ product.regDate }" pattern="yyyy-MM-dd" /></td>	
	</tr>
	<tr>		
		<td class="table-info" style="width: 110px;">대표성분</td>
		<td class="contentTd" style="width: 200px;">${ product.typicalIngredient }</td>
		<td class="table-info" style="width: 110px;">대표기능</td>
		<td class="contentTd">${ product.typicalFunction }</td>
	</tr>
	
	<!-- 관리자 및 판매자만 이미지 이름 확인 -->
	<c:if test="${sessionScope.member.id == 'admin' || sessionScope.member.seller == '1'}">	
	<tr>
		<td class="table-info" style="width: 110px;">첨부 이미지 이름</td>
		<td class="contentTd" colspan="3">
		<c:if test="${ empty product.image }">
			이미지 없음
		</c:if>
		<c:if test="${ not empty product.image }">
			${ product.image }
		</c:if>
		</td>		
	</tr>
	</c:if>
	
	<tr>		
		<td class="readContent" colspan="4" style="border: none; font-size:larger; text-align: center;">
			<img alt="그림" src="resources/upload/${ product.image }"/>
			<pre>${ product.productExplain }</pre>
		</td>
	</tr>
	

	
	<!-- 관리자 및 판매자만 수정 삭제 가능 -->
	<tr style="border-top: outset">
		<td colspan="4" style="text-align: center; border: none; border-bottom: double; border-bottom-color: aquamarine;">
			<c:if test="${sessionScope.member.id == 'admin' || sessionScope.member.seller == '1'}">	
			<input type="button" id="detailProductUpdate" value="수정하기" class="btn btn-success"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" class="btn btn-success"/>
			</c:if>
			
			
			<%-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려 보낸다. --%>
			<c:if test="${ not searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기" class="btn btn-success"
					onclick="javascript:window.location.href='productList?pageNum=${ pageNum }'"/>
			</c:if>
	
	
			<!-- 검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. --> 
			<c:if test="${ searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기" class="btn btn-success"
					onclick="javascript:window.location.href='productList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
				<%-- 
					위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
					않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
				--%>		
			</c:if>				
		</td>
	</tr>
	<c:if test="${ sessionScope.isLogin == true }">	
	<tr>
		<td colspan="4" class="tdSpan" style="text-align: center;">
			<select class="form-select" id="count">
				<option selected="selected">1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
				<option>6</option>
				<option>7</option>
				<option>8</option>
				<option>9</option>
			</select>
			<input type="button" id="basket" value="장바구니 담기" class="btn btn-warning"/>
		</td>
	</tr>
	</c:if>

</table>

</article>



