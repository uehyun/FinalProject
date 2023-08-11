package kr.or.ddit.travelmaker.host.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface IHostService2 {
	/* 공용 */
	public List<AcommodationVO> selectInvalidAcc(String memNo);
	
	public List<AcommodationVO> selectValidAcc(Map<String, Object> map);
	
	public List<AccReservationVO> selectAres(Map<String, Object> map);
	
	public List<AcommodationVO> selectAccWithFilter(Map<String, Object> map);
	
	public ServiceResult updateAccActive(Map<String, Object> map);
	/* 공용 */
	
	
	/* 매출 */
	public Map<String, Object> getAllSalesAmount(Map<String, Object> map);

	public Map<String, Object> avgReservation(Map<String, Object> map);

	public List<Map<String, Object>> getPieChartData(Map<String, Object> map);
	
	public List<Map<String, Object>> getAvgGraphChartData(Map<String, Object> map);
	
	public List<Map<String, Object>> selectReservationList(Map<String, Object> map);
	/* 매출 */
	
	
	/* 캘린더 */
	public AcommodationVO selectAccReservation(Map<String, Object> map);
	
	public Map<String, Object> selectReservationDetail(String aresNo);
	
	public ServiceResult updateInvalidDate(Map<String, Object> map);

	public ServiceResult updateEvent(Map<String, Object> map);
	
	public AdminEventVO selectEvent(Map<String, Object> map);
	
	public String isParticipate(Map<String, Object> map);
	
	public ServiceResult updateParticipate(Map<String, Object> map);
	/* 캘린더 */
	
	
	/* 인기 카테고리 */
	public List<Map<String, Object>> selectTopCategory();
	/* 인기 카테고리 */
}
