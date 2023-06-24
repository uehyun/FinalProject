package kr.or.ddit.controller;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.oauth.SNSLogin;
import kr.or.ddit.oauth.SnsValue;
import kr.or.ddit.service.member.IMemberService;
import kr.or.ddit.service.oauth.IKakaoService;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private IKakaoService ks;
	
	@Inject
	private IMemberService memberService;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(Model model) throws Exception {
		SNSLogin naverLogin = new SNSLogin(naverSns);
		model.addAttribute("naverUrl", naverLogin.getNaverAuthURL());
		
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?client_id=4e0625b31428542719b6bbc5747b13f2&redirect_uri=http://localhost/oauth/kakao/login&response_type=code";
		model.addAttribute("kakaoUrl", kakaoUrl);
		
		return "login/signin";
	}
	
	@RequestMapping(value="/oauth/{service}/login")
	public String snsLogin(@PathVariable String service, Model model, @RequestParam String code) throws Exception {
		log.info("service : " + service);
		log.info("code : " + code);
		
		MemberVO member = null;
		
		if(StringUtils.equals("naver", service)) {
			SNSLogin snsLogin = new SNSLogin(naverSns);
			member = snsLogin.getUserProfile(code);
			
			log.info("profile ==> " + member);
		} else if(StringUtils.equals("google", service)) {
			//구글 수정해야 함
			
		} else if(StringUtils.equals("kakao", service)) {
			String access_token = ks.getToken(code); 
			log.info("카카오 토큰 : " + access_token);
			
	        member = ks.getUserInfo(access_token);
	        log.info("사용자 정보 : " + member);
		}
		
		//1. 받아온 code로 access_token 받기
		//2. access_token을 이용해서 사용자 profile 정보 가져오기
		
		
		
		//3. DB 해당 유저가 존재하는지 체크 (google 아이디, naver 아이디) 컬럼
		MemberVO snsMember = memberService.selectMemberBySocialId(member);
		//userService.getBySns(user);
		if(snsMember == null) {
			//없는 회원
		} else {
			//있는 회원
		}
		
		//4. 존재하면 로그인, 없으면 가입
		
		return "main/mainPage";
	}
}
