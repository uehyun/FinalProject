package kr.or.ddit.travelmaker.alarm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;

@Mapper
public interface AlarmMapper {
	public List<AlarmVO> selectAlarm(String memNo);
	
	public int selectCount(String memNo);
	
	public void updateAlarm(String alarmNo);
	
	public int deleteAlarm(String alarmNo);
	
	public String selectMemberByAlarmNo(String alarmNo);
	
	public int insertAlarm(AlarmVO vo);
}
