<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/main_css.css" />
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/member.js"></script>
<script src="js/formcheck.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script type="text/javascript"> 
	//비밀번호 확인
	$(function(){
		$("#alert-success").hide();
		$("#alert-danger").hide();
		$("input").keyup(function(){
			var pwd1=$("#pwd1").val();
			var pwd2=$("#pwd2").val();
			if(pwd1 != "" && pwd2 != ""){
				if(pwd1 == pwd2){
					$("#alert-success").show();
					$("#alert-danger").hide();
				}else{
					$("#alert-success").hide();
					$("#alert-danger").show();
				}
			} else {
				$("#alert-success").hide();
				$("#alert-danger").hide();
			}
		});
	});
	
	//핸드폰번호 이동
	$(function(){
		$("#phone1").keyup(function(){
			var phone1 = $("#phone1").val();
			if(phone1.length == 4){
				$("#phone2").focus();
			}
		})
	});
	
	//생년월일
	
	$(document).ready(function () {
		appendYear();
 	 });
	
	function appendYear(){
		
		var date = new Date();
		var com_year = date.getFullYear();
		var year = "";
		$("#year").append("<option value=''>" + com_year + "</option>");
		
		for (var y = com_year - 1; y >= com_year - 100; y--) {
		      $("#year").append("<option value='" + y + "'>" + y + "</option>");
		}
	}

</script>
</head>
<body>
	<div class="wrap">
	<div class="container" style="width: 860px;">
		<form id="SignUpForm" action="SignUpProcess.mvc" method="post">
			<fieldset style="margin-top: 50px;">
				<legend style="text-align: center">회원가입</legend>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="id" class="col-sm-3 col-form-label">아이디 : </label>
					<div class="row">
					<div class="col-sm-8">
						<input type="text" class="form-control" name="id" id="id" placeholder="Id" onkeydown="inputIdCheck()">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwd" class="col-sm-3 col-form-label">비밀번호 : </label>
					<div class="row">
					<div class="col-sm-8">
						<input type="password" class="form-control" name="pwd" id="pwd1" placeholder="PassWord">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwd" class="col-sm-3 col-form-label">비밀번호 확인 : </label>
					<div class="row">
					<div class="col-sm-8">
						<input type="password" class="form-control" name="pwd" id="pwd2" placeholder="PassWord">
					</div>
					</div>
					<div class="alert alert-success" id="alert-success" style="margin-top: 10px">비밀번호가 일치합니다.</div> 
					<div class="alert alert-danger" id="alert-danger" style="margin-top: 10px">비밀번호가 일치하지 않습니다.</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="nk" class="col-sm-3 col-form-label">닉네임 : </label>
					<div class="row">
					<div class="col-sm-8">
						<input type="text" class="form-control" name="nk" id="nk" placeholder="NickName" onkeydown="inputNkCheck()">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="phone" class="col-sm-3 col-form-label">핸드폰번호 : </label>
					<div class="row">
					<div class="col-sm-8" >
						<select style="width:31%; display:inline;" class="form-control">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="012">012</option>
						</select> - 
						<input type="text" style="width:31%; display:inline;" class="form-control" name="phone1" id="phone1" placeholder="Phone" maxlength="4"> - 
						<input type="text" style="width:31%; display:inline;" class="form-control" name="phone2" id="phone2" placeholder="Phone" maxlength="4">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="birth" class="col-sm-3 col-form-label">생년월일 : </label>
					<div class="row">
					<div class="col-sm-8">
						<select style="width:31%; display:inline;" class="form-control" id="year">

						</select>
						<input type="text" class="form-control" name="birth" id="birth" placeholder="Birth">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="name" class="col-sm-3 col-form-label">이 름 : </label>
					<div class="row">
					<div class="col-sm-8">
						<input type="text" class="form-control" name="name" id="name" placeholder="Name"">
					</div>
					</div>
				</div>
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="address" class="col-sm-3 col-form-label">주 소 : </label>
					<div>
						<input type="text" id="sample4_postcode" placeholder="우편번호" readonly>
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample4_roadAddress" placeholder="도로명주소" readonly>
						<input type="text" id="sample4_jibunAddress" placeholder="지번주소" readonly>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" placeholder="상세주소">
						<input type="text"  id="sample4_extraAddress" placeholder="참고항목" readonly>
					</div>
				</div>
				<div style="text-align: center;">
					<input type="submit" class="btn btn-success" id="submitForm" value="가입하기" />		
				</div>
			</fieldset>
		</form>
	</div>
	</div>
</body>
</html>

