package com.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.project.domain.Basket;
import com.project.domain.Member;
import com.project.service.MemberService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

// 스프링 MVC의 컨트롤러임을 선언하고 있다.
@Controller

/* 스프링은 데이터를 세션 영역에 저장할 수 있도록 @SessionAttributes("모델이름")
 * 애노테이션을 제공하고 있다. 클래스 레벨에 @SessionAttributes("모델이름")와
 * 같이 애노테이션과 모델 이름을 지정하고 아래 login(), joinInfo() 메서드와 같이 
 * Controller 메서드에서 @SessionAttributes에 지정한 모델이름과 동일한 
 * 이름으로 모델에 객체를 추가하면 이 객체를 세션 영역에 저장해 준다.
 * 
 * 회원 가입 처리를 위한 단계를 살펴보면 약관동의, 실명인증 , 회원 기본정보 입력,
 * 회원 추가정보 입력 등과 같이 여러 화면으로 구성되어 있다. 이렇게 여러 단계를
 * 거쳐서 회원이 입력한 정보를 임시로 저장해야 할 경우 일반적으로 세션 영역에 저장하게
 * 되는데 이 때 @SessionAttributes("모델이름") 애노테이션을 사용해 임시로
 * 사용할 데이터를 세션 영역에 저장할 수 있다.
 * 클래스 레벨에 @SessionAttributes("모델이름") 애노테이션과 모델 이름을
 * 지정하고 아래 joinInfo() 메서드와 같이 Controller 메서드에서 같은 이름을
 * 지정해 모델에 추가하면 이 객체를 세션 영역에 저장하게 된다. 그리고 임시로 사용할
 * 객체의 사용이 끝나면 아래 logout(), joinResult() 메서드와 같이 SessionStatus의
 * setComplete() 메서드를 이용해 데이터를 세션 영역에서 삭제하면 된다.
 * 
 * @SessionAttributes()를 사용해 member와 m 두 개의 모델 이름을 지정했다. 
 **/
@SessionAttributes({"member", "m", "countBasket"})
public class MemberController {
	private MemberService memberService;
	private IamportClient api;
	
	public MemberController() {
		this.api = new IamportClient("8134985003699769",
				"7BWxqsSezbExZaA3whZw1EucBL0ao6rwHo37QVmp70W6bxaHOadQOI3pu3zS91pRptZfolFwmCDy9OfY");
	}
	
	/* @Autowired annotation을 사용해 MemberService 구현체를 셋터 주입하고 있다. 
	 * 스프링이 기본 생성자를 통해 이 클래스의 인스턴스를 생성한 후 setter 주입
	 * 방식으로 MemberService 구현체를 주입해 준다. 셋터 주입은 반드시 기본 생성자가
	 * 존재해야 하지만 이 클래스에는 다른 생성자가 존재하지 않으므로 컴파일러에 의해
	 * 자동으로 기본 생성자가 만들어 진다.
	 **/
	@Autowired
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	/* @RequestMapping의 ()에 method=RequestMethod.Post를 지정해
	 * "/login"으로 들어오는 POST 방식의 요청을 처리할 수 있도록 설정하고 있다.
	 * 
	 * 요청을 처리한 결과를 뷰에 전달하기 위해 사용하는 것이 Model 객체이다.
	 * 컨트롤러는 요청을 처리한 결과 데이터를 모델에 담아 뷰로 전달하고 뷰는
	 * 모델로 부터 데이터를 읽어와 클라이언트로 보낼 결과 페이지를 만들게 된다.
	 *   
	 * 스프링은 컨트롤러에서 모델에 데이터를 담을 수 있는 다양한 방법을 제공하는데
	 * 아래와 같이 파라미터에 Model을 지정하는 방식이 많이 사용된다. 
	 * @RequestMapping 애노테이션이 적용된 메서드의 파라미터에 Model
	 * 을 지정하면 스프링이 이 메서드를 호출하면서 Model 타입의 객체를 넘겨준다.
	 * 우리는 Model을 받아 이 객체에 결과 데이터를 담기만 하면 뷰로 전달된다.
	 * 	
	 * @RequestMapping 애노테이션이 적용된 메서드의 파라미터에 
	 * @RequestParam 애노테이션에 파라미터 이름을 지정하면 
	 * 이 애노테이션이 앞에 붙은 매개변수에 파라미터 값을 바인딩 시켜준다.
	 * 
	 * @RequestParam 애노테이션에 사용할 수 있는 속성은 아래와 같다.
	 * value : HTTP 요청 파라미터의 이름을 지정한다.
	 * required : 요청 파라미터가 필수인지 설정하는 속성으로 기본값은 true 이다.
	 * 			이 값이 true인 상태에서 요청 파라미터의 값이 존재하지 않으면
	 * 			스프링은 Exception을 발생시킨다.
	 * defaultValue : 요청 파라미터가 없을 경우 사용할 기본 값을 문자열로 지정한다.
	 * 
	 * @RequestParam(value="id" required="false" defaultValue="")
	 * 
	 * @RequestParam 애노테이션은 요청 파라미터 값을 읽어와 메서드의 
	 * 파라미터 타입에 맞게 변환해 준다.
	 * 스프링은 요청 파라미터의 값으로 변환할 수 없는 경우 400 에러를 발생시킨다.
	 * 
	 * @RequestMapping 애노테이션이 적용된 메서드에 요청 파라미터
	 * 이름과 메서드의 파라미터 이름이 같은 경우 @RequestParam 애노테이션을
	 * 지정하지 않아도 스프링으로부터 요청 파라미터를 받을 수 있다. 
	 **/	 
	@RequestMapping(value="/login", method=RequestMethod.POST)	
	public String login(Model model, @RequestParam("id") String id, 
			@RequestParam("pwd") String pwd, 
			HttpSession session, HttpServletResponse response) 
					throws ServletException, IOException, NoSuchAlgorithmException {
		
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(pwd.getBytes());
		String hex = String.format("%064x", new BigInteger(1, md.digest()));
		
		System.out.println("hex = " + hex);
		int result = memberService.login(id, hex);
		
		if(result == -1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("	alert('존재하지 않는 아이디 입니다.');");
			out.println("	history.back();");
			out.println("</script>");
			
			/* 컨트롤러에서 null을 반환하거나 메서드의 반환 타입이 void일 경우
			 * Writer나 OutputStream을 이용해 응답 결과를 직접 작성할 수 있다.
			 * DispatcherServlet을 경유해 리소스 자원에 접근하는 경우에
			 * 자바스크립트의 history.back()은 약간의 문제를 일으킬 수 있다.
			 * history 객체를 이용하는 경우 서버로 요청을 보내는 것이 아니라
			 * 브라우저의 접속 이력에서 이전 페이지로 이동되기 때문에 발생한다. 
			 **/
			return null;
			
		} else if(result == 0) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("	alert('비밀번호가 다릅니다.');");
			out.println("	location.href='loginForm'");
			out.println("</script>");
			
			return null;
		}		
		
		int countBasket = memberService.countBasket(id);
		
		model.addAttribute("countBasket", countBasket);

		System.out.println("countBasket = " + countBasket);
		Member member = memberService.getMember(id);
		session.setAttribute("isLogin", true);
		
		/* 클래스 레벨에 @SessionAttributes("member") 애노테이션을
		 * 지정하고 컨트롤러의 메서드에서 아래와 같이 동일한 이름으로 모델에
		 * 추가하면 스프링이 세션 영역에 데이터를 저장해 준다.
		 **/ 
		model.addAttribute("member", member);
		System.out.println("member.name : " + member.getName());

		/* 클라이언트 요청을 처리한 후 리다이렉트 해야할 경우 아래와 같이 redirect:
		 * 접두어를 붙여 뷰 이름을 반환하면 된다. 뷰 이름에 redirect 접두어가 붙으면
		 * HttpServletResponse를 사용해서 지정한 경로로 Redirect 된다. 
		 * redirect 접두어 뒤에 경로를 지정할 때 "/"로 시작하면 ContextRoot를
		 * 기준으로 절대 경로 방식으로 Redirect 된다. "/"로 시작하지 않으면 현재 
		 * 경로를 기준으로 상대 경로로 Redirect 된다. 또한 다른 사이트로 Redirect
		 * 되기를 원한다면 redirect:http://사이트 주소를 지정한다.
		 * 
		 * 로그인이 성공하면 게시 글 리스트로 리다이렉트 된다.
		 **/
		return "redirect:/main";
	}
	
	/* @RequestMapping의 ()에 method 속성을 지정하지 않았으므로 
	 * "/logout" 으로 들어오는 GET 방식 요청을 처리할 수 있도록 설정하고 있다.
	 **/
	@RequestMapping("/logout")
	public String logout(SessionStatus sessionStatus, HttpSession session) {	
		
		/* 세션 영역에서 객체를 삭제
		 * 세션 영역에서만 삭제되고 모델에는 삭제되지 않는다.
		 * 세션을 다시 시작하지 않기 때문에 세션이 계속해서 유지된다.
		 **/
		sessionStatus.setComplete();
		
		// 현재 세션을 종료하고 새로운 세션을 시작한다.
		session.invalidate();
		
		/* 클라이언트 요청을 처리한 후 리다이렉트 해야할 경우 아래와 같이 redirect:
		 * 접두어를 붙여 뷰 이름을 반환하면 된다. 뷰 이름에 redirect 접두어가 붙으면
		 * HttpServletResponse를  사용해서 지정한 경로로 Redirect 된다. 
		 * redirect 접두어 뒤에 경로를 지정할 때 "/"로 시작하면 ContextRoot를
		 * 기준으로 절대 경로 방식으로 Redirect 된다. "/"로 시작하지 않으면 현재 
		 * 경로를 기준으로 상대 경로로 Redirect 된다. 또한 다른 사이트로 Redirect
		 * 되기를 원한다면 redirect:http://사이트 주소를 지정한다.
		 * 
		 * 로그아웃 되면 게시 글 리스트로 리다이렉트 된다./
		 **/
		return "redirect:/main";
	}
	
	/* 회원가입 폼, 수정 폼 에서 들어오는 요청을 처리하는 메서드
	 * 아래는 "/joinInfo"로 들어오는 GET 방식 요청을 처리하는 메서드를 지정한
	 * 것이다. method 속성을 생략하면 기본 값은 RequestMethod.GET 이다.
	 * 
	 * 실제 memberJoinForm.jsp에서 폼을 전송할 때 POST 방식으로 폼을 전송
	 * 했지만 아래의 jointInfo() 메서드에서 정상적으로 처리된다.
	 * method 속성이 생략되면 스프링은 GET 방식 요청을 먼저 적용해 처리 하지만
	 * POST 방식의 요청도 처리해 준다.
	 * 
	 * 만약 아래에서 method=RequestMethod.GET 를 명시적으로 지정했거나
	 * /joinInfo 요청을 처리하는 메서드가 존재하지 않는다면 아래와 같이 405
	 * 익셉션이 발생하게 된다.
	 * 
	 * HTTP Status 405 - Request method 'POST' not supported
	 * 
	 * 스프링이 자동으로 처리해 주긴 하지만 GET 방식과 POST 방식을 명확하게
	 * 처리하는 것이 바람직한 코딩 방법이다.
	 * 
	 * 스프링은 폼으로부터 전달된 파라미터를 객체로 처리 할 수 있는 아래와 같은
	 * 방법을 제공하고 있다. 아래와 같이 요청 파라미터를 전달받을 때 사용하는 
	 * 객체를 커맨드 객체라고 부르며 이 커맨트 객체는 자바빈 규약에 따라 프로퍼티에
	 * 대한 setter를 제공하도록 작성해야 한다. 그리고 파라미터 이름이 커맨드 객체의
	 * 프로퍼티와 동일하도록 폼 컨트롤의 name 속성을 지정해야 한다.
	 * 
	 * @RequestMapping 애노테이션이 적용된 Controller 메서드에 커맨드 객체를
	 * 파라미터로 지정하면 커맨드 객체의 프로퍼티와 동일한 이름을 가진 요청 
	 * 파라미터의 데이터를 스프링이 자동으로 설정해 준다. 이때 스프링은 자바빈
	 * 규약에 따라 적절한 setter 메서드를 사용해 값을 설정한다.
	 * 
	 * 커맨드 객체의 프로퍼티와 일치하는 파라미터 이름이 없다면 기본 값으로 설정된다.
	 * 또한 프로퍼티의 데이터 형에 맞게 적절히 형 변환 해 준다. 형 변환을 할 수 없는
	 * 경우 스프링은 400 에러를 발생 시킨다. 예를 들면 프로퍼티가 정수 형 일때 매칭
	 * 되는 값이 정수형으로 형 변환 할 수 없는 경우 400 에러를 발생 시킨다.
	 *
	 * 커맨드 객체는 스프링에 의해 클래스 이름에서 첫 자를 소문자한 카멜 케이싱된
	 * 이름으로 뷰에 전달할 model에 자동 추가된다.
	 * 예를 들면 클래스 이름이 MemberServiceRequest라면 model에 저장되는
	 * 이름은 클래스 이름의 첫 자를 소문자한 memberServiceRequest가 된다.
	 * 위와 같이 클래스 이름이 길어 model에 추가되는 커맨드 객체의 이름을 변경해야
	 * 할 경우 아래와 같이 커맨드 객체 앞에 @ModelAttribute() 애노테이션을
	 * 사용해 model에서 사용할 이름을 지정하면 된다.
	 * 
	 * @ModelAttribute("m") MemberServiceRequest member
	 *  
	 * 아래의 Member 객체에 @ModelAttribute("m")를 적용시키면 에러가 발생한다.
	 * 그 이유는 클래스 레벨에 @SessionAttributes({"member", "m"})를 지정하고
	 * Controller 메서드의 파라미터에 @ModelAttribute("m")를 이용해 동일한 이름을
	 * 지정하게 되면 세션 영역에서 m이라는 이름을 가진 데이터를 찾는데 /joinInfo로
	 * 요청이 들어올 때 세션에는 m이라는 이름을 가진 속성이 없기 때문에 에러가 발생한다.
	 **/
	@RequestMapping("/joinInfo")
	public String joinInfo(SessionStatus sessionStatus, HttpSession session, Member member,
			String id, String pwd1, String pwdQuestion, String pwdAnswer,
			String nk, String phone0, String phone1, String phone2,
			int year, int month, int day, String name, String email1,
			String email2, String postcode1, String roadAddress1,
			String detailAddress1, String extraAddress1,
			String CompanyName, String postcode2, String roadAddress2,
			String detailAddress2, String extraAddress2,
			int sell, int medi) throws NoSuchAlgorithmException {
		
		System.out.println("/joinInfo");
		
		
		member.setId(id);
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(pwd1.getBytes());
		String hex = String.format("%064x", new BigInteger(1, md.digest()));
		member.setPw(hex);
		member.setPwQuestion(pwdQuestion);
		member.setPwAnswer(pwdAnswer);
		member.setNickName(nk);
		member.setPhone(phone0 + "-" + phone1 + "-" + phone2);
		int y1 = year % 10;
		int y2 = year / 10 % 10 * 10;
		year = y1 + y2;
		member.setBirth(year*10000 + month*100 + day);
		member.setName(name);
		member.setEmail(email1 + "@" + email2);
		member.setAddress(postcode1 + "-" + roadAddress1 + 
				"-" + extraAddress1 + "-" + detailAddress1);
		
		member.setSeller(sell);
		member.setMedic(medi);
		
		if(medi == 0) {
		} else {
			member.setBusinessName(CompanyName);
			member.setBusinessAdd(postcode2 + "-" + roadAddress2 + 
					"-" + extraAddress2 + "-" + detailAddress2);
		}
		
		
		memberService.addMember(member);
		
		// 세션 삭제
		sessionStatus.setComplete();
		
		return "redirect:main";
	}
	

	// 회원가입 아이디 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public int idCheck(@RequestParam("checkId") String check_id) {
		
		return memberService.overlapIdCheck(check_id);
	}
	
	// 회원가입 닉네임 체크
	@RequestMapping(value = "/nkCheck", method = RequestMethod.GET)
	@ResponseBody
	public int nkCheck(@RequestParam("checkNk") String check_nk) {
		
		return memberService.overlapNkCheck(check_nk);
	}
	
	
	// 회원 정보 수정 폼 요청을 처리하는 메서드
	@RequestMapping("/memberUpdateForm")
	public String updateForm(Model model, String id) {
		
		/* 일반적으로 회원 정보 수정은 로그인이 완료된 후에 이루어 진다.
		 * 회원 로그인 시에 이미 세션 영역에 Member 객체를 저장하도록
		 * 구현되어 있으므로 별도로 모델을 만들 필요는 없다. 
		 **/
		Member member = memberService.getMember(id);
		model.addAttribute("member", member);
		
		return "member/memberUpdateForm";
	}	
	
	// 회원 수정 폼에서 들어오는 요청을 처리하는 메서드
	@RequestMapping("/memberUpdateInfo")
	public String memberUpdateInfo(Model model, Member member,
			String pass1, String emailId, String emailDomain,
			String mobile1, String mobile2, String mobile3,
			String phone1, String phone2, String phone3,
			@RequestParam(value="emailGet", required=false, 
				defaultValue="false")boolean emailGet) {
		System.out.println("/memberUpdateInfo ");
		
		member.setPw(pass1);
		member.setEmail(emailId + "@" + emailDomain);
				
		if(phone2.equals("") || phone3.equals("")) {			
			member.setPhone("");				
		} else {			
			member.setPhone(phone1 + "-" + phone2 + "-" + phone3);
		}				
		
		/* 클래스 레벨에 @SessionAttributes({"member", "m"}) 
		 * 애노테이션을 지정하고 컨트롤러의 메서드에서 아래와 같이 동일한 
		 * 이름으로 모델에 추가하면 스프링이 세션 영역에 데이터를 저장해 준다.
		 **/ 
		model.addAttribute("m", member);	
		return "member/memberUpdateInfo";
	}
	
	/* 회원이 수정한 정보를 확인한 후 수정완료를 클릭하여 들어오는 요청을 처리하는 메서드
	 * 
	 * 클래스 레벨에 @SessionAttributes({"member", "m"})를 지정하고
	 * Controller 메서드에서 member, m이라는 이름으로 모델에 저장하면
	 * 이 데이터는 세션 영역의 속성에 저장된다. Controller 메서드의 파라미터에
	 * 아래와 같이 Controller 메서드의 파라미터에 @ModelAttribute("m")를
	 * 지정하면 스프링은 세션 영역에서 m이라는 이름을 가진 데이터를 찾아 member
	 * 변수에 바인딩 시켜 준다. 만약 세션 영역의 속성에 m이라는 이름을 가진 
	 * 데이터가 존재하지 않으면 Exception이 발생한다.
	 **/
	@RequestMapping("/memberUpdateResult")
	public String updateResult(Model model,
			HttpSession session,
			SessionStatus sessionStatus,
			@ModelAttribute("m") Member member) {
		
		System.out.println("updateResult : " + member.getId());
		memberService.updateMember(member);
		
		return "redirect:boardList";
	}
	
	// 장바구니 담기
	@RequestMapping(value = "/addBasket", method = RequestMethod.GET)
	@ResponseBody
	public void Basket(@RequestParam("num") int num, 
			@RequestParam("id") String id, @RequestParam("count") int count,
			Basket basket, Model model) {
		System.out.println("여기까진 왔어");
		System.out.println("id = " + id);
		System.out.println("num = " + num);
		System.out.println("count = " + count);
		
		basket.setNum(num);
		basket.setId(id);
		basket.setCount(count);
		
		memberService.addBasket(basket);
		int countBasket = memberService.countBasket(id);
		
		model.addAttribute("countBasket", countBasket);
	}
	
	// 장바구니 하나 삭제
	@RequestMapping(value = "/deleteBasketOne", method = RequestMethod.GET)
	@ResponseBody
	public void delBasket(HttpServletRequest request, @RequestParam("no") int no, Model model) {
		memberService.deleteBasketOne(no);
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		String id = member.getId();
		int countBasket = memberService.countBasket(id);
		
		model.addAttribute("countBasket", countBasket);
	}
	
	// 구매시 장바구니 삭제 및 구매내역 넣기
	@RequestMapping(value = "/deleteBasket", method = RequestMethod.GET)
	@ResponseBody
	public void Basket(HttpServletRequest request, @RequestParam("productName") List<String> productName,
			@RequestParam("count") List<Integer> count,
			@RequestParam("price") List<Integer> price,
			@RequestParam("num") List<Integer> num, Model model) {

		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		String id = member.getId();
		int birth = member.getBirth();
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
		
		Date time = new Date();
		String time1 = format1.format(time);
		int now = Integer.parseInt(time1);
		int time2 = 0;
		if(birth / 10000 > 22) {
			time2 = now - 1900 - (birth / 10000) + 1;
		} else {
			time2 = now - 2000 - (birth / 10000) + 1;
		}
		time2 = time2 / 10 * 10;
		
		String age = Integer.toString(time2)+ "대";
		System.out.println("age = " + age);
		Basket basket = new com.project.domain.Basket();
		System.out.println("productName = " + productName);
		System.out.println("count = " + count);
		System.out.println("price = " + price);
		System.out.println("num = " + num);
		System.out.println("id = " + id);
		for(int i=0; i < productName.size(); i++) {
			basket.setProductName(productName.get(i));
			basket.setCount(count.get(i));
			basket.setPrice(price.get(i));
			basket.setNum(num.get(i));
			basket.setId(id);
			basket.setAge(age);
			memberService.addPurchase(basket);
		}
		
		memberService.deleteBasket(basket);
		int countBasket = memberService.countBasket(id);
		
		model.addAttribute("countBasket", countBasket);
	}
	
	@RequestMapping("/basket")
	public String Basket(HttpServletRequest request,Model model) {
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		String id = member.getId();
		List<Basket> basket = memberService.getBasket(id);
		if(basket.size() != 0) {
			System.out.println("basket" + basket);
			model.addAttribute("basket", basket);
			int total = 0;
			for(int i=0; i < basket.size(); i++) {
				total += basket.get(i).getPrice();
			}
			System.out.println("total = " + total);
			System.out.println("장바구니 id = " + id);
			
			model.addAttribute("total", total);
		}
		return "member/Basket";
	}
	
	@RequestMapping("/MyPage")
	public String MyPage(HttpServletRequest request,Model model,
			@RequestParam(value="pageNum", required=false, 
			defaultValue="1") int pageNum) {
		int begin = 0;
		int end = 0;
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		String id = member.getId();
		
		int startRow = (pageNum-1) * 10;
		if(pageNum - 2 >= 1) {
			begin = pageNum - 2;
		} else {
			begin = 1;
		}
		int pageCount = memberService.countPurchase(id);
		if(pageCount % 10 == 0) {
			end = pageCount / 10;
		} else {
			end = pageCount / 10 + 1;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startRow", startRow);
		List<Basket> basket = memberService.getPurchase(map);
		if(basket.size() != 0) {
			model.addAttribute("purchase", basket);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("end", end);
			model.addAttribute("begin", begin);
		}
		
		return "member/MyPage";
	}
	
	@RequestMapping("/SignUp")
	public String SignUp() {
		
		return "member/SignUp";
	}
	
	@RequestMapping("/login")
	public String Login() {
		
		return "member/Login";
	}
	
	//결제 확인
	@ResponseBody
	@RequestMapping("/payments/complete")
	public IamportResponse<Payment> paymentByImpUid(Model model,
			Locale locale, HttpSession session,
			@PathVariable(value="imp_uid") String imp_uid) throws IamportResponseException,
	IOException{
		System.out.println("컨트롤러까진 오냐?");
		return api.paymentByImpUid(imp_uid);
	}
}
