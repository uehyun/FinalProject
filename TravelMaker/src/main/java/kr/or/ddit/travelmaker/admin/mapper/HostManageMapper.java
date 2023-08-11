package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.HostManageVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Mapper
public interface HostManageMapper {
	public List<HostManageVO> list();
	public int okUpdate(HostManageVO hostManageVO);
	public int noUpdate(HostManageVO hostManageVO);
	public List<OptionitemVO> selectCategory();
	public Map<String, Object> getTextData(Map<String, Object> map);
	public List<Map<String, Object>> getPieChartData(Map<String, Object> map);
	public List<Map<String, Object>> getGraphChartData(Map<String, Object> map);
	public List<FileVO> getImg(String accNo);
	public HostManageVO selectOne(String accNo);
}
