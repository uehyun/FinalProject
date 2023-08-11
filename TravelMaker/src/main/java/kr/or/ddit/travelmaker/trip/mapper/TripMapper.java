package kr.or.ddit.travelmaker.trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.trip.vo.TravelAccVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleDetailVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Mapper
public interface TripMapper {
	public void insert(TravelScheduleVO vo);
	public void updatePicture(TravelScheduleVO vo);
	public TravelScheduleVO selectOne(String travelNo);
	public void delete(String travelNo);
	public void insertDetail(TravelScheduleDetailVO vo);
	public void deleteList(TravelScheduleDetailVO vo);
	public List<TravelScheduleDetailVO> selectList(TravelScheduleDetailVO vo);
	public List<TravelScheduleVO> list(String memNo);
	public int update(TravelScheduleDetailVO vo);
	public List<TravelScheduleVO> myList(String memNo);
	public List<TravelAccVO> getAcc(TravelAccVO taVO);
	public List<FileVO> getImg(String accNo);
}
