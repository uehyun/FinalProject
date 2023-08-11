package kr.or.ddit.travelmaker.admin.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.admin.mapper.AdminInquiryMapper;
import kr.or.ddit.travelmaker.admin.service.IInquiryService;
import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.admin.vo.inquiryVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class InquiryServiceImpl implements IInquiryService {
	
	@Inject
	private AdminInquiryMapper mapper;
	
	@Override
	public inquiryVO detail(String inqBoardNo) {
		//mapper.incrementHit(inqBoardNo);
		return mapper.detail(inqBoardNo);
	}

	@Override
	public List<inquiryVO> list() {
		return mapper.list();
	}

	@Override
	public void register(inquiryVO inquiry) {
		mapper.register(inquiry);
	}

	@Override
	public void update(inquiryVO inquiry) {
		mapper.update(inquiry);
	}

	@Override
	public ServiceResult delete(String inqBoardNo, String memNo) {
		ServiceResult result = null;
		int cnt = mapper.delete(inqBoardNo, memNo); 
		if(cnt > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int selectInboardCount(PaginationInfoVO<inquiryVO> pagingVO) {
		return mapper.selectInboardCount(pagingVO);
	}

	@Override
	public List<inquiryVO> selectInboardList(PaginationInfoVO<inquiryVO> pagingVO) {
		return mapper.selectInboardList(pagingVO);
	}

	
}
