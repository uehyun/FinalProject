package kr.or.ddit.travelmaker.admin.vo;

import lombok.Data;

@Data
public class inquiryVO {
	private String inqBoardNo;
	private String inqBoardTitle;
	private String inqBoardContent;
	private int inqBoardHit;
	private String inqBoardRegDate;
	private String inqBoardModDate;
	private String inqBoardDelDate;
	private String inqBoardDelYN;
	private String inqAttGroupNo;
	private String inqBoardWriter;
	private String inqRepYN = "답변대기";
	private String MemName;
	
}
