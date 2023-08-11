package kr.or.ddit.travelmaker.chat.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.chat.mapper.ChatMapper;
import kr.or.ddit.travelmaker.chat.service.ChatService;
import kr.or.ddit.travelmaker.chat.vo.ChatRoomVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.mapper.FileMapper;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Inject
	private ChatMapper chatMapper;

	@Inject
	private FileMapper fileMapper;
	
	@Override
	public List<ChatRoomVO> list(String memNo) {
		return chatMapper.list(memNo);
	}

	@Override
	public ChatRoomVO selectOne(ChatRoomVO vo) {
		return chatMapper.selectOne(vo);
	}

	@Override
	public ServiceResult insert(ChatRoomVO vo) {
		int cnt = chatMapper.insert(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delete() {
		int cnt = chatMapper.delete();
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public void update(ChatRoomVO vo) {
		chatMapper.update(vo);
	}

	@Override
	public Map<String, Object> getAccReservation(Map<String, Object> map) {
		Map<String, Object> result1 = chatMapper.getAccReservation(map);
		Map<String, Object> result2 = chatMapper.getAccData(map);
		
		List<FileVO> saveName = fileMapper.getSaveName(result2.get("ACC_ATT_GROUP_NO").toString());
		
		if(result1 == null || result1.size() == 0) {
			result2.put("ARES_NO", null);
			result2.put("accImg", saveName.get(0).getAttPath());
			return result2;
		} else {
			result1.putAll(result2);
			result1.put("accImg", saveName.get(0).getAttPath());
			
			return result1;
		}
	}
}
