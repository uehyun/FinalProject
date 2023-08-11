package kr.or.ddit.travelmaker.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class CommonExceptionHandler {
	@ExceptionHandler(Exception.class)
	public String handle(Exception e, Model model) {
		log.info("e : " + e.toString());
		model.addAttribute("exception", e);
		return "error/errorPage";
	}
}
