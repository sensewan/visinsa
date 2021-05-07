package com.project.domain;

import java.sql.Timestamp;

/* 하나의 댓글 정보를 저장하는 클래스(Domain, VO, Beans, DTO)
 * 댓글 정보를 저장하고 있는 테이블의 필드와 1:1 맵핑되는 Domain 클래스
 **/
public class Reply {
	private int no;
	private int bbsNo;
	private String replyContent;
	private String replyid;
	private Timestamp replydate;
	private int replyrecommend;
	private int replymedic;
	private String replybusinessName;
	private String replybusinessAdd;
	
	public Reply() { }
	public Reply(int bbsNo, String replyContent, String replyid) {
		this.bbsNo = bbsNo;
		this.replyContent = replyContent;
		this.replyid = replyid;
	}	
	public Reply(int no, int bbsNo, String replyContent, 
			String replyid, Timestamp replydate, int replyrecommend) {
		
		this.no = no;
		this.bbsNo = bbsNo;
		this.replyContent = replyContent;
		this.replyid = replyid;
		this.replydate = replydate;
		this.replyrecommend = replyrecommend;
	}
	
	public Reply(int bbsNo, String replyContent, 
			String replyid, Timestamp replydate, int replyrecommend) {
		
		this.bbsNo = bbsNo;
		this.replyContent = replyContent;
		this.replyid = replyid;
		this.replydate = replydate;
		this.replyrecommend = replyrecommend;
	}
	
	
	
	public Reply(int no, int bbsNo, String replyContent, String replyid, Timestamp replydate, int replyrecommend,
			int replymedic, String replybusinessName, String replybusinessAdd) {
		super();
		this.no = no;
		this.bbsNo = bbsNo;
		this.replyContent = replyContent;
		this.replyid = replyid;
		this.replydate = replydate;
		this.replyrecommend = replyrecommend;
		this.replymedic = replymedic;
		this.replybusinessName = replybusinessName;
		this.replybusinessAdd = replybusinessAdd;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBbsNo() {
		return bbsNo;
	}
	public void setBbsNo(int bbsNo) {
		this.bbsNo = bbsNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public Timestamp getReplydate() {
		return replydate;
	}
	public void setReplydate(Timestamp replydate) {
		this.replydate = replydate;
	}
	public int getReplyrecommend() {
		return replyrecommend;
	}
	public void setReplyrecommend(int replyrecommend) {
		this.replyrecommend = replyrecommend;
	}
	public int getReplymedic() {
		return replymedic;
	}
	public void setReplymedic(int replymedic) {
		this.replymedic = replymedic;
	}
	public String getReplybusinessName() {
		return replybusinessName;
	}
	public void setReplybusinessName(String replybusinessName) {
		this.replybusinessName = replybusinessName;
	}
	public String getReplybusinessAdd() {
		return replybusinessAdd;
	}
	public void setReplybusinessAdd(String replybusinessAdd) {
		this.replybusinessAdd = replybusinessAdd;
	}

	
	
	

}
