<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>

</style>
<script>
	//증상클릭 이벤트
	$(function(){
		$("#symptomCheck").on("click", function(){
			var symCode = [];
			$("input[id=symptom]:checked").each(function(){
				var chk = $(this).val();
				symCode.push(chk);
			});
			console.log(symCode);
			$(".modal").hide();
			$("#modalForm *").remove();
			$.ajax({
				url : "${pageContext.request.contextPath}/mainBodySymCode?symCode=" + symCode,
				type : "get",
				success : function(data) {
				
				}
			});
		});
	});
	// 머리 클릭 이벤트
	function map1(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000007%7CB000004%7CB000002%7CB000017%7CB000015",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#head'>머리</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#eye'>눈</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#ear'>귀</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#nose'>코</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#mouth'>입</a></li>";
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
  				for(i=0; i < data.length; i++){
 					if(i >= 78 && i <= 144) {
 						if(i == 78) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade active show' id='head'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 144) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 144){
 	 						dd +="</div>"
 	 	 					dd +="</div>"
 	 					}
 					}
 					if( i >= 13 && i <= 77) {
 						if(i == 13) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='eye'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 77) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 77){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 0 && i <= 12) {
 						if(i == 0) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='ear'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 12) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 12){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 185 && i <= 193) {
 						if(i == 185) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='nose'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 193) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 193){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 145 && i <= 184) {
 						if(i == 145) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='mouth'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 184) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 184){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
				}
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	// 목 클릭 이벤트
	function map2(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000008",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#neck'>목</a></li>";
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
	 			dd += "<div class='tab-pane fade active show' id='head'>";
  				for(i=0; i < data.length; i++){
  					
 	 				if(i % 10 == 0) {
 	 	 	 			dd += "<div>";
 	 				}
 	 				
 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";

 	 				if(i % 10 == 9 && i != data.length - 1) {
 	 	 	 			dd += "</div>";
 	 				}
				}
  				dd += "</div>";
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	
	// 가슴 클릭 이벤트
	function map3(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000020%7CB000014",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#chest'>가슴</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#breast'>유방</a></li>";
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
  				for(i=0; i < data.length; i++){
 					if(i >= 0 && i <= 8) {
 						if(i == 0) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='breast'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 8) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 8){
 	 						dd +="</div>"
 	 	 					dd +="</div>"
 	 					}
 					}
 					if( i >= 9 && i <= 62) {
 						if(i == 9) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade active show' id='chest'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 62) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 62){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
				}
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	// 배 클릭 이벤트
	function map4(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000006%7CB000010%7CB000019",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#stomach'>배</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#waist'>등/허리</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#skin'>피부</a></li>"
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
  				for(i=0; i < data.length; i++){
 					if(i >= 8 && i <= 63) {
 						if(i == 8) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade active show' id='stomach'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 63) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 63){
 	 						dd +="</div>"
 	 	 					dd +="</div>"
 	 					}
 					}
 					if( i >= 0 && i <= 7) {
 						if(i == 0) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='waist'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 7) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 7){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 64 && i <= 135) {
 						if(i == 64) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='skin'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 135) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 135){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
				}
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	// 팔 클릭 이벤트
	function map5(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000012%7CB000018",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#hand'>손</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#arm'>팔</a></li>";
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
  				for(i=0; i < data.length; i++){
 					if(i >= 0 && i <= 23) {
 						if(i == 0) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade active show' id='hand'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 23) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 23){
 	 						dd +="</div>"
 	 	 					dd +="</div>"
 	 					}
 					}
 					if( i >= 24 && i <= 54) {
 						if(i == 24) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='arm'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 54) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 54){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
				}
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	
	// 다리 클릭 이벤트
	function map6(){
		var dd = "";
		$(".modal").show();
		console.log("여기까지");
		$.ajax({
			url : "${pageContext.request.contextPath}/mainBody?code=B000001%7CB000005%7CB000009%7CB000011%7CB000013",
			type : "get",
			success : function(data) {
				console.log("갔다왔어");
				console.log(data);
				dd += "<ul class='nav nav-tabs'>";
				dd += "<li class='nav-item'><a class='nav-link active' data-toggle='tab' href='#leg'>다리</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#pelvis'>골반</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#hip'>엉덩이</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#genital'>생식기</a></li>";
				dd += "<li class='nav-item'><a class='nav-link' data-toggle='tab' href='#foot'>발</a></li>";
				dd += "</ul>";
				dd += "<div id='myTabContent' class='tab-content'>";
  				for(i=0; i < data.length; i++){
 					if(i >= 42 && i <= 87) {
 						if(i == 42) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade active show' id='leg'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 87) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 87){
 	 						dd +="</div>"
 	 	 					dd +="</div>"
 	 					}
 					}
 					if( i >= 0 && i <= 41) {
 						if(i == 0) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='pelvis'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 41) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 41){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 158 && i <= 176) {
 						if(i == 158) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='hip'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 176) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 176){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 111 && i <= 157) {
 						if(i == 111) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='genital'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 157) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 157){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
 					if( i >= 88 && i <= 110) {
 						if(i == 88) {
 	 						var j = 0;
 	 	 					dd += "<div class='tab-pane fade' id='foot'>";
 						}
 	 					if(j % 10 == 0) {
 	 	 	 				dd += "<div>";
 	 	 	 				dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 110) {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' value='" + data[i].symptomName + "'>" + data[i].symptomName + "&nbsp;";
 	 					}
 						j++;
	 					
 	 					if(i == 110){
 	 						dd +="</div>"
 	 						dd +="</div>"
 	 					}
 					}
				}
  				dd += "</div>";
				$("#modalForm").append(dd);
			}
		});
	}
	
	$(function(){
		$("#modalClose").click(function(){
			$(".modal").hide();
			$("#modalForm *").remove();
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
		<div class="modal-dialog" role="document" style="max-width: 100%; width: auto; display: table;">
			<div class="modal-content">
				<div class="modal-header" style="margin: auto;">
					<h5 class="modal-title" >증상을 선택해주세요.</h5>
				</div>
				<div class="modal-body">
					<form action="" id="modalForm">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="symptomCheck">확인</button>
					<button type="button" class="btn btn-secondary" id="modalClose">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal2">
		<div class="modal-dialog" role="document" style="max-width: 100%; width: auto; display: table;">
			<div class="modal-content">
				<div class="modal-header" style="margin: auto;">
					<h5 class="modal-title" >이러한 질병들이 예상됩니다.</h5>
				</div>
				<div class="modal-body">
					<form action="" id="modalForm2">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="symptomCheck">확인</button>
					<button type="button" class="btn btn-secondary" id="modalClose">취소</button>
				</div>
			</div>
		</div>
	</div>
	
<script>

</script>
</article>