package kr.or.ddit.travelmaker.trip.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.trip.mapper.TBoardReplyMapper;
import kr.or.ddit.travelmaker.trip.service.TBoardReplyService;
import kr.or.ddit.travelmaker.trip.vo.TBoardReplyVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class TBoardReplyServiceImpl implements TBoardReplyService {
	
	@Inject
	private TBoardReplyMapper tBoardReplyMapper;

	@Override
	public List<TBoardReplyVO> list(String tboardNo) {
		return tBoardReplyMapper.list(tboardNo);
	}

	@Override
	public ServiceResult insert(TBoardReplyVO vo) {
		int cnt = tBoardReplyMapper.insert(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult update(TBoardReplyVO vo) {
		int cnt = tBoardReplyMapper.update(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delete(TBoardReplyVO vo) {
		int cnt = tBoardReplyMapper.delete(vo);
		ServiceResult result = null;
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int count(String tboardNo) {
		return tBoardReplyMapper.count(tboardNo);
	}

}
