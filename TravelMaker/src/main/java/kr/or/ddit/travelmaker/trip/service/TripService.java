package kr.or.ddit.travelmaker.trip.service;

import java.util.List;

import kr.or.ddit.travelmaker.trip.vo.TravelAccVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleDetailVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface TripService {
	public void insert(TravelScheduleVO vo);
	public void updatePicture(TravelScheduleVO vo);
	public List<TravelScheduleVO> list(String memNo);
	public void delete(String travelNo);
	public TravelScheduleVO selectOne(String travelNo);
	public void insertDetail(List<TravelScheduleDetailVO> placeList);
	public void deleteDetail(TravelScheduleDetailVO travelScheduleDetailVO);
	public List<TravelScheduleDetailVO> selectList(TravelScheduleDetailVO vo);
	public ServiceResult update(TravelScheduleDetailVO vo);
	public List<TravelScheduleVO> myList(String memNo);
	public List<TravelAccVO> getAcc(TravelAccVO taVO);
}
