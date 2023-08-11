package kr.or.ddit.travelmaker.flight.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.HashCodeExclude;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.flight.service.IFlightService;
import kr.or.ddit.travelmaker.flight.vo.FlightVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/flight")
@Slf4j
public class FlightController {
	
	@Inject
	private IFlightService flightService;
	@Inject
	private IMemberService memberService;
	
	// 비행기 메인 페이지
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String goFlightMain(Model model) {
		log.info("비행기 메인 페이지 입장...");
		List<FlightVO> airportList = flightService.getAirport();
		model.addAttribute("airport", airportList);
		return "flight/flightMain";
	}
	
	@RequestMapping(value = "/reservation/{flightNo}", method = RequestMethod.GET)
	public String flightReservation(@PathVariable String flightNo, Model model) {
		log.info("비행기 예약 페이지 입장...");
		model.addAttribute("flight", flightNo);
		return "flight/reservation";
	}
	
	// 탑승객 정보 들고 좌석 예약 페이지로 이동
	@ResponseBody
	@PostMapping("/passengerInfo")
	public ResponseEntity<ServiceResult> passengerInformation(HttpServletRequest req,
			@RequestBody List<FlightVO> passengerList){
		
		log.info("탑승객 정보 들고가기...");
		if(passengerList != null) {
			HttpSession session = req.getSession();
			session.setAttribute("passenger", passengerList);
			List<FlightVO> list = (List<FlightVO>) session.getAttribute("passenger");
			for (FlightVO flightVO : list) {
				System.out.println("Fffff" + flightVO);
			}
			log.info("세션저장");
			
			return new ResponseEntity<ServiceResult>(ServiceResult.OK, HttpStatus.OK);
		}else {
			return new ResponseEntity<ServiceResult>(ServiceResult.FAILED, HttpStatus.OK);
		}
		
	}
	
	// 좌석 데이터 
	@RequestMapping(value = "/seatReservation", method = RequestMethod.GET)
	public String flightSeatReservation(@RequestParam String flightNo, Model model) {
		log.info("비행기 좌석예약 페이지 입장...");
		List<FlightVO> list = flightService.selectSeats(flightNo);
		
		List<FlightVO> lista = new ArrayList<FlightVO>();
		List<FlightVO> listb = new ArrayList<FlightVO>();
		List<FlightVO> listc = new ArrayList<FlightVO>();
		List<FlightVO> listd = new ArrayList<FlightVO>();
		List<FlightVO> liste = new ArrayList<FlightVO>();
		List<FlightVO> listf = new ArrayList<FlightVO>();
		
		log.info("모델 담기 전");
		
		for (FlightVO flightVO : list) {
			if(flightVO.getFlightSeatNo().contains("A")) {
				lista.add(flightVO);
			}
			if(flightVO.getFlightSeatNo().contains("B")) {
				listb.add(flightVO);
			}
			if(flightVO.getFlightSeatNo().contains("C")) {
				listc.add(flightVO);
			}
			if(flightVO.getFlightSeatNo().contains("D")) {
				listd.add(flightVO);
			}
			if(flightVO.getFlightSeatNo().contains("E")) {
				liste.add(flightVO);
			}
			if(flightVO.getFlightSeatNo().contains("F")) {
				listf.add(flightVO);
			}
		}
		model.addAttribute("rowA", lista);
		model.addAttribute("rowB", listb);
		model.addAttribute("rowC", listc);
		model.addAttribute("rowD", listd);
		model.addAttribute("rowE", liste);
		model.addAttribute("rowF", listf);
		model.addAttribute("flightNo", flightNo);
		
		log.info("페이지 넘어가기전");
		
		return "flight/seatReservation";
	}
	
	@PostMapping(value = "/reservationDetail", produces = "application/json;charset=utf-8")
	public String flightReservationDetail(
			@RequestParam("childPrice") int[] childPrice,
			@RequestParam("adultPrice") int[] adultPrice,
			@RequestParam("flightSeatNo") String[] flightSeatNo,
			@RequestParam("flightNo") String flightNo,
									HttpServletRequest req,
									Model model) {
		log.info("비행기 예약 상세 페이지 입장...");
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", user.getUsername());
		MemberVO member = memberService.selectMember(map);
		System.out.println("member : " + member);
		String memNo =member.getMemNo();
		String memEmail = member.getMemEmail();
		String memName = member.getMemName();
		String memPhone = member.getMemPhone();
		
		
//		System.out.println("memNo: " + memNo);
		
		HttpSession session = req.getSession();
		List<FlightVO> flightList =  (List<FlightVO>) session.getAttribute("passenger");
		
		int totalPrice = 0;
		
		for (int i = 0; i < flightList.size(); i++) {
			FlightVO flightVO = flightList.get(i);
			if(flightVO.getPassengerType().equals("성인")) {
				for (int j = 0; j < adultPrice.length; j++) {
					if(adultPrice[j] != 0) {
						flightVO.setFlightSeatNo(flightSeatNo[j]);
						flightVO.setAdultPrice(adultPrice[j]);
						flightVO.setFreservationPrice(adultPrice[j]);
						totalPrice += adultPrice[j];
						adultPrice[j] = 0;
						break;
					}
				}
			}else if (flightVO.getPassengerType().equals("유소년")) {
				for (int j = 0; j < childPrice.length; j++) {
					if(childPrice[j] != 0) {
						flightVO.setFlightSeatNo(flightSeatNo[j]);
						flightVO.setChildPrice(childPrice[j]);
						flightVO.setFreservationPrice(childPrice[j]);
						totalPrice += childPrice[j];
						childPrice[j] = 0;
						break;
					}
				}
			}
		}
		
		
		for (int a = 0; a < flightList.size(); a++) {
			FlightVO flightVO = flightList.get(a);
			flightVO.setMemNo(memNo);
			flightVO.setMemName(memName);
			flightVO.setMemEmail(memEmail);
			flightVO.setMemPhone(memPhone);
			flightVO.setFreservationTotalPrice(totalPrice);
			int adultCount = flightVO.getAdultCount();
			int childCount = flightVO.getChildCount();
			int totalCount = adultCount + childCount;
			flightVO.setFreservationPassengerCount(totalCount);
		}
		for (FlightVO flightVO2 : flightList) {
			System.out.println("flightVO2 : "  + flightVO2);
		}
		String uuidId = UUID.randomUUID().toString();
		log.info("uuidId -> " + uuidId);
		
		model.addAttribute("uuidId", uuidId);
		flightService.insertReservation(flightList);
		
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("flight", flightList);
		
		List<FlightVO> list = flightService.reservationDetail(flightNo);
		model.addAttribute("reservationDetail", list);
		return "flight/reservationDetail";
	}
	
	@PostMapping(value = "/insertPayment", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> insertPayment(@RequestBody Map<String, Object> map){
		flightService.insertPayment(map);
		
		Map<String, Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("url", "/main/home");
		return ResponseEntity.ok().body(response) ;
	}
	
	// 비행기 검색
	@GetMapping(value = "/searchAirport", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> searchAirport(@RequestParam String flightName, Model model) {
		List<FlightVO> airportList = flightService.getAirportByName(flightName);
		
		Map<String, Object> response = new HashMap<>();
	    response.put("result", "SUCCESS");
	    response.put("airport", airportList);
		return ResponseEntity.ok().body(response);
	}
	
	// 비행기 예약 리스트
	@ResponseBody
	@PostMapping(value = "/flightList", produces = "application/json; charset=utf-8")
	public ResponseEntity<List<FlightVO>> flightList(@RequestBody FlightVO flightVO){
		String sortOption = flightVO.getSortOption();
		int startNo = flightVO.getStartNo();
		int itemsPerPage = flightVO.getItemsPerPage();
		List<FlightVO> flightList;
		
	    if (StringUtils.isNotEmpty(sortOption)) {
	        flightList = flightService.flightListFilter(flightVO);
	    } else {
	        flightList = flightService.flightList(flightVO);
	    }
		return new ResponseEntity<List<FlightVO>>(flightList, HttpStatus.OK);
	}
	
}
 


















