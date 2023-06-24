package kr.or.ddit.controller.memberController;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.vo.PlaceVO;
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
	public String addTripForm() {
		log.info("여행 추가해보아용...");
		return "member/tripForm";
	}

	@RequestMapping(value = "/addTrip", method = RequestMethod.PUT, headers = "X-HTTP-Method-Override=PUT")
	public ResponseEntity<String> addTrip(@RequestBody List<PlaceVO> placeList, Model model) {
		log.info("addTrip() 실행..");
		for(PlaceVO place : placeList) {
			log.info("이름 : " + place.getName());
			log.info("카테고리 : " + place.getCategory());
			log.info("URL : " + place.getUrl());
			log.info("전화번호 : " + place.getPhone());
			log.info("x좌표 : " + place.getX());
			log.info("y좌표 : " + place.getY());
		}
		ResponseEntity<String> entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		model.addAttribute("res", placeList);
		return entity;
	}
	
}
