package com.project.domain;

import java.sql.Timestamp;


public class Community {

	// 게시판 domain 정보
	private int no;
	private String id;
	private String category;
	private String title;
	private String content;
	private int medic;
	private Timestamp regdate;
	private int readcount;
	private int recommend;
	
	// 댓글 domain 정보 (no, medic, id는 fk)


	private int unlike;
	private Timestamp replydate;
	
	
	
	
	public Community() {}
	
	public Community(int no, String id, String category, String title, String content, int medic, Timestamp regdate,
			int readcount, int recommend, int unlike, Timestamp replydate) {
		this.no = no;
		this.id = id;
		this.category = category;
		this.title = title;
		this.content = content;
		this.medic = medic;
		this.regdate = regdate;
		this.readcount = readcount;
		this.recommend = recommend;
		this.unlike = unlike;
		this.replydate = replydate;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getMedic() {
		return medic;
	}
	public void setMedic(int medic) {
		this.medic = medic;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getUnlike() {
		return unlike;
	}
	public void setUnlike(int unlike) {
		this.unlike = unlike;
	}
	public Timestamp getReplydate() {
		return replydate;
	}
	public void setReplydate(Timestamp replydate) {
		this.replydate = replydate;
	}
	
	
	
	
	
	
}
