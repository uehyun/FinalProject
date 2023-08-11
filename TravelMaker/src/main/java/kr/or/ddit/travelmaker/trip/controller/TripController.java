package kr.or.ddit.travelmaker.trip.controller;

import java.lang.reflect.Field;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.travelmaker.alarm.service.IAlarmService;
import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.trip.service.TripMemberService;
import kr.or.ddit.travelmaker.trip.service.TripService;
import kr.or.ddit.travelmaker.trip.vo.TravelAccVO;
import kr.or.ddit.travelmaker.trip.vo.TravelMemberVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleDetailVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.service.FileService;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class TripController {

	@Inject
	private TripService tripService;

	@Inject
	private TripMemberService tripMemberService;

	@Inject
	private FileService fileService;

	@Inject
	private IMemberService memberService;
	
	@Inject
	private IAlarmService alarmService;

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/trip")
	public String goTrip(Principal principal, Model model) {
		log.info("goTrip() 실행....");
		MemberVO member = getMemNo(principal.getName());
		List<TravelScheduleVO> list = tripService.myList(member.getMemNo());
		model.addAttribute("tripList", list);
		return "member/trip";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "ajaxTrip", produces = "application/json; charset=utf-8")
	public ResponseEntity<Object> ajaxTrip(Principal principal) {
		log.info("goTrip() 실행....");
		MemberVO member = getMemNo(principal.getName());
		List<TravelScheduleVO> list = tripService.myList(member.getMemNo());
		return ResponseEntity.ok().body(list);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/addTrip", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> addTripForm(HttpServletRequest req, TravelScheduleVO vo,
			Principal principal) {
		log.info("addTripForm() 실행...");

		tripService.insert(vo);

		MemberVO member = getMemNo(principal.getName());

		TravelMemberVO tmVO = new TravelMemberVO();
		tmVO.setMemNo(member.getMemNo());
		tmVO.setTravelNo(vo.getTravelNo());

		tripMemberService.insert(tmVO);

		// 파일 업로드 로직
		FileVO fileVO = new FileVO();
		String folder = "tripTheme";
		try {
			fileVO.setFile(req, vo.getTravelImg(), folder, vo.getTravelNo());
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}

		List<FileVO> list = new ArrayList<FileVO>();
		list.add(fileVO);
		fileService.insertFile(list);
		//
		List<FileVO> fileList = fileService.getSaveName(vo.getTravelNo());
		//
		vo.setTravelImgPath(fileList.get(0).getAttPath());
		tripService.updatePicture(vo);

		Map<String, Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("returnPage", "/member/tripForm?travelNo=" + vo.getTravelNo());
		return ResponseEntity.ok().body(response);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/tripForm")
	public String goTripForm(String travelNo, Model model) {
		log.info("goTripForm() 실행...");
		TravelScheduleVO vo = tripService.selectOne(travelNo);
		TravelMemberVO tmVO = tripMemberService.selectOne(travelNo);
		model.addAttribute("tripSchedule", vo);
		model.addAttribute("mem", tmVO);
		return "member/tripForm";
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/tripList")
	public ResponseEntity<Map<String, Object>> getTripList(String travelNo, String travelDate, Principal principal) {
		log.info("getTripList() 실행...");
		TravelScheduleDetailVO vo = new TravelScheduleDetailVO();
		vo.setTravelNo(travelNo);
		vo.setTravelDate(travelDate);
		
		MemberVO member = getMemNo(principal.getName());
		
		TravelAccVO taVO = new TravelAccVO();
		taVO.setTravelDate(travelDate);
		taVO.setMemNo(member.getMemNo());
		
		Map<String, Object> response = new HashMap<String, Object>();
		//
		List<TravelScheduleDetailVO> tripList = tripService.selectList(vo);
		List<Map<String, Object>> mappedList = tripList.stream()
			    .map(tsVO -> {
			        try {
			            return toMap(tsVO);
			        } catch (IllegalAccessException e) {
			            throw new RuntimeException(e);
			        }
			    })
			    .collect(Collectors.toList());
		List<TravelAccVO> list = tripService.getAcc(taVO);
		response.put("acc", list);
		response.put("trip", mappedList);
		return ResponseEntity.ok().body(response);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/addTripDetail", produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> addTrip(@RequestBody List<TravelScheduleDetailVO> placeList) {
		log.info("addTrip() 실행..");
		tripService.deleteDetail(placeList.get(0));
		if(placeList.get(0).getPlaceUrl() != null) {
			tripService.insertDetail(placeList);
		}
		Map<String, Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("places", placeList);
		return ResponseEntity.ok().body(response);
	}

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/delTrip", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> delTrip(@RequestBody Map<String, String> req, Principal principal) {
		log.info("delTrip() 입장.....=>>");
		log.info("여행번호" + req.get("travelNo"));
		String travelNo = req.get("travelNo");
		tripService.delete(travelNo);

		Map<String, Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("msg", "삭제가 완료되었습니다.");
		return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/addMem", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxAddMember(@RequestBody Map<String,String> map, Principal principal) {
		log.info("ajaxAddMember() 입장.....===>>");
		MemberVO member = getMemNo(map.get("memId"));
		MemberVO memVO = getMemNo(principal.getName());
		Map<String,Object> response = new HashMap<String, Object>();
		if(member.getMemNo() != null || ("").equals(member.getMemNo())) {
			TravelMemberVO vo = new TravelMemberVO();
			vo.setMemNo(member.getMemNo());
			vo.setTravelNo(map.get("travelNo"));
			TravelMemberVO tmVO = null;
			tmVO = tripMemberService.selectOne(map.get("travelNo"));
			boolean memOk = true;
			for(MemberVO mem : tmVO.getMemList()) {
				if(mem.getMemNo().equals(member.getMemNo())) {
					response.put("msg", "이미 추가된 회원입니다.");
					memOk = false;
					break;
				}
			}
			if(memOk) {
				ServiceResult result = tripMemberService.insert(vo);
				tmVO = tripMemberService.selectOne(map.get("travelNo"));
				if(result.equals(ServiceResult.OK)) {
					response.put("result", "SUCCESS");
					response.put("mem", tmVO);
					response.put("msg", "추가되었습니다.");
					// 여기서 추가된 회원에게 알림보내기
					AlarmVO alarm = new AlarmVO();
					alarm.setMemNo(member.getMemNo());
					alarm.setAlarmType("공유된 여행");
					alarm.setAlarmContent(memVO.getMemName() + "님의 여행에 추가되었습니다.");
					alarm.setAlarmUrl("/member/tripForm?travelNo=" + map.get("travelNo"));
					alarmService.insertAlarm(alarm);
				} else {
					response.put("msg", "서버 오류로 인해 실패하였습니다.");
				}
			}
		} else {
			response.put("msg", "존재하지 않는 사용자입니다.");
		}
		return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/tripMemo", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxTripMemo(@RequestBody TravelScheduleDetailVO vo) {
		log.info("ajaxTripMemo() 실행....=====>>");
		Map<String,Object> response = new HashMap<String, Object>();
		
		ServiceResult result = tripService.update(vo);
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
			response.put("memo", vo.getMemo());
		} else {
			response.put("msg", "서버 오류 등록에 실패했습니다.");
		}
		return ResponseEntity.ok().body(response);
	}

	// 회원 no 가져오는 메소드
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
	
	public Map<String, Object> toMap(Object object) throws IllegalAccessException {
	    Map<String, Object> map = new HashMap<>();

	    Field[] fields = object.getClass().getDeclaredFields();
	    for (Field field : fields) {
	        field.setAccessible(true); // private 필드에 접근 가능하도록 설정
	        String key = field.getName();
	        Object value = field.get(object);
	        
	        String underscoreKey = Arrays.stream(key.split("(?=[A-Z])"))
	            .map(String::toLowerCase)
	            .collect(Collectors.joining("_"));
	        map.put(underscoreKey, value);
	    }
	    return map;
	}
}
