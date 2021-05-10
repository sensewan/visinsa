package com.project.dao;

import java.util.List;

import com.project.domain.Best;


public interface BestDao {
	
	// 메인페이지 사람 클릭
	public abstract List<Best> getAgeTop5(String age);
}
