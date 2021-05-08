package com.project.service;

import java.util.List;

import com.project.domain.MainBody;

public interface MainService {
	
	// 메인페이지 사람 클릭
	public abstract List<MainBody> mainBody(String code);

	// 증상선택시
	public abstract List<MainBody> bodySym(List<String> symCode);
	
}
