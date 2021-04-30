package com.project.dao;

import java.util.List;

import com.project.domain.Community;
import com.project.domain.CommunityReply;

public interface CommunityDao {
	
	public abstract List<Community> CommunityBoardList(
			int startRow, int num, String type, String keyword);
	
	public abstract int getCommunityBoardCount(String type, String keyword);
	
	
	  public abstract Community getBoard(int no, boolean isCount);
	  
	  public abstract List<CommunityReply> replyList(int no);
	  
	  
	  public abstract void insertBoard(Community board);
	  
	  
	  /*
	  public abstract void updateBoard(Community board);
	  
	  public abstract void deleteBoard(int no);
	  
	  
	  

	  
	  public abstract void updateRecommend(int no, String recommend);
	  
	  public abstract Community getRecommend(int no);
	  
	  public void addReply(Reply reply);
	  
	  public void updateReply(Reply reply);
	  
	  public void deleteReply(int no);
	 */
}
