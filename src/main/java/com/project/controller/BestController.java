package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.domain.Best;
import com.project.service.BestService;

@Controller
public class BestController {
	
	@Autowired
	private BestService bestService;
	
	public void setBestService(BestService bestService) {
		this.bestService = bestService;
	}
	
	@RequestMapping(value = {"/best"})
	public String bestBody(Model model, Best best) throws Exception {
		
		/*
		{ // Data store
	  		mathworks: [['matlab', 1.71], ['matlab plot', 0.33], ['matlab download', 0.25], ['plot matlab', 0.22], ['matlab online', 0.2]],
	  		ansys: [['ansys', 12.06], ['ansys student', 3], ['ansys fluent', 2.79], ['fluent', 2.66], ['ansys customer portal', 1.73]],
	  		arenasimulation: [['arena software', 20.01], ['arena simulation', 15.43], ['arena', 6.88], ['rockwell arena', 3.38], ['arena download', 2.55]],
	  		omnetpp: [['omnet', 19.29], ['inet', 11.04], ['omnet tutorial', 5.3], ['omnet download', 3.64], ['omnet tutorial for beginners ...', 2.69]],
	  		promodel: [['promodel', 12.63], ['gsa ebuy', 9.83], ['process simulator', 4.9], ['promodel corporation', 4.47, ['promodel download', 2.54]]]
		} 
			
		
		
		[59.90, 41.30, 51.20, 48.40, 23.50]
		
		 * */
		
	
		// 20~60대 top5 가지고오기
		List<Best> topAge20 = bestService.getAgeTop5("20대");
		List<Best> topAge30 = bestService.getAgeTop5("30대");
		List<Best> topAge40 = bestService.getAgeTop5("40대");
		List<Best> topAge50 = bestService.getAgeTop5("50대");
		List<Best> topAge60 = bestService.getAgeTop5("60대");
		
		// 클릭후 나오는 그래프 데이터형식으로 변형
		List<Object> twentytop5 = new ArrayList<Object>();
		List<Object> thirtytop5 = new ArrayList<Object>();
		List<Object> fortytop5 = new ArrayList<Object>();
		List<Object> fiftytop5 = new ArrayList<Object>();
		List<Object> sixtytop5 = new ArrayList<Object>();
		
		
		for (int i = 0; i < 5; i++) {
			// 중첩리스트 만들기
			List<Object> twentySub = new ArrayList<Object>();
			List<Object> thirtySub = new ArrayList<Object>();
			List<Object> fortySub = new ArrayList<Object>();
			List<Object> fiftySub = new ArrayList<Object>();
			List<Object> sixtySub = new ArrayList<Object>();
			
			twentySub.add(topAge20.get(i).getProductName());
			twentySub.add(topAge20.get(i).getCount());
			
			thirtySub.add(topAge30.get(i).getProductName());
			thirtySub.add(topAge30.get(i).getCount());
			
			fortySub.add(topAge40.get(i).getProductName());
			fortySub.add(topAge40.get(i).getCount());
			
			fiftySub.add(topAge50.get(i).getProductName());
			fiftySub.add(topAge50.get(i).getCount());
			
			sixtySub.add(topAge60.get(i).getProductName());
			sixtySub.add(topAge60.get(i).getCount());
						
			twentytop5.add(twentySub);
			thirtytop5.add(thirtySub);
			fortytop5.add(fortySub);
			fiftytop5.add(fiftySub);
			sixtytop5.add(sixtySub);
			
		}
		
		// 20대 ~ 60대 각 세대의 세부 데이터
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("twentytop5", twentytop5);
		map.put("thirtytop5", thirtytop5);
		map.put("fortytop5", fortytop5);
		map.put("fiftytop5", fiftytop5);
		map.put("sixtytop5", sixtytop5);
		
		ObjectMapper m = new ObjectMapper();
		String generationDetail = m.writeValueAsString(map);
		model.addAttribute("generationDetail", generationDetail);
		
		
		// 20대 ~ 60대 각 세대의 판매량1위 저장
		List<Integer> generationTop1 = new ArrayList<Integer>();
		generationTop1.add(topAge20.get(0).getCount());
		generationTop1.add(topAge30.get(0).getCount());
		generationTop1.add(topAge40.get(0).getCount());
		generationTop1.add(topAge50.get(0).getCount());
		generationTop1.add(topAge60.get(0).getCount());
		
		List<String> top1Name = new ArrayList<String>();
		top1Name.add(topAge20.get(0).getProductName());
		top1Name.add(topAge30.get(0).getProductName());
		top1Name.add(topAge40.get(0).getProductName());
		top1Name.add(topAge50.get(0).getProductName());
		top1Name.add(topAge60.get(0).getProductName());
		
		m = new ObjectMapper();
		String generationSum = m.writeValueAsString(generationTop1);
		model.addAttribute("generationSum", generationSum);

		model.addAttribute("top1Name", top1Name);
		
		
		model.addAttribute("twentytop5", twentytop5);
		
		return "/best/Best";
	}
	
}
