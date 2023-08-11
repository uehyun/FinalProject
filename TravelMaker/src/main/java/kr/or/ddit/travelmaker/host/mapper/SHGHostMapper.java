package kr.or.ddit.travelmaker.host.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;

@Mapper
public interface SHGHostMapper {
	/* 공용 */
	public List<AcommodationVO> selectValidAcc(Map<String, Object> map);
	
	public List<AcommodationVO> selectInvalidAcc(String memNo);
	
	public List<AccReservationVO> selectAres(Map<String, Object> map);
	
	public List<AcommodationVO> selectAccWithOption(Map<String, Object> map);
	
	public List<AcommodationVO> selectAccWithFilter(Map<String, Object> map);
	
	public void updateAccActive(Map<String, Object> map);
	/* 공용 */
	
	
	/* 매출 */
	public Map<String, Object> getAllSalesAmount(Map<String, Object> map);
	
	public Map<String, Object> avgReservation(Map<String, Object> map);
	
	public List<Map<String, Object>> getPieChartData(Map<String, Object> map);
	
	public List<Map<String, Object>> selectReservationList(Map<String, Object> map);
	
	public List<Map<String, Object>> getAvgGraphChartData(Map<String, Object> map);
	/* 매출 */
	
	
	/* 캘린더 */
	public AcommodationVO selectAccReservation(Map<String, Object> map);
	
	public Map<String, Object> selectReservationDetail(String aresNo);
	
	public int selectInvalidDate(Map<String, Object> map);

	public int deleteInvalidDate(Map<String, Object> map);

	public int insertInvalidDate(Map<String, Object> map);
	
	public int updateEvent(Map<String, Object> map);
	
	public int deleteBeforeDate();
	
	public AdminEventVO selectEvent(Map<String, Object> map);
	
	public String isParticipate(Map<String, Object> map);
	
	public int updateParticipate(Map<String, Object> map);
	/* 캘린더 */
	
	
	/* 실시간 카테고리 순위 */
	public List<Map<String, Object>> selectPopular();
	
	public void updateCategoryRank(Map<String, Object> map);
	
	public List<Map<String, Object>> selectTopCategory();
	/* 실시간 카테고리 순위 */
}
