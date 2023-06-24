package kr.or.ddit.controller.memberController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberTripController {
	
	@RequestMapping(value = "/trip",method = RequestMethod.GET)
	public String goTrip() {
		log.info("여행관리 들어옴....");
		return "member/trip";
	}
	
	@RequestMapping(value = "/addTrip", method = RequestMethod.GET)
	public String addTrip() {
		log.info("여행 추가해보아용...");
		return "member/tripForm";
	}


}
