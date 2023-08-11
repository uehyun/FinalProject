package kr.or.ddit.travelmaker.admin.vo;

import lombok.Data;

@Data
public class BlameVO {
	private String blameNo;
	private String blameType;
	private String blameReason;
	private String blameStatus;
	private String blameDate;
	private String blameApprovalDate;
	private String memNo;
	private String reviewNo;
	private String accNo;
	private String boardNo;
	private String replyNo;
	private String blameMem;
	private String memReviewContent;
	
	private String flag;
}
