package com.project.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String bestBody(Model model, Best best) {
		
		/*
		{ // Data store
	  		mathworks: [['matlab', 1.71], ['matlab plot', 0.33], ['matlab download', 0.25], ['plot matlab', 0.22], ['matlab online', 0.2]],
	  		ansys: [['ansys', 12.06], ['ansys student', 3], ['ansys fluent', 2.79], ['fluent', 2.66], ['ansys customer portal', 1.73]],
	  		arenasimulation: [['arena software', 20.01], ['arena simulation', 15.43], ['arena', 6.88], ['rockwell arena', 3.38], ['arena download', 2.55]],
	  		omnetpp: [['omnet', 19.29], ['inet', 11.04], ['omnet tutorial', 5.3], ['omnet download', 3.64], ['omnet tutorial for beginners ...', 2.69]],
	  		promodel: [['promodel', 12.63], ['gsa ebuy', 9.83], ['process simulator', 4.9], ['promodel corporation', 4.47, ['promodel download', 2.54]]]
		} 
		
		
		['Mathworks.com', 'Ansys.com', 'Arenasimulation.com', 'Omnetpp.org', 'Promodel.com']
		
		
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
		
		
		
		
		
		
		
		model.addAttribute("topAge20", topAge20);
		model.addAttribute("topAge30", topAge30);
		model.addAttribute("topAge40", topAge40);
		model.addAttribute("topAge50", topAge50);
		model.addAttribute("topAge60", topAge60);
		
		return "/best/Best";
	}
	
}
