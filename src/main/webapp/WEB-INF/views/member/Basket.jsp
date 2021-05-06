<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/main_css.css" />
<script src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	var IMP = window.IMP;
	IMP.init('imp19285602');
	$(function(){
		$("#pay").on("click", function(){
			IMP.request_pay({
			    pg : 'kakaopay',
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '주문명:결제테스트',
			    amount : ${total},
			    buyer_email : 'sju04015@naver.com',
			    buyer_name : '우광현',
			    buyer_tel : '010-6414-9034',
			    buyer_addr : '서울특별시 양천구',
			    buyer_postcode : '123-456',
			    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			}, function(rsp) {
				if ( rsp.success ) {
			    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
			    	jQuery.ajax({
			    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
			    		type: 'POST',
			    		dataType: 'json',
			    		data: {
				    		imp_uid : rsp.imp_uid
				    		//기타 필요한 데이터가 있으면 추가 전달
			    		}
			    	}).done(function(data) {
			    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
			    		if ( everythings_fine ) {
			    			var msg = '결제가 완료되었습니다.';
			    			msg += '\n고유ID : ' + rsp.imp_uid;
			    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
			    			msg += '\결제 금액 : ' + rsp.paid_amount;
			    			msg += '카드 승인번호 : ' + rsp.apply_num;
			    			
			    			alert(msg);
			    		} else {
			    			//[3] 아직 제대로 결제가 되지 않았습니다.
			    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
			    		}
			    	});
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			        
			        alert(msg);
			    }
			});
		});
	});
</script>
</head>
<body>
	<div class="wrap">
		<div class="content">
		</div>
	<div class="tb">
		<div class="btn-group-vertical" id="button" style="margin: 10px;">
			<button type="button" name="MemberUpdate" id="MemberUpdate" class="btn btn-primary">개인정보 변경하기</button>
			<button type="button" name="MyContent" id="MyContent" class="btn btn-primary">나의 작성글</button>
			<button type="button" name="MemberDel" id="MemberDel" class="btn btn-primary">회원 탈퇴</button>
		</div>
	</div>
		<div class="container" style="width: 860px; min-width:400px; margin-top: -140px;">
			<div id="h2" class="row" style="text-align:center; margin:0 auto;">
				<h2 class="col-sm-8" style="margin-bottom: 30px;">장바구니</h2>
				<h6 class="col-sm-4" style="padding-top: 10px;">총 금액 : <fmt:formatNumber value="${ total }" type="currency"/></h6>
			</div>
			<div id="content">
				<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">상품</th>
						<th scope="col">금액</th>
						<th scope="col">개수</th>
						<th scope="col">합계</th>
					</tr>
				</thead>
				<!-- 게시 글이 있는 경우 - 게시 글 리스트가 비어있지 않으면 -->
				<c:if test="${ not empty basket }">
				<c:forEach var="b" items="${ basket }" varStatus="status">
					<tr class="listTr">
						<td class="listTdTitle" style="text-align:left;"><a href="productDetail?no=${ b.num }">${b.productName }</a></td>
						<td class="listTdNo"><fmt:formatNumber value="${ b.productPrice }" type="currency"/></td>
						<td class="listTdRegDate">${ b.count }개</td>
						<td class="listTdNo"><fmt:formatNumber value="${ b.price }" type="currency"/></td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ empty basket }">
				<tr>
					<td colspan="4" class="listTdSpan">담은 상품이 존재하지 않습니다.</td>
				</tr>
				</c:if>
			</table>
			<div>
				<input type="button" class="btn btn-primary" id="pay" value="결제하기">
			</div>
			</div>
		</div>
	</div>
</body>
</html>