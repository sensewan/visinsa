package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MainDao;
import com.project.domain.MainBody;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainDao mainDao;
	
	// 메인페이지 사람 클릭
	@Override
	public List<MainBody> mainBody(String code) {
		
		return mainDao.mainBody(code);
	}

	@Override
	public List<MainBody> bodySym(List<String> symCode) {
		return mainDao.bodySym(symCode);
	}

	@Override
	public List<String> getBodyName(List<String> symCode) {
		return mainDao.getBodyName(symCode);
	}

	@Override
	public String getIngredient(List<String> typicalFunction) {
		return mainDao.getIngredient(typicalFunction);
	}
	
}
