<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<title>세션을 이용한 사용자 로그인 유지하기</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/main_css.css" />
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/member.js"></script>
</head>
<body>
<div class="wrap">
	<div class="clear"></div>
	<div class="form">
		<div class="container" style="width: 400px; margin-top: 100px;">
			<form id="login_check" action="login" method="post">
				<p class="input">
					<label for="id" class="col-form-label">아 이 디 : </label>
					<input class="form-control" type="text" placeholder="Id" name="id" id="id" /></p>
				<p class="input">
					<label for="pwd" class="col-form-label">비밀번호 : </label>
					<input class="form-control" type="password" placeholder="PassWord" name="pwd" id="pwd" /></p>
				<div style="text-align: center;">
					<input class="btn btn-primary" type="submit" value="로그인" />
				</div>
				<div style="text-align: center; margin-top: 10px;">
					<a href="#">비밀번호 찾기</a>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>