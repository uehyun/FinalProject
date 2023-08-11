package kr.or.ddit.travelmaker.trip.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.trip.vo.TBoardVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

public interface TBoardService {
//	public List<TBoardVO> list(String memNo);
	public TBoardVO selectOne(String tboardNo);
	public ServiceResult insert(TBoardVO vo);
	public ServiceResult update(TBoardVO vo);
	public ServiceResult delete(String tboardNo, String memNo);
	
	// 페이징 처리
	public int selectTBoardCount(PaginationInfoVO<TBoardVO> pagingVO);
	public List<TBoardVO> selectTBoardList(PaginationInfoVO<TBoardVO> pagingVO);
	
	// 인기 숙소 (조회수 기준)
	public List<TBoardVO> popList();
	
	// 신고하기
    public ServiceResult blame(BlameVO vo);
    
    public int selectBlame(BlameVO vo);
}
