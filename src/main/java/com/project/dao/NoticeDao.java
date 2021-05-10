package com.project.dao;

import java.util.List;

import com.project.domain.Notice;

public interface NoticeDao {
	
	public abstract List<Notice> noticeList(
			int startRow, int num, String type, String keyword);
	
	public abstract int getNoticeCount(String type, String keyword);
	
	public abstract Notice getNotice(int no, boolean isCount);
	
	public abstract void insertNotice(Notice notice);
	
	public boolean isPassCheck(int no, String pass);
	
	public abstract void updateNotice(Notice notice);
	
	public abstract void deleteNotice(int no);
	
	public abstract List<Notice> miniNoticeList(int startRow, int endRow);
}