package kr.or.ddit.controller.adminController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String adminMain() {
		log.info("관리자 메인 입장...");
		return "admin/main";
	}

}
