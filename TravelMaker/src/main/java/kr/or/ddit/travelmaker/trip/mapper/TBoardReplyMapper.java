package kr.or.ddit.travelmaker.trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.trip.vo.TBoardReplyVO;

@Mapper
public interface TBoardReplyMapper {
	public List<TBoardReplyVO> list(String tboardNo);
	public int count(String tboardNo);
	public int insert(TBoardReplyVO vo);
	public int update(TBoardReplyVO vo);
	public int delete(TBoardReplyVO vo);
}
