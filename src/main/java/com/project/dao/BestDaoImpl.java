package com.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.domain.Best;

@Repository
public class BestDaoImpl implements BestDao {

	private final String NAME_SPACE = "com.springstudy.bbs.mapper.BestMapper";
	
	private SqlSessionTemplate sqlSession;
		
	@Autowired
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<Best> getAgeTop5(String age) {
		return sqlSession.selectList(NAME_SPACE + ".getAgeTop5", age);
	}

	
}
