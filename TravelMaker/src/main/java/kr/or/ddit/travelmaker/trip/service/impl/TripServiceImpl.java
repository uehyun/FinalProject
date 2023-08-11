package kr.or.ddit.travelmaker.trip.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.trip.mapper.TripMapper;
import kr.or.ddit.travelmaker.trip.service.TripService;
import kr.or.ddit.travelmaker.trip.vo.TravelAccVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleDetailVO;
import kr.or.ddit.travelmaker.trip.vo.TravelScheduleVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class TripServiceImpl implements TripService {
	
	@Inject
	private TripMapper tripMapper;

	@Override
	public void insert(TravelScheduleVO vo) {
		tripMapper.insert(vo);
	}

	@Override
	public void updatePicture(TravelScheduleVO vo) {
		tripMapper.updatePicture(vo);
	}

	@Override
	public TravelScheduleVO selectOne(String travelNo) {
		return tripMapper.selectOne(travelNo);
	}

	@Override
	public void insertDetail(List<TravelScheduleDetailVO> placeList) {
		for(int i=0; i<placeList.size(); i++) {
			tripMapper.insertDetail(placeList.get(i));
		}
	}
	
	public void deleteDetail(TravelScheduleDetailVO travelScheduleDetailVo) {
		tripMapper.deleteList(travelScheduleDetailVo);
	}

	@Override
	public List<TravelScheduleDetailVO> selectList(TravelScheduleDetailVO vo) {
		return tripMapper.selectList(vo);
	}

	@Override
	public List<TravelScheduleVO> list(String memNo) {
		return tripMapper.list(memNo);
	}

	@Override
	public void delete(String travelNo) {
		tripMapper.delete(travelNo);
	}

	@Override
	public ServiceResult update(TravelScheduleDetailVO vo) {
		ServiceResult result = null;
		int cnt = tripMapper.update(vo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {	
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<TravelScheduleVO> myList(String memNo) {
		return tripMapper.myList(memNo);
	}

	@Override
	public List<TravelAccVO> getAcc(TravelAccVO taVO) {
		List<TravelAccVO> list = tripMapper.getAcc(taVO);
		if(list != null) {
			for(TravelAccVO vo : list) {
				vo.setImgList((tripMapper.getImg(vo.getAccNo())));
			}
		}
		return list;
	}
}
