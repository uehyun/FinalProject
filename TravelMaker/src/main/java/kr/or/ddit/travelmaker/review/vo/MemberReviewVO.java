package kr.or.ddit.travelmaker.review.vo;

import lombok.Data;

@Data
public class MemberReviewVO {
	private String memReviewNo;
	private String memNo;
	private String accNo;
	private String memReviewContent;
	private String memReviewRegDate;
	private String reviewType;
	
	private String hostNo;
	private String hostId;
	private String hostProfilePath;
}
