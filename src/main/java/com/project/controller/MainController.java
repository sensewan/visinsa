package com.project.controller;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.MainBody;
import com.project.service.MainService;
import com.project.service.NoticeService;

@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
	public void setMainService(MainService mainService) {
		this.mainService = mainService;
	}
	
	@RequestMapping(value = "/mainBody", method = RequestMethod.GET)
	@ResponseBody
	public List<MainBody> mainBody(@RequestParam("code") String code) {
		System.out.println("여기까진 왔어");
		
		List<MainBody> mainBody = mainService.mainBody(code);
		
		System.out.println("code = " + code);
		System.out.println("mainBody = " + mainBody.isEmpty());
		System.out.println("메인바디-> "+ mainBody);
		System.out.println("mainBodyType = " + mainBody.getClass().getName());
		
		return mainBody;
	}
	
	@RequestMapping(value = "/mainBodySymCode", method = RequestMethod.GET)
	@ResponseBody
	public List<MainBody> mainSym(@RequestParam("symCode") List<String> symCode){


		System.out.println("symCode = " + symCode);
		List<MainBody> bodySym = mainService.bodySym(symCode);
		System.out.println("bodySym = " + bodySym);
		List<String> typicalFunction = mainService.getBodyName(symCode);
		System.out.println("typicalFunction = " + typicalFunction);
		String typicalIngredient = mainService.getIngredient(typicalFunction);
		System.out.println("typicalIngredient = " + typicalIngredient);
		
		
		
		
		
		
		
		
		MainBody test = new MainBody();
		test.setTypicalIngredient(typicalIngredient);
		
		bodySym.add(test);
		System.out.println("bodySym = " + bodySym);
		
		System.out.println("symCode = " + symCode);
		return bodySym;
	}
	
	@Autowired
	private NoticeService noticeService;
	
	public void setBoardService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	
	// *** 메인 홈으로 이동 시키기 ***
	@RequestMapping(value= {"/home", "/main"})
	public String test_main(Model model) {
		// service를 이용해 게시글 리스트 갖고오기 (일반 게시글 요청인지, 검색 요청인지 체크해서 반환 함)
		Map<String, Object> modelMap = noticeService.miniNoticeList(1, 3);
		
		model.addAllAttributes(modelMap);
		
		return "main";
	}
	
}
