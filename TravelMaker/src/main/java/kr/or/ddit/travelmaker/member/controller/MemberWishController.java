package kr.or.ddit.travelmaker.member.controller;

import java.io.Console;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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

import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.service.IMemberWishService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberWishController {
	
	@Inject
	private IMemberService memberService;
	
	@Inject
	private IMemberWishService memberWishService;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/wishlist")
	public String wishListPage(Model model) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", user.getUsername());
		
		MemberVO member = memberService.selectMember(map);
		model.addAttribute("member", member);
		
		List<WishlistCategoryVO> wishlistCategoryList = memberWishService.selectWishlistByaccNo(member.getMemNo());
		model.addAttribute("wishlistCategoryList", wishlistCategoryList);
		
		log.info("wishlistCategoryList -> " + wishlistCategoryList);
		return "member/wishlist";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping(value = "/wishlist/detail/{wishlistCategoryNo}")
	public String goWishListDetail(@PathVariable String wishlistCategoryNo, Model model) {
		
		List<WishlistVO> wishlist = memberWishService.selectWishlistDetail(wishlistCategoryNo);
		model.addAttribute("wishlist", wishlist);
		
		WishlistCategoryVO category = memberWishService.selectWishlistCategory(wishlistCategoryNo);
		model.addAttribute("category", category);
		log.info("wishlist -> " + wishlist);
		log.info("category -> " + category);
		
		
		return "member/wishlistDetail";
	}
	
	@PostMapping(value = "/wishlist/detail/addMemo", produces = "application/json")
	public ResponseEntity<String> addMemo(@RequestBody WishlistVO wishlist) {
		log.info("wishlist -> " + wishlist);
		
		ServiceResult result = null;
		String status = "";
		
		result = memberWishService.updateWishlist(wishlist);
		
		if (result.equals(ServiceResult.OK)) {
			status = "SUCCESS";
		} else {
			status = "FAILED";
		}
		
		return ResponseEntity.ok(status);
	}
	
	@PostMapping(value = "/wishlist/detail/editMemo", produces = "application/json")
	public ResponseEntity<String> editMemo(@RequestBody WishlistVO wishlist) {
		log.info("edit wishlist -> " + wishlist);
		
		ServiceResult result = null;
		String status = "";
		
		result = memberWishService.editWishlist(wishlist);
		
		if (result.equals(ServiceResult.OK)) {
			status = "SUCCESS";
		} else {
			status = "FAILED";
		}
		
		return ResponseEntity.ok(status);
	}
}
