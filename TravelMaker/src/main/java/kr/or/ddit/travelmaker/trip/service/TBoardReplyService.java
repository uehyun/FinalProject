package kr.or.ddit.travelmaker.trip.service;

import java.util.List;

import kr.or.ddit.travelmaker.trip.vo.TBoardReplyVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface TBoardReplyService {
	public List<TBoardReplyVO> list(String tboardNo);
	public int count(String tboardNo);
	public ServiceResult insert(TBoardReplyVO vo);
	public ServiceResult update(TBoardReplyVO vo);
	public ServiceResult delete(TBoardReplyVO vo);
}
