package kr.or.ddit.travelmaker.admin.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.mapper.HostManageMapper;
import kr.or.ddit.travelmaker.admin.service.HostManageService;
import kr.or.ddit.travelmaker.admin.vo.HostManageVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class HostManageServiceImpl implements HostManageService {
	
	@Inject
	private HostManageMapper hostManageMapper;

	@Override
	public List<HostManageVO> list() {
		return hostManageMapper.list();
	}

	@Override
	public ServiceResult update(List<HostManageVO> list) {
		ServiceResult result = null;
		int cnt = 0;
		if(list.get(0).getFlag().equals("ok")) {
			for(int i=0; i<list.size(); i++) {
				cnt += hostManageMapper.okUpdate(list.get(i));
			}
			if(cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else if(list.get(0).getFlag().equals("no")) {
			for(int i=0; i<list.size(); i++) {
				cnt += hostManageMapper.noUpdate(list.get(i));
			}
			if(cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<OptionitemVO> selectCategory() {
		return hostManageMapper.selectCategory();
	}

	@Override
	public Map<String, Object> getTextData(Map<String, Object> map) {
		return hostManageMapper.getTextData(map);
	}

	@Override
	public List<Map<String, Object>> getPieChartData(Map<String, Object> map) {
		return hostManageMapper.getPieChartData(map);
	}

	@Override
	public List<Map<String, Object>> getGraphChartData(Map<String, Object> map) {
		return hostManageMapper.getGraphChartData(map);
	}

	@Override
	public HostManageVO selectOne(String accNo) {
		HostManageVO vo = hostManageMapper.selectOne(accNo);
		vo.setFileList(hostManageMapper.getImg(accNo));
		return vo;
	}
}
