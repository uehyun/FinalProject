package kr.or.ddit.travelmaker.interceptor;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Logger extends HandlerInterceptorAdapter {
	PrintWriter writer;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		
//		String username = "";
//		if(authentication != null && authentication.isAuthenticated()) {
//			if (authentication instanceof AnonymousAuthenticationToken) {
//				username = "익명";
//			} else {
//				User user = (User) authentication.getPrincipal();
//				username = user.getUsername();
//			}
//        }
//        
//		String path = "D:/logs/" + username + "/";
//        File directory = new File(path);
//        
//        if(!directory.exists()) {
//        	directory.mkdirs();
//        }
//        
//        File file = new File(path + "travelmaker_logger.log");
//        
//		writer = new PrintWriter(new FileWriter(file, true), true);
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//		String requestURI = request.getRequestURI();
//		log.info("requestURI : " + requestURI);
//		
//		if (handler instanceof HandlerMethod) {
//            HandlerMethod handlerMethod = (HandlerMethod) handler;
//            Method method = handlerMethod.getMethod();
//
//            Class<?> clazz = method.getDeclaringClass();
//            String className = clazz.getName();
//            String methodName = method.getName();
//            Parameter[] parameters = method.getParameters();
//            
//            writer.printf("현재일시 : %s %n", getCurrentTime());
//        	writer.printf("요청 컨트롤러 : %s %n", className + "." + methodName);
//        	
//        	for (Parameter parameter : parameters) {
//        		writer.printf("파라미터: %s %s %n", parameter.getType().getName(), parameter.getName());
//        	}
//        }
	}
	
	public String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(cal.getTime());
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
}
