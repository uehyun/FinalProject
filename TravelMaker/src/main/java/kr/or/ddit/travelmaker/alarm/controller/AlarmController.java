package kr.or.ddit.travelmaker.alarm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.travelmaker.alarm.service.IAlarmService;
import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/alarm")
@Slf4j
public class AlarmController {
	@Inject
	private IMemberService memberService;
	
	@Inject
	private IAlarmService alarmService;
	
	@ResponseBody
	@PostMapping("/getAlarmList")
	public ResponseEntity<List<AlarmVO>> getList() {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		List<AlarmVO> list = alarmService.selectAlarm(member.getMemNo());
		
		return new ResponseEntity<List<AlarmVO>>(list, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping("/deleteAlarm")
	public ResponseEntity<ServiceResult> deleteAlarm(String alarmNo) {
		log.info(alarmNo);
		
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = alarmService.selectMemberByAlarmNo(alarmNo);
		
		if(!user.getUsername().equals(memId)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.FORBIDDEN, HttpStatus.OK);
		}
		
		int res = alarmService.deleteAlarm(alarmNo);
		
		if(res > 0) {
			return new ResponseEntity<ServiceResult>(ServiceResult.OK, HttpStatus.OK);
		} else {
			return new ResponseEntity<ServiceResult>(ServiceResult.FAILED, HttpStatus.OK);
		}
	}
	
	@ResponseBody
	@GetMapping("/getCount")
	public ResponseEntity<Integer> getAlarmCount(String memNo) {
		int res = alarmService.selectAlarmCount(memNo);
		
		return new ResponseEntity<Integer>(res, HttpStatus.OK);
	}
}
