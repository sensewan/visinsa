package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.domain.Product;

public interface ProductService {
	
	
//	ProductDao를 이용해서 -> 한 페이지에 해당하는 게시글 리스트 및 페이징 처리에 필요한 데이터를 Map형태로 반환
	public abstract Map<String, Object> productList(
			int pageNum, String type, String keyword);

//	ProductDao를 이용해서 -> 현재 페이지에 해당하는 게시글 리스트 반환
	public abstract List<Product> productList();
	
	
	
	/* ProductDao를 이용해 게시판 테이블에서 no에 해당하는 게시 글 을 읽어와 반환하는 메서드 
 	 * isCount == true 면 게시 상세보기, false 면 게시 글 수정 폼 요청임 
	 */
	public abstract Product getProduct(int no, boolean isCount);
	
	
	// BoardDao를 이용해 새로운 게시 글을 추가하는 메서드
	public abstract void insertProduct(Product product);
	
	
	/* 게시 글 수정, 삭제 시 BoardDao를 이용해 비밀번호 입력을 체크하는 메서드
	 * 
	 * - 게시 글의 비밀번호가 맞으면 : true를 반환
	 * - 게시 글의 비밀번호가 맞지 않으면 : false를 반환
	 **/
//	public boolean isPassCheck(int no, String pass);
	
	
	
	// 상품 수정하기
	public abstract void updateProduct(Product product);
	
	
	// 상품 삭제하기
	public abstract void deleteProduct(int no);
	

}
