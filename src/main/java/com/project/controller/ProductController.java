package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.Product;
import com.project.service.ProductService;

@Controller
public class ProductController {
	
	// 업로드한 파일 저장할 경로
	private final static String DEFAULT_PATH = "/resources/upload/";
	
	
	// 서비스 사용하기
	@Autowired
	private ProductService productService;


	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	
	
//	*** 상품 리스트 ***
	@RequestMapping(value= {"/productList"})
	public String productList(Model model, 
			@RequestParam(value="pageNum", required=false, 
					defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
					defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
					defaultValue="null") String keyword) {

		
		// service를 이용해 게시글 리스트 갖고오기 (일반 게시글 요청인지, 검색 요청인지 체크해서 반환 함)
		Map<String, Object> modelMap = productService.productList(pageNum, type, keyword);
		
		model.addAllAttributes(modelMap);
		
		return "product/productList";
	}
	
	
// *** 상품 상세보기 ***
	@RequestMapping("/productDetail")
	public String boardDetail(Model model, int no, 
			@RequestParam(value="pageNum", required=false, 
					defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
					defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
					defaultValue="null") String keyword) throws Exception {
		
		/* 요청 파라미터에서 type이나 keyword가 비어 있으면 일반 
		 * 게시 글 리스트를 요청하는 것으로 간주하여 false 값을 갖게 한다.
		 * Controller에서 type이나 keyword의 요청 파라미터가 없으면
		 * 기본 값을 "null"로 지정했기 때문에 아래와 같이 체크했다.
		 **/
		boolean searchOption = (type.equals("null") || keyword.equals("null")) ? false : true; 				
		
		/* @Transactional 애노테이션을 이용한 트랜잭션 처리 메서드 호출
		 * Service 클래스를 이용해 no에 해당하는 게시 글 하나의 정보를 읽어온다.
		 * 두 번째 인수에 true를 지정해 게시 글 읽은 횟수를 1 증가 시킨다.
		 **/
		Product product = productService.getProduct(no, true);
		
		// 현재 게시 글에 해당하는 댓글 리스트
//		List<Reply> replyList = boardService.replyList(no);
		
		

		/* 파라미터로 받은 모델 객체에 뷰로 보낼 모델을 저장한다.
		 * 모델에는 도메인 객체나 비즈니스 로직을 처리한 결과를 저장한다. 
		 **/	
		model.addAttribute("product", product);
//		model.addAttribute("replyList", replyList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchOption", searchOption);
		
		// 검색 요청이면 type과 keyword를 모델에 저장한다.
		if(searchOption) {
			
			/* IE에서 링크로 요청 시 파라미터에 한글이 포함되면 IE는 URLEncoding을
			 * 하지 않고 서버로 전송하는데 톰캣 7.06x 버전에서 정상적으로 동작하던 것이
			 * 7.07x 버전에서는 Invalid character found in the request target
			 * 이라는 에러가 발생한다. 이 문제는 아래와 같이 java.net 패키지의 URLEncoder
			 * 클래스를 이용해 수동으로 URLEncoding을 해주면 해결할 수 있다.
			 * 크롬 브라우저는 링크로 요청 시 파라미터에 한글이 포함되어 있으면 브라우저 
			 * 주소창에는 한글 그대로 표시되지만 UTF-8로 URLEncoding을 해준다.
			 **/		
			model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
			model.addAttribute("type", type);
			model.addAttribute("word", keyword);
		}
		
		/* 게시 글 상세보기에서 링크로 파일 다운로드를 요청할 때 파일 이름에 한글이 있는
		 * 경우 IE는 URLEncoding을 해주지 않기 때문에 UTF-8로 수동 인코딩 했다.
		 **/
		if(product.getImage() != null) {
			model.addAttribute("fileName", URLEncoder.encode(product.getImage(), "utf-8"));
		}
		
		/* servlet-context.xml에 설정한 ViewResolver에서 prefix와 suffix에
		 * 지정한 정보를 제외한 뷰 이름을 문자열로 반환하면 된다.
		 * 
		 * 아래와 같이 뷰 이름을 반환하면 포워드 되어 제어가 뷰 페이지로 이동한다. 
		 **/
		
		
		return "product/productDetail";
	}
	
	
	
	
//	*** 상품등록하기 (상품등록 폼에서 옮) ***
	@RequestMapping(value="/productWriteProcess", method=RequestMethod.POST)
	public String insertBoard(HttpServletRequest request,
			String productCode, String productName, String typicalIngredient, String typicalFunction, int productPrice,
			String productBrand, String productExplain,
			@RequestParam(value="image", required=false) MultipartFile multipartFile) 
					throws IOException {	
		
		System.out.println("상품 이미지 originName-> " + multipartFile.getOriginalFilename());
		System.out.println("상품 이미지name-> " + multipartFile.getName());	
		
		Product product = new Product();
		product.setProductCode(productCode);
		product.setProductName(productName);
		product.setTypicalIngredient(typicalIngredient);
		product.setTypicalFunction(typicalFunction);
		product.setProductPrice(productPrice);
		product.setProductBrand(productBrand);
		product.setProductExplain(productExplain);
		
		
		/* 업로드한 Multipart 데이터(파일)에 접근하기
		 * 
		 * - MultipartFile 인터페이스를 이용한 접근
		 * - @RequestParam 애노테이션을 이용한 접근
		 * - MultipartHttpServletRequest를 이용한 접근
		 * - 커맨드 객체를 이용한 접근
		 *   커맨드 클래스에 MultipartFile 타입의 프로퍼티가 있어야 한다. 
		 * - 서블릿 3의 Part를 이용한 접근
		 * 
		 * 이 예제는 MultipartHttpServletRequest를 이용한 파일 업로드
		 * 방법을 소개하고 있다.
		 **/		
		if(!multipartFile.isEmpty()) { // 업로드된 파일 데이터가 존재하면
			
			// Request 객체를 이용해 파일이 저장될 실제 경로를 구한다.
			String filePath = request.getServletContext().getRealPath(DEFAULT_PATH);
			
			/* UUID(Universally Unique Identifier, 범용 고유 식별자)
			 * 소프트웨어 구축에 쓰이는 식별자의 표준으로 네트워크 상에서 서로 모르는
			 * 개체들을 식별하고 구별하기 위해서 사용된다. UUID 표준에 따라 이름을
			 * 부여하면 고유성을 완벽하게 보장할 수는 없지만 실제 사용상에서 중복될 
			 * 가능성이 거의 없다고 인정되기 때문에 실무에서 많이 사용되고 있다.
			 * 
			 * 파일 이름의 중복을 막고 고유한 파일 이름으로 저장하기 위해 java.util
			 * 패키지의 UUID 클래스를 이용해 랜덤한 UUID 값을 생성한다.
			 **/
			UUID uid = UUID.randomUUID();
			String saveName = uid.toString() + "_" + multipartFile.getOriginalFilename();
			
			File file = new File(filePath, saveName);
			System.out.println("상품등록 이미지 새로운 이름-> " + file.getName());			
			
			// 업로드 되는 파일을 upload 폴더로 저장한다.
			multipartFile.transferTo(file);
			
			/* 아래와 같이 스프링이 지원하는 FileCopyUtils 클래스를
			 * 이용해 업로드 되는 파일을 upload 폴더로 저장할 수 있다.
			 **/
			//byte[] in = multipartFile.getBytes();
			//FileCopyUtils.copy(in, file);
			
			// 업로드된 파일 명을 Board 객체에 저장한다.
			product.setImage(saveName);
			System.out.println("디비에 저장된 이미지 이름-> "+saveName);
		}
		
		/* BoardService 클래스를 이용해
		 * 폼에서 넘어온 게시 글 정보를 게시 글 테이블에 추가한다.
		 **/
		productService.insertProduct(product);

		
		/* ProductMapper에서 게시 글 추가하는 맵핑 구문을 아래와 같이 작성했다.
		 *
		 * 	<insert id="insertBoard" parameterType="product" useGeneratedKeys="true" keyProperty="no">
		 * 
		 * 테이블에 하나의 레코드를 INSERT 할때 자동으로 증가되는 컬럼이나
		 * Sequence를 사용하는 컬럼의 값을 읽어와야 할 때도 있다.
		 * 보통 자동 증가되는 컬럼의 값은 데이터가 INSERT 된 후에 읽어오고
		 * Sequence일 경우 INSERT 이전에 값을 읽어와야 한다.
		 * 이렇게 INSERT 작업을 하면서 생성된 키의 값을 읽어와야 할 경우
		 * 아래와 같이 useGeneratedKeys="true"를 지정하고 자동 생성된
		 * 키의 값을 설정할 자바 모델 객체의 프로퍼티 이름을 keyProperty에
		 * 지정하면 Board 객체의 no 프로퍼티에 값을 설정해 준다.
		 **/
		System.out.println("insert No : " + product.getNo());		
		
		/* 클라이언트 요청을 처리한 후 리다이렉트 해야 할 경우 아래와 같이 redirect:
		 * 접두어를 붙여 뷰 이름을 반환하면 된다. 뷰 이름에 redirect 접두어가 붙으면
		 * HttpServletResponse를 사용해서 지정한 경로로 Redirect 된다. 
		 * redirect 접두어 뒤에 경로를 지정할 때 "/"로 시작하면 ContextRoot를
		 * 기준으로 절대 경로 방식으로 Redirect 된다. "/"로 시작하지 않으면 현재 
		 * 경로를 기준으로 상대 경로로 Redirect 된다. 또한 다른 사이트로 Redirect
		 * 되기를 원한다면 redirect:http://사이트 주소를 지정한다.
		 **/		
		return "redirect:productList";
	}
	

	
	
	// *** 상품 수정 폼 요청을 처리 (상품 수정페이지로 요청한 게시글 가지고 감) ***
	@RequestMapping(value="/updateProduct")
	public String updateBoard(Model model, HttpServletResponse response, 
			int no,
			@RequestParam(value="pageNum", required=false, 
					defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
					defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
					defaultValue="null") String keyword) throws Exception {
		

		
		// 요청 파라미터에서 type이나 keyword가 비어 있으면  
		// 일반 게시글 리스트를 요청하는 것으로 간주하여 false 값을 갖게 한다.
		boolean searchOption = (type.equals("null")	|| keyword.equals("null")) ? false : true; 
		
		/* Service 클래스를 이용해 no에 해당하는 게시 글 하나의 정보를 읽어온다.
		 * 두 번째 인수로 false를 지정해 게시 글 읽은 횟 수를 증가시키지 않는다. 
		 **/
		Product product = productService.getProduct(no, false);
		
		
		/* 파라미터로 받은 모델 객체에 뷰로 보낼 모델을 저장한다.
		 * 모델에는 도메인 객체나 비즈니스 로직을 처리한 결과를 저장한다. 
		 **/
		model.addAttribute("product", product);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchOption", searchOption);
		
		
		// 검색 요청이면 type과 keyword를 모델에 저장한다.
		if(searchOption) {
			
			/* IE에서 링크로 요청 시 파라미터에 한글이 포함되면 IE는 URLEncoding을
			 * 하지 않고 서버로 전송하는데 톰캣 7.06x 버전에서 정상적으로 동작하던 것이
			 * 7.07x 버전에서는 Invalid character found in the request target
			 * 이라는 에러가 발생한다. 이 문제는 아래와 같이 java.net 패키지의 URLEncoder
			 * 클래스를 이용해 수동으로 URLEncoding을 해주면 해결할 수 있다.
			 * 크롬 브라우저는 링크로 요청 시 파라미터에 한글이 포함되어 있으면 브라우저 
			 * 주소창에는 한글 그대로 표시되지만 UTF-8로 URLEncoding을 해준다.
			 **/
			model.addAttribute("keyword", URLEncoder.encode(keyword, "utf-8"));
			model.addAttribute("type", type);
			model.addAttribute("word", keyword);
		}
		
		
		return "product/productUpdateForm";
	}
	
	

	// *** 상품 수정 진행 ***
	@RequestMapping(value="updateProductProcess", method=RequestMethod.POST)
	public String updateBoard(HttpServletResponse response, HttpServletRequest request, RedirectAttributes reAttrs, 
			@RequestParam(value="pageNum", required=false, 
					defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
					defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
					defaultValue="null") String keyword,
			String productCode, String productName, String typicalIngredient, String typicalFunction, int productPrice,
			String productBrand, String productExplain, int no,
			@RequestParam(value="image", required=false) MultipartFile multipartFile) throws Exception {		
		

		Product product = new Product();
		product.setNo(no);
		product.setProductCode(productCode);
		product.setProductName(productName);
		product.setTypicalIngredient(typicalIngredient);
		product.setTypicalFunction(typicalFunction);
		product.setProductPrice(productPrice);
		product.setProductBrand(productBrand);
		product.setProductExplain(productExplain);
		
		
		/* 업로드한 Multipart 데이터(파일)에 접근하기
		 * 
		 * - MultipartFile 인터페이스를 이용한 접근
		 * - @RequestParam 애노테이션을 이용한 접근
		 * - MultipartHttpServletRequest를 이용한 접근
		 * - 커맨드 객체를 이용한 접근
		 *   커맨드 클래스에 MultipartFile 타입의 프로퍼티가 있어야 한다. 
		 * - 서블릿 3의 Part를 이용한 접근
		 * 
		 * 이 예제는 MultipartHttpServletRequest를 이용한 파일 업로드
		 * 방법을 소개하고 있다.
		 **/		
		if(!multipartFile.isEmpty()) { // 업로드된 파일 데이터가 존재하면
			
			// Request 객체를 이용해 파일이 저장될 실제 경로를 구한다.
			String filePath = request.getServletContext().getRealPath(DEFAULT_PATH);
			
			/* UUID(Universally Unique Identifier, 범용 고유 식별자)
			 * 소프트웨어 구축에 쓰이는 식별자의 표준으로 네트워크 상에서 서로 모르는
			 * 개체들을 식별하고 구별하기 위해서 사용된다. UUID 표준에 따라 이름을
			 * 부여하면 고유성을 완벽하게 보장할 수는 없지만 실제 사용상에서 중복될 
			 * 가능성이 거의 없다고 인정되기 때문에 실무에서 많이 사용되고 있다.
			 * 
			 * 파일 이름의 중복을 막고 고유한 파일 이름으로 저장하기 위해 java.util
			 * 패키지의 UUID 클래스를 이용해 랜덤한 UUID 값을 생성한다.
			 **/
			UUID uid = UUID.randomUUID();
			String saveName = uid.toString() + "_" + multipartFile.getOriginalFilename();
			
			File file = new File(filePath, saveName);
			System.out.println("상품수정 이미지 새로운 이름-> " + file.getName());			
			
			// 업로드 되는 파일을 upload 폴더로 저장한다.
			multipartFile.transferTo(file);
			
			/* 아래와 같이 스프링이 지원하는 FileCopyUtils 클래스를
			 * 이용해 업로드 되는 파일을 upload 폴더로 저장할 수 있다.
			 **/
			//byte[] in = multipartFile.getBytes();
			//FileCopyUtils.copy(in, file);
			
			// 업로드된 파일 명을 Board 객체에 저장한다.
			product.setImage(saveName);
			System.out.println("디비에 저장된 상품 수정 이미지 이름-> "+saveName);
		}
		
		// BoardService 클래스를 이용해 게시판 테이블에서 게시 글을 수정한다.
		productService.updateProduct(product);
		
		
		
		/* 요청 파라미터에서 type이나 keyword가 비어 있으면 
		 * 일반 게시 글 리스트를 요청하는 것으로 간주하여 false 값을 갖게 한다.
		 **/
		boolean searchOption = (type.equals("null")	|| keyword.equals("null")) ? false : true; 
		System.out.println("업데이트되어라!!!"+product.getProductName());
		

		reAttrs.addAttribute("searchOption", searchOption);
		
		// 검색 요청이면 type과 keyword를 모델에 저장한다.
		if(searchOption) {			
			
			/* Redirect 되는 경우 주소 끝에 파라미터를 지정해 GET방식의 파라미터로
			 * 전송할 수 있지만 스프링프레임워크가 지원하는 RedirectAttributs객체를
			 * 이용하면 한 번만 사용할 임시 데이터와 지속적으로 사용할 파라미터를 구분해
			 * 지정할 수 있다.
			 * 
			 * 게시 글 상세 보기 요청을 처리하는 boardDetail() 메서드에서 뷰 페이지에서
			 * 링크에 사용할 keyword를 java.net 패키지의 URLEncoder 클래스를
			 * 이용해 수동으로 인코딩한 후 모델에 담아 뷰 페이지로 전달하였다.
			 * 
			 * 리다이렉트 될 때 필요한 파라미터를 스프링이 제공하는 RedirectAttributs의
			 * addAttribute() 메서드를 사용해 파라미터를 지정하면 자동으로 주소 뒤에 
			 * 요청 파라미터로 추가되며 파라미터에 한글이 포함되는 경우 URLEncoding을
			 * java.net 패키지의 URLEncoder 클래스를 이용해 인코딩 해줘야 하지만
			 * web.xml에서 스프링프레임워크가 지원하는 CharacterEncodingFilter를
			 * 설정했기 때문에 Filter에 의해 UTF-8로 인코딩 되어 클라이언트로 응답된다.
			 * 
			 * 아래는 검색 리스트로 Redirect 되면서 같이 보내야할 keyword와 type을
			 * RedirectAttributs를 이용해 파라미터로 전달하는 예이다. 
			 **/			
			reAttrs.addAttribute("keyword", keyword);
			reAttrs.addAttribute("type", type);
		}
		
		reAttrs.addAttribute("pageNum", pageNum);		
		//reAttrs.addFlashAttribute("test", "1회용 파라미터 받음 - test");
		return "redirect:productList";
	}
	
	
	
	
	// 게시글 삭제하기
	@RequestMapping("/deleteProduct")
	public String deleteProduct(HttpServletResponse response, 
			int no, RedirectAttributes reAttrs, 
			@RequestParam(value="pageNum", required=false, 
				defaultValue="1") int pageNum,
			@RequestParam(value="type", required=false,  
				defaultValue="null") String type,
			@RequestParam(value="keyword", required=false,
				defaultValue="null") String keyword) throws Exception {
		
		
		/* 요청 파라미터에서 type이나 keyword가 비어 있으면 
		 * 일반 게시 글 리스트를 요청하는 것으로 간주하여 false 값을 갖게 한다.
		 * 기본 값을 "null"로 지정했기 때문에 아래와 같이 체크했다.
		 **/
		boolean searchOption = (type.equals("null")	|| keyword.equals("null")) ? false : true;
		
		
		// 게시글 삭제하기
		productService.deleteProduct(no);
		

		/* 클라이언트 요청을 처리한 후 리다이렉트 해야 할 경우 아래와 같이 redirect:
		 * 접두어를 붙여 뷰 이름을 반환하면 된다. 뷰 이름에 redirect 접두어가 붙으면
		 * HttpServletResponse를 사용해서 지정한 경로로 Redirect 된다. 
		 * redirect 접두어 뒤에 경로를 지정할 때 "/"로 시작하면 ContextRoot를
		 * 기준으로 절대 경로 방식으로 Redirect 된다. "/"로 시작하지 않으면 현재 
		 * 경로를 기준으로 상대 경로로 Redirect 된다. 또한 다른 사이트로 Redirect
		 * 되기를 원한다면 redirect:http://사이트 주소를 지정한다.
		 * 
		 * Redirect 되는 경우 주소 끝에 파라미터를 지정해 GET방식의 파라미터로
		 * 전송할 수 있지만 스프링프레임워크가 지원하는 RedirectAttributs객체를
		 * 이용하면 한 번만 사용할 임시 데이터와 지속적으로 사용할 파라미터를 구분해
		 * 지정할 수 있다.
		 * 
		 * 아래와 같이 RedirectAttributs의 addAttribute() 메서드를 사용해
		 * 지속적으로 사용할 파라미터를 지정하면 자동으로 주소 뒤에 파라미터로 추가되며 
		 * addFlashAttribute() 메서드를 사용해 파라미터로 지정하면
		 * 한 번만 사용할 수 있도록 주소 뒤에 파라미터로 추가되지 않는다. 
		 * 
		 * addAttribute() 메서드를 사용해 파라미터로 지정한 데이터는 페이지를
		 * 새로 고침해도 계속해서 주소 뒤에 파라미터로 남아있지만 addFlashAttribute()
		 * 메서드를 사용해 지정한 파라미터는 사라지기 때문에 1회성으로 필요한
		 * 데이터를 addFlashAttribute() 메서드를 사용해 지정하면 편리하다.
		 * 
		 * 파라미터에 한글이 포함되는 경우 URLEncoding을 코드로 구현해야 하지만
		 * web.xml에서 스프링프레임워크가 지원하는 CharacterEncodingFilter를
		 * 설정했기 때문에 Filter에 의해 UTF-8로 인코딩 되어 클라이언트로 응답된다.
		 * 
		 * 아래는 게시 글 리스트로 Redirect 되면서 같이 보내야할 searchOption을
		 * RedirectAttributs를 이용해 파라미터로 전달하는 예이다. 
		 **/
		reAttrs.addAttribute("searchOption", searchOption);
		
		
		
		// 검색 요청이면 type과 keyword를 모델에 저장한다.
		if(searchOption) {
			
			/* Redirect 되는 경우 주소 끝에 파라미터를 지정해 GET방식의 파라미터로
			 * 전송할 수 있지만 스프링프레임워크가 지원하는 RedirectAttributs객체를
			 * 이용하면 한 번만 사용할 임시 데이터와 지속적으로 사용할 파라미터를 구분해
			 * 지정할 수 있다.
			 * 
			 * 게시 글 상세 보기 요청을 처리하는 boardDetail() 메서드에서 뷰 페이지에서
			 * 링크에 사용할 keyword를 java.net 패키지의 URLEncoder 클래스를
			 * 이용해 수동으로 인코딩한 후 모델에 담아 뷰 페이지로 전달하였다.
			 * 
			 * 리다이렉트 될 때 필요한 파라미터를 스프링이 제공하는 RedirectAttributs의
			 * addAttribute() 메서드를 사용해 파라미터를 지정하면 자동으로 주소 뒤에 
			 * 요청 파라미터로 추가되며 파라미터에 한글이 포함되는 경우 URLEncoding을
			 * java.net 패키지의 URLEncoder 클래스를 이용해 인코딩 해줘야 하지만
			 * web.xml에서 스프링프레임워크가 지원하는 CharacterEncodingFilter를
			 * 설정했기 때문에 Filter에 의해 UTF-8로 인코딩 되어 클라이언트로 응답된다.
			 * 
			 * 아래는 검색 리스트로 Redirect 되면서 같이 보내야할 keyword와 type을
			 * RedirectAttributs를 이용해 파라미터로 전달하는 예이다. 
			 **/			
			reAttrs.addAttribute("keyword", keyword);
			reAttrs.addAttribute("type", type);
		}
		
		reAttrs.addAttribute("pageNum", pageNum);
		
		
		return "redirect:productList";

		
	}

	
	
	
	
	
	
	
}
