package com.project.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Notice;
import com.project.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	public void setBoardService(NoticeService noticeService) {
	this.noticeService = noticeService;
	}
	
	@RequestMapping(value= {"/noticeList", "/list"}, method=RequestMethod.GET)
	public String noticeList(Model model,
			@RequestParam(value="pageNum", required=false,
			defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,
			defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
			defaultValue="null") String keyword) {
		
		Map<String, Object> modelMap = noticeService.noticeList(pageNum, type, keyword);
		model.addAllAttributes(modelMap);
		return "noticeList";
	}
	
	@RequestMapping("/noticeDetail")
	public String noticeDetail(Model model, int no,
	@RequestParam(value="pageNum", required=false, defaultValue="1")
	int pageNum,
	@RequestParam(value="type", required=false,
	defaultValue="null") String type,
	@RequestParam(value="keyword", required=false,
	defaultValue="null") String keyword) throws Exception {
		
		boolean searchOption = (type.equals("null")
				|| keyword.equals("null")) ? false : true;
		
		
		
		Notice notice = noticeService.getNotice(no, true);
		model.addAttribute("notice", notice);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchOption", searchOption);
		
		if(searchOption) {
			model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
			model.addAttribute("type", type);
			model.addAttribute("word", keyword);
		}
		
		return "noticeDetail";
	}
	
	@RequestMapping(value="/noticewriteProcess", method=RequestMethod.POST)
	public String insertNotice(Notice notice) {
		
		noticeService.insertNotice(notice);
		
		return "redirect:noticeList";
	}
	
	
	@RequestMapping(value="/updateNotice")
	public String updateNotice(Model model, HttpServletResponse response,
				int no, String pass,
	@RequestParam(value="pageNum", required=false, defaultValue="1")
	int pageNum,
	@RequestParam(value="type", required=false,
	defaultValue="null") String type,
	@RequestParam(value="keyword", required=false,
	defaultValue="null") String keyword) throws Exception {
		
		boolean result = noticeService.isPassCheck(no, pass);
		
		if(! result) {
			response.setContentType("text/html; charset=utf-8");
			
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('비밀번호가 맞지 않습니다.');");
			out.println(" history.back();");
			out.println("</script>");
			return null;
		}
		
		boolean searchOption = (type.equals("null")
				|| keyword.equals("null")) ? false : true;
		
		Notice notice = noticeService.getNotice(no, false);
		
		model.addAttribute("notice", notice);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchOption", searchOption);
		
		if(searchOption) {
			model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
			model.addAttribute("type", type);
			model.addAttribute("word", keyword);
		}
		
		return "noticeupdateForm";
	}
	
	@RequestMapping(value="updateNotice", method=RequestMethod.POST)
	public String updateNotice(HttpServletResponse response,
	PrintWriter out, Notice notice, RedirectAttributes reAttrs,
	@RequestParam(value="pageNum", required=false, defaultValue="1")
	int pageNum,
	@RequestParam(value="type", required=false,
	defaultValue="null") String type,
	@RequestParam(value="keyword", required=false,
	defaultValue="null") String keyword) throws Exception {
		
		boolean result = noticeService.isPassCheck(notice.getNo(), notice.getPass());
		
		if(! result) {
			response.setContentType("text/html; charset=utf-8");
			out.println("<script>");
			out.println(" alert('비밀번호가 맞지 않습니다.');");
			out.println(" history.back();");
			out.println("</script>");
			return null;
		}
		
		boolean searchOption = (type.equals("null")
				|| keyword.equals("null")) ? false : true;
		
		noticeService.updateNotice(notice);
		reAttrs.addAttribute("pageNum", pageNum);
		reAttrs.addAttribute("searchOption", searchOption);
		
		if(searchOption) {
			reAttrs.addAttribute("keyword", keyword);
			reAttrs.addAttribute("type", type);
		}
		
		reAttrs.addAttribute("pageNum", pageNum);
		
		return "redirect:noticeList";
	}
	
	@RequestMapping({"/deletenotice", "deleteNotice"})
	public String deleteNotice(HttpServletResponse response,
	PrintWriter out, int no, String pass, RedirectAttributes reAttrs,
	@RequestParam(value="pageNum", required=false, defaultValue="1")
	int pageNum,
	@RequestParam(value="type", required=false,
	defaultValue="null") String type,
	@RequestParam(value="keyword", required=false,
	defaultValue="null") String keyword) throws Exception {
		
		boolean result = noticeService.isPassCheck(no, pass);
		
		if(! result) {
			response.setContentType("text/html; charset=utf-8");
			out.println("<script>");
			out.println(" alert('비밀번호가 맞지 않습니다.');");
			out.println(" history.back();");
			out.println("</script>");
			return null;
		}
		
		boolean searchOption = (type.equals("null")
				|| keyword.equals("null")) ? false : true;
		
		noticeService.deleteNotice(no);
		reAttrs.addAttribute("pageNum", pageNum);
		reAttrs.addAttribute("searchOption", searchOption);
		
		if(searchOption) {
			reAttrs.addAttribute("keyword", keyword);
			reAttrs.addAttribute("type", type);
		}
		
		reAttrs.addAttribute("pageNum", pageNum);
		
		return "redirect:noticeList";
	}
}