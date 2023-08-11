package kr.or.ddit.travelmaker.admin.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.mapper.AdminRepMapper;
import kr.or.ddit.travelmaker.admin.service.IReplyService;
import kr.or.ddit.travelmaker.admin.vo.ireplyVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class ReplyServiceImpl implements IReplyService {

	@Inject
	private AdminRepMapper mapper;
	
	@Override
	public ServiceResult insert(ireplyVO vo) {
		ServiceResult result = null;
		int cnt = mapper.insert(vo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<ireplyVO> list(String inqBoardNo) {
		return mapper.list(inqBoardNo);
	}
	
	@Override
	public int replyCnt(String inqBoardNo) {
		return mapper.replyCnt(inqBoardNo);
	}

//	@Override
//	public ServiceResult remove(String inqBoardNo) {
//		ServiceResult result = null;
//		int cnt = mapper.remove(inqBoardNo);
//		if(cnt > 0) {
//			result = ServiceResult.OK;
//		} else {
//			result = ServiceResult.FAILED;
//		}
//		return result;
//	}

//	@Override
//	public ServiceResult modify(ireplyVO vo) {
//		ServiceResult result = null;
//		int cnt = mapper.modify(vo);
//		if(cnt > 0) {
//			result = ServiceResult.OK;
//		} else {
//			result = ServiceResult.FAILED;
//		}
//		return result;
//
//	}
	
	@Override
	public ServiceResult delete(ireplyVO vo) {
		int cnt = mapper.delete(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult update(ireplyVO vo) {
		int cnt = mapper.update(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	
}
