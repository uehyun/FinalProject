package kr.or.ddit.travelmaker.admin.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.mapper.EventManageMapper;
import kr.or.ddit.travelmaker.admin.service.EventManageService;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class EventManageServiceImpl implements EventManageService {

	@Inject
	private EventManageMapper eventManageMapper;

    @Override
    public List<OptionitemVO> cotOptionItems() {
        return eventManageMapper.cotOptionItems();
    }

    @Override
    public ServiceResult insertEvent(AdminEventVO vo) {
        
        ServiceResult result = null;
        int dupChkCnt = eventManageMapper.dupEventChk(vo);
        
        if (dupChkCnt > 0) {
            result = ServiceResult.EXIST;
            
        } else {
            
            int cnt = eventManageMapper.insertEvent(vo); 
            if(cnt > 0) {
                result = ServiceResult.OK;
            } else {
                result = ServiceResult.FAILED;
            }
        }
        
        return result;
    }

	@Override
	public List<AdminEventVO> list() {
		return eventManageMapper.list();
	}

	@Override
	public ServiceResult update(AdminEventVO vo) {
		ServiceResult result = null;
		int cnt = eventManageMapper.update(vo);
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult delete(List<AdminEventVO> eList) {
		ServiceResult result = null;
		for(int i=0; i<eList.size(); i++) {
			int cnt = eventManageMapper.delete(eList.get(i));
			if(cnt == 0) {
				result = ServiceResult.FAILED;
				break;
			} else {
				result = ServiceResult.OK;
			}
		}
		return result;
	}

	@Override
	public ServiceResult updateStatus(List<AdminEventVO> list) {
		ServiceResult result = null;
		int cnt = 0;
		if(list.get(0).getFlag().equals("ok")) {
			for(int i=0; i<list.size(); i++) {
				cnt += eventManageMapper.okUpdate(list.get(i));
			}
			if(cnt > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} else if(list.get(0).getFlag().equals("no")) {
			for(int i=0; i<list.size(); i++) {
				cnt += eventManageMapper.noUpdate(list.get(i));
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
