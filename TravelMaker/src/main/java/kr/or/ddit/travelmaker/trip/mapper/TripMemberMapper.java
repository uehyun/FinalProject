package kr.or.ddit.travelmaker.trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.trip.vo.TravelMemberVO;

@Mapper
public interface TripMemberMapper {
	public List<TravelMemberVO> list();
	public TravelMemberVO selectOne(String travelNo);
	public int insert(TravelMemberVO vo);
	public int update(TravelMemberVO vo);
	public int delete(String travelNo);
}
