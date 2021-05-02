package com.project.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.dao.CommunityDao;
import com.project.domain.Community;
import com.project.domain.CommunityReply;

@Service
public class CommunityServiceImpl implements CommunityService {

	private static final int PAGE_SIZE = 10;
	
	private static final int PAGE_GROUP = 10;
	
	@Autowired
	private CommunityDao CommunityDao;
	
	public void setCommunityDao(CommunityDao CommunityDao) {
		this.CommunityDao = CommunityDao;
	}
	
	
	@Override
	public Map<String, Object> CommunityBoardList(
			int pageNum, String type, String keyword, String category) {
		
		int currentPage = pageNum;
				
	
		int startRow = (currentPage - 1) * PAGE_SIZE;		
		int listCount = 0;
		

		boolean searchOption = (type.equals("null") 
				|| keyword.equals("null")) ? false : true; 
		

		listCount = CommunityDao.getCommunityBoardCount(type, keyword);		
		System.out.println("listCount : " + listCount + ", type : " 
					+ type + ", keyword : " + keyword);
		

		if(listCount > 0) {
			

			List<Community> CommunityBoardList = CommunityDao.CommunityBoardList(
					startRow, PAGE_SIZE, type, keyword, category);

			int pageCount = 
					listCount / PAGE_SIZE + (listCount % PAGE_SIZE == 0 ? 0 : 1);
			
			int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
					- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);		
						
			int endPage = startPage + PAGE_GROUP - 1;
			

			if(endPage > pageCount) {
				endPage = pageCount;
			}
						

			Map<String, Object> modelMap = new HashMap<String, Object>();		
			
			modelMap.put("CommunityBoardList", CommunityBoardList);
			modelMap.put("pageCount", pageCount);
			modelMap.put("startPage", startPage);
			modelMap.put("endPage", endPage);
			modelMap.put("currentPage", currentPage);
			modelMap.put("listCount", listCount);
			modelMap.put("pageGroup", PAGE_GROUP);
			modelMap.put("searchOption", searchOption);
			
			if(searchOption) {
				

				try {
					modelMap.put("keyword", URLEncoder.encode(keyword, "utf-8"));
				} catch (UnsupportedEncodingException e) {					
					e.printStackTrace();
				}
				modelMap.put("word", keyword);
				modelMap.put("type", type);
			}
			
			return modelMap;			
		} else {
			return null;
		}
	}
	
	
	  @Override 
	  public List<Community> CommunityBoard() {
		  return  CommunityDao.CommunityBoardList(0, 10, "null", "null", "CommunityBoardList"); }
	  
	  
	  @Override 
	  public Community getBoard(int no, boolean isCount) { 
		  return  CommunityDao.getBoard(no, isCount); 
		  }
	  
	  public List<CommunityReply> replyList(int no) {
		  return CommunityDao.replyList(no); 
		  }
	  
	  
	  
	  @Override public void insertBoard(Community board) {
	  CommunityDao.insertBoard(board); 
	  }
	  
	  
	  
	  @Override public void updateBoard(Community board) {
	  CommunityDao.updateBoard(board); 
	  }
	  
	  
	  @Override public void deleteBoard(int no) { CommunityDao.deleteBoard(no); }
	  
	  
	  
	  public Map<String, Integer> recommend(int no, String recommend) {
	  
	  CommunityDao.updateRecommend(no, recommend);
	  Community board = CommunityDao.getRecommend(no);
	  
	  Map<String, Integer> map = new HashMap<String, Integer>();
	  map.put("recommend", board.getRecommend());
	  
	  return map; 
	  }
	  
	  /*
	  
	  public void addReply(Reply reply) { CommunityDao.addReply(reply); }
	  
	  public void updateReply(Reply reply) { CommunityDao.updateReply(reply); }
	  
	  public void deleteReply(int no) { CommunityDao.deleteReply(no); }
	 */
	
}
