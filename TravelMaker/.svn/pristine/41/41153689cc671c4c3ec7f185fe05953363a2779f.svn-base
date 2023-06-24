package kr.or.ddit.controller.intercept;

import java.lang.reflect.Method;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class loginInterceptor extends HandlerInterceptorAdapter {
	/**
	 * 로그인이 안되어 있으면 로그인 페이지로 보내고 로그인 성공 시 다시 요청한 페이지로 돌아오는 메소드
	 * 로그인 체크할 때 쿠키값 받아서 requestURI라는 쿠키가 null이 아니면 return "redirect:" + requestURI로 다시 보내주면 됨
	 * 
	 * 주석인 상태로 테스트 하고 마지막에 처리
	 * 로그인이 필요 없는 경우 servlet-context.xml에서 exclude mapping 해줄 것
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.info("preHandle");
		
		String requestURI = request.getRequestURI();			
		
		log.info("PreHandle에서 요청한 URI : " + requestURI);
		
//		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		
//		log.info("userInfo : " + user);
//		
//		if(user == null) {
//			Cookie cookie = new Cookie("requestURI", requestURI);
//			cookie.setMaxAge(60 * 60);
//			cookie.setPath("/");
//			response.addCookie(cookie);
//			
//			//로그인 폼으로 보내는 uri 작성
//			response.sendRedirect("");
//			
//			return false;
//		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		log.info("postHandle");
		
		String requestURI = request.getRequestURI();
		
		log.info("postHandle에서 요청한 URI : " + requestURI);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		log.info("afterCompletion");
		
		String requestURL = request.getRequestURL().toString();
		String requestURI = request.getRequestURI();
		
		log.info("requestURL : " + requestURL);
		log.info("requestURI : " + requestURI);
		
		HandlerMethod method = (HandlerMethod) handler;
		Method methodObj = method.getMethod();
		
		log.info("Bean : " + method.getBean());
		log.info("method : " + methodObj);
	}
}
