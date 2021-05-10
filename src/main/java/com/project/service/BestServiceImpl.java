package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BestDao;
import com.project.domain.Best;

@Service
public class BestServiceImpl implements BestService {
	
	@Autowired
	private BestDao bestDao;

	@Override
	public List<Best> getAgeTop5(String age) {
		return bestDao.getAgeTop5(age);
	}

	
}
