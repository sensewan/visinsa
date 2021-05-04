<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>

</style>
<script>
	function map1(){
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000007",
			type : "get",
			success : function() {
				console.log("갔다왔어");
			}
		});
	}
	function map2(){
		alert("목")
	}
	function map3(){
		alert("가슴")
	}
	function map4(){
		alert("배")
	}
	function map5(){
		alert("팔")
	}
	function map6(){
		alert("다리")
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
		<img src="resources/images/human_main.png" name="mainImg" alt="Body" usemap="#bodymap" width="600px">
		<map name="bodymap">
			<area shape="circle" coords="300,101,79" id="map1" onclick="map1();" onmouseover="if(document,images)mainImg.src='resources/images/human_head.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="rect" coords="265,181,334,195" id="map2" onclick="map2();" onmouseover="if(document,images)mainImg.src='resources/images/human_neck.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="rect" coords="243,198,369,261" id="map3" onclick="map3();" onmouseover="if(document,images)mainImg.src='resources/images/human_chest.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="rect" coords="246,264,382,326" id="map4" onclick="map4();" onmouseover="if(document,images)mainImg.src='resources/images/human_stomach.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="poly" coords="238,206,142,291,83,284,60,344,112,365,238,263" id="map5" onclick="map5();" onmouseover="if(document,images)mainImg.src='resources/images/human_arm.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="poly" coords="370,182,372,249,482,167,537,168,549,136,520,126,477,138,471,109,446,142" id="map5" onclick="map5();" onmouseover="if(document,images)mainImg.src='resources/images/human_arm.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
			<area shape="poly" coords="384,334,387,493,407,529,365,535,320,499,318,380,272,502,237,549,201,524,230,487,267,333" id="map6" onclick="map6();" onmouseover="if(document,images)mainImg.src='resources/images/human_leg.png'" onmouseout="if(document, images)mainImg.src='resources/images/human_main.png'">
		</map>
	</div>
	
	
	<div class="modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">제목</h5>
				</div>
				<div class="modal-body">
					<form action="">
						<div>
							<c:if test="${ mainBody == null}">
								<div>없어${mainBody }zz</div>
							</c:if>
			  				<c:forEach var="mb" items="${mainBody }">
								<li class="list-group-item">${ mb.symptomName }d</li>					 
							</c:forEach>
						</div>
					</form>
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