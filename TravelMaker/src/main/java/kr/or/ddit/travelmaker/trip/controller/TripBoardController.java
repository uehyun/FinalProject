package kr.or.ddit.travelmaker.trip.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.trip.service.TBoardReplyService;
import kr.or.ddit.travelmaker.trip.service.TBoardService;
import kr.or.ddit.travelmaker.trip.service.TripService;
import kr.or.ddit.travelmaker.trip.vo.TBoardReplyVO;
import kr.or.ddit.travelmaker.trip.vo.TBoardVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/tripBoard")
@Slf4j
public class TripBoardController {
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private TripService tripService;
	
	@Inject
	private TBoardService tBoardService;
	
	@Inject
	private TBoardReplyService tBoardReplyService;

	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/main")
	public String tripBoardMain(Model model) {
		log.info("tripBoardMain() 시작....");
		List<TBoardVO> list = tBoardService.popList();
		model.addAttribute("popList", list);
		return "tripboard/main";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/register")
	public String registerTripBoard(Principal principal, Model model) {
		log.info("registerTripBoard() 입장....");
		MemberVO member = getMemNo(principal.getName());
		List<TravelScheduleVO> list = tripService.list(member.getMemNo());
		model.addAttribute("tripList", list);
		return "tripboard/register";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/register")
	public String registerBoard(TBoardVO vo,Principal principal, Model model) {
		log.info("registerBoard() 입장....");
		log.info(vo.getTboardContent());
		log.info(vo.getTboardTitle());
		
		MemberVO member = getMemNo(principal.getName());
		vo.setTboardWriter(member.getMemNo());
		
		if(vo.getTboardPublicYn() == null || "".equals(vo.getTboardPublicYn())) {
			vo.setTboardPublicYn("N");
		}
		
		String goPage = "";
		ServiceResult result = tBoardService.insert(vo);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/tripBoard/detail?tboardNo=" + vo.getTboardNo();
		} else {
			goPage = "redirect:/tripBoard/register";
		}
		// 일단 메인으로 상세 페이지 만들면 거기로
		return goPage;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail")
	public String tBoardDetail(String tboardNo, Model model, Principal principal) {
		model.addAttribute("tbn", tboardNo);
		TBoardVO vo = tBoardService.selectOne(tboardNo);
		
		
		// 회원정보
		Map<String, Object> map = new HashMap<>();
		map.put("memId", vo.getTboardWriter());
		MemberVO member = memberService.selectMember(map);
		
		// 댓글 정보 가져가기
		MemberVO memberVO = getMemNo(principal.getName());
		
		model.addAttribute("member", member);
		model.addAttribute("me", memberVO.getMemNo());
		model.addAttribute("tBoard",vo);
		return "tripboard/detail";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/list", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage,
			@RequestParam(name="title", required=false, defaultValue="") String title,
			Principal principal) {
		MemberVO member = getMemNo(principal.getName());
//		List<TBoardVO> list = tBoardService.list(member.getMemNo());
		
		PaginationInfoVO<TBoardVO> pagingVO = new PaginationInfoVO<TBoardVO>();
		pagingVO.setScreenSize(6);
		if(StringUtils.isNotBlank(title)) {
			pagingVO.setSearchWord(title);
		} else {
			pagingVO.setSearchWord("");
		}
		
		pagingVO.setMemNo(member.getMemNo());
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = tBoardService.selectTBoardCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<TBoardVO> dataList = tBoardService.selectTBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		
		Map<String,Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("pagingVO", pagingVO);
		response.put("searchWord", title);
		return ResponseEntity.ok().body(response);
	}
	
	// 댓글 삭제도 필요
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/delete", produces = "application/json; charset=utf-8")
	public Map<String,Object> delTBoard(@RequestBody Map<String,Object> map,Principal principal) {
		log.info("delTBoard() 실행,....====>>");
		Map<String,Object> response = new HashMap<String, Object>();
		MemberVO member = getMemNo(principal.getName());
		ServiceResult result = tBoardService.delete(map.get("tboardNo").toString(),member.getMemNo());
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "삭제 권한이 없습니다.");
		}
		return response;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/update")
	public String updateTBoardForm(String tboardNo, Model model,Principal principal) {
		log.info("updateTBoard() 실행..... ====>>");
		String goPage = "";
		TBoardVO vo = tBoardService.selectOne(tboardNo);
		if(!vo.getTboardWriter().equals(principal.getName())) {
			goPage = "redirect:/tripBoard/detail?tboardNo=" + vo.getTboardNo();
		} else {
			model.addAttribute("tBoard", vo);
			model.addAttribute("status", "u");
			goPage = "tripboard/register";
		}
		return goPage;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/update")
	public String updateTBoard(TBoardVO vo,Principal principal) {
		log.info("updateTBoard() 실행.....=======>>");
		String goPage = "";
		MemberVO member = getMemNo(principal.getName());
		vo.setTboardWriter(member.getMemNo());
		if(vo.getTboardPublicYn() == null || "".equals(vo.getTboardPublicYn())) {
			vo.setTboardPublicYn("N");
		}
		ServiceResult result = tBoardService.update(vo);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/tripBoard/detail?tboardNo=" + vo.getTboardNo();
		} else {
			goPage = "redirect:/tripBoard/update?tboardNo=" + vo.getTboardNo();
		}
		return goPage;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "replyList")
	public ResponseEntity<Map<String,Object>> ajaxReplyList(String tboardNo, Principal principal) {
		log.info("ajaxReplyList() 실행....");
		List<TBoardReplyVO> list = tBoardReplyService.list(tboardNo);
		int cnt = tBoardReplyService.count(tboardNo);
		Map<String,Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("cnt", cnt);
		response.put("me", principal.getName());
		response.put("replyList", list);
		return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/registerReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReply(@RequestBody TBoardReplyVO vo, Principal principal) {
		log.info("ajaxReply() 입장....");
		log.info("이름 =====>" + vo.getTboardNo());
		log.info("이름 =====>" + vo.getTreplyContent());
		MemberVO member = getMemNo(principal.getName());
		vo.setMemNo(member.getMemNo());
		
		ServiceResult result = tBoardReplyService.insert(vo);
		List<TBoardReplyVO> list = tBoardReplyService.list(vo.getTboardNo());
		int cnt = tBoardReplyService.count(vo.getTboardNo());
		Map<String,Object> response = new HashMap<>();
		
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "등록에 실패했습니다.");
		}
		response.put("cnt", cnt);
		response.put("replyList", list);
		return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/deleteReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReplyDelete(@RequestBody TBoardReplyVO vo, Principal principal) {
		log.info("ajaxReplyDelete() 입장......==>>");
		MemberVO member = getMemNo(principal.getName());
		vo.setMemNo(member.getMemNo());
		ServiceResult result = tBoardReplyService.delete(vo);
		Map<String,Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "삭제에 실패했습니다.");
		}
		return ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/updateReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReplyUpdate(@RequestBody TBoardReplyVO vo,Principal principal) {
		log.info("ajaxReplyUpdate() 입장...===>>");
		MemberVO member = getMemNo(principal.getName());
		vo.setMemNo(member.getMemNo());
		ServiceResult result = tBoardReplyService.update(vo);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "수정에 실패하였습니다.");
		}
		return  ResponseEntity.ok().body(response);
	}
	
	// 회원 no 가져오는 메소드
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/blame", produces = "application/json; charset=utf-8")
    public ResponseEntity<Map<String,Object>> blame(@RequestBody BlameVO vo, Principal principal) {
		log.info("blame() 실행.....");
		Map<String,Object> response = new HashMap<>();
		MemberVO memVO = getMemNo(principal.getName());
		vo.setBlameMem(memVO.getMemNo());
		int cnt = tBoardService.selectBlame(vo);
		if(cnt > 0) {
			response.put("msg", "해당 게시글은 이미 신고를 하였습니다.");
		} else {
			ServiceResult result = tBoardService.blame(vo);
			if(result.equals(ServiceResult.OK)) {
				response.put("result", "SUCCESS");
			} else {
				response.put("msg", "신고 등록에 실패했습니다.");
			}
		}
        return ResponseEntity.ok().body(response);
    }
}
