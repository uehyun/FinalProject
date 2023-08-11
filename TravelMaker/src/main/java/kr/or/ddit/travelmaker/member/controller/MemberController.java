package kr.or.ddit.travelmaker.member.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.password.PasswordEncoder;
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

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.SignatureException;
import kr.or.ddit.travelmaker.admin.service.IFaqService;
import kr.or.ddit.travelmaker.admin.service.IInquiryService;
import kr.or.ddit.travelmaker.admin.service.IReplyService;
import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.admin.vo.inquiryVO;
import kr.or.ddit.travelmaker.admin.vo.ireplyVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.service.IReviewService;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.utils.JWTUtils;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Inject
	private IMemberService memberService;
	
	@Inject
	private IReviewService reviewService;
	
	@Inject
	private PasswordEncoder pe;
	
	@Inject
	private JWTUtils jwtUtil; 
	
	@Inject 
	private IInquiryService inservice;
	
	@Inject 
	private IReplyService reservice;
	
	@Inject 
	private IFaqService faqservice;
	
	
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/profile")
	public String profileForm(@RequestParam(value="token", required=false, defaultValue="") String token, Model model, RedirectAttributes ra) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		try {
			if(StringUtils.isNotEmpty(token)) {
				if(jwtUtil.isValidToken(token, user)) {
					log.info("토큰 : " + token);
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("memId", user.getUsername());
					
					MemberVO member = memberService.selectMember(map);
					
					String email = member.getMemEmail();
					String[] split = email.split("@");
					
					member.setMemEmail(split[0]);
					member.setMemDomain("@" + split[1]);
					
					model.addAttribute("member", member);
					model.addAttribute("updateMember", member);
					
					return "member/profile";
				} 
			}
		} catch(ExpiredJwtException e) {
			ra.addFlashAttribute("error", "인증이 필요한 페이지 입니다.");
			return "redirect:/member/detail";
		} catch(SignatureException e) {
			ra.addFlashAttribute("error", "인증이 필요한 페이지 입니다.");
			return "redirect:/member/detail";
		}
		ra.addFlashAttribute("error", "인증이 필요한 페이지 입니다.");
		return "redirect:/member/detail";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/detail")
	public String memberDetail(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);

		List<MemberReviewVO> list = reviewService.selectSomeMemberReview(member.getMemNo());
		
		model.addAttribute("reviewList", list);
		model.addAttribute("member", member);
		return "member/detail";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/message")
	public String messagePage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		model.addAttribute("member", member);
		
		return "member/message";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/prefer")
	public String preferPage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		model.addAttribute("member", member);
		return "member/prefer";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/alarm")
	public String alarmPage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		model.addAttribute("member", member);
		
		return "member/alarm";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/review")
	public String reviewPage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		model.addAttribute("member", member);
		
		return "member/review";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/payment")
	public String paymentPage(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		model.addAttribute("member", member);
		
		return "member/payment";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/profile")
	public String updateProfile(HttpServletRequest req, MemberVO vo, RedirectAttributes ra, Model model, HttpServletResponse response) {
		if(vo == null) {
			ra.addFlashAttribute("error", "인증이 필요한 페이지 입니다.");
			return "redirect:/member/detail";
		}
		
		log.info("프로필 수정 : " + vo);
		
		ServiceResult res = memberService.profileUpdate(req, vo);
		
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String token = jwtUtil.generateToken(user);
		
		if(res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "회원정보가 수정되었습니다.");
		} else {
			ra.addFlashAttribute("error", "프로필 수정을 실패하였습니다.");
		}
		
		return "redirect:/member/profile?token=" + token;
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/changePassword")
	public String updatePw(@RequestParam Map<String, Object> map, RedirectAttributes ra, Model model, HttpServletResponse response) {
		if(map == null || map.size() == 0) {
			ra.addFlashAttribute("error", "인증이 필요한 페이지 입니다.");
			return "redirect:/member/detail";
		}
		
		log.info("비밀번호 변경 대상 : " + map.get("memNo").toString());
		log.info("비밀번호 변경 : " + map.get("memPw").toString());
		
		ServiceResult res = memberService.updatePassword(map);
		
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String token = jwtUtil.generateToken(user);
		
		if(res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "비밀번호가 변경되었습니다.");
		} else {
			ra.addFlashAttribute("error", "비밀번호 변경이 실패했습니다.");
		}
		
		return "redirect:/member/profile?token=" + token;
	}
	
	@ResponseBody
	@PostMapping(value="/updateSocial", produces="application/json; charset=UTF-8")
	public ResponseEntity<Map<String, Object>> updateSocial(@RequestBody Map<String, Object> map) {
		log.info(map.get("memNo").toString());
		log.info(map.get("socialId").toString());
		log.info(map.get("socialType").toString());
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		ServiceResult res = memberService.updateSocial(map);
		
		map.put("result", res);
		
		if(res.equals(ServiceResult.OK)) {
			String token = jwtUtil.generateToken(user);
	        map.put("token", token);
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} else {
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
	}
	
	@ResponseBody
	@PostMapping(value="/updatePrefer", produces="application/json; charset=UTF-8")
	public ResponseEntity<ServiceResult> updatePrefer(@RequestBody MemberVO vo) {
		ServiceResult res = memberService.updatePrefer(vo);
		
		if(res.equals(ServiceResult.OK)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.OK, HttpStatus.OK);
		} else {
			return new ResponseEntity<ServiceResult>(ServiceResult.FAILED, HttpStatus.OK);
		}
	}
	
	@ResponseBody
	@PostMapping("/checkPw")
	public ResponseEntity<Map<String, Object>> checkPw(HttpServletResponse res, String memPw) {
	    User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("memId", user.getUsername());

	    MemberVO member = memberService.selectMember(map);

	    if (pe.matches(memPw, member.getMemPw())) {
	        String token = jwtUtil.generateToken(user);
	        map.put("result", "OK");
	        map.put("token", token);

	        return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	    } else {
	    	map.put("result", "FAILED");
	        return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	    }
	}
	
//	@RequestMapping(value = "/myList")
//	public ResponseEntity<Map<String, Object>> myList( ){
//		
//	}
//	
	
	//문의게시판 목록
	@RequestMapping(value = "/inlist")
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
		log.debug("체킁:" + pagingVO);
		log.debug("체킁:" + pagingVO.getPagingHTML());
		//답변영역
		for(int i=0; i<dataList.size(); i++) {
			inquiryVO inquiry = dataList.get(i);
			List<ireplyVO> list = reservice.list(inquiry.getInqBoardNo());
			if(!list.isEmpty()) {
				inquiry.setInqRepYN("답변완료");
			}
		}
		pagingVO.setDataList(dataList);
		//List<inquiryVO> inquiryList = inservice.list();
		log.debug("체킁:" + pagingVO);
		log.debug("체킁:" + pagingVO.getPagingHTML());
		
		//답변영역
		for(int i=0; i<dataList.size(); i++) {
			inquiryVO inquiry = dataList.get(i);
			List<ireplyVO> list = reservice.list(inquiry.getInqBoardNo());
			if(!list.isEmpty()) {
				inquiry.setInqRepYN("답변완료");
			}
		}
		
		model.addAttribute("pagingVO", pagingVO);
		return "member/inlist";
	}
	//로그인정보 가져오기
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
	
	
	//문의게시판 등록폼
	@RequestMapping(value = "/inregister", method = RequestMethod.GET)
	public String inqRegisterForm(Model model) {
		log.info("inqRegisterForm() 실행...!");
		model.addAttribute("inquiry", new inquiryVO());
		return "member/inregister";
	}
	
	
	//문의게시판 등록 실행
	@RequestMapping(value = "/inregister", method = RequestMethod.POST)
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
		
		return "redirect:/member/inlist";
	}
	
	
	//문의 게시판 글수정폼
	@GetMapping(value = "/inmodify")
	public String inqModifyForm(String inqBoardNo, Model model) {
		log.debug("inqModifyForm() 실행...!");
		inquiryVO inquiry = inservice.detail(inqBoardNo);
		model.addAttribute("inquiry", inquiry);
		model.addAttribute("status", "u");	//수정을 진행중입니다 라는 플래그값
		return "member/inregister";
	}
	
	//문의게시판 글수정
	@PostMapping(value = "/inmodify")
	public String inqModify(inquiryVO inquiry, RedirectAttributes ra) {
		log.debug("inqModify() 실행...!");
		inservice.update(inquiry);
		ra.addFlashAttribute("inquiry", "수정완료");
		
		return "redirect:/member/inlist";
	}
	
	//문의게시판 글삭제
	@ResponseBody
	@PostMapping(value = "/indelete", produces = "application/json; charset=utf-8")
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
	
	//문의게시판 상세보기
	@RequestMapping(value = "/indetail", method = RequestMethod.GET)
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
		
		
		return "member/indetail";
	}
	
	//문의게시판 댓글리스트 출력하기
	@GetMapping(value = "/replyList")
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
	@PostMapping(value = "/registerReply", produces = "application/json; charset=utf-8")
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
	
	//문의게시판 댓글 삭제하기
	@PostMapping(value = "/deleteReply", produces = "application/json; charset=utf-8")
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
	@PostMapping(value = "/updateReply", produces = "application/json; charset=utf-8")
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
	
	
	
	//faq 게시판 목록
	@RequestMapping(value = "/faqlist")
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
		pagingVO.setMemNo(member.getMemNo()); //로그인한 회원정보
		
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = faqservice.selectFaqCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<faqVO> dataList = faqservice.selectFaqList(pagingVO);
		pagingVO.setDataList(dataList);
		model.addAttribute("pagingVO", pagingVO);
		return "member/faqlist";
	}
	
	
	
	

	
	
	

	
}
