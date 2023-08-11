package kr.or.ddit.travelmaker.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.admin.vo.HostManageVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface HostManageService {
	public List<HostManageVO> list();
	public ServiceResult update(List<HostManageVO> list);
	public List<OptionitemVO> selectCategory();
	public Map<String, Object> getTextData(Map<String, Object> map);
	public List<Map<String, Object>> getPieChartData(Map<String, Object> map);
	public List<Map<String, Object>> getGraphChartData(Map<String, Object> map);
	public HostManageVO selectOne(String accNo);
}
