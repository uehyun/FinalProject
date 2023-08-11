package kr.or.ddit.travelmaker.trip.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.trip.mapper.TripMemberMapper;
import kr.or.ddit.travelmaker.trip.service.TripMemberService;
import kr.or.ddit.travelmaker.trip.vo.TravelMemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class TripMemberServiceImpl implements TripMemberService {
	
	@Inject
	private TripMemberMapper triMemberpMapper;

	@Override
	public List<TravelMemberVO> list() {
		return triMemberpMapper.list();
	}

	@Override
	public TravelMemberVO selectOne(String travelNo) {
		return triMemberpMapper.selectOne(travelNo);
	}

	@Override
	public ServiceResult insert(TravelMemberVO vo) {
		ServiceResult result = null;
		int cnt = triMemberpMapper.insert(vo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult update(TravelMemberVO vo) {
		ServiceResult result = null;
		int cnt = triMemberpMapper.update(vo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delete(String travelNo) {
		ServiceResult result = null;
		int cnt = triMemberpMapper.delete(travelNo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

}
