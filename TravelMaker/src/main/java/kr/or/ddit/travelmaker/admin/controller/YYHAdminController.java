package kr.or.ddit.travelmaker.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.admin.service.EventManageService;
import kr.or.ddit.travelmaker.admin.service.HostManageService;
import kr.or.ddit.travelmaker.admin.service.MemberManageService;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.admin.vo.HostManageVO;
import kr.or.ddit.travelmaker.admin.vo.MemberManageVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/manage")
@Slf4j
public class YYHAdminController {
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private MemberManageService memManageService;
	
	@Inject
	private HostManageService hostManageService;
	
	@Inject
	private EventManageService eventManageService;
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/revenue")
	public String adminMain(Model model) {
		log.info("adminMain() 입장....===================>>");
		List<OptionitemVO> list = hostManageService.selectCategory();
		model.addAttribute("list", list);
		return "admin/revenue/main";
	}

	// ========================================= 회원 관리 =============================================>>
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/member")
	public String memberManagement() {
		log.info("memberManagement() 입장.....==================================>>");
		return "admin/manage/member";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/memberList")
	@ResponseBody
	public List<MemberManageVO> ajaxMemberList() {
		log.info("ajaxMemberList() 실행.........===========================>>");
		List<MemberManageVO> list = memManageService.list();
		return list;
	}
	
	// ========================================= 호스트 관리 =============================================>>
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/host")
	public String hostManagement() {
		log.info("hostManagement() 입장.....==================================>>");
		return "admin/manage/host";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/hostList")
	@ResponseBody
	public List<HostManageVO> ajaxHostList() {
		log.info("ajaxHostList() 실행....=================================>>");
		List<HostManageVO> list = hostManageService.list();
		return list;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/selectOne/{num}")
	@ResponseBody
	public HostManageVO ajaxHostDetail(@PathVariable("num") String accNo) {
		log.info("ajaxHostDetail()...실행~!");
		HostManageVO vo = hostManageService.selectOne(accNo);
		return vo;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/hostUpdate", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> ajaxHostUpdate(@RequestBody List<HostManageVO> list) {
		log.info("ajaxHostUpdate() 실행......==============================>>");
		
		Map<String, Object> response = new HashMap<>();
		ServiceResult result = hostManageService.update(list);
		if(result.equals(ServiceResult.OK)) {
			if(list.get(0).getFlag().equals("ok")) {
				response.put("result", "SUCCESS");
				response.put("msg", "숙소 승인이 완료되었습니다.");
			} else if(list.get(0).getFlag().equals("no")) {
				response.put("result", "SUCCESS");
				response.put("msg", "숙소 거절이 완료되었습니다.");
			}
		} else {
			response.put("msg", "서버오류 요청이 실패했습니다.");
		}
		List<HostManageVO> newList = hostManageService.list();
		response.put("list", newList);
		return response;
	}
	// ========================================= 신고 관리 =============================================>>
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/blame")
	public String blameManagement() {
		log.info("blameManagement() 입장.........!");
		return "admin/manage/blame";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	@GetMapping("/blameList")
	public List<BlameVO> ajaxBlameList() {
		log.info("ajaxBlameList() 실행.....=====>>");
		List<BlameVO> list = memManageService.blameList();
		return list;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/blameUpdate", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> ajaxBlameUpdate(@RequestBody List<BlameVO> list) {
		log.info("ajaxHostUpdate() 실행......==============================>>");
		
		Map<String, Object> response = new HashMap<>();
		ServiceResult result = memManageService.update(list);
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
			response.put("msg", "신고처리가 완료되었습니다.");
		} else {
			response.put("msg", "서버오류 요청이 실패했습니다.");
		}
		List<BlameVO> newList = memManageService.blameList();
		response.put("list", newList);
		return response;
	}
	
	// ========================================= 이벤트 관리 =============================================>>
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/event")
	public String eventManagement() {
		log.info("eventManagement() 입장.....==================================>>");
		return "admin/manage/event";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/eventList")
	@ResponseBody
	public List<AdminEventVO> ajaxEventList() {
		log.info("ajaxEventList() 실행.......!");
		List<AdminEventVO> list = eventManageService.list();
		return list;
	}
	
	   //이벤트 등록 페이지
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@RequestMapping(value = "/detailEvent", method = RequestMethod.GET)
	public String detailEvent(Model model) {
	    List<OptionitemVO> cotOptions = eventManageService.cotOptionItems();
	    model.addAttribute("cotOptions", cotOptions);
	    return "admin/manage/eventDetail";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value="/insertEvent", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> insertEvent(@RequestBody AdminEventVO vo, Model model) {
	    
	    ServiceResult result = eventManageService.insertEvent(vo);
	    Map<String,Object> response = new HashMap<>();
	    if(result.equals(ServiceResult.OK)) {
	        response.put("result", "SUCCESS");
	    } else if (result.equals(ServiceResult.EXIST)) {
	    	response.put("result", "이벤트가 이미 존재합니다.");
	    } else {
	    	response.put("result", "이벤트 등록에 실패했습니다.");
	    }
	    return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/updateEvent", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> ajaxUpdateEvent(@RequestBody AdminEventVO vo) {
		Map<String, Object> response = new HashMap<>();
		ServiceResult result = eventManageService.update(vo);
		List<AdminEventVO> list = eventManageService.list();
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
			response.put("msg", "수정이 완료되었습니다.");
		} else {
			response.put("msg", "수정이 실패했습니다.");
		}
		response.put("list", list);
		return response;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/deleteEvent", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> ajaxDeleteEvent(@RequestBody List<AdminEventVO> eList) {
		log.info("ajaxDeleteEvent() 실행....!!");
		Map<String,Object> response = new HashMap<String, Object>();
		ServiceResult result = eventManageService.delete(eList);
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
			response.put("msg", "삭제가 완료되었습니다.");
		} else {
			response.put("msg", "서버 오류 삭제가 실패했습니다.");
		}
		List<AdminEventVO> list = eventManageService.list();
		response.put("list", list);
		return response;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/eventUpdate", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> ajaxUpdateStatus(@RequestBody List<AdminEventVO> list) {
log.info("ajaxHostUpdate() 실행......==============================>>");
		
		Map<String, Object> response = new HashMap<>();
		ServiceResult result = eventManageService.updateStatus(list);
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
			response.put("msg", "처리가 완료되었습니다.");
		} else {
			response.put("msg", "서버오류 요청이 실패했습니다.");
		}
		List<AdminEventVO> newList = eventManageService.list();
		response.put("list", newList);
		return response;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/cateList")
	@ResponseBody
	public List<OptionitemVO> ajaxOptionList() {
		List<OptionitemVO> list = eventManageService.cotOptionItems();
		return list;
	}
	
	
	// 회원 no 가져오는 메소드
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}

}