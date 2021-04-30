package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.domain.Community;
import com.project.domain.CommunityReply;

public interface CommunityService {
	
	public abstract Map<String, Object> CommunityBoardList(
			int pageNum, String type, String keyword);
	 
	  public abstract List<Community> CommunityBoard();
	  
	  public abstract Community getBoard(int no, boolean isCount);
 
	  public abstract List<CommunityReply> replyList(int no);
	  
	  
	  public abstract void insertBoard(Community board);
	  
	  
	  /*
	  public abstract void updateBoard(Community board);
	  
	  public abstract void deleteBoard(int no);
	  
	  public Map<String, Integer> recommend(int no, String recommend);
	  
	  public void addReply(Reply reply);
	  
	  public void updateReply(Reply reply);
	  
	  public void deleteReply(int no); */
	 
}
