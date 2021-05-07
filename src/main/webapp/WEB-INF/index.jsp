<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="resources/css/main_css.css" />
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script src="resources/js/formcheck.js"></script>
<script src="resources/js/member.js"></script>

<style type="text/css">
	body {
		width: 100%;
		height: 100%;
	}
	#imgs {
		margin: 0px auto;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}
	ul { list-style: none; }
	#imgs ul { 
		width: 100%; height: 488px; position: relative; 	
	}
	#imgs ul li {		
		width: 100%; height: 488px; position: absolute;
	}
	#imgs .visual_01 { 
		left: 0%; 
		background: 0 0 no-repeat; 
		background: url('image/main_t1.jpg') 0 0 no-repeat;		
	}
	#imgs .visual_02 { 
		left: 100%; 
		background: url('image/main_t2.jpg') 0 0 no-repeat; 
	}
	#imgs .visual_03 { 
		left: 200%; 
		background: url('image/main_t3.jpg') 0 0 no-repeat;
	}	
	#btnList li {
		background: url('image/btnVisual.png') 0px -16px no-repeat;
		width: 14px;
		height: 15px;
		float: left; /* 버튼 이미지를 수평으로 놓음 */
		left: 50%;
		bottom: 50px;
		position: relative;
		margin: 0px 5px;
		cursor: pointer;
	}
	#btnList li.on { background-position: 0 0; }
	#btnList li > a{ display: block; text-indent: -9999px; }
	
	div.main {
		min-height: 650px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<!-- <script src="js/jquery-3.3.1.min.js"></script> -->

<script>

</script>

</head>


<body>
	<div class="wrap" style="min-width: 1000px;">
		<!-- 헤더 가져오기 -->
		<jsp:include page="views/pages/header.jsp" />
		
		
		<!-- 메인영역 -->
		<c:if test="${ empty param.body }">
		<div class="content">
			<h1>테스트1</h1>
		</div>
		</c:if>
		
		
		<c:if test="${ not empty param.body }">
		<div>
			<jsp:include page="${ param.body }" />
		</div>
		</c:if>	
	</div>
</body>
</html>