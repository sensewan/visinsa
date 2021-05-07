<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function() {


	// 게시글 수정버튼 클릭시
	$("#detailProductUpdate").on("click", function() {
		
		$("#checkForm").attr("action", "updateProduct");
		$("#checkForm").submit();
	});
	
	//장바구니 담기
	$("#basket").on("click", function() {
		var count = $("#count").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/addBasket?num=${ product.no }&id=${ member.id }&count=" + count,
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
		<td class="contentTh">상품명</td>
		<td class="contentTd" colspan="3">${ product.productName }</td>		
	</tr>
	<tr>
		<td class="contentTh">브랜드</td>
		<td class="contentTd">${ product.productBrand }</td>
		<td class="contentTh">등록일</td>
		<td class="contentTd"><fmt:formatDate value="${ product.regDate }" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>		
	</tr>
	<tr>		
		<td class="contentTh">대표성분</td>
		<td class="contentTd">${ product.typicalIngredient }</td>
		<td class="contentTh">대표기능</td>
		<td class="contentTd">${ product.typicalFunction }</td>
	</tr>	
	<tr>		
		<td class="readContent" colspan="4">
			<pre>${ product.productExplain }</pre>
			<img alt="그림" src="resources/upload/${ product.image }"/>
		</td>
	</tr>	
	<tr>
		<td class="contentTh">첨부 이미지 이름: </td>
		<td class="contentTd" colspan="3">
		<c:if test="${ empty product.image }">
			이미지 없음
		</c:if>
		<c:if test="${ not empty product.image }">
			${ product.image }
		</c:if>
		</td>		
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailProductUpdate" value="수정하기"/>
			<input type="button" id="basket" value="장바구니 담기"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />
			<%-- 일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려 보낸다. --%>
			<c:if test="${ not searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기"
					onclick="javascript:window.location.href=
						'productList?pageNum=${ pageNum }'"/>
			</c:if>
			<%-- 
				검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. 
			--%>
			<c:if test="${ searchOption }">
				&nbsp;&nbsp;<input type="button" value="목록보기"
					onclick="javascript:window.location.href=
						'productList?pageNum=${ pageNum }&type=${ type }&keyword=${ keyword }'"/>
				<%-- 
					위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
					않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
				--%>		
			</c:if>				
		</td>
		<td>
			<input type="number" id="count" value="1">
		</td>
	</tr>
</table>

</article>


