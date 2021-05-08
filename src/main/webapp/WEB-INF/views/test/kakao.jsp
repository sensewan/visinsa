<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	
	.disTab{
		margin: 0px auto;
		width: 100%;
		height: 600px;
		overflow: auto;
	}
	
	#table1 {
            width: 100%;
            margin-left: auto;
            margin-right: auto;
            /* background-color: rgba( 255, 255, 255, 1 ); */
        }
       
    .text-muted{
    	display: inline-block;
    	position: relative;
    	text-align: right;
    	margin-top:5px;
    	left : 10px
     }   
	
	.modal{
		margin-top:50px;
	}
	
	.modal-content{
		width:800px;
	}
	
	.content_info{
		width:1200px;
		margin: 0 auto;
	}
	
	.content_wrap{
		margin-top: 80px;
	}
	
	.content{
		height:600px;
	}
	
	.content::after{
		opacity : 0.8;
		height: 600px;
	}
	.div_page_title{
		width:1200px;
		margin: 0 auto;
		margin-top : 10px;
		
	}
	
	.page_title{
		color: #5a5a5a;
    	font-weight: bold;
    	font-size: x-large;
    	margin-left : 10px;
	}
	
	.div_page_title > hr{
		background-color: #5a5a5a;
	    border: 0;
	    height: 2px;
	}
	
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cdb0e08bc78164637f460112638cb43d&libraries=services"></script>

<article>

	<h3>주소</h3>
	<input id="addr" type="text" />
	<input type="button" value="주소검색" onclick="toServer()"/>
	
	<div class="content_wrap">
		<div class="div_page_title">
				<p class="page_title">나의 병명 확인</p>
				<hr/>
		</div>
			<div class="content_info">
				<p class="text-muted" style="font-size: 18px; margin: 10px auto;">
					* 증상 : 

				</p><br/>
				<p class="text-danger" style="font-size: 14px; font-weight:bold; text-align: right; margin-bottom: 3px; margin-right: 5px;">진료과를 선택하면 내 주변에서 해당 진료과에 해당하는 병원을 지도에 나타내줍니다.</p>
				</div>
		
		<div class="content">
			<div class="disTab">
				<table class="table table-hover" id="table1">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="50%">
				</colgroup>
				<thead>
					<tr class="table-primary">
						<th scope="col">번호</th>
						<th scope="col">병명</th>
						<th scope="col">진료과</th>
					</tr>
				</thead>
				
					<tr>
						<td>번호가나</td>
						<td>질병이 나옴</td>
						<td>
			
							<a href="#" class="dept">
							이비인후과
							</a>

						</td>
					</tr>
			
					
				</table>
			</div>

		</div>
	</div>

<!-- 
	<div id="map" style="width:500px;height:400px;">지도</div>
	<a href="" class="dept">지도33</a>
	
	 -->
	
	<!-- 지도 -->
	<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Modal title</h5>
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



<script>
	
	
<%-- 모달 레이어 팝업 --%>
	
   $(document).ready(function(){
	  
   	
		// ip geolocation 시작
		var lat = 37.566826;
		var lon = 126.9786567;
	
		// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} 
			
			
		function showPosition(position) {
			lat = position.coords.latitude;
			lon = position.coords.longitude;
			console.log('위도: ', lat)
			console.log('경도: ', lon)
			
		  
		}
		// ip geolocation 끝
		
		
		
		// 모달창 띄우기
		$(".dept").on("click", function(event) {
			$("#myModal").modal('show');
			var id = $(this).text();
			$(".modal-title").text(id);
			
			
				
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
			
			// 지도 끝
		
		});
   });
	
   
</script>

</article>



