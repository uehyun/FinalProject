package kr.or.ddit.travelmaker.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		log.info("로그인 성공 후 실행");
		User customUser = (User) authentication.getPrincipal();
		
		log.info("username : " + customUser.getUsername());
		log.info("password : " + customUser.getPassword());
		log.info("user : " + customUser);
		
//		Cookie[] cookies = request.getCookies();
//		
//		if(cookies != null && cookies.length != 0) {
//			for(Cookie cookie : cookies) {
//				if("requestURI".equals(cookie.getName())) {
//					response.sendRedirect(cookie.getValue());
//					return;
//				}
//			}
//		}
		
		response.sendRedirect("/main/home");
	}
}
