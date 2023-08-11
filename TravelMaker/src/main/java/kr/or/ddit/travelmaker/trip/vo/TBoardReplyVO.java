package kr.or.ddit.travelmaker.trip.vo;

import lombok.Data;

@Data
public class TBoardReplyVO {
	private String treplyNo;
	private String memNo;
	private String tboardNo;
	private String treplyContent;
	private String treplyRegDate;
	private String treplyModDate;
	private String treplyDelDate;
	private String treplyDelYn;
	private String memProfilePath;
}
