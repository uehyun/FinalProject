package kr.or.ddit.travelmaker.alarm.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AlarmVO {
	private String alarmNo;
	private String memNo;
	private String alarmType;
	private String alarmStatus;
	private String alarmDate;
	private String alarmUrl;
	private String alarmContent;
}
