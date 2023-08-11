package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;

@Mapper
public interface EventManageMapper {
	public List<OptionitemVO> cotOptionItems();
	public int insertEvent(AdminEventVO vo);
	public int dupEventChk(AdminEventVO vo);
	public List<AdminEventVO> list();
	public int update(AdminEventVO vo);
	public int delete(AdminEventVO vo);
	public int okUpdate(AdminEventVO adminEventVO);
	public int noUpdate(AdminEventVO adminEventVO);
}
