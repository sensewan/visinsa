package com.project.dao;

import java.util.List;

import com.project.domain.Product;

public interface ProductDao {
	
	/* 한 페이지에 보여 질 게시글 리스트와 검색 리스트 요청 시 호출되는 메소드
	 * 현재 페이지에 해당하는 게시글 리스트를 DB에서 읽어와 반환 
	 **/
	public abstract List<Product> productList(int startRow, int num, String type, String keyword);
	
	
	
	
	/* 게시 글 수를 계산하기 위해 호출되는 메서드 - paging 처리에 사용
	 * 게시 글 리스트와 검색 리스트에 대한 게시 글 수를 반환 하는 메서드
	 **/
	public abstract int getProductCount(String type, String keyword);
	
	
	
	/* 게시 글 상세보기 요청 시 호출되는 메서드
	 * no에 해당하는 게시 글 을 DB에서 읽어와 Board 객체로 반환 하는 메서드 
	 * isCount == true 면 게시 글 읽은 횟수를 1 증가시킨다.
	 **/
	public abstract Product getProduct(int no, boolean isCount);
	
	
	
	/* 게시 글쓰기 요청 시 호출되는 메서드
	 * 게시 글쓰기 요청 시 게시 글 내용을 Product 객체로 받아 DB에 추가하는 메서드 
	 **/
	public abstract void insertProduct(Product product);
	
	
	// 상품 수정하기
	public abstract void updateProduct(Product product);
	
	
	// 상품 삭제하기
	public abstract void deleteProduct(int no);
	
	

}
