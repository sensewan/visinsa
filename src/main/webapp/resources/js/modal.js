$(function() {
	

	$('.openModalBtn').on('click', function(){
		$('#modalBox').modal('show');
		
		
		console.log("click open");
		});
		// 모달 안의 취소 버튼에 이벤트를 건다.
		$('#closeModalBtn').on('click', function(){
		$('#modalBox').modal('hide');
		console.log("click close");
		});
		$('#modalBox').on('show.bs.modal', function (e) {
		console.log("show.bs.modal");
		});
		$('#modalBox').on('shown.bs.modal', function (e) {
		console.log("shown.bs.modal");
		});
		$('#modalBox').on('hide.bs.modal', function (e) {
		console.log("hide.bs.modal");
		});
		$('#modalBox').on('hidden.bs.modal', function (e) {
		console.log("hidden.bs.modal");
	
		
		
		
		
		
		});
	
		
		$('#closeModalBtn').on('click', function(){
			$('#modalBox').modal('hide');
			});

});