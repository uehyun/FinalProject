package kr.or.ddit.travelmaker.trip.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.trip.mapper.TBoardMapper;
import kr.or.ddit.travelmaker.trip.service.TBoardService;
import kr.or.ddit.travelmaker.trip.vo.TBoardVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Service
public class TBoardServiceImpl implements TBoardService {
	
	@Inject
	private TBoardMapper tBoardMapper;
	
//	@Override
//	public List<TBoardVO> list(String memNo) {
//		return tBoardMapper.list(memNo);
//	}

	@Override
	public TBoardVO selectOne(String tboardNo) {
		tBoardMapper.updateHit(tboardNo);
		return tBoardMapper.selectOne(tboardNo);
	}

	@Override
	public ServiceResult insert(TBoardVO vo) {
		ServiceResult result = null;
		int cnt = tBoardMapper.insert(vo); 
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult update(TBoardVO vo) {
		ServiceResult result = null;
		int cnt = tBoardMapper.update(vo); 
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delete(String tboardNo, String memNo) {
		ServiceResult result = null;
		int cnt = tBoardMapper.delete(tboardNo, memNo); 
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<TBoardVO> popList() {
		return tBoardMapper.popList();
	}

	@Override
	public int selectTBoardCount(PaginationInfoVO<TBoardVO> pagingVO) {
		return tBoardMapper.selectTBoardCount(pagingVO);
	}

	@Override
	public List<TBoardVO> selectTBoardList(PaginationInfoVO<TBoardVO> pagingVO) {
		return tBoardMapper.selectTBoardList(pagingVO);
	}

    @Override
    public ServiceResult blame(BlameVO vo) {
        ServiceResult result = null;
        if (vo.getBoardNo().contains("tbn")) {
            vo.setBlameType("게시글");
        }
        int cnt = tBoardMapper.blame(vo);
        if(cnt > 0) {
            result = ServiceResult.OK;
        } else {
            result = ServiceResult.FAILED;
        }
        return result;
    }

	@Override
	public int selectBlame(BlameVO vo) {
		return tBoardMapper.selectBlame(vo);
	}

}
