package kr.or.ddit.travelmaker.alarm.service;

import java.util.List;

import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;

public interface IAlarmService {
	public List<AlarmVO> selectAlarm(String memNo);

	public int deleteAlarm(String alarmNo);

	public int selectAlarmCount(String memNo);
	
	public String selectMemberByAlarmNo(String alarmNo);
	
	public int insertAlarm(AlarmVO vo);
}
