package kr.or.ddit.travelmaker.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.OkHttp3ClientHttpRequestFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.host.service.IHostService2;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.EventVO;
import kr.or.ddit.travelmaker.main.service.IMainService;
import kr.or.ddit.travelmaker.main.vo.OptionVO;
import kr.or.ddit.travelmaker.main.vo.PaymentVO;
import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.review.vo.ReviewScoreVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/main")
@Slf4j
public class MainController {
	
	@Inject
	private IMainService mainService;
	
	@Inject
	private IHostService2 hostService;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String goMain(Model model) {
//		log.info("메인 페이지 입장...");
		Map<String,Object> map = new HashMap<>();
		map.put("cateNum", "");
		List<OptionVO> optionList = mainService.getCategory();
		
		model.addAttribute("option", optionList);
		return "main/mainPage";
	}
	
	
	@RequestMapping(value = "/detail/{accNo}", method = RequestMethod.GET)
	public String goAccommodationDetail(@PathVariable String accNo, Model model, Authentication authentication) {
//		log.info("상세 보기 페이지");
		
		AcommodationVO acommodation = mainService.accommodationDetailByAccNo(accNo);
		log.info("acommodation -> " + acommodation.getEventList());
		
		applyAdminDiscount(acommodation);
		model.addAttribute("acommodation", acommodation);
		acommodation.getEventList();
		
		MemberVO member = mainService.hostProfileByAccNo(accNo);
		model.addAttribute("member", member);
		
		List<MemberReviewVO> reviewList = mainService.selectReviewByAccNo(accNo);
		if (reviewList.size() > 0) {
			List<ReviewScoreVO> reviewScore = mainService.selectReviewScoreByAccNo(accNo);
			model.addAttribute("reviewList", reviewList);
			model.addAttribute("reviewScore", reviewScore);
			
			log.info("reviewList -> " + reviewList);
			log.info("reviewScore -> " + reviewScore);
		}
		
		
		if (authentication != null && authentication.isAuthenticated()) {
			User user = (User) authentication.getPrincipal();
			String memNo = mainService.memNoById(user.getUsername());
			
			List<WishlistCategoryVO> wishCategoryList = mainService.selectWishCategoryList(memNo);
			model.addAttribute("wishCategoryList", wishCategoryList);
			
			Map<String, String> paramMap = new HashMap<>();
		    paramMap.put("memNo", memNo);
		    paramMap.put("accNo", accNo);
			int isWished = mainService.selectIsWished(paramMap);
			
//			log.info("null이 아닙니다." + isWished);
			model.addAttribute("isWished", isWished);
		}
		
//		log.info("acommodation Detail -> " + acommodation);
//		log.info("member Detail -> " + member);
		
		return "main/accommodationDetail";
	}
	
	private void applyAdminDiscount(AcommodationVO acommodation) {
//		// null이면 관리자 할인 없음
		if (acommodation.getEventNo() != null) {
			AdminEventVO adminEvent = mainService.selectAdminEventByEventNo(acommodation.getEventNo());
			acommodation.setAdminEvent(adminEvent);
//			if (adminEvent != null) {
//				for(int i=0; i<2; i++) {
//					EventVO event = acommodation.getEventList().get(i);
//					EventVO copyEvent = new EventVO();
//					if (event.getDiscountType().equals("WEEK")) {
//						copyEvent.setDiscountType("WEEKADMIN");
//					} else {
//						copyEvent.setDiscountType("MONTHADMIN");
//					}
//					copyEvent.setAccNo(event.getAccNo());
//					copyEvent.setDiscountRate(event.getDiscountRate() + Integer.parseInt(adminEvent.getEventDiscountRate()));
//					
//					acommodation.getEventList().add(copyEvent);
//				}
//				
//				// 관리자 할인만
//				EventVO eventVO = new EventVO();
//				eventVO.setAccNo(acommodation.getAccNo());
//				eventVO.setDiscountType("ADMIN");
//				eventVO.setDiscountRate(Integer.parseInt(adminEvent.getEventDiscountRate()));
//				acommodation.getEventList().add(eventVO);
//				log.info("acommodation edit -------------> " + acommodation.getEventList());
//			}
		}
		
		
	}

	@RequestMapping(value = "/createWishList", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<Integer> createWishList(Authentication authentication, @RequestParam String wishlistCategoryName, @RequestParam String accNo) {
		
//		log.info("위시 내용 -> " + wishlistCategoryName);
//		log.info("accNo -> " + accNo);
		
		User user = (User) authentication.getPrincipal();
		String memNo = mainService.memNoById(user.getUsername());
		
		WishlistCategoryVO wishlistCategory = new WishlistCategoryVO();
		wishlistCategory.setMemNo(memNo);
		wishlistCategory.setWishlistCategoryName(wishlistCategoryName);
		
		ServiceResult result = null;
		result = mainService.insertWishlistCategory(wishlistCategory);
//		log.info("accNo -> " + wishlistCategory.getWishlistCategoryNo());
		
		WishlistVO wishlist = new WishlistVO();
		wishlist.setAccNo(accNo);
		wishlist.setWishlistCategoryNo(wishlistCategory.getWishlistCategoryNo());
		
		int status = mainService.insertWishlist(wishlist);
		
		return ResponseEntity.ok(status);
	}
	
	@RequestMapping(value = "/selectCategoryList", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<Integer> selectCategoryList(@RequestBody WishlistVO wishlist) {
		log.info("accNo -> " + wishlist.getWishlistCategoryNo());
		log.info("accNo -> " + wishlist.getAccNo());
		
		int status = mainService.insertWishlist(wishlist);
		return ResponseEntity.ok(status);
	}
	
	@RequestMapping(value = "/deleteWishList", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<Integer> deleteWishList(Authentication authentication, @RequestParam String accNo) {
//		log.info("위시 삭제 accNo -> " + accNo);
		
		User user = (User) authentication.getPrincipal();
		String memNo = mainService.memNoById(user.getUsername());
		
		Map<String, String> paramMap = new HashMap<>();
	    paramMap.put("memNo", memNo);
	    paramMap.put("accNo", accNo);
		int deleteWishStatus = mainService.deleteWishList(paramMap);
		
		return ResponseEntity.ok(deleteWishStatus);
	}
	
	@RequestMapping(value = "/blame", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<String> isnertAccBlame(Authentication authentication, @RequestBody BlameVO blame) {
		ServiceResult result = null;
		String status = "";
		
		User user = (User) authentication.getPrincipal();
		String memNo = mainService.memNoById(user.getUsername());
		blame.setBlameMem(memNo);
		
		result = mainService.isnertAccBlame(blame);
		if (result.equals(ServiceResult.OK)) {
			status = "SUCCESS";
		} else {
			status = "FAILED";
		}
		return ResponseEntity.ok(status);
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@RequestMapping(value = "/accommodation/reservation", method = RequestMethod.POST)
	public String goAccommodationReservation(Authentication authentication, Model model, AccReservationVO reservation) {
		
		log.info("reservation.accNo" + reservation.getAccNo());
		log.info("reservation.getAresCheckinDate" + reservation.getAresCheckinDate());
		log.info("reservation.getAresCheckoutDate" + reservation.getAresCheckoutDate());
		log.info("reservation.getAresGuestCount" + reservation.getAresGuestCount());
		log.info("reservation.getAresExtraGuest" + reservation.getAresExtraGuest());
		log.info("reservation.getAresTotalPrice" + reservation.getAresTotalPrice());
		log.info("reservation.getAresExtraPrice" + reservation.getAresExtraPrice());
		log.info("reservation.getAresDiscountPrice" + reservation.getAresDiscountPrice());
		model.addAttribute("reservation", reservation);
		
		User user = (User) authentication.getPrincipal();
		MemberVO buyer = mainService.memberBymemId(user.getUsername());
		model.addAttribute("buyer", buyer);
		log.info("buyer " + buyer);
		
		MemberVO member = mainService.hostProfileByAccNo(reservation.getAccNo());
		member.setMemRegDate(member.getMemRegDate().replaceAll("-", "년"));
		model.addAttribute("member", member);
		log.info("member" + member);
		
		
		AcommodationVO accommodation = mainService.accommodationReservationDetailByAccNo(reservation.getAccNo());
		model.addAttribute("accommodation", accommodation);
		log.info("accommodation" + accommodation);
		
		
		UUID uuid = UUID.randomUUID();
		String uuid8 = uuid.toString().substring(0, 8);
//		String orderNo = reservation.getAresCheckinDate().replaceAll("-", "") + "_" + accommodation.getAccNo().replaceAll("_", "");
		String orderNo = uuid8 + "_" + reservation.getAresCheckinDate().replaceAll("-", "");
		// 주문번호 생성
		model.addAttribute("orderNo", orderNo);
		log.info("주문번호 -> " + orderNo);
		
		return "main/accommodationReservation";
	}
	
	@RequestMapping(value = "/accommodation/insertPayment", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<String> insertPayment(@RequestBody Map<String, Object> requestData, Authentication authentication) {
		ObjectMapper objectMapper = new ObjectMapper();
		AccReservationVO accReservation =  objectMapper.convertValue(requestData.get("accReservation"), AccReservationVO.class);
		PaymentVO payment = objectMapper.convertValue(requestData.get("payment"), PaymentVO.class);
		User user = (User) authentication.getPrincipal();
		
		
		ServiceResult aresResult = mainService.insertAccReservation(accReservation, user.getUsername());
		ServiceResult payMent = mainService.insertPayment(payment, accReservation);
		if (aresResult.equals(ServiceResult.OK) && payMent.equals(ServiceResult.OK)) {
			return ResponseEntity.ok("SUCCESS");
		}
		
		log.info("accReservation -> " + accReservation);
		log.info("payment -> " + payment);
		
		
		return ResponseEntity.ok("FAILED");
	}
	
	@ResponseBody
	@GetMapping("/selectTopCategory")
	public ResponseEntity<List<Map<String, Object>>> selectTopCategory() {
		List<Map<String,Object>> list = hostService.selectTopCategory();
		
		return new ResponseEntity<List<Map<String, Object>>>(list, HttpStatus.OK);
	}
}






















