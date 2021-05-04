package com.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Community;
import com.project.domain.Reply;
import com.project.service.CommunityService;

@Controller
public class CommunityController {
	
	@Autowired
	private CommunityService CommunityService;

	public void setCommunityService(CommunityService communityService) {
		CommunityService = communityService;
	}

	@RequestMapping(value= {"/Community", "/CommunityBoardList"})
	public String CommunityBoardList(Model model, 
			@RequestParam(value="pageNum", required=false, 
						defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
						defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
						defaultValue="null") String keyword,
			@RequestParam(value="category", required=false,
						defaultValue="Community") String category
			) {		

		Map<String, Object> modelMap = 
				CommunityService.CommunityBoardList(pageNum, type, keyword, category);

		model.addAllAttributes(modelMap);		

		return "/community/CommunityBoardList";
	}
	
	
	  @RequestMapping("/CommunityBoardDetail") 
	  public String boardDetail(Model model,int no,
		  @RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum,
		  @RequestParam(value="type", required=false, defaultValue="null") String type,
		  @RequestParam(value="keyword", required=false, defaultValue="null") String keyword, 
		  @RequestParam(value="category", required=false, defaultValue="null") String category
		  ) throws Exception {
	  
	  
	  boolean searchOption = (type.equals("null") || keyword.equals("null")) ?
	  false : true;
	  
	  
	  Community board = CommunityService.getBoard(no, true, category);
	  
	  
	  List<Reply> replyList = CommunityService.replyList(no);
	  
	  model.addAttribute("board", board); 
	  model.addAttribute("replyList", replyList);
	  model.addAttribute("pageNum", pageNum);
	  model.addAttribute("searchOption", searchOption);
	  
	  
	  if(searchOption) {
	  
	  
	  model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
	  model.addAttribute("type", type);
	  model.addAttribute("word", keyword);
	  model.addAttribute("category", category);
	  }
	  
	  return "/community/CommunityBoardDetail"; 
	  }
	  
	  
	  
	  @RequestMapping(value="/CommunitywriteProcess", method=RequestMethod.POST)
	  public String insertBoard( HttpServletRequest request, String title, String
			  id, String content, int medic, String category) throws IOException {
	  
	  Community board = new Community();
	  
	  board.setTitle(title);
	  board.setId(id); 
	  board.setContent(content);
	  board.setMedic(medic);
	  board.setCategory(category);
	  
	  
	  CommunityService.insertBoard(board);
	  
	  return "redirect:CommunityBoardList";
	  
	  }
	  
	  @RequestMapping(value="/CommunityaddProcess", method=RequestMethod.POST)
	  public String addBoard(MultipartHttpServletRequest request) throws
	   IOException {
	   
	   Community board = new Community();
	   board.setTitle(request.getParameter("title"));
	   board.setId(request.getParameter("id"));
	   board.setContent(request.getParameter("content"));
	   
	   
	   CommunityService.insertBoard(board);
	   
	   return "redirect:CommunityBoardList"; }
	  
	  
	  
	   
	   @RequestMapping(value="/Communityupdate") 
	   public String updateBoard(Model model, HttpServletResponse response,  int no,
		   @RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum,
		   @RequestParam(value="type", required=false, defaultValue="null") String type,
		   @RequestParam(value="keyword", required=false, defaultValue="null") String keyword,
		   @RequestParam(value="category", required=false, defaultValue="null") String category
	   ) throws Exception 
	   {
	   
	   
	   boolean searchOption = (type.equals("null") || keyword.equals("null")) ?
	   false : true;
	   
	   Community board = CommunityService.getBoard(no, false, category);
	   
	   
	   model.addAttribute("board", board); 
	   model.addAttribute("pageNum", pageNum);
	   model.addAttribute("searchOption", searchOption);
	   
	   if(searchOption) {
		   model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
		   model.addAttribute("type", type); model.addAttribute("word", keyword); }
		   
		   return "/community/updateForm"; 
	   
	   }
	   
	   @RequestMapping(value= {"Communityupdate", "/update"}, method=RequestMethod.POST) 
	   public  String updateBoard(HttpServletResponse response, PrintWriter out, Community
	   board, RedirectAttributes reAttrs,
	   @RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum,
	   @RequestParam(value="type", required=false, defaultValue="null") String type,
	   @RequestParam(value="keyword", required=false, defaultValue="null") String
	   keyword) throws Exception {
	   
	   
	   boolean searchOption = (type.equals("null") || keyword.equals("null")) ?
	   false : true;
	   
	   CommunityService.updateBoard(board);
	   
	   reAttrs.addAttribute("searchOption", searchOption);
	   
	   if(searchOption) {
	   
	   reAttrs.addAttribute("keyword", keyword); 
	   reAttrs.addAttribute("type", type);
	   }
	   
	   reAttrs.addAttribute("pageNum", pageNum); 
	   return  "redirect:/community/CommunityBoardList"; 
	   }
	   
	   
	   @RequestMapping({"/delete", "deleteBoard"}) 
	   public String deleteBoard(HttpServletResponse response, PrintWriter out, int no, RedirectAttributes reAttrs,
	   
	   @RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum,
	   
	   @RequestParam(value="type", required=false, defaultValue="null") String type,
	   
	   @RequestParam(value="keyword", required=false, defaultValue="null") String
	   keyword) throws Exception {
	   
	   
	   
	   boolean searchOption = (type.equals("null") || keyword.equals("null")) ?
	   false : true;
	   
	   CommunityService.deleteBoard(no);
	   
	   reAttrs.addAttribute("searchOption", searchOption);
	   
	   if(searchOption) {
	   
	   reAttrs.addAttribute("keyword", keyword); reAttrs.addAttribute("type", type);
	   }
	   
	   reAttrs.addAttribute("pageNum", pageNum); return
	   "redirect:/community/CommunityBoardList";
	   }
	  
}
