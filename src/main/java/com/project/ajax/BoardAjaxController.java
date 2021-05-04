package com.project.ajax;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.Reply;
import com.project.service.CommunityService;

@Controller
public class BoardAjaxController {
	
	@Autowired
	CommunityService CommunityService;
	
	
	@RequestMapping("/recommend.ajax")
	@ResponseBody
	public Map<String, Integer> recommend(int no, String recommend) {
		
				
		return CommunityService.recommend(no, recommend);		
	}
	

	
	// 댓글 쓰기 요청을 처리하는 메서드
	
	@RequestMapping("/replyWrite.ajax")
	@ResponseBody
	public List<Reply> addReply(Reply reply) {
		
		// 새로운 댓글을 등록한다.
		CommunityService.addReply(reply);
		
	
		return CommunityService.replyList(reply.getBbsNo());
	}
	
	// 댓글 수정 요청을 처리하는 메서드	
	@RequestMapping("/replyUpdate.ajax")
	@ResponseBody
	public List<Reply> updateReply(Reply reply) {
		
		// 새로운 댓글을 등록한다.
		CommunityService.updateReply(reply);
		
		// 새롭게 갱신된 댓글 리스트를 가져와 반환한다.
		return CommunityService.replyList(reply.getBbsNo());
	}
	
	// 댓글 삭제 요청을 처리하는 메서드
	@RequestMapping("/replyDelete.ajax")
	@ResponseBody
	public List<Reply> deleteReply(int no, int bbsNo) {
		
		// 새로운 댓글을 등록한다.
		CommunityService.deleteReply(no);
		
		// 새롭게 갱신된 댓글 리스트를 가져와 반환한다.
		return CommunityService.replyList(bbsNo);
	}
	
	
	@RequestMapping("/replyrecommend.ajax")
	@ResponseBody
	public Map<String, Integer> replyrecommend(int no, String replyrecommend) {
		
				
		return CommunityService.replyrecommend(no, replyrecommend);		
	}
	
	

	
	
}
