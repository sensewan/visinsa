package com.project.dao;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.domain.Community;
import com.project.domain.Reply;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	private final String NAME_SPACE = "com.springstudy.bbs.mapper.CommunityMapper";

	private SqlSessionTemplate sqlSession;

	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Community> CommunityBoardList(int startRow,
			int num, String type, String keyword, String category) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startRow", startRow);
		params.put("num", num);
		params.put("type", type);
		params.put("keyword", keyword);
		params.put("category", category);

		return sqlSession.selectList(NAME_SPACE + ".CommunityBoardList", params);
	}
	
	  @Override 
	  public int getCommunityBoardCount(String type, String keyword, String category) {
		  Map<String, String> params = new HashMap<String, String>();	
	 params.put("type", type); 
	 params.put("keyword",	  keyword);
	 params.put("category",	  category);
	  
	  return sqlSession.selectOne(NAME_SPACE + ".getCommunityBoardCount", params);
	  }
	  
	  
	  @Override 
	  public Community getBoard(int no, boolean isCount, String category) {
	  
	  if(isCount) { sqlSession.update(NAME_SPACE + ".incrementReadCount", no); 
		  	}
	  
	  
	  return sqlSession.selectOne(NAME_SPACE + ".getCommunityBoardDetail", no); 
	  
	  }
	  
	  
	  
	  public List<Reply> replyList(int no) {
		  return sqlSession.selectList(NAME_SPACE + ".replyList", no);
		  }
	  
	  
	  
	  @Override 
	  public void insertBoard(Community board) {
	  
	  sqlSession.insert(NAME_SPACE + ".insertCommunityBoard", board); 
	  }
	  
	  
	  public void updateBoard(Community board) {
		  
	  sqlSession.update(NAME_SPACE + ".updateCommunityBoard", board); 
	  }
	  
	  @Override 
	  public void deleteBoard(int no) {
	  
	  sqlSession.delete(NAME_SPACE + ".deleteBoard", no); }
	  
	  
	  public void updateRecommend(int no, String recommend) {
		  
		  Map<String, Object> params = new HashMap<String, Object>(); 
		  params.put("no",no);
		  params.put("recommend", recommend);
		  sqlSession.update(NAME_SPACE + ".updateRecommend", params); 
	  }
	  
	  public Community getRecommend(int no) { 
		  return sqlSession.selectOne(NAME_SPACE + ".getRecommend", no); 
		  }

	   public void addReply(Reply reply) { sqlSession.insert(NAME_SPACE +
	  ".addReply", reply); }
	  
	  public void updateReply(Reply reply) { sqlSession.update(NAME_SPACE +
	  ".updateReply", reply); }
	  
	  public void deleteReply(int no) { sqlSession.delete(NAME_SPACE +
	  ".deleteReply", no); }
	
	
	  
	  public void updatereplyRecommend(int no, String replyrecommend) {
		  
		  Map<String, Object> params = new HashMap<String, Object>(); 
		  params.put("no",no);
		  params.put("replyrecommend", replyrecommend);
		  sqlSession.update(NAME_SPACE + ".updatereplyRecommend", params); 
		  
		  System.out.println("replyrecommend : " + replyrecommend);
	  }
	  
	  public Reply getreplyRecommend(int no) { 
		  return sqlSession.selectOne(NAME_SPACE + ".getreplyRecommend", no); 
		  }
	  
	  
	
	  /*
	  public boolean isPassCheck(int no, String pass) {
		  
	  boolean result = false;
	  
	  String dbPass = sqlSession.selectOne( NAME_SPACE + ".isPassCheck", no);
	  
	  if(dbPass.equals(pass)) { result = true; } return result; }
	  
	  */
	  
}
