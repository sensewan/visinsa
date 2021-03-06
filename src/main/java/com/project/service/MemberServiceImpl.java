package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDao;
import com.project.domain.Basket;
import com.project.domain.Member;


 // 이 클래스가 서비스(비즈니스 로직) 계층의 컴포넌트임을 선언한다. 
@Service
public class MemberServiceImpl implements MemberService {
	
	/* 인스턴스 필드에 @Autowired annotation을 사용하면 접근지정자가 
	 * private이고 setter 메서드가 없다고 하더라도 문제없이 주입 할 수 있다.
	 * 기본 생성자가 반드시 존재해야 스프링이 이 클래스의 인스턴스를 생성한 후
	 * setter 주입 방식으로 주입해 준다. 이 클래스에는 다른 생성자가 존재하지
	 * 않으므로 컴파일러에 의해 자동으로 기본 생성자가 만들어 진다.
	 **/
	@Autowired
	private MemberDao memberDao;
	
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	
	// MemberDao를 이용해 로그인 요청 처리 결과를 반환하는 메서드
	@Override
	public int login(String id, String pass) {		
		return memberDao.login(id, pass);
	}
	
	// MemberDao를 이용해 no에 해당하는 회원 정보를 가져오는 메서드
	@Override
	public Member getMember(String id) {		
		return memberDao.getMember(id);
	}
	
	// 회원 가입시 아이디 중복을 체크하는 메서드
	@Override
	public int overlapIdCheck(String id) {
		Member member = memberDao.getMember(id);
		if(member == null) {
			return 0;
		}
		return 1;
	}
	
	// 회원 가입시 닉네임 중복을 체크하는 메서드
	@Override
	public int overlapNkCheck(String nk) {
		Member member = memberDao.getMemberNk(nk);
		if(member == null) {
			return 0;
		}
		return 1;
	}
	
	// 회원 정보를 DAO를 이용해 회원 테이블에 저장하는 메서드
	@Override
	public void addMember(Member member) {
		memberDao.addMember(member);
	}
	
	// 회원 정보 수정 시에 기존 비밀번호가 맞는지 체크하는 메서드
	public boolean memberPassCheck(String id, String pass) {		
		return memberDao.memberPassCheck(id, pass);
	}
	
	// 회원 정보를 DAO를 이용해 회원 테이블에서 수정하는 메서드
	public void updateMember(Member member) {
		memberDao.updateMember(member);
	}

	@Override
	public void addBasket(Basket basket) {
		memberDao.addBasket(basket);
	}

	@Override
	public List<Basket> getBasket(String id) {
		return memberDao.getBasket(id);
	}

	@Override
	public int countBasket(String id) {
		return memberDao.countBasket(id);
	}

	@Override
	public void deleteBasket(Basket basket) {
		memberDao.deleteBasket(basket);
	}

	@Override
	public void addPurchase(Basket basket) {
		memberDao.addPurchase(basket);
	}

	@Override
	public List<Basket> getPurchase(Map<String, Object> map) {
		return memberDao.getPurchase(map);
	}

	@Override
	public int countPurchase(String id) {
		return memberDao.countPurchase(id);
	}

	@Override
	public void deleteBasketOne(int no) {
		memberDao.deleteBasketOne(no);
	}
}
