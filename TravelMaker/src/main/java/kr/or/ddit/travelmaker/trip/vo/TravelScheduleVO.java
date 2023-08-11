package kr.or.ddit.travelmaker.trip.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TravelScheduleVO {
	private String travelNo;
	private String memNo;
	private String travelName;
	private String travelStartDate;
	private String travelEndDate;
	private MultipartFile travelImg;
	private String travelImgPath;
}
