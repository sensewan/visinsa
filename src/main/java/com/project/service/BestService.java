package com.project.service;

import java.util.List;

import com.project.domain.Best;

public interface BestService {
	
	// 20대 top5
	public abstract List<Best> getAgeTop5(String age);

	
}
