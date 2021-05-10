package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.domain.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	private final String NAME_SPACE = "com.project.mapper.NoticeMapper";
	
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Notice> noticeList(
			int startRow, int num, String type, String keyword) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startRow", startRow);
		params.put("num", num);
		params.put("type", type);
		params.put("keyword", keyword);
		
		return sqlSession.selectList(NAME_SPACE + ".noticeList", params);
	}
	
	@Override
	public int getNoticeCount(String type, String keyword) {
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("type", type);
		params.put("keyword", keyword);
		
	return sqlSession.selectOne(NAME_SPACE + ".getNoticeCount", params);
	
	}

	@Override
	public Notice getNotice(int no, boolean isCount) {
		
		if(isCount) {
			sqlSession.update(NAME_SPACE + ".incrementHits", no);
		}
		return sqlSession.selectOne(NAME_SPACE + ".getNotice", no);
	}

	@Override
	public void insertNotice(Notice notice) {
		sqlSession.insert(NAME_SPACE + ".insertNotice", notice);
	}

	@Override
	public boolean isPassCheck(int no, String pass) {
		
		boolean result = false;
		
		String dbPass = sqlSession.selectOne(
				NAME_SPACE + ".isPassCheck", no);
		
		if(dbPass.equals(pass)) {
			result = true;
			}
		
		return result;
	}

	@Override
	public void updateNotice(Notice notice) {
		sqlSession.update(NAME_SPACE + ".updateNotice", notice);
	}

	@Override
	public void deleteNotice(int no) {
		sqlSession.delete(NAME_SPACE + ".deleteNotice", no);
	}

	
	// 홈에 뿌려줄 미니 리스
	@Override
	public List<Notice> miniNoticeList(int startRow, int endRow) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startRow", startRow);
		params.put("endRow", endRow);
		
		return sqlSession.selectList(NAME_SPACE + ".miniNoticeList", params);
	}
}