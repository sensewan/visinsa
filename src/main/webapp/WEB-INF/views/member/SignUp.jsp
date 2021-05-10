<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    
    function sample5_execDaumPostcode() {
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
                document.getElementById('sample5_postcode').value = data.zonecode;
                document.getElementById("sample5_roadAddress").value = roadAddr;
                document.getElementById("sample5_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample5_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample5_extraAddress").value = '';
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
	
	//아이디 중복체크
	$(function(){
		$("#success-id").hide();
		$("#danger-id").hide();
		$("#danger-id2").hide();
		$("#id").keyup(function(){
			var check_id = $("#id").val();
			if(check_id.length != 0){
				if(check_id.length >= 4){
					$("#danger-id2").hide();
					$.ajax({
						url : "${pageContext.request.contextPath}/idCheck?checkId="+ check_id,
						type : "get",
						success : function(data) {
							console.log("data = " + data);
							if (data == 1) {
								$("#danger-id").show();
								$("#success-id").hide();
								$("#submit_check_id").val("0");
							} else {
								$("#success-id").show();
								$("#danger-id").hide();
								$("#submit_check_id").val("1");
							}
						}
					});
				} else {
					$("#danger-id2").show();
					$("#success-id").hide();
					$("#danger-id").hide();
				}
			} else {
				$("#success-id").hide();
				$("#danger-id").hide();
				$("#danger-id2").hide();
				$("#submit_check_id").val("0");
			}
		});
	});
	
	
	//비밀번호 확인
	$(function(){
		$("#alert-success").hide();
		$("#alert-danger").hide();
		$("#alert-danger1").hide();
		$("input").keyup(function(){
			var pwd1=$("#pwd1").val();
			var pwd2=$("#pwd2").val();
			if(pwd1.length == 0){
				$("#alert-danger1").hide();
				$("#submit_check_pwd").val("0");
			} else if(pwd1.length < 4 || pwd1.length > 13) {
				$("#alert-danger1").show();
			} else {
				$("#alert-danger1").hide();
			}
			if(pwd1 != "" && pwd2 != ""){
				if(pwd1 == pwd2){
					$("#alert-success").show();
					$("#alert-danger").hide();
					$("#submit_check_pwd").val("1");
				}else{
					$("#alert-success").hide();
					$("#alert-danger").show();
					$("#submit_check_pwd").val("0");
				}
			} else {
				$("#alert-success").hide();
				$("#alert-danger").hide();
			}
		});
	});
	
	//닉네임 중복체크
	$(function(){
		$("#success-nk").hide();
		$("#danger-nk").hide();
		$("#nk").keyup(function(){
			var check_nk = $("#nk").val();
			if(check_nk.length != 0){
				$.ajax({
					url : "${pageContext.request.contextPath}/nkCheck?checkNk="+ check_nk,
					type : "get",
					success : function(data) {
						console.log("data = " + data);
						if (data == 1) {
							$("#danger-nk").show();
							$("#success-nk").hide();
							$("#submit_check_nk").val("0");
						} else {
							$("#success-nk").show();
							$("#danger-nk").hide();
							$("#submit_check_nk").val("1");
						}
					}
				});
			} else {
				$("#success-nk").hide();
				$("#danger-nk").hide();
				$("#submit_check_nk").val("0");
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
	$(function(){
		var date = new Date();
		var com_year = date.getFullYear();
		var year = "";
		
		for (var y = com_year; y >= com_year - 100; y--) {
			$("#year").append("<option value='" + y + "'>" + y + "</option>");
		}
		for (var m = 1; m <= 12; m++) {
			$("#month").append("<option value='" + m + "'>" + m + "</option>");
		}
		for (var d = 1; d <= 31; d++) {
			$("#day").append("<option value='" + d + "'>" + d + "</option>");
		}
	});
	
	//이메일 입력
	$(function(){
		$("#selectEmail").change(function(){
			if($(this).val() == "1"){
				$("#email3").val("");
				$("#email3").attr("readonly", false);
			}else{
				$("#email3").val($(this).val());
				$("#email3").attr("readonly", true);
			}
		});
	});
	
	//구매자 판매자 구별
	$(function(){
		$("#buyer").click(function(){
			$(this).attr("class", "btn btn-primary")
			$("#seller").attr("class", "btn btn-secondary")
			$("#sell").val(0);
		});
		$("#seller").click(function(){
			$(this).attr("class", "btn btn-primary")
			$("#buyer").attr("class", "btn btn-secondary")
			$("#sell").val(1);
		});
	});
	
	//의사 약사 일반인 구별
	$(function(){
		$("#general").click(function(){
			$(this).attr("class", "btn btn-primary")
			$("#doctor").attr("class", "btn btn-secondary")
			$("#chemist").attr("class", "btn btn-secondary")
			$("#doctornchemist1").hide();
			$("#doctornchemist2").hide();
			$("#medi").val(0);
		});
		$("#doctor").click(function(){
			$(this).attr("class", "btn btn-primary")
			$("#general").attr("class", "btn btn-secondary")
			$("#chemist").attr("class", "btn btn-secondary")
			$("#doctornchemist1").show();
			$("#doctornchemist2").show();
			$("#medi").val(1);
		});
		$("#chemist").click(function(){
			$(this).attr("class", "btn btn-primary")
			$("#doctor").attr("class", "btn btn-secondary")
			$("#general").attr("class", "btn btn-secondary")
			$("#doctornchemist1").show();
			$("#doctornchemist2").show();
			$("#medi").val(2);
		});
	});
	
	//회원가입 폼체크
	$(function(){
		$("#submitForm").on("click", function() {
			if($('#id').val().length <= 0) {
				alert("아이디가 입력되지 않았습니다.\n아이디를 입력해 주세요");			
				$("#id").focus();
				return false;
			}
			if($("#submit_check_id").val() != "1") {
				alert("아이디를 확인해주세요.");
				return false;
			}
			if($("#pwd1").val().length <= 0) {
				alert("비밀번호가 입력되지 않았습니다.\n비밀번호를 입력해 주세요");			
				$("#pwd1").focus();
				return false;
			}
			if($("#pwd2").val().length <= 0) {
				alert("비밀번호를 확인하지 않았습니다.\n비밀번호를 확인해 주세요");			
				$("#pwd2").focus();
				return false;
			}
			if($("#nk").val().length <= 0) {
				alert("닉네임이 입력되지 않았습니다.\n닉네임을 입력해 주세요");			
				$("#nk").focus();
				return false;
			}
			if($("#submit_check_nk").val() != "1") {
				alert("닉네임을 확인해주세요.");
				return false;
			}
			if($("#phone1").val().length <= 0) {
				alert("핸드폰번호가 입력되지 않았습니다.\n핸드폰번호를 입력해 주세요");			
				$("#phone1").focus();
				return false;
			}
			if($("#phone2").val().length <= 0) {
				alert("핸드폰번호가 입력되지 않았습니다.\n핸드폰번호를 입력해 주세요");			
				$("#phone2").focus();
				return false;
			}
			if($("#name").val().length <= 0) {
				alert("이름이 입력되지 않았습니다.\n이름을 입력해 주세요");			
				$("#name").focus();
				return false;
			}
			if($("#email1").val().length <= 0) {
				alert("이메일이 입력되지 않았습니다.\n이메일을 입력해 주세요");			
				$("#email1").focus();
				return false;
			}
			if($("#email3").val().length <= 0) {
				alert("이메일이 입력되지 않았습니다.\n이메일을 입력해 주세요");			
				$("#email3").focus();
				return false;
			}
			if($("#sample4_detailAddress").val().length <= 0 || $("#sample4_postcode").val().length <=0) {
				alert("주소가 입력되지 않았습니다.\n주소를 입력해 주세요");			
				$("#sample4_detailAddress").focus();
				return false;
			}
		});
	});

</script>
<body>
	<div class="wrap">
	<div class="container" style="width: 960px;">
		<form name="SignUpForm" id="SignUpForm" action="joinInfo" method="post">
			<fieldset style="margin-top: 50px;">
				<legend style="text-align: center">회원가입</legend>
				<input type="hidden" name="sell" id="sell" value="0">
				<input type="hidden" name="medi" id="medi" value="0">
				<input type="hidden" id="submit_check_id" value="0">
				<input type="hidden" id="submit_check_pwd" value="0">
				<input type="hidden" id="submit_check_nk" value="0">
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<div class="row">
					<div class="col-sm-10">
						<input type="button" style="width:50%; display:inline;" class="btn btn-primary" name="buyer" id="buyer" value="구매자">
						<input type="button" style="width:49%; display:inline;" class="btn btn-secondary" name="seller" id="seller" value="판매자">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<div class="row">
					<div class="col-sm-10">
						<input type="button" style="width:32%; display:inline;" class="btn btn-primary" name="general" id="general" value="일반인">
						<input type="button" style="width:33%; display:inline;" class="btn btn-secondary" name="doctor" id="doctor" value="의사">
						<input type="button" style="width:33%; display:inline;" class="btn btn-secondary" name="chemist" id="chemist" value="약사">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="id" class="col-sm-3 col-form-label">아이디 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" class="form-control" name="id" id="id" placeholder="Id" maxlength="20">
					</div>
					</div>
					<div class="alert alert-success" id="success-id" style="margin-top: 10px">사용가능한 아이디입니다.</div> 
					<div class="alert alert-danger" id="danger-id" style="margin-top: 10px">사용할수없는 아이디입니다.</div>
					<div class="alert alert-danger" id="danger-id2" style="margin-top: 10px">4~20자를 사용하세요.</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwd1" class="col-sm-3 col-form-label">비밀번호 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="password" class="form-control" name="pwd1" id="pwd1" placeholder="PassWord" maxlength=13>
					</div>
					</div>
					<div class="alert alert-danger" id="alert-danger1" style="margin-top: 10px">4~13자를 사용하세요.</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwd2" class="col-sm-3 col-form-label">비밀번호 확인 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="PassWord" maxlength=13>
					</div>
					</div>
					<div class="alert alert-success" id="alert-success" style="margin-top: 10px">비밀번호가 일치합니다.</div> 
					<div class="alert alert-danger" id="alert-danger" style="margin-top: 10px">비밀번호가 일치하지 않습니다.</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwdQuestion" class="col-sm-3 col-form-label">비밀번호 질문 : </label>
					<div class="row">
					<div class="col-sm-10">
						<select class="form-control" name="pwdQuestion" id="pwdQuestion">
							<option value="기억에 남는 추억의 장소는?">기억에 남는 추억의 장소는?</option>
							<option value="자신의 인생 좌우명은?">자신의 인생 좌우명은?</option>
							<option value="자신의 보물 제1호는?">자신의 보물 제1호는?</option>
							<option value="가장 기억에 남는 선생님 성함은?">가장 기억에 남는 선생님 성함은?</option>
							<option value="인상 깊게 읽은 책 이름은?">인상 깊게 읽은 책 이름은?</option>
						</select>
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="pwdAnswer" class="col-sm-3 col-form-label">비밀번호 답변 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" class="form-control" name="pwdAnswer" id="pwdAnswer" placeholder="answer">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="nk" class="col-sm-3 col-form-label">닉네임 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" class="form-control" name="nk" id="nk" placeholder="NickName">
					</div>
					</div>
					<div class="alert alert-success" id="success-nk" style="margin-top: 10px">사용가능한 닉네임입니다.</div> 
					<div class="alert alert-danger" id="danger-nk" style="margin-top: 10px">사용할수없는 닉네임입니다.</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="phone0" class="col-sm-3 col-form-label">핸드폰번호 : </label>
					<div class="row">
					<div class="col-sm-10" >
						<select style="width:32%; display:inline; text-align-last: center;" class="form-control" name="phone0" id="phone0">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="012">012</option>
						</select> - 
						<input type="text" style="width:32%; display:inline; text-align-last: center;" class="form-control" name="phone1" id="phone1" placeholder="Phone" maxlength="4"> - 
						<input type="text" style="width:31%; display:inline; text-align-last: center;" class="form-control" name="phone2" id="phone2" placeholder="Phone" maxlength="4">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="year" class="col-sm-3 col-form-label">생년월일 : </label>
					<div class="row">
					<div class="col-sm-10">
						<select style="width:31%; display:inline; text-align-last: center;" class="form-control" name="year" id="year"></select>년   
						<select style="width:30%; display:inline; text-align-last: center;" class="form-control" name="month" id="month"></select>월   
						<select style="width:30%; display:inline; text-align-last: center;" class="form-control" name="day" id="day"></select>일
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="name" class="col-sm-3 col-form-label">이 름 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" class="form-control" name="name" id="name" placeholder="Name">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label for="email1" class="col-sm-3 col-form-label">이 메 일 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" style="width:33%; display:inline;" class="form-control" name="email1" id="email1" placeholder="email"> @
						<select style="width:31%; display:inline;" class="form-control" id="selectEmail">
							<option value="1">직접 입력</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="daum.net">daum.net</option>
						</select>
						<input type="text" style="width:31%; display:inline;" class="form-control" name="email2" id="email3">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px;">
					<label class="col-sm-3 col-form-label">주 소 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="postcode1" id="sample4_postcode" placeholder="우편번호" readonly>
						<input type="button" style="width: 20%; display:inline;" class="form-control" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					</div>
					</div>
					<div class="row" style="margin-top:10px;">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="roadAddress1" id="sample4_roadAddress" placeholder="도로명주소" readonly>
						<input type="text" style="width: 49%; display:inline;" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" readonly>
						<span id="guide" style="color:#999;display:none"></span>
					</div>
					</div>
					<div class="row" style="margin-top:10px;">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="detailAddress1" id="sample4_detailAddress" placeholder="상세주소">
						<input type="text" style="width: 49%; display:inline;" class="form-control" name="extraAddress1" id="sample4_extraAddress" placeholder="참고항목" readonly>
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px; display:none" id="doctornchemist1" >
					<label for="CompanyName" class="col-sm-3 col-form-label">상 호 명 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" class="form-control" name="CompanyName" id="CompanyName" placeholder="Company Name">
					</div>
					</div>
				</div>
				
				<div class="form-group" style="font-size: 16px; margin-left: 150px; display:none" id="doctornchemist2" >
					<label class="col-sm-3 col-form-label">근 무 지 : </label>
					<div class="row">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="postcode2" id="sample5_postcode" placeholder="우편번호" readonly>
						<input type="button" style="width: 20%; display:inline;" class="form-control" onclick="sample5_execDaumPostcode()" value="우편번호 찾기"><br>
					</div>
					</div>
					<div class="row" style="margin-top:10px;">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="roadAddress2" id="sample5_roadAddress" placeholder="도로명주소" readonly>
						<input type="text" style="width: 49%; display:inline;" class="form-control" id="sample5_jibunAddress" placeholder="지번주소" readonly>
						<span id="guide" style="color:#999;display:none"></span>
					</div>
					</div>
					<div class="row" style="margin-top:10px;">
					<div class="col-sm-10">
						<input type="text" style="width: 50%; display:inline;" class="form-control" name="detailAddress2" id="sample5_detailAddress" placeholder="상세주소">
						<input type="text" style="width: 49%; display:inline;" class="form-control" name="extraAddress2" id="sample5_extraAddress" placeholder="참고항목" readonly>
					</div>
					</div>
				</div>
				
				<div style="text-align: center; margin-bottom:50px;">
					<input type="submit" class="btn btn-primary" id="submitForm" value="가입하기" />		
				</div>
			</fieldset>
		</form>
	</div>
	</div>
</body>

