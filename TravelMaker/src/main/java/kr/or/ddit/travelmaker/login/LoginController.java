package kr.or.ddit.travelmaker.login;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.travelmaker.login.oauth.SNSLogin;
import kr.or.ddit.travelmaker.login.oauth.SnsValue;
import kr.or.ddit.travelmaker.login.vo.CustomUser;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.MailUtils;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	
	@GetMapping("/login")
	public String loginForm(String error, Model model) throws Exception {
		SNSLogin naverLogin = new SNSLogin(naverSns);
		model.addAttribute("naverUrl", naverLogin.getNaverAuthURL());
		
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?client_id=키 값&redirect_uri=http://localhost/oauth/kakao/login&response_type=code";
		model.addAttribute("kakaoUrl", kakaoUrl);
		
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("googleUrl", url);
		
		if(StringUtils.isNotBlank(error)) {
			model.addAttribute("error", error);
		}
		
		return "login/signin";
	}
	
	@GetMapping("/signup")
	public String registerForm() {
		return "login/signup";
	}
	
	@GetMapping("/forget")
	public String forgetForm() {
		return "login/forget";
	}
	
	@PostMapping("/signup")
	public String register(@RequestParam Map<String, Object> map, Model model, RedirectAttributes ra) {
		Map<String, String> error = new HashMap<>();
		
		if(StringUtils.isBlank(map.get("memId").toString())) {
			error.put("idError", "아이디를 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("memPw").toString())) {
			error.put("pwError", "비밀번호를 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("memName").toString())) {
			error.put("nameError", "이름을 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("memPhone").toString())) {
			error.put("phoneError", "전화번호를 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("memEmail").toString())) {
			error.put("emailError", "이메일을 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("domain").toString())) {
			error.put("domainError", "이메일 주소를 입력해주세요.");
		}
		if(StringUtils.isBlank(map.get("memAgree").toString())) {
			error.put("agreeError", "개인정보를 동의해주세요.");
		}
		
		if(error.size() > 0) {
			model.addAttribute("error", error);
			model.addAttribute("member", map);
			return "login/signup";
		}
		
		map.put("isSocial", "N");
		ServiceResult result = memberService.insertMember(map);
		
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("result", "회원가입이 완료되었습니다.");
			return "redirect:/login";
		} else {
			model.addAttribute("error", "회원가입이 실패했습니다.");
			return "login/signup";
		}
	}
	
	@RequestMapping(value="/oauth/{service}/login")
	public String snsLogin(@PathVariable String service, @RequestParam String code, RedirectAttributes ra, Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
		SNSLogin snsLogin = null;
		
		if(StringUtils.equals("naver", service)) {
			snsLogin = new SNSLogin(naverSns);
			map = snsLogin.getNaverUserInfo(code);
		} else if(StringUtils.equals("google", service)) {
			snsLogin = new SNSLogin();
			String accessToken = snsLogin.getGoogleToken(code);
			
			map = snsLogin.getGoogleUserInfo(accessToken);
		} else if(StringUtils.equals("kakao", service)) {
			snsLogin = new SNSLogin();
			String accessToken = snsLogin.getKakaoToken(code); 
			
			map = snsLogin.getKakaoUserInfo(accessToken);
		}
		
		map.put("socialService", service);
		MemberVO snsMember = memberService.selectMember(map);
		
		if (snsMember == null) {
			map.put("isSocial", "Y");
			map.put("memPw", UUID.randomUUID().toString());
			ServiceResult res = memberService.insertMember(map);
			
			log.info("결과 : " + res);
			
			if(res.equals(ServiceResult.OK)) {
				model.addAttribute("memNo", map.get("memNo").toString());
				return "login/updatePassword";
			} else {
				ra.addFlashAttribute("error", "회원가입에 실패했습니다.");
				return "redirect:/login";
			}

		} else {
			User user = new CustomUser(snsMember);
			Authentication authentication = new UsernamePasswordAuthenticationToken(user, snsMember.getMemPw(), user.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(authentication);
		}
        
		return "redirect:/main/home";
	}
	
	@ResponseBody
	@PostMapping(value="/idCheck", produces="application/json; charset=UTF-8")
	public ResponseEntity<ServiceResult> idCheck(@RequestBody Map<String, Object> map) {
		MemberVO vo = memberService.findData(map);
		ServiceResult res = null;
		
		if(vo != null) {
			res = ServiceResult.EXIST;
		} else {
			res = ServiceResult.NOTEXIST;
		}
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/findId", produces="application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> findId(@RequestBody Map<String, Object> map) {
		log.info("name : " + map.get("memName").toString());
		log.info("email : " + map.get("memEmail").toString());
		log.info("domain : " + map.get("domain").toString());
		
		String memEmail = map.get("memEmail").toString() + map.get("domain").toString();
		map.put("memEmail", memEmail);
		
		MemberVO vo = memberService.findData(map);
		
		if(vo == null) {
			map.put("id", null);
			map.put("social", null);
		} else {
			map.put("id", vo.getMemId());
		}
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/sendCertification", produces="application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, Object> map) {
		String str = "";
        for(int i = 0; i < 6; i++) {
        	int random = (int)(Math.random()*10);
            str += random;
        }
        
        long res = 0;
        
        log.info(map.get("memPhone").toString());
        
		if("N".equals(map.get("isFind").toString())) {
			//회원가입에서 온 데이터
			res = memberService.sendMessage(map.get("memPhone").toString(), str);
		} else {
			//비밀번호 찾기에서 온 데이터
			MemberVO vo = memberService.findData(map);
			if(vo == null) {
				map.put("fail", "존재하지 않는 회원입니다.");
				return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			} else {
				res = memberService.sendMessage(map.get("memPhone").toString(), str);
			}
		}
        
        log.info("결과값 : " + res);
        
        if(res > 0) {
        	map.put("str", str);
        	map.put("fail", null);
        	return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
        } else {
        	map.put("fail", "인증번호 전송을 실패하였습니다.");
        	return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
        }
	}
	
	@ResponseBody
	@PostMapping("/sendMail")
	public ResponseEntity<Map<String, Object>> sendMail(@RequestBody Map<String, Object> map) {
		log.info("id : " + map.get("memId").toString());
		log.info("email : " + map.get("memEmail").toString());
		
		String memEmail = map.get("memEmail").toString() + map.get("domain").toString();
		map.put("memEmail", memEmail);
		
		MemberVO vo = memberService.findData(map);
		
		if(vo == null) {
			map.put("error", "존재하지 않는 회원입니다.");
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		
		map.put("memNo", vo.getMemNo());
		int res = MailUtils.sendMail(map);
		
		map.put("res", res);
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/findPw", produces="application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> findPw(@RequestBody Map<String, Object> map) {
		log.info("id : " + map.get("memId").toString());
		log.info("memPhone : " + map.get("memPhone").toString());
		
		MemberVO vo = memberService.findData(map);
		log.info("vo : " + vo);
		
		if(vo == null) {
			map.put("no", null);
			map.put("social", null);
		} else {
			map.put("no", vo.getMemNo());
			map.put("social", null);
		}
		
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	@GetMapping("/updatePassword")
	public String updatePasswordForm(String memNo, Model model) {
		model.addAttribute("memNo", memNo);
		return "login/updatePassword";
	}
	
	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam Map<String, Object> map, Model model, RedirectAttributes ra) {
		log.info("no : " + map.get("memNo").toString());
		log.info("pw : " + map.get("memPw").toString());
		
		ServiceResult result = memberService.updatePassword(map);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("result", "비밀번호가 변경되었습니다.");
			return "redirect:/login";
		} else {
			model.addAttribute("member", map);
			return "login/forget";
		}
	}
}
