package kr.or.ddit.travelmaker.admin.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.ireplyVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface IReplyService {
	public ServiceResult insert(ireplyVO vo);
	public List<ireplyVO> list(String inqBoardNo);
	public int replyCnt(String inqBoardNo);
//	public ServiceResult remove(String inqBoardNo);
//	public ServiceResult modify(ireplyVO vo);
	public ServiceResult delete(ireplyVO vo);
	public ServiceResult update(ireplyVO vo);

}
