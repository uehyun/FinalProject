package kr.or.ddit.travelmaker.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nhncorp.lucy.security.xss.XssPreventer;

import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.service.IReviewService;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/review")
@Slf4j
public class ReviewController {
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private IReviewService reviewService;
	
	@GetMapping("/selectReview")
	public ResponseEntity<PaginationInfoVO<?>> selectReview(int page, String type) {
		log.info("페이지 : " + page);
		log.info("타입 : " + type);
		
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		
		map.put("memNo", member.getMemNo());
		map.put("type", type);
		map.put("currentPage", page);
		
		PaginationInfoVO<?> pagingVO = reviewService.selectAllReview(map);
		
		return new ResponseEntity<PaginationInfoVO<?>>(pagingVO, HttpStatus.OK);
	}
	
	@PostMapping(value="/insertAccReview", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> insertReview(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		map.put("memNo", member.getMemNo());
		
		String updateContent = XssPreventer.escape(map.get("accReviewContent").toString());
		map.put("accReviewContent", updateContent);
		
		ServiceResult res = reviewService.insertAccReview(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@PostMapping(value="/insertMemReview", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> insertMemReview(@RequestBody Map<String, Object> map) {
		String updateContent = XssPreventer.escape(map.get("memReviewContent").toString());
		map.put("memReviewContent", updateContent);
		
		ServiceResult res = reviewService.insertMemReview(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@PostMapping(value="/deleteAccReview", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> deleteAccReview(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = reviewService.selectMemberByReview(map.get("accReviewNo").toString());
		
		log.info("memIDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD : " + memId);
		
		if(!user.getUsername().equals(memId)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.FORBIDDEN, HttpStatus.OK);
		}
		
		ServiceResult res = reviewService.deleteAccReview(map.get("accReviewNo").toString());
		
		log.info("결과 : +++++++++++++++++++++++++++++" + res);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@PostMapping(value="/updateAccReview", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> updateAccReview(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = reviewService.selectMemberByReview(map.get("accReviewNo").toString());
		
		if(!user.getUsername().equals(memId)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.FORBIDDEN, HttpStatus.OK);
		}
		
		String updateContent = XssPreventer.escape(map.get("accReviewContent").toString());
		map.put("accReviewContent", updateContent);
		
	    ServiceResult res = reviewService.updateAccReview(map);
	    
	    return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
	
	@PostMapping(value="/blameAcc", produces="application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> blame(@RequestBody Map<String, Object> map) {
		for (String key : map.keySet()) {
			log.info(key);
			log.info(map.get(key).toString());
			log.info("=============================");
		}
		
		String updateContent = XssPreventer.escape(map.get("blameReason").toString());
		map.put("blameReason", updateContent);
		
		ServiceResult res = reviewService.blameAcc(map);
		
		return new ResponseEntity<ServiceResult>(res, HttpStatus.OK);
	}
}
