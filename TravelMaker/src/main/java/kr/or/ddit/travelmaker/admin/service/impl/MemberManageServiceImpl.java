package kr.or.ddit.travelmaker.admin.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.mapper.MemberManageMapper;
import kr.or.ddit.travelmaker.admin.service.MemberManageService;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.admin.vo.MemberManageVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class MemberManageServiceImpl implements MemberManageService {
	
	@Inject
	private MemberManageMapper memberManageMapper;

	@Override
	public List<MemberManageVO> list() {
		List<MemberManageVO> list = memberManageMapper.list();
		for(int i=0; i<list.size(); i++) {
			if("".equals(list.get(i).getMemDel()) || list.get(i).getMemDel() == null) {
				list.get(i).setMemDel("정상");
			}
		}
		return list;
	}

	@Override
	public List<BlameVO> blameList() {
		return memberManageMapper.blameList();
	}

	@Override
	public ServiceResult update(List<BlameVO> list) {
		ServiceResult result = null;
		int cnt = 0;
		if(list.get(0).getFlag().equals("ok")) {
			for(int i=0; i<list.size(); i++) {
				cnt += memberManageMapper.okUpdate(list.get(i));
			}
			if(cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else if(list.get(0).getFlag().equals("no")) {
			for(int i=0; i<list.size(); i++) {
				cnt += memberManageMapper.noUpdate(list.get(i));
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

}
