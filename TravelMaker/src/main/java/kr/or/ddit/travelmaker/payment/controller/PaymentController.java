package kr.or.ddit.travelmaker.payment.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.payment.service.IPaymentService;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/payment")
@Slf4j
public class PaymentController {
	@Inject
	private IPaymentService paymentService;
	
	@Inject
	private IMemberService memberService;
	
	@ResponseBody
	@PostMapping("/selectList")
	public ResponseEntity<List<Map<String, Object>>> getList(@RequestBody Map<String, Object> map) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		MemberVO member = memberService.selectMember(map);
		
		map.put("memNo", member.getMemNo());
		
		List<Map<String, Object>> list = paymentService.selectAllPayment(map);
		
		return new ResponseEntity<List<Map<String,Object>>>(list, HttpStatus.OK);
	}
	
	@GetMapping("/receipt")
	public String receiptPage(String paymentNo, String type, Model model) {
		log.info("타입 : " + type);
		
		Map<String, Object> map = null;
		if("acc".equals(type)) {
			map = paymentService.selectAccReceipt(paymentNo);
			Map<String, Object> map2 = paymentService.getHost(map.get("ACCNO").toString());
			map.putAll(map2);
			
			model.addAttribute("map", map);
			
			return "payment/accReceipt";
		} else {
			map = paymentService.selectFlightReceipt(paymentNo);
			List<Map<String, Object>> list = paymentService.selectPassenger(map.get("PAYMENTNO").toString());
			
			log.info(map.get("FLIGHTAIRLINE").toString());
			
			model.addAttribute("list", list);
			model.addAttribute("map", map);
			
			return "payment/flightReceipt";
		}
	}
}
