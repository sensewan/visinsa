<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>

</style>
<script>
	function map1(){
		$(".modal").show();
	}
	
	$(function(){
		$("#modalClose").click(function(){
			$(".modal").hide();
		});
	});
</script>

<article>

	<h1>테스트 메인 페이지4</h1>
	<div class="content">
		<img src="resources/images/human.png" alt="Body" usemap="#bodymap" width="600px">
		<map name="bodymap">
			<area coords="227,34,380,192" id="map1" onclick="map1();">
		</map>
	</div>
	
	<div class="modal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">제목</h5>
	      </div>
	      <div class="modal-body">
	        <p>제발 떠라</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary">확인</button>
	        <button type="button" class="btn btn-secondary" id="modalClose">취소</button>
	      </div>
	    </div>
	  </div>
	</div>

	
<script>

</script>
</article>