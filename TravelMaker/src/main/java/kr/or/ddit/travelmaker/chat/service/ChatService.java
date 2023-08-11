package kr.or.ddit.travelmaker.chat.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.chat.vo.ChatRoomVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface ChatService {
	public List<ChatRoomVO> list(String memNo);
	public ChatRoomVO selectOne(ChatRoomVO vo);
	public ServiceResult insert(ChatRoomVO vo);
	public void update(ChatRoomVO vo);
	public ServiceResult delete();
	public Map<String, Object> getAccReservation(Map<String, Object> map);
}
