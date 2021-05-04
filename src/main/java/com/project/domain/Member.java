package com.project.domain;

/* 한 명의 회원 정보를 저장하는 클래스(VO, Beans, DTO)
 * 회원 정보를 저장하고 있는 테이블의 필드와 1:1 맵핑되는 Domain 클래스
 **/
public class Member {	
	
	private String id, pw, pwQuestion, pwAnswer, name, nickName;
	private String address, email, phone, businessName, businessAdd;
	private int seller, birth, medic, del;
	
	public Member() { }
	
	public Member(String id, int seller, String pw, String pwQuestion, String pwAnswer, String name, String nickName,
			String address, String email, int birth, String phone, int medic, String businessName, String businessAdd) {
		this.id = id;
		this.pw = pw;
		this.pwQuestion = pwQuestion;
		this.pwAnswer = pwAnswer;
		this.name = name;
		this.nickName = nickName;
		this.address = address;
		this.email = email;
		this.phone = phone;
		this.businessName = businessName;
		this.businessAdd = businessAdd;
		this.seller = seller;
		this.birth = birth;
		this.medic = medic;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getPwQuestion() {
		return pwQuestion;
	}

	public void setPwQuestion(String pwQuestion) {
		this.pwQuestion = pwQuestion;
	}

	public String getPwAnswer() {
		return pwAnswer;
	}

	public void setPwAnswer(String pwAnswer) {
		this.pwAnswer = pwAnswer;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getBusinessAdd() {
		return businessAdd;
	}

	public void setBusinessAdd(String businessAdd) {
		this.businessAdd = businessAdd;
	}

	public int getSeller() {
		return seller;
	}

	public void setSeller(int seller) {
		this.seller = seller;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	public int getMedic() {
		return medic;
	}

	public void setMedic(int medic) {
		this.medic = medic;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

}
