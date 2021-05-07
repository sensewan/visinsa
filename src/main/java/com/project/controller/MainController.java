package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.MainBody;
import com.project.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	public void setMainService(MainService mainService) {
		this.mainService = mainService;
	}
	
	@RequestMapping(value = "/mainBody", method = RequestMethod.GET)
	@ResponseBody
	public List<MainBody> idCheck(@RequestParam("code") String code) {
		System.out.println("여기까진 왔어");
		
		List<MainBody> mainBody = mainService.mainBody(code);
		
		System.out.println("code = " + code);
		System.out.println("mainBody = " + mainBody.isEmpty());
		System.out.println("메인바디-> "+ mainBody);
		System.out.println("mainBodyType = " + mainBody.getClass().getName());
		
		return mainBody;
	}
}
