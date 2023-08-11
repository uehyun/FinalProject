package kr.or.ddit.travelmaker.host.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.service.IHostService2;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/host")
@Slf4j
public class SHGHostController {
	
	@Inject
	private IHostService2 hostService;
	
	@Inject
	private IMemberService memberService;
	
	/* 메인 */
	//@PreAuthorize("hasRole('ROLE_HOST')")
	@GetMapping("/main")
	public String mainPage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		List<AcommodationVO> accList = hostService.selectInvalidAcc(member.getMemNo());
		
		model.addAttribute("accList", accList);
		model.addAttribute("member", member);
		
		return "host/main";
	}
	
	@ResponseBody
	@PostMapping(value="/selectAres", produces="application/json; charset=UTF-8")
	public ResponseEntity<List<AccReservationVO>> getAres(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		 
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		  
		List<AccReservationVO> list = hostService.selectAres(map);
		  
		return new ResponseEntity<List<AccReservationVO>>(list, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_HOST')")
	@GetMapping("/manage")
	public String goManage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		MemberVO member = memberService.selectMember(map);
		
		model.addAttribute("member", member);
		
		return "host/accommodationManage";
	}
	
	@ResponseBody
	@PostMapping(value="/selectAccWithFilter", produces="application/json; charset=UTF-8")
	public ResponseEntity<List<AcommodationVO>> selectAcc(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		for (String key : map.keySet()) {
			log.info(key);
			log.info(map.get(key).toString());
			log.info("=================================================");
		}
		
		List<AcommodationVO> list = hostService.selectAccWithFilter(map);

		return new ResponseEntity<List<AcommodationVO>>(list, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/activeInactive", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> updateActive(@RequestBody Map<String, Object> map) {
		ServiceResult res = hostService.updateAccActive(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	/* 메인 */
	
	
	/* 매출 */
//	@PreAuthorize("hasRole('ROLE_HOST')")
	@GetMapping("/revenue")
	public String getProfit(Model model, RedirectAttributes ra) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		List<AcommodationVO> accList = hostService.selectValidAcc(map);
		
		if(accList == null || accList.size() == 0) {
			ra.addFlashAttribute("error", "호스팅 중인 숙소가 없습니다.");
			return "redirect:/host/main";
		}
		
		model.addAttribute("member", member);
		model.addAttribute("accList", accList);
		
		return "host/revenue";
	}
	
	@ResponseBody
	@PostMapping(value="/getTextData", produces="application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> getData(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		Map<String, Object> salesMap = hostService.getAllSalesAmount(map);
		
		Map<String, Object> avgMap = hostService.avgReservation(map);
		
		if(salesMap != null && salesMap.size() > 0) {
			map.putAll(salesMap);
		}
		
		if(avgMap != null && avgMap.size() > 0) {
			map.putAll(avgMap);
		}
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/getPieChartData", produces="application/json; charset=UTF-8")
	public ResponseEntity<List<Map<String, Object>>> getPieChart(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		List<Map<String, Object>> list = hostService.getPieChartData(map);
		
		return new ResponseEntity<List<Map<String,Object>>>(list, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/getGraphChartData", produces="application/json; charset=UTF-8")
	public ResponseEntity<List<Map<String, Object>>> getGraphChart(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		List<Map<String, Object>> avgGraphList = hostService.getAvgGraphChartData(map);
		
		return new ResponseEntity<List<Map<String,Object>>>(avgGraphList, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/getReservationList", produces="application/json; charset=UTF-8")
	public ResponseEntity<List<Map<String, Object>>> getList(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		List<Map<String, Object>> list = hostService.selectReservationList(map);
		
		return new ResponseEntity<List<Map<String, Object>>>(list, HttpStatus.OK);
	}
	/* 매출 */
	
	/* 캘린더 */
	//@PreAuthorize("hasRole('ROLE_HOST')")
	@GetMapping("/calendar")
	public String calendarPage(Model model, RedirectAttributes ra) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
//		map.put("memId", "a001");
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		List<AcommodationVO> accList = hostService.selectValidAcc(map);
		
		if(accList == null || accList.size() == 0) {
			ra.addFlashAttribute("error", "호스팅 중인 숙소가 없습니다.");
			return "redirect:/host/main";
		}
		
		model.addAttribute("member", member);
		model.addAttribute("accList", accList);
		
		return "host/calendar";
	}
	
	@ResponseBody
	@PostMapping(value="/getAllReservation", produces="application/json; charset=UTF-8")
	public ResponseEntity<AcommodationVO> getAllReservation(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
//		map.put("memId", "a001");
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		AcommodationVO acc = hostService.selectAccReservation(map);
		
		return new ResponseEntity<AcommodationVO>(acc, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("/accReservationDetail/{aresNo}")
	public ResponseEntity<Map<String, Object>> getReservationDetail(@PathVariable String aresNo) {
		log.info(aresNo);
		
		Map<String, Object> map = hostService.selectReservationDetail(aresNo);
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/updateInvalid", produces="application/json; charset=UTF-8")
	public ResponseEntity<ServiceResult> updateInvalid(@RequestBody Map<String, Object> map) {
		ServiceResult res = hostService.updateInvalidDate(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/updateEvent")
	public ResponseEntity<ServiceResult> updateEvent(@RequestBody Map<String, Object> map) {
		ServiceResult res = hostService.updateEvent(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("/selectEvent")
	public ResponseEntity<AdminEventVO> selectEvent(String eventNo) {
		log.info(eventNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("eventNo", eventNo);
		
		AdminEventVO vo = hostService.selectEvent(map);
		
		return new ResponseEntity<AdminEventVO>(vo, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping(value="/participateEvent", produces="application/json; charset=UTF-8")
	public ResponseEntity<ServiceResult> participate(@RequestBody Map<String, Object> map) {
		String str = hostService.isParticipate(map);
		
		if(StringUtils.isNotEmpty(str)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.FAILED, HttpStatus.OK);
		} else {
			ServiceResult res = hostService.updateParticipate(map);
			return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
		}
	}
	/* 캘린더 */
}
