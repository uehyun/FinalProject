package kr.or.ddit.travelmaker.admin.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface EventManageService {
    public List<OptionitemVO> cotOptionItems();
    public ServiceResult insertEvent(AdminEventVO vo);
    public List<AdminEventVO> list();
	public ServiceResult update(AdminEventVO vo);
	public ServiceResult delete(List<AdminEventVO> eList);
	public ServiceResult updateStatus(List<AdminEventVO> list);
}
