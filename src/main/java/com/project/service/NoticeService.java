package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.domain.Notice;

public interface NoticeService {
	
	public abstract Map<String, Object> noticeList(
			int pageNum, String type, String keyword); 
	
	public abstract Notice getNotice(int no, boolean isCount);
	
	public abstract void insertNotice(Notice notice);
	
	public boolean isPassCheck(int no, String pass);
	
	public abstract void updateNotice(Notice notice);
	
	public abstract void deleteNotice(int no);
}