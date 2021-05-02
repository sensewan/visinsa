$(function() {

	/* 게시 글 상세보기에서 게시 글 수정 폼 요청 처리
	 * 아래와 같이 hidden 폼을 통해 post 방식으로 처리 할 수 있다.
	 **/
	$("#detailUpdate").on("click", function() {
				
		$("#checkForm").attr("action", "Communityupdate");
		$("#checkForm").submit();
	});

	$("#detailDelete").on("click", function() {
			
		var del = confirm("정말로 삭제 하시겠습니까?");
		
		if(del){
			$("#checkForm").attr("action", "delete");
			$("#checkForm").attr("method", "post");
			$("#checkForm").submit();
			
		}else{
			return false;
		}
	});
	
	// 게시 글쓰기 폼 유효성 검사
	$("#writeForm").on("submit", function() {
		if($("#writer").val().length <= 0) {
			alert("작성자가 입력되지 않았습니다.\n작성자를 입력해주세요");
			$("#writer").focus();			
			return false;
		}
		if($("#title").val().length <= 0) {
			alert("제목이 입력되지 않았습니다.\n제목을 입력해주세요");
			$("#title").focus();
			return false;
		}
		if($("#pass").val().length <= 0) {
			alert("비밀번호가 입력되지 않았습니다.\n비밀번호를 입력해주세요");
			$("#pass").focus();
			return false;
		}
		if($("#content").val().length <= 0) {
			alert("내용이 입력되지 않았습니다.\n내용을 입력해주세요");
			$("#content").focus();
			return false;
		}
	});

	// 게시 글 수정 폼 유효성 검사
	$("#updateForm").on("submit", function() {
		
	});
	
	// 게시 글 리스트, 검색 결과 페이지에서 검색 요청 처리
	$("#searchForm").on("submit", function() {
		var keyword = $("#keyword").val();
		if(keyword.length <= 0) {
			alert("검색어가 입력되지 않았습니다.\n검색어를 입력해주세요");
			return false;
		}		
		$(this).attr("method", "post");
		$(this).attr("action", "boardList");		
	});	
	
	$("#categoryFilter").on("click", function() {
		$("#catcat").val($(this).attr("id"));
		$("#categoryFilterForm").submit();
				
	});	
});