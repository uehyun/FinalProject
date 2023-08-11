package kr.or.ddit.travelmaker.review.vo;

import lombok.Data;

@Data
public class AccReviewVO {
	private String accReviewNo;
	private String accNo;
	private String aresNo;
	private String accName;
	private String memNo;
	private String accReviewContent;
	private String accReviewRegDate;
	private String accReviewModDate;
	private String accReviewDelDate;
	private String reviewType;
	private String filePath;
	private Double rating;
}
