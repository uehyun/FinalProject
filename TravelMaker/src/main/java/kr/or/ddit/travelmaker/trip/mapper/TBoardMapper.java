package kr.or.ddit.travelmaker.trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.trip.vo.TBoardVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Mapper
public interface TBoardMapper {
//	public List<TBoardVO> list(String memNo);
	public TBoardVO selectOne(String tboardNo);
	public int insert(TBoardVO vo);
	public int update(TBoardVO vo);
	public int delete(@Param("tboardNo") String tboardNo,@Param("memNo") String memNo);
	public void updateHit(String tboardNo);
	public List<TBoardVO> popList();
	public int selectTBoardCount(PaginationInfoVO<TBoardVO> pagingVO);
	public List<TBoardVO> selectTBoardList(PaginationInfoVO<TBoardVO> pagingVO);
    public int blame(BlameVO vo);
    public int selectBlame(BlameVO vo);
}
