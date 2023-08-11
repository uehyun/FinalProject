package kr.or.ddit.travelmaker.host.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.mapper.SHGHostMapper;
import kr.or.ddit.travelmaker.host.service.IHostService2;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.mapper.FileMapper;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Service
public class HostServiceImpl2 implements IHostService2 {
	
	@Inject
	private SHGHostMapper mapper;
	
	@Inject
	private FileMapper fileMapper;
	
	/* 공용 */
	@Override
	public List<AcommodationVO> selectValidAcc(Map<String, Object> map) {
		return mapper.selectValidAcc(map);
	}
	
	@Override
	public List<AcommodationVO> selectInvalidAcc(String memNo) {
		return mapper.selectInvalidAcc(memNo);
	}
	
	@Override
	public List<AccReservationVO> selectAres(Map<String, Object> map) {
		return mapper.selectAres(map);
	}
	
	@Override
	public List<AcommodationVO> selectAccWithFilter(Map<String, Object> map) {
		List<AcommodationVO> list = mapper.selectAccWithOption(map);
		List<AcommodationVO> option = mapper.selectAccWithFilter(map);
		
		List<AcommodationVO> result = new ArrayList<AcommodationVO>();
		
		for(int i = 0; i < list.size(); i++) {
			for(int j = 0; j < option.size(); j++) {
				if(list.get(i).getAccNo().equals(option.get(j).getAccNo())) {
					AcommodationVO vo = new AcommodationVO();
					vo.setAccNo(list.get(i).getAccNo());
					vo.setAccName(list.get(i).getAccName());
					vo.setAccCount(list.get(i).getAccCount());
					vo.setAccRegDate(list.get(i).getAccRegDate());
					vo.setAccStatus(list.get(i).getAccStatus());
					vo.setFiles(list.get(i).getFiles());
					vo.setAccRejectComment(list.get(i).getAccRejectComment());
					vo.setAccOption(option.get(j).getAccOption());
					result.add(vo);
				}
			}
		}
		
		return result;
	}
	
	@Override
	public ServiceResult updateAccActive(Map<String, Object> map) {
		int res = 0;
		ServiceResult result = null;
		
		List<Map<String, Object>> list = (List<Map<String, Object>>) map.get("data");
		String type = map.get("type").toString();
		
		for (Map<String, Object> map2 : list) {
			res++;
			map2.put("type", type);
			mapper.updateAccActive(map2);
		}
		
		if(res > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	/* 공용 */
	
	
	/* 매출 */
	@Override
	public Map<String, Object> getAllSalesAmount(Map<String, Object> map) {
		return mapper.getAllSalesAmount(map);
	}

	@Override
	public Map<String, Object> avgReservation(Map<String, Object> map) {
		return mapper.avgReservation(map);
	}

	@Override
	public List<Map<String, Object>> getPieChartData(Map<String, Object> map) {
		return mapper.getPieChartData(map);
	}

	@Override
	public List<Map<String, Object>> getAvgGraphChartData(Map<String, Object> map) {
		return mapper.getAvgGraphChartData(map);
	}

	@Override
	public List<Map<String, Object>> selectReservationList(Map<String, Object> map) {
		return mapper.selectReservationList(map);
	}
	/* 매출 */
	
	
	/* 캘린더 */
	@Override
	public AcommodationVO selectAccReservation(Map<String, Object> map) {
		AcommodationVO vo = mapper.selectAccReservation(map);
		
		map.put("category", vo.getAccCategory());
		
		AdminEventVO event = mapper.selectEvent(map);
		
		if(event != null) {
			vo.setEventNo(event.getEventNo());
		}
		
		return vo;
	}
	
	@Override
	public Map<String, Object> selectReservationDetail(String aresNo) {
		Map<String, Object> map = mapper.selectReservationDetail(aresNo);
		
		List<FileVO> list = fileMapper.getSaveName(map.get("GROUPNO").toString());
		map.put("attPath", list.get(0).getAttPath());
		
		return map;
	}

	@Override
	public ServiceResult updateInvalidDate(Map<String, Object> map) {
		ServiceResult result = null;
		
		int count = mapper.selectInvalidDate(map);
		
		int res = 0;
		if(count > 0) {
			//update
			res = mapper.deleteInvalidDate(map);
		} else {
			//insert
			res = mapper.insertInvalidDate(map);
		}
		
		if(res > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult updateEvent(Map<String, Object> map) {
		ServiceResult result = null;
		int res = 0;
		
		res = mapper.updateEvent(map);
		
		if(res > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Override
	public AdminEventVO selectEvent(Map<String, Object> map) {
		return mapper.selectEvent(map);
	}
	
	@Override
	public String isParticipate(Map<String, Object> map) {
		return mapper.isParticipate(map);
	}
	
	@Override
	public ServiceResult updateParticipate(Map<String, Object> map) {
		int res = mapper.updateParticipate(map);
		
		ServiceResult result = null;
		
		if(res > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	/* 캘린더 */

	@Override
	public List<Map<String, Object>> selectTopCategory() {
		return mapper.selectTopCategory();
	}
}
