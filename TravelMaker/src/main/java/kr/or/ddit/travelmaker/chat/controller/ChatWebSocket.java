package kr.or.ddit.travelmaker.chat.controller;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.travelmaker.chat.service.ChatService;
import kr.or.ddit.travelmaker.chat.vo.ChatRoomVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatWebSocket extends TextWebSocketHandler {

	private List<WebSocketSession> users = new LinkedList<>();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    @Inject
    private IMemberService memberService;
    
    @Inject
    private ChatService chatService;
    
    private void sendMessage(String memNo, String message, String pictureUrl, String chatroom) {
        String sendMessage = "<div class='message-bubble' data-memno='"+ memNo +"'>"
        					+ 	"<div class='message-avatar'>" + "<img src='" + pictureUrl + "'/></div>"
        					+ 	"<div class='message-text' data-message='" + message + "'><p>" + message + "</p></div>"
        					+ "</div>";
        ChatRoomVO vo = new ChatRoomVO();
        vo.setChatroomNo(chatroom);
        vo.setMessage(message);
        chatService.update(vo);
        for (WebSocketSession user : users) {
            try {
                user.sendMessage(new TextMessage(sendMessage));
            } catch (Throwable e) {
                e.printStackTrace();
            }
        }
    }
    
    private void saveFile(String memNo,String message, String pictureUrl, String chatId) {
    	String filePath = "D:\\CHAT\\" + chatId + ".txt";
    	String msg = "<div class='message-bubble' data-memno='"+ memNo +"'>"
					+ 	"<div class='message-avatar'>" + "<img src='" + pictureUrl + "'/></div>"
					+ 	"<div class='message-text'><p>" + message + "</p></div>"
					+ "</div>";
    	log.info(chatId);
        try (BufferedOutputStream outputStream = new BufferedOutputStream(new FileOutputStream(filePath, true))) {
            outputStream.write(msg.getBytes("UTF-8"));
            outputStream.flush();
        } catch (Throwable e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	log.info("접속자 : " +  session.getAttributes().size() + "명");
    	users.add(session);
    }
   
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String msg = message.getPayload();
    	ChatRoomVO chatRoom = objectMapper.readValue(msg, ChatRoomVO.class);
    	Map<String,Object> map = new HashMap<>();
    	map.put("memNo", chatRoom.getMemNo());
    	MemberVO vo = memberService.findData(map);
    	
    	if(chatRoom.getState() != 0 ) {
    		if(session != null) {
    			String msgval = chatRoom.getMessage();
    			if(StringUtils.isEmpty(vo.getMemProfilePath())) {
    				vo.setMemProfilePath("http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&amp;s=70");
    			}
    			sendMessage(vo.getMemNo(), msgval, vo.getMemProfilePath(), chatRoom.getChatroomNo());
    			saveFile(vo.getMemNo(), msgval, vo.getMemProfilePath(), chatRoom.getChatroomNo());
    		}
    	}
    }
   
    // 클라이언트와 연결을 끊었을 때 실행되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	users.remove(session);
    	log.info("----------------->socket 종료");
    }
}
