// DOM(Document Object Model)이 준비 되었다면
$(document).ready(function() {
	
	$("#commend").click(function() {		
		$.ajax({			
			url: "recommend.ajax",
			
			// type을 지정하지 않으면 get 방식 요청이다.
			type: "post",
			
			// 파라미터로 보낼 데이터를 객체 리터럴로 지정하고 있다.
			data : { recommend: "recommend", no : $("#no").val()},

			/* RecommendAction 클래스에서 Gson 라이브러리를 이용해
			 * 응답 데이터를 json 형식으로 출력했기 때문에 dataType을 json
			 * 으로 지정해야 한다. 응답 데이터를 json 형식으로 받았기 때문에 
			 * Ajax 통신이 성공하면 실행될 함수의 첫 번째 인수로 지정한 
			 * data는 자바스크립트 객체이므로 닷(.) 연산자를 이용해 접근할 수 있다. 
			 **/
			dataType: "json",
			success: function(data) {	
				/* 추천하기가 반영된 것을 사용자에게 알리고 
				 * 응답으로 받은 갱신된 추천하기 데이터를 화면에 표시한다.
				 **/ 
				alert("추천하기가 반영 되었습니다.");
				$("#commend > .recommend").text(" (" + data.recommend + ")");
			},
			error: function(xhr, status, error) {
				alert("error : " + xhr.statusText + ", " + status + ", " + error);
			}
		});
	}).hover(function() {
		$(this).css({cursor: "pointer"});
	});
	
	
	
	$("#replycommend").click(function() {		
		$.ajax({			
			url: "replyrecommend.ajax",
			
			type: "post",
			
			data : { replyrecommend: "replyrecommend", no : $("#replyno").val()},

			/* RecommendAction 클래스에서 Gson 라이브러리를 이용해
			 * 응답 데이터를 json 형식으로 출력했기 때문에 dataType을 json
			 * 으로 지정해야 한다. 응답 데이터를 json 형식으로 받았기 때문에 
			 * Ajax 통신이 성공하면 실행될 함수의 첫 번째 인수로 지정한 
			 * data는 자바스크립트 객체이므로 닷(.) 연산자를 이용해 접근할 수 있다. 
			 **/
			dataType: "json",
			success: function(data) {	
				/* 추천하기가 반영된 것을 사용자에게 알리고 
				 * 응답으로 받은 갱신된 추천하기 데이터를 화면에 표시한다.
				 **/ 
				alert("추천하기가 반영 되었습니다.");
				$("#replycommend > .replyrecommend").text(" (" + data.replyrecommend + ")");
			},
			error: function(xhr, status, error) {
				alert("error : " + xhr.statusText + ", " + status + ", " + error);
			}
		});
	}).hover(function() {
		$(this).css({cursor: "pointer"});
	});
	
	
	
});