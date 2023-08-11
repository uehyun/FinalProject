package kr.or.ddit.travelmaker.host.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.host.mapper.HostMapper;
import kr.or.ddit.travelmaker.host.service.IHostService;
import kr.or.ddit.travelmaker.host.vo.AccoptionVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.EventVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HostServiceImpl implements IHostService {

	@Inject
	private HostMapper hostMapper;
	
	@Override
	public Map<String, List<OptionitemVO>> selectOptionItems() {
		Map<String, List<OptionitemVO>> selectOptionItems = new HashMap<String, List<OptionitemVO>>();
		selectOptionItems.put("typeOptions", hostMapper.typeOptionItems());
		selectOptionItems.put("facOptions", hostMapper.facOptionItems());
		selectOptionItems.put("secOptions", hostMapper.secOptionItems());
		selectOptionItems.put("cotOptions", hostMapper.cotOptionItems());
		selectOptionItems.put("danOptions", hostMapper.danOptionItems());
		return selectOptionItems;
	}
	
	@Override
	public String memNoById(String memName) {
		return hostMapper.memNoById(memName);
	}

	@Override
	public ServiceResult insertAcommodation(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int res = hostMapper.getRole(acommodationVO.getMemNo());
		if(res == 0) {
			hostMapper.insertRole(acommodationVO.getMemNo());
		}
		
		List<EventVO> list = new ArrayList<>();
		EventVO vo = new EventVO();
		vo.setDiscountRate(0);
		vo.setDiscountType("WEEK");
		
		EventVO vo1 = new EventVO();
		vo1.setDiscountRate(0);
		vo1.setDiscountType("MONTH");
		list.add(vo);
		list.add(vo1);
		
		acommodationVO.setEventList(list);
		
		
		List<AccoptionVO> conTypeList = new ArrayList<AccoptionVO>();
		for(int i=0; i<4; i++) {
			AccoptionVO accoption = new AccoptionVO();
			accoption.setAccNo(acommodationVO.getAccNo());
			if (i == 0) { accoption.setOptionNo("con_001"); } 
			else if (i == 1) { accoption.setOptionNo("con_002"); } 
			else if (i == 2) { accoption.setOptionNo("con_003"); } 
			else if (i == 3) { accoption.setOptionNo("con_004"); }
			accoption.setOptionCount(1);
			
			conTypeList.add(accoption);
		}
		acommodationVO.setAccOption(conTypeList);
		
		
		int status = hostMapper.insertAcommodation(acommodationVO);
		
		
		
		
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult SessionUpdate1(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int status = hostMapper.SessionUpdate1(acommodationVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult SessionUpdate2(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int status = hostMapper.SessionUpdate2(acommodationVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult uploadImagesByaccNo(List<FileVO> fileList, AcommodationVO acommodationVO) {
		log.info("서비스에서 acc 출력 ------------> " + acommodationVO);
		ServiceResult result = null;
		
		int updateS = hostMapper.SessionUpdate3(acommodationVO);
		int status = hostMapper.uploadImagesByaccNo(fileList);
		
		
		if (status > 0 && updateS > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Override
	public ServiceResult updateConTypeOption(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int status = 0;
		int updateS = hostMapper.SessionOptionUpdate(acommodationVO);
		
		for(int i=0; i<4; i++) {
			log.info("acommodationVO.getAccOption().get(i)" + acommodationVO.getAccOption().get(i));
			status = hostMapper.updateConTypeOption(acommodationVO.getAccOption().get(i));
		}
		
		log.info("status -> " + status + " updateS" + updateS);
		
		if (status > 0 && updateS > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public ServiceResult insertTypeOption(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int updateS = hostMapper.SessionOptionUpdate(acommodationVO);
//		log.info("service Check -> " + acommodationVO.getAccOption());
		int status = hostMapper.insertTypeOption(acommodationVO.getAccOption());
		
		if (status > 0 && updateS > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult SessionUpdate6(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int status = hostMapper.SessionUpdate6(acommodationVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult SessionUpdate8(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		
		int status = hostMapper.SessionUpdate8(acommodationVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult SessionUpdate9(AcommodationVO acommodationVO) {
		ServiceResult result = null;
		int status = 0;
		
		int update = hostMapper.SessionUpdate9(acommodationVO);
		if (acommodationVO.getAccOption().size() > 0) {
			status = hostMapper.insertTypeOption(acommodationVO.getAccOption());
		}
		
		if (update > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	
	
	@Override
	public AcommodationVO accommodationDetailByAccNo(String accNo) {
		AcommodationVO acommodation = hostMapper.accommodationDetailByAccNo(accNo);
		
		if (acommodation.getFiles() == null) {
			acommodation.setFiles(new ArrayList<FileVO>());
		}
		
		List<AccoptionVO> accoptionList = hostMapper.accommodationOptionsByAccNo(accNo);
		if (accoptionList != null) {
			acommodation.setAccOption(accoptionList);
		} else {
			acommodation.setAccOption(new ArrayList<>());
		}
		
		return acommodation;
	}
}
