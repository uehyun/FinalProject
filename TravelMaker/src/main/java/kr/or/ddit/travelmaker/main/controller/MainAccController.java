package kr.or.ddit.travelmaker.main.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.main.service.IMainService;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/main")
@Slf4j
public class MainAccController {
	
	@Inject
	private IMainService mainService;
	
	@Inject
	private IMemberService memberService;
	
	@ResponseBody
	@GetMapping(value = "/accCate", produces = "application/json; charset=utf-8")
	public List<AcommodationVO> ajaxGetAcc(@RequestParam Map<String,Object> map) {
		log.info("ajaxGetAcc() 실행...!");
		
		List<AcommodationVO> list = mainService.getAllAcommodations(map);
		return list;
	}
	
	@ResponseBody
	@GetMapping(value = "/search", produces = "application/json; charset=utf-8")
	public List<AcommodationVO> ajaxSearch(@RequestParam Map<String,Object> map, Principal principal) {
		PaginationInfoVO<AcommodationVO> pagingVO = new PaginationInfoVO<AcommodationVO>();
		if(principal != null) {
			MemberVO member = getMemNo(principal.getName());
			pagingVO.setMemNo(member.getMemNo());
		}
		pagingVO.setScreenSize(15);
		if(StringUtils.isNotBlank(map.get("category").toString())) {
			pagingVO.setCategory(map.get("category").toString());
		}
		if(StringUtils.isNotBlank(map.get("checkIn").toString())) {
			pagingVO.setCheckIn(map.get("checkIn").toString());
		}
		if(StringUtils.isNotBlank(map.get("checkOut").toString())) {
			pagingVO.setCheckOut(map.get("checkOut").toString());
		}
		if(StringUtils.isNotBlank(map.get("juso").toString())) {
			pagingVO.setJuso(map.get("juso").toString());
		}
		pagingVO.setGuest(Integer.parseInt(map.get("guest").toString()));
		pagingVO.setCurrentPage(Integer.parseInt(map.get("pageCount").toString()));
		
		int totalRecord = mainService.selectAccCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AcommodationVO> dataList = mainService.selectAccList(pagingVO);
		
		return dataList;
	}
	
	// 회원 no 가져오는 메소드
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}

}
