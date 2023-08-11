package kr.or.ddit.travelmaker.chat.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.travelmaker.chat.service.ChatService;
import kr.or.ddit.travelmaker.chat.vo.ChatRoomVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class ChatController {
	
	@Inject
	private ChatService chatService;
	
	@Inject
	private IMemberService memberService;
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/chat")
	public String chatMain(String chatroomNo, Principal principal, Model model) {
		log.info("chatMain() 입장...");
		MemberVO vo = getMemNo(principal.getName());
		
		List<ChatRoomVO> chatList = chatService.list(vo.getMemNo());
		
		model.addAttribute("memNo", vo.getMemNo());
		model.addAttribute("chatList", chatList);
		model.addAttribute("chatroomNo", chatroomNo);
		return "member/chat";
	}
	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@PostMapping("/chatStart")
	public String chatStart(ChatRoomVO vo, Principal principal) {
		log.info("chatStart() 실행....!");
		String goPage = "";
		MemberVO memVO = getMemNo(principal.getName());
		vo.setMemNo(memVO.getMemNo());
		ChatRoomVO chatVO = chatService.selectOne(vo);
		if(chatVO == null) {
			ServiceResult result = chatService.insert(vo);
			if(result.equals(ServiceResult.OK)) {
				goPage = "redirect:/member/chat";
			} else {
				goPage = "main/mainPage";
			}
		} else {
			goPage = "redirect:/member/chat?chatroomNo=" + chatVO.getChatroomNo();
		}
		return goPage;
	}
	
	@PostMapping(value = "/getMsg", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> ajaxChatMessage(@RequestBody Map<String,Object> map) throws IOException {
		String chatRoom = "D:\\CHAT\\" + map.get("chatroomNo").toString() + ".txt";
		
	    // 채팅내역 읽어오기
    	File file = new File(chatRoom);
    	
    	if(!file.exists()) {
    		file.createNewFile();
    	}
    	String message = "";
    	try(InputStream stream = new FileInputStream(file)) {
    		byte[] buffer = new byte[(int) file.length()];
    		stream.read(buffer);
    		message = new String(buffer);
    	} catch (Throwable e) {
    		e.printStackTrace();
    	}
    	Map<String,Object> response = new HashMap<String, Object>();
    	response.put("msg", message);
    	return response;
	}
	
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
	
	@ResponseBody
	@GetMapping("/reservationDetail")
	public ResponseEntity<Map<String, Object>> getReservationDetail(String accNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		map.put("memId", user.getUsername());
		MemberVO vo = memberService.selectMember(map);
		
		map.put("memNo", vo.getMemNo());
		map.put("accNo", accNo);
		
		Map<String, Object> result = chatService.getAccReservation(map);
		
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
	}
}
