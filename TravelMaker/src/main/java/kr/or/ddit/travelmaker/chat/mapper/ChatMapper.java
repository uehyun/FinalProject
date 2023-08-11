package kr.or.ddit.travelmaker.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.chat.vo.ChatRoomVO;

@Mapper
public interface ChatMapper {
	public List<ChatRoomVO> list(String memNo);
	public ChatRoomVO selectOne(ChatRoomVO vo);
	public int insert(ChatRoomVO vo);
	public void update(ChatRoomVO vo);
	public int delete();
	public Map<String, Object> getAccReservation(Map<String, Object> map);
	public Map<String, Object> getAccData(Map<String, Object> map);
}
