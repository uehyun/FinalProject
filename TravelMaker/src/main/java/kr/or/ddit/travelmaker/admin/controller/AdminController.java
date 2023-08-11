package kr.or.ddit.travelmaker.admin.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.travelmaker.admin.service.HostManageService;
import kr.or.ddit.travelmaker.admin.service.IFaqService;
import kr.or.ddit.travelmaker.admin.service.IInquiryService;
import kr.or.ddit.travelmaker.admin.service.IReplyService;
import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.admin.vo.inquiryVO;
import kr.or.ddit.travelmaker.admin.vo.ireplyVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {
	@Inject
	private IFaqService service;
	
	@Inject
	private IInquiryService inservice;
	
	@Inject
	private IReplyService reservice;
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private HostManageService hostService;
	
	//faq게시판 등록폼
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/faq/register")
	public String faqRegisterForm(Model model) {
		log.info("faqRegisterForm() 실행...!");
		model.addAttribute("faq", new faqVO());
		return "admin/faq/register";
	}
	
	//faq 게시판 등록실행
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/faq/register")
	public String faqRegister(@Validated faqVO faq, RedirectAttributes ra, Principal principal) {
		log.info("faqRegister() 실행...!");
		MemberVO vo = getMemNo(principal.getName());	//현재 로그인한 회원 정보
		faq.setFaqBoardWriter(vo.getMemNo());
		try {
			service.register(faq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 1회성 메세지
		ra.addFlashAttribute("faq", "등록이 완료되었습니다.");
		return "redirect:/admin/faq/list";
	}
	
	//faq 게시판 목록
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/faq/list")
	public String faqList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name="title", required = false, defaultValue = "") String title,
			@RequestParam(required = false) String searchWord,
			Model model,
			Principal principal) {
		log.info("faqList() 실행...!");
		log.debug("principal"+principal);
		
		PaginationInfoVO<faqVO> pagingVO = new PaginationInfoVO<faqVO>(10,5);
		pagingVO.setScreenSize(5);
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchWord", searchWord);
		}
		
		MemberVO member = getMemNo(principal.getName());
		pagingVO.setMemNo(member.getMemNo());
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.selectFaqCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<faqVO> dataList = service.selectFaqList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "admin/faq/list";
	}
	
	//faq 게시판 글삭제
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/faq/delete")
	public String faqDelete(String faqBoardNo, Model model) {
		log.debug("faqDelete() 실행...!" + faqBoardNo);
		service.deleteOne(faqBoardNo);
		return "redirect:/admin/faq/list";
	}
	
	//faq 게시판 글 선택 삭제
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/faq/selectDelete", produces = "application/json; charset=utf-8")
	@ResponseBody  // 아작스 요청엔 요걸 붙인당
	public String faqSelDel(@RequestBody List<String> msg, Principal principal) {

		log.debug("체킁: " + msg);
		int size = msg.size();
		int sum =0;
		for(int i=0; i<size; i++) {
			sum += service.selectDelete(msg.get(i)); // return값 수정해야 함. void 아주 안 좋음.
		}
		return Integer.toString(sum);
	}
	
	
	//faq 게시판 글수정폼
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping(value = "/faq/modify")
	public String faqModifyForm(String faqBoardNo, Model model) {
		log.debug("faqModifyForm() 실행...!");
		faqVO faq = service.detail(faqBoardNo);
		model.addAttribute("faq", faq);
		model.addAttribute("status", "u");	//수정을 진행중입니다 라는 플래그값
		return "admin/faq/register";
	}
	
	//faq 게시판 글수정
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping(value = "/faq/modify")
	public String faqModify(faqVO faq, RedirectAttributes ra) {
		log.debug("faqModify() 실행...!");
		service.update(faq);
		ra.addFlashAttribute("faq", "수정완료");
		
		return "redirect:/admin/faq/list";
	}
	
/*
	//문의게시판 등록폼
	@RequestMapping(value = "/inquiry/register", method = RequestMethod.GET)
	public String inqRegisterForm(Model model) {
		log.info("inqRegisterForm() 실행...!");
		model.addAttribute("inquiry", new inquiryVO());
		return "admin/inquiry/register";
	}
	
	
	//문의게시판 등록 실행
	@RequestMapping(value = "/inquiry/register", method = RequestMethod.POST)
	public String inqRegister(@Validated inquiryVO inquiry,  Principal principal, RedirectAttributes ra) {
		log.info("inqRegister() 실행...!");
		Map<String, Object> map = new HashMap<>();	
		MemberVO vo = getMemNo(principal.getName());	//현재 로그인한 회원 정보
		inquiry.setInqBoardWriter(vo.getMemNo());
		inquiry.setInqBoardWriter(vo.getMemNo());
		map.put("memNo", inquiry.getInqBoardWriter());	
		//MemberVO memVO = memberService.findData(map);
		//MemberVO member = getMemNo(memVO.getMemId());
		
		try {
			inservice.register(inquiry);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 1회성 메세지
		ra.addFlashAttribute("inquiry", "등록이 완료되었습니다.");
		
		return "redirect:/admin/inquiry/list";
	}
*/
	
	//문의 게시판 글수정폼
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/inquiry/modify")
	public String inqModifyForm(String inqBoardNo, Model model) {
		log.debug("inqModifyForm() 실행...!");
		inquiryVO inquiry = inservice.detail(inqBoardNo);
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("status", "u");	//수정을 진행중입니다 라는 플래그값
		return "admin/inquiry/register";
	}
	
	//문의게시판 글수정
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/inquiry/modify")
	public String inqModify(inquiryVO inquiry, RedirectAttributes ra) {
		log.debug("inqModify() 실행...!");
		inservice.update(inquiry);
		ra.addFlashAttribute("inquiry", "수정완료");
		
		return "redirect:/admin/inquiry/list";
	}
	
	//문의게시판 글삭제
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@ResponseBody
	@PostMapping(value = "/inquiry/delete", produces = "application/json; charset=utf-8")
	public Map<String,Object> inqDelete(@RequestBody Map<String,Object> map, Principal principal) {
		log.debug("inqDelete() 실행...!" + map.get("inqBoardNo"));
		String inqBoardNo = (String) map.get("inqBoardNo");
		Map<String,Object> response = new HashMap<String, Object>();
		MemberVO member = getMemNo(principal.getName());
		ServiceResult result = inservice.delete(inqBoardNo,member.getMemNo());
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "삭제가 실패했습니다.");
		}
		return response;
	}
	
	//문의게시판 목록
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/inquiry/list")
	public String inquiryList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model,
			Principal principal) {
		log.info("inquiryList() 실행...!");
		
		MemberVO member = getMemNo(principal.getName());
		
		PaginationInfoVO<inquiryVO> pagingVO = new PaginationInfoVO<inquiryVO>(10,5);
		
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			// 전다미 바보 멍청이
			model.addAttribute("searchWord", searchWord);
		}
		
		
		pagingVO.setMemNo(member.getMemNo());
		
		pagingVO.setCurrentPage(currentPage);
		log.debug("currentPage::"+ currentPage);
		
		int totalRecord = inservice.selectInboardCount(pagingVO);
		log.debug("totalRecord::"+ totalRecord);
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<inquiryVO> dataList = inservice.selectInboardList(pagingVO);
		pagingVO.setDataList(dataList);
		//List<inquiryVO> inquiryList = inservice.list();
		log.debug("체킁:" +pagingVO);
		log.debug("체킁:" +pagingVO.getPagingHTML());
		//답변영역
		for(int i=0; i<dataList.size(); i++) {
			inquiryVO inquiry = dataList.get(i);
			List<ireplyVO> list = reservice.list(inquiry.getInqBoardNo());
			if(!list.isEmpty()) {
				inquiry.setInqRepYN("답변완료");
			}
		}
		
		model.addAttribute("pagingVO", pagingVO);
		return "admin/inquiry/list";
	}
	
	//문의게시판 상세보기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/inquiry/detail", method = RequestMethod.GET)
	public String inquiryDetail(String inqBoardNo, Model model, Principal principal) {
		log.info("inquiryDetail() 실행...!");
		model.addAttribute("ibn", inqBoardNo);
		inquiryVO inquiry = inservice.detail(inqBoardNo);
		
		//회원정보
		Map<String, Object> map = new HashMap<>();
		MemberVO vo = getMemNo(principal.getName());	
		map.put("memNo", inquiry.getInqBoardWriter());
		MemberVO memVO = memberService.findData(map);
		MemberVO member = getMemNo(memVO.getMemId());
		
		//댓글정보
		List<ireplyVO> list = reservice.list(inqBoardNo);	//댓글 리스트 
		model.addAttribute("replyList", list);	//댓글 리스트
		model.addAttribute("inquiry", inquiry);	//특정 글넘버 게시글 정보
		model.addAttribute("vo", vo);	// 로그인한 회원 정보
		model.addAttribute("member", member);	// 글쓴이 회원 정보
		model.addAttribute("me", vo.getMemNo());	//로그인한 회원 정보
		
		model.addAttribute("status", "u");	// 수정을 진행중입니다 라는 플래그값
		
		return "admin/inquiry/detail";
	}
	
	
	//문의게시판 댓글리스트 출력하기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/reply/replyList")
	public ResponseEntity<Map<String,Object>> ajaxReplyList(String inqBoardNo, Principal principal) {
		log.info("ajaxReplyList() 실행....");
		MemberVO vo = getMemNo(principal.getName());
		List<ireplyVO> list = reservice.list(inqBoardNo);
		int repCnt = reservice.replyCnt(inqBoardNo);
		Map<String,Object> response = new HashMap<>();
		response.put("result", "SUCCESS");
		response.put("repCnt", repCnt);
		response.put("me", vo.getMemNo());
		response.put("replyList", list);
		return ResponseEntity.ok().body(response);
	}
	
	
	//문의게시판 댓글 등록하기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/reply/registerReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReply(@RequestBody ireplyVO vo, Principal principal) {
		log.info("ajaxReply() 입장....");
		log.info("이름 =====>" + vo.getInqBoardNo());
		log.info("이름 =====>" + vo.getIreplyContent());
		MemberVO member = getMemNo(principal.getName());
		vo.setIreplyWriter(member.getMemNo());
		
		ServiceResult result = reservice.insert(vo);
		List<ireplyVO> list = reservice.list(vo.getInqBoardNo());
		int repCnt = reservice.replyCnt(vo.getInqBoardNo());
		Map<String,Object> response = new HashMap<>();
		
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "댓글 등록에 실패했습니다.");
		}
		response.put("repCnt", repCnt);
		response.put("replyList", list);
		return ResponseEntity.ok().body(response);
	}
	
	//로그인정보 가져오기
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
	
	//문의게시판 댓글 삭제하기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/reply/deleteReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReplyDelete(@RequestBody ireplyVO vo, Principal principal) {
		log.info("ajaxReplyDelete() 입장......==>>");
		MemberVO member = getMemNo(principal.getName());
		vo.setIreplyWriter(member.getMemNo());
		ServiceResult result = reservice.delete(vo);
		Map<String,Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "삭제에 실패했습니다.");
		}
		return ResponseEntity.ok().body(response);
	}
	
	
	// 문의게시판 댓글 수정하기
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping(value = "/reply/updateReply", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String,Object>> ajaxReplyUpdate(@RequestBody ireplyVO vo,Principal principal) {
		log.info("ajaxReplyUpdate() 입장...===>>");
		MemberVO member = getMemNo(principal.getName());
		vo.setIreplyWriter(member.getMemNo());
		ServiceResult result = reservice.update(vo);
		Map<String, Object> response = new HashMap<>();
		if(result.equals(ServiceResult.OK)) {
			response.put("result", "SUCCESS");
		} else {
			response.put("result", "수정에 실패하였습니다.");
		}
		return  ResponseEntity.ok().body(response);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	@PostMapping(value="/getTextData", produces="application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> getTextData(@RequestBody Map<String, Object> map) {
		Map<String, Object> data = hostService.getTextData(map);
		
		return new ResponseEntity<Map<String,Object>>(data, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	@PostMapping(value="/getPieChartData", produces="application/json; charset=utf-8")
	public ResponseEntity<List<Map<String, Object>>> getPieChartData(@RequestBody Map<String, Object> map) {
		List<Map<String, Object>> data = hostService.getPieChartData(map);
		
		return new ResponseEntity<List<Map<String,Object>>>(data, HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	@PostMapping(value="/getGraphChartData", produces="application/json; charset=utf-8")
	public ResponseEntity<List<Map<String, Object>>> getGraphChartData(@RequestBody Map<String, Object> map) {
		List<Map<String, Object>> data = hostService.getGraphChartData(map);
		
		return new ResponseEntity<List<Map<String,Object>>>(data, HttpStatus.OK);
	}
	
//	@ResponseBody
//	@PostMapping(value="/getRevenueList", produces="application/json; charset=utf-8")
//	public ResponseEntity<List<Map<String, Object>>> getRevenueList(@RequestBody Map<String, Object> map) {
//		return null;
//	}
}

