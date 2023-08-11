package kr.or.ddit.travelmaker.trip.vo;

import java.util.List;

import kr.or.ddit.travelmaker.member.vo.MemberVO;
import lombok.Data;

@Data
public class TravelMemberVO {
	private String travelNo;
	private String memNo;
	private List<MemberVO> memList;
}
