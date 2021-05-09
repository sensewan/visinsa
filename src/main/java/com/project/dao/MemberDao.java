package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.domain.Basket;
import com.project.domain.Member;


public interface MemberDao {
	
	/** 
	 * 회원 로그인을 처리하는 메서드
	 * @param id는 회원 아이디
	 * @param pass는 회원 비밀번호
	 * @return 로그인 처리 결과를 정수로 반환 	
	 */	
	public int login(String id, String pass);		
	
	/**
	 * 한 명의 회원 정보를 반환하는 메서드
	 * @param id는 회원 아이디
	 * @return no에 해당하는 회원 정보를 Member 객체로 반환
	 **/
	public Member getMember(String id);
	
	public Member getMemberNk(String nk);
	
	// 장바구니 삭제
	public void deleteBasket(Basket basket);
	
	// 장바구니 넣기
	public void addBasket(Basket basket);
	
	// 내 장바구니 확인
	public List<Basket> getBasket(String id);
	
	// 장바구니 개수 확인
	public int countBasket(String id);
	
	// 회원 정보를 회원 테이블에 저장하는 메서드
	public void addMember(Member member);
	
	// 회원 정보 수정 시에 기존 비밀번호가 맞는지 체크하는 메서드
	public boolean memberPassCheck(String id, String pass);
	
	// 회원 정보를 회원 테이블에서 수정하는 메서드
	public void updateMember(Member member);

	// 구매내역 넣기
	public void addPurchase(Basket basket);

	// 구매내역 가져오기
	public List<Basket> getPurchase(Map<String, Object> map);

	// 구매내역 카운트
	public int countPurchase(String id);

	// 장바구니 하나 삭제
	public void deleteBasketOne(int no);
}
