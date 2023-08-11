package kr.or.ddit.travelmaker.admin.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.admin.vo.MemberManageVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface MemberManageService {
	public List<MemberManageVO> list();
	public List<BlameVO> blameList();
	public ServiceResult update(List<BlameVO> list);
}
