package com.project.domain;

import java.sql.Timestamp;

public class Notice {
	
	private int no;
	private String title;
	private String writer;
	private String pass;
	private String content;
	private Timestamp regDate;
	private int hits;
	private int state;
	
	
	
	public Notice() { }
	public Notice(int no, String title, String writer, String pass,
			String content, Timestamp regDate, int hits, int state) {
		
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.pass = pass;
		this.content = content;
		this.regDate = regDate;
		this.hits = hits;
		this.state = state;
}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
}