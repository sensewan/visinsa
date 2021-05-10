package com.project.dao;

import java.util.List;

import com.project.domain.MainBody;

public interface MainDao {
	
	// 메인페이지 사람 클릭
	public abstract List<MainBody> mainBody(String code);

	// 증상선택시
	public abstract List<MainBody> bodySym(List<String> symCode);

	// 부위 중간검색
	public abstract List<String> getBodyName(List<String> symCode);

	// 추천 검색
	public abstract String getIngredient(List<String> typicalFunction);
	
}
