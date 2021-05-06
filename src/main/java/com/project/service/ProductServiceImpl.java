package com.project.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.ProductDao;
import com.project.domain.Product;

@Service
public class ProductServiceImpl implements ProductService {
	
	
	// 한 페이지에 보여 줄 게시글의 수
	private static final int PAGE_SIZE = 3;
	
	/* 한 페이지에 보여질 페이지 그룹의 수
	 * [이전] 1 2 3 4 5 6 7 8 9 10 [다음]	
	 **/
	private static final int PAGE_GROUP = 2;
	
	
	
	@Autowired
	private ProductDao productDao;

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	@Override
	public Map<String, Object> productList(int pageNum, String type, String keyword) {
		
		
		// 요청 파라미터의 pageNum을 현재 페이지로 설정
		int currentPage = pageNum;
		
		/* 요청한 페이지에 해당하는 게시글 리스트의 첫 번째 행의 값을 계산한다.
		 * (MySQL에서 검색된 게시 글 리스트의 row에 대한 index는 0부터 시작한다.)
		 * 한 페이지에 게시글이 10개씩 보여지고 현재 페이지가 1일 경우 startRow는 0, 2페이지일 경우 startRow는 10이 된다.
		 * 
		 * 예를 들어 3페이지에 해당하는 게시 글 리스트를 가져 온다면 한 페이지에 보여줄
		 * 게시 글 리스트의 수가 10개로 지정되어 있으므로 startRow는 20이 된다. 
		 * 즉 아래의 공식에 의해 startRow(20) = (3 - 1) * 10;
		 * 첫 번째 페이지 startRow = 0, 두 번째 페이지 startRow = 10이 된다.
		 **/
		
		int startRow = (currentPage - 1) * PAGE_SIZE;		
		int listCount = 0;
		
		
		
		
		/* 요청 파라미터에서 type이나 keyword가 비어 있으면 (즉 null 값이면)-> 
		 * 일반 게시글 리스트를 요청한 것으로 false 값을 갖게 한다. (검색인 경우에는 당현히 true 값을 갖음)
		 * Controller에서 type이나 keyword의 요청 파라미터가 없으면 기본 값을 "null"로 지정했기 때문에 아래와 같이 체크함
		 **/
		boolean searchOption = (type.equals("null") || keyword.equals("null")) ? false : true;
		
		
		
		/* 맵핑 구문 안에서 동적쿼리를 사용해 
		 * type이 없으면 -> 전체 게시 글의 수를 반환하고, 
		 * type이 존재하면 -> 제목이나 내용 또는 작성자를 기준으로 검색어가 포함된 게시 글 수를 반환한다.
		 **/
		listCount = productDao.getProductCount(type, keyword);		
		System.out.println("productList호출-> "+"listCount : " + listCount + ", type : "	+ type + ", keyword : " + keyword);
		
		
		
		
		/* 게시 글 리스트가 하나 이상 존재하면 요청한 페이지(currentPage)에 해당하는
		 * 게시 글 리스트를 DB로 부터 읽어 Board 객체를 저장하는 ArrayList에 저장한다. 
		 **/
		if(listCount > 0) {
			
			/* Oracle에서는 페이징 처리를 위해 의사컬럼인 ROWNUM을 사용했지만
			 * MySQL은 검색된 데이터에서 특정 행 번호부터 지정한 개수 만큼 행을 읽어오는
			 * LIMIT 명령을 제공하고 있다. LIMIT의 첫 번째 매개변수에 가져올 데이터의
			 * 시작 행을 지정하고 두 번째 매개변수에 가져올 데이터의 개수를 지정하면 된다.
			 **/
			List<Product> productList = productDao.productList(startRow, PAGE_SIZE, type, keyword);
			
			
//			************ 페이징 처리 관련 ************
			/* 페이지 그룹 이동 처리를 위해 전체 페이지를 계산 한다.
			 * [이전] 11 12 13...   또는   ... 8 9 10 [다음] 과 같은 페이징 처리
			 * 전체 페이지 = 전체 게시 글 수 / 한 페이지에 표시할 게시 글 수가 되는데 
			 * 이 계산식에서 나머지가 존재하면 전체 페이지 수는 전체 페이지 + 1이 된다.
			 **/	
			int pageCount = listCount / PAGE_SIZE + (listCount % PAGE_SIZE == 0 ? 0 : 1);
			
			/* 페이지 그룹 처리를 위해 페이지 그룹별 시작 페이지와 마지막 페이지를 계산
			 * 페이지 그룹 별 시작 페이지 : 1, 11, 21, 31...
			 * 첫 번째 페이지 그룹에서 페이지 리스트는 1 ~ 10이 되므로 currentPage가
			 * 1 ~ 10 사이에 있으면 startPage는 1이 되고 11 ~ 20 사이면 11이 된다.
			 * 
			 * 정수형 연산의 특징을 이용해 startPage를 아래와 같이 구할 수 있다.
			 * 아래 연산식으로 계산된 결과를 보면 현재 그룹의 마지막 페이지일 경우
			 * startPage가 다음 그룹의 시작 페이지가 나오게 되므로 삼항 연자자를
			 * 사용해 현재 페이지가 속한 그룹의 startPage가 되도록 조정 하였다.
			 * 즉 currentPage가 10일 경우 다음 페이지 그룹의 시작 페이지가 되므로
			 * 삼항 연산자를 사용하여 PAGE_GROUP으로 나눈 나머지가 0이면
			 * PAGE_GROUP을 차감하여 현재 그룹의 시작 페이지가 되도록 하였다.
			 **/
			int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
					- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);		
						
			// 현재 페이지 그룹의 마지막 페이지 : 10, 20, 30...
			int endPage = startPage + PAGE_GROUP - 1;
			
			/* 위의 식에서 endPage를 구하게 되면 endPage는 항상 PAGE_GROUP의
			 * 크기만큼 증가(10, 20, 30 ...) 되므로 맨 마지막 페이지 그룹의 endPage가
			 * 정확하지 못할 경우가 발생하게 된다. 다시 말해 전체 페이지가 53페이지라고
			 * 가정하면 위의 식에서 계산된 endPage는 60 페이지가 되지만 실제로 
			 * 60페이지는 존재하지 않는 페이지이므로 문제가 발생하게 된다.
			 * 그래서 맨 마지막 페이지에 대한 보정이 필요하여 아래와 같이 endPage와
			 * pageCount를 비교하여 현재 페이지 그룹에서 endPage가 pageCount 보다
			 * 크다면 pageCount를 endPage로 지정 하였다. 즉 현재 페이지 그룹이
			 * 마지막 페이지 그룹이면 endPage는 전체 페이지 수가 되도록 지정한 것이다.
			 **/
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			
			
			/* View 페이지에서 필요한 데이터를 Map에 저장한다.
			 * 현재 페이지, 전체 페이지 수, 페이지 그룹의 시작 페이지와 마지막 페이지
			 * 게시 글 리스트의 수, 한 페이지에 보여 줄 게시 글 리스트의 데이터를 
			 * Map에 저장해 컨트롤러로 전달한다.
			 **/
			Map<String, Object> modelMap = new HashMap<String, Object>();		
			
			modelMap.put("productList", productList);
			modelMap.put("pageCount", pageCount);
			modelMap.put("startPage", startPage);
			modelMap.put("endPage", endPage);
			modelMap.put("currentPage", currentPage);
			modelMap.put("listCount", listCount);
			modelMap.put("pageGroup", PAGE_GROUP);
			modelMap.put("searchOption", searchOption);
			
			
			// 검색 요청이면 type과 keyword를 모델에 저장한다.
			if(searchOption) {
				
				/* IE에서 링크로 요청 시 파라미터에 한글이 포함되면 IE는 URLEncoding을
				 * 하지 않고 서버로 전송하는데 톰캣 7.06x 버전에서 정상적으로 동작하던 것이
				 * 7.07x 버전에서는 Invalid character found in the request target
				 * 이라는 에러가 발생한다. 이 문제는 java.net 패키지의 URLEncoder
				 * 클래스를 이용해 수동으로 URLEncoding을 해주면 해결할 수 있다.
				 * 크롬 브라우저는 링크로 요청 시 파라미터에 한글이 포함되어 있으면 브라우저 
				 * 주소창에는 한글 그대로 표시되지만 UTF-8로 URLEncoding을 해준다.
				 **/
				
				try {
					modelMap.put("keyword", URLEncoder.encode(keyword, "utf-8"));
				} catch (UnsupportedEncodingException e) {					
					e.printStackTrace();
				}
				
				modelMap.put("word", keyword);
				modelMap.put("type", type);
			}
			return modelMap;
			
		} else {
			return null;
		}
		
	}
	
	
//	ajax 용 테스트??
	@Override
	public List<Product> productList() {
		return productDao.productList(0, 10, "null", "null");
	}

	
	
	/* ProductDao를 이용해 게시판 테이블에서 no에 해당하는 게시 글 을 읽어와 반환하는 메서드 
 	 * isCount == true 면 게시 상세보기, false 면 게시 글 수정 폼 요청임 
	 **/
	@Override
	public Product getProduct(int no, boolean isCount) {
		return productDao.getProduct(no, isCount);
	}
	
	
	// ProductDao를 이용해 새로운 게시 글을 추가하는 메서드
	@Override
	public void insertProduct(Product product) {
		productDao.insertProduct(product);
		
	}

	
	/* 게시 글 수정, 삭제 시 비밀번호 입력을 체크하는 메서드
	 * 
	 * - 게시 글의 비밀번호가 맞으면 : true를 반환
	 * - 게시 글의 비밀번호가 맞지 않으면 : false를 반환
	 **/
//	public boolean isPassCheck(int no, String pass) {	
//		return productDao.isPassCheck(no, pass);
//	}
	
	// 상품 수정하기
	@Override
	public void updateProduct(Product product) {
		productDao.updateProduct(product);
		
	}
	

	
	
	
	
	
	
	
	

}
