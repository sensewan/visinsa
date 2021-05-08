<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<article>
<form name="productWriteForm" action="productWriteProcess" id="productWriteForm" 
	method="post" enctype="multipart/form-data">
	
	<!-- String productCode, String productName, String typicalIngredient, String typicalFunction, int productPrice,
			String productBrand, String productExplain, -->
	<table class="readTable">
		<tr>
			<td colspan="4" class="boardTitle">
				<h2>상품등록하기</h2>
			</td>
		</tr>
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		
		<tr>
			<td class="readTh">상품코드</td>
			<td class="readTd">
				<input type="text" name="productCode" size="30" id="productCode" maxlength="10"/>
			</td>
			<td class="readTh">상품명</td>
			<td class="readTd">
				<input type="text" name="productName" size="30" id="productName" maxlength="50"/>
			</td>
		</tr>
				
		<tr>
			<td class="readTh">대표성분</td>
			<td class="readTd" >
				<input type="text" name="typicalIngredient" size="30" id="typicalIngredient" maxlength="50"/>
			</td>
			<td class="readTh">대표기능</td>
			<td class="readTd" >
				<input type="text" name="typicalFunction" size="30" id="typicalFunction" maxlength="50"/>
			</td>
		</tr>		
		<tr>
			<td class="readTh">상품가격</td>
			<td class="readTd" colspan=3>
				<input type="text" name="productPrice" size="10" id="productPrice" maxlength="10"/>
			</td>
		</tr>
		
		<tr>
			<td class="readTh">브랜드</td>
			<td class="readTd" colspan=3>
				<input type="text" name="productBrand" size="10" id="productBrand" maxlength="10"/>
			</td>
		</tr>		
			
		<tr>
			<td class="readTh">상품설명</td>
			<td class="readTd" colspan="3">
				<textarea name="productExplain" id="productExplain" rows="20" cols="80"></textarea>
			</td>
		</tr>	
		<tr>
			<td class="readTh">상품이미지</td>
			<td class="readTd" colspan=3>
				<input type="file" name="image" size="70" id="image" maxlength="50"/>
			</td>
		</tr>	
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="tdSpan"><input type="reset" value="다시쓰기"/>
				&nbsp;&nbsp;<input type="submit" value="등록하기" />
				&nbsp;&nbsp;<input type="button" value="목록보기" 
					onclick="javascript:window.location.href='productList'"/></td>
		</tr>
	</table>
</form>
</article>