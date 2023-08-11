package kr.or.ddit.travelmaker.trip.vo;

import java.util.List;

import lombok.Data;

@Data
public class TBoardVO {
	private String tboardNo;
	private String travelNo;
	private String tboardTitle;
	private String tboardContent;
	private String tboardTag;
	private int tboardHit;
	private String tboardRegDate;
	private String tboardModDate;
	private String tboardDelDate;
	private String tboardDelYn;
	private String tboardPublicYn;
	private String tboardWriter;
	private String travelImgPath;
	private List<TravelScheduleVO> travelList;
	private List<TravelScheduleDetailVO> travlDetailList;
}
