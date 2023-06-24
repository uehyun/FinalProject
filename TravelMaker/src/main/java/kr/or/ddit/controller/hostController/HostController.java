package kr.or.ddit.controller.hostController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/host")
@Slf4j
public class HostController {
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String hostMain() {
		log.info("호스트 메인페이지 입장....");
		return "host/main";
	}

}
