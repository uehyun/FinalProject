package kr.or.ddit.travelmaker.trip.vo;

import java.util.List;

import kr.or.ddit.travelmaker.member.vo.MemberVO;
import lombok.Data;

@Data
public class TravelScheduleDetailVO {
	private String travelScheduleDetailsNo;
	private String travelNo;
	private String id;
	private String placeName;
	private String placeUrl;
	private String categoryGroupName;
	private String phone;
	private String x;
	private String y;
	private String memo;
	private String travelDate;
	private List<MemberVO> memList;
}
