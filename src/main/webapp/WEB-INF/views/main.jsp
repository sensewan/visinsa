<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cdb0e08bc78164637f460112638cb43d&libraries=services"></script>
<script>

//↱위도 경도 전역변수 설정
lat = 37.566826;
lon = 126.9786567;

	//증상클릭 이벤트
	$(function(){
		$("#modal2").hide();
		$("#symptomCheck").on("click", function(){
			var symCode = [];
			var f1 = "";
			$("input[id=symptom]:checked").each(function(){
				var chk = $(this).val();
				symCode.push(chk);
			});
			console.log(symCode);
			$("#modal1").hide();
			$("#modalForm *").remove();
			$.ajax({
				url : "${pageContext.request.contextPath}/mainBodySymCode?symCode=" + symCode,
				type : "get",
				success : function(data) {
					var last = data.length - 1;
					var ing = data[last].typicalIngredient;
					if(ing != null) {
						var ti = ing.split(",");
						console.log(ti);
					}
					console.log(data);
					if(data.length == 0) {
						f1 += "<div>";
						f1 += "예상되는 질병이 없습니다.";
						f1 += "</div>";
					} else {
						f1 += "<div>";
						for(i=0; i < data.length-1; i++){
							medi = data[i].medicalName.split(",");
							f1 += "<a href='#'>";
							f1 += data[i].diseaseName;
							f1 += "</a>,&nbsp;";
							f1 += "진료과 :";
							for(j=0; j < medi.length; j++){
								if(j == 0) {
									f1 += "<a href='#' class='dept2'>" + medi[j] + "</a>";
								} else {
									f1+="<span>,</span>";
									f1 += "<a href='#' class='dept2'>" + medi[j] + "</a>";
								}
							}
							f1 += "<br>";
						}
						if(ing != null) {
							f1 += "<br>";
							f1 += "<div style='border-top: 1px solid black'>";
							f1 += "<br>";
		 					for(k=0; k < ti.length; k++){
								if(k == 0) {
									f1 += "<a href='productList?type=typicalIngredient&keyword=" + ti[k] + "'>" + ti[k] + "</a>";
								} else {
									f1 += "<span>,</span>";
									f1 += "<a href='productList?type=typicalIngredient&keyword=" + ti[k] + "'>" + ti[k] + "</a>";
								}
							}
							f1 += "<strong>을(를) 추천드립니다.</strong>";
							f1 += "</div>";
						}
					}
					$("#modalForm2").append(f1);
					$("#modal2").show();
					kakaoMap();
				}
			});
		});
		
		// **** 카카오 지도에 사용할 내 위치좌표 구해놓기 ****
		
		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		// ip geolocation 시작
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} 
			
		function showPosition(position) {
			lat = position.coords.latitude;
			lon = position.coords.longitude;
			console.log('위도: ', lat)
			console.log('경도: ', lon)
		  
		}// ip geolocation 끝
		
	});

	
	
	// **** 카카오 지도 ****
	
	function kakaoMap2() {
		alert('하하하');
		console.log('이이잉');
	}


	function kakaoMap() {
		
		
		console.log('클릭한 후 위도:',lat)
		
		// 지도 모달창 띄우기
		$(".dept2").on("click", function(event) {
			$("#myModal").modal('show');
			console.log("지도 모달1");
			var id = $(this).text();
			$("#kakao-modal-title").text(id);
			
			
				
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			// 지도 시작
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
			        level: 5, // 지도의 확대 레벨
			        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
			        
			    }; 
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
	     	// 현재 나의 위치의 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	        var locPosition2 = new kakao.maps.LatLng(lat, lon);
			var message2 = '<div style="padding:5px;">현재위치!</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        my_displayMarker(locPosition2, message2)
			
			// 현재 위치를 지도에 표시는 마커 함수
			function my_displayMarker(locPosition2, message2) {
		        console.log('locPosition2-> ', locPosition2);
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: locPosition2
			    });
		    
			    var iwContent = message2; // 인포윈도우에 표시할 내용
		        var iwRemoveable = true;

			    // 인포윈도우를 생성합니다
			    var infowindow2 = new kakao.maps.InfoWindow({
			        content : iwContent,
			        removable : iwRemoveable
			    });
			    
			    // 인포윈도우를 마커위에 표시합니다 
			    infowindow2.open(map, marker);
			     
			    // 지도 중심좌표를 접속위치로 변경합니다
			    map.setCenter(locPosition2);    
			    

			    // 마커에 클릭이벤트를 등록합니다
/* 			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			    }); */
			}
			
			    
			
			// 지도 타입 변경 컨트롤을 생성한다
			var mapTypeControl = new kakao.maps.MapTypeControl();
	
			// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	
	
			// 지도에 확대 축소 컨트롤을 생성한다
			var zoomControl = new kakao.maps.ZoomControl();
	
			// 지도의 우측에 확대 축소 컨트롤을 추가한다
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places(); 
			
			// 키워드로 장소를 검색합니다
			//               ↱a태그의 텍스트 즉 검색 키워드가 들어감	
			ps.keywordSearch(id, placesSearchCB, {
				location : new kakao.maps.LatLng(lat, lon),
				radius : 3000
			}); 
			
			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();
			        
			        for (var i=0; i<data.length; i++) {
			            displayMarker(data[i]);
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       
					 
					 
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        //map.setBounds(bounds);
			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			        alert('현재 범위 내 검색 결과가 존재하지 않습니다.');
			        return;

			    } else if (status === kakao.maps.services.Status.ERROR) {

			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;

			    }
			    
			}

			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        //position: locPosition2
			        position: new kakao.maps.LatLng(place.y, place.x) 
			    });
			    
			    

			    // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			    });
			}
			
			
			kakao.maps.event.addListener(map, 'idle', function() {
				var latlng = map.getCenter();
				var lat = latlng.getLat();
				var lng = latlng.getLng();
				
				ps.keywordSearch(id, placesSearchCB, {
					location : new kakao.maps.LatLng(lat, lng),
					radius : 3000
				}); 
			});
			
		});// 지도 끝
		
	} // kakaoMap() 끝
	
	
	// 머리 클릭 이벤트
	function map1(){
		var dd = "";
		$("#modal1").show();
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 12) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 193) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 184) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
		$("#modal1").show();
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
 	 				
 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";

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
		$("#modal1").show();
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 8) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 62) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
		$("#modal1").show();
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 63) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 7) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 135) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
		$("#modal1").show();
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 23) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 54) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
		$("#modal1").show();
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 87) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 41) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 176) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 157) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
 	 	 	 				dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 					}else if(j % 10 == 9 && i != 110) {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
 	 	 	 				dd += "</div>";
 	 					} else {
 	 						dd += "<input type='checkbox' id='symptom' value='" + data[i].symptomCode + "'>" + data[i].symptomName + "&nbsp;";
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
		$("#modalClose1").click(function(){
			$("#modal1").hide();
			$("#modalForm *").remove();
		});
		
		$("#modalClose2").click(function(){
			$("#modal2").hide();
			$("#modalForm2 *").remove();
		});
		
		$("#symptomCheck2").click(function(){
			$("#modal2").hide();
			$("#modalForm2 *").remove();
		});
	});
	
	

		
</script>

<article>

	<h1>아픈 부위나 관심 있는 부위를 선택해 주세요.</h1>
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
	
	<div class="modal" id="modal1" style="overflow: auto;">
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
					<button type="button" class="btn btn-secondary" id="modalClose1">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal" id="modal2" style="overflow: auto;">
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
					<button type="button" class="btn btn-primary" id="symptomCheck2">확인</button>
					<button type="button" class="btn btn-secondary" id="modalClose2">취소</button>
				</div>
			</div>
		</div>
	</div>



	

	
	<!-- 지도 -->
	<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content" style="width: 800px;">
				<div class="modal-header">
					<h5 class="modal-title" id="kakao-modal-title">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="map" style="width:500px;height:400px;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	
	

</article>