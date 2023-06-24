package kr.or.ddit.controller.mainController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/main")
@Slf4j
public class MainController {
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String goMain() {
		log.info("메인 페이지 입장...");
		return "main/mainPage";
	}

}
