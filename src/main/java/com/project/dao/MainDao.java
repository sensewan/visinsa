package com.project.dao;

import java.util.List;

import com.project.domain.MainBody;

public interface MainDao {
	
	// 메인페이지 사람 클릭
	public abstract List<MainBody> mainBody(String code);
	
}
