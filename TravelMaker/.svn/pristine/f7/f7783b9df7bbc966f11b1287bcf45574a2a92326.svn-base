package kr.or.ddit.controller.exception;

import java.nio.file.attribute.UserPrincipalNotFoundException;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class CommonExceptionHandler {
	/**
	 * 로그인 실패 
	 * @param e : 에러메세지
	 * @param model : 에러메시지 담아서 로그인 폼으로
	 * @return : 로그인 폼 uri
	 */
	@ExceptionHandler(UserPrincipalNotFoundException.class)
	public String notFoundUser(Exception e, Model model) {
		log.info("에러메시지 : " + e);
		model.addAttribute("msg", e);
		return "";
	}
}
