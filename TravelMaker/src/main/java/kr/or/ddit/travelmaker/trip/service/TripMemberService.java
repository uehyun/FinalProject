package kr.or.ddit.travelmaker.trip.service;

import java.util.List;

import kr.or.ddit.travelmaker.trip.vo.TravelMemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface TripMemberService {
	public List<TravelMemberVO> list();
	public TravelMemberVO selectOne(String travelNo);
	public ServiceResult insert(TravelMemberVO vo);
	public ServiceResult update(TravelMemberVO vo);
	public ServiceResult delete(String travelNo);
}
