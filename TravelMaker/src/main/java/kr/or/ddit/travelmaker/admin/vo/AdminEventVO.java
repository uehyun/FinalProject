package kr.or.ddit.travelmaker.admin.vo;

import lombok.Data;

@Data
public class AdminEventVO {
	private String eventNo;
	private String eventTitle;
	private String eventContent;
	private String eventHit;
	private String eventStartDate;
	private String eventEndDate;
	private String eventRegDate;
	private String eventModDate;
	private String eventDelDate;
	private String eventDiscountRate;
	private String eventAttGroupNo;
	private String optionNo;
	private String optionName;
	private String eventStatus;
	
	private String flag;
}
