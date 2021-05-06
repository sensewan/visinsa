package com.project.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.NoticeDao;
import com.project.domain.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	private static final int PAGE_SIZE = 15;
	
	private static final int PAGE_GROUP = 10;
	
	
	@Autowired
	private NoticeDao noticeDao;
	public void setNoticeDao(NoticeDao noticeDao) {
	this.noticeDao = noticeDao;
	}

	@Override
	public Map<String, Object> noticeList(
			int pageNum, String type, String keyword) {
		
		int currentPage = pageNum;
		int startRow = (currentPage - 1) * PAGE_SIZE;
		int listCount = 0;
		
		boolean searchOption = (type.equals("null")
				|| keyword.equals("null")) ? false : true;
		
		listCount = noticeDao.getNoticeCount(type, keyword);
		System.out.println("listCount : " + listCount + ", type : "
		+ type + ", keyword : " + keyword);
		
		List<Notice> noticeList = noticeDao.noticeList(
				startRow, PAGE_SIZE, type, keyword);
		
		int pageCount =
				listCount / PAGE_SIZE + (listCount % PAGE_SIZE == 0 ? 0 : 1);
		
		int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
				- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);
		
		int endPage = startPage + PAGE_GROUP - 1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		modelMap.put("noticeList", noticeList);
		modelMap.put("pageCount", pageCount);
		modelMap.put("startPage", startPage);
		modelMap.put("endPage", endPage);
		modelMap.put("currentPage", currentPage);
		modelMap.put("listCount", listCount);
		modelMap.put("pageGroup", PAGE_GROUP);
		modelMap.put("searchOption", searchOption);
		
		if(searchOption) {
			try {
				modelMap.put("keyword", URLEncoder.encode(keyword, "utf-8"));
				
			} catch(UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			modelMap.put("word", keyword);
			modelMap.put("type", type);
		}
		
		return modelMap;
	}

	@Override
	public Notice getNotice(int no, boolean isCount) {
		return noticeDao.getNotice(no, isCount);
	}

	@Override
	public void insertNotice(Notice notice) {
		noticeDao.insertNotice(notice);

	}

	@Override
	public boolean isPassCheck(int no, String pass) {
		return noticeDao.isPassCheck(no, pass);
	}

	@Override
	public void updateNotice(Notice notice) {
		noticeDao.updateNotice(notice);
	}

	@Override
	public void deleteNotice(int no) {
		noticeDao.deleteNotice(no);
	}
}