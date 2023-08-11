package kr.or.ddit.travelmaker.alarm.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.alarm.mapper.AlarmMapper;
import kr.or.ddit.travelmaker.alarm.service.IAlarmService;
import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements IAlarmService {

	@Inject
	private AlarmMapper alarmMapper;
	
	@Override
	public List<AlarmVO> selectAlarm(String memNo) {
		return alarmMapper.selectAlarm(memNo);
	}

	@Override
	public int deleteAlarm(String alarmNo) {
		return alarmMapper.deleteAlarm(alarmNo);
	}

	@Override
	public int selectAlarmCount(String memNo) {
		return alarmMapper.selectCount(memNo);
	}

	@Override
	public String selectMemberByAlarmNo(String alarmNo) {
		return alarmMapper.selectMemberByAlarmNo(alarmNo);
	}

	@Override
	public int insertAlarm(AlarmVO vo) {
		return alarmMapper.insertAlarm(vo);
	}
}
