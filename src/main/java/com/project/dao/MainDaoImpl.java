package com.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.domain.MainBody;

@Repository
public class MainDaoImpl implements MainDao {

	private final String NAME_SPACE = "com.springstudy.bbs.mapper.MainMapper";
	
	private SqlSessionTemplate sqlSession;
		
	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}	
	
	// 메인페이지 사람 클릭
	@Override
	public List<MainBody> mainBody(String code) {

		return sqlSession.selectList(NAME_SPACE + ".mainBody", code);
	}

	// 증상선택시
	@Override
	public List<MainBody> bodySym(List<String> symCode) {
		return sqlSession.selectList(NAME_SPACE + ".bodySym", symCode);
	}
}
