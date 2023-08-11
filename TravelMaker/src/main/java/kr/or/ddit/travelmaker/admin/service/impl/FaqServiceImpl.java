package kr.or.ddit.travelmaker.admin.service.impl;


import java.io.IOException;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.travelmaker.admin.mapper.AdminFaqMapper;
import kr.or.ddit.travelmaker.admin.service.IFaqService;
import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FaqServiceImpl implements IFaqService {
	
	@Inject
	private AdminFaqMapper mapper;
	
	@Transactional(rollbackFor = IOException.class)
	@Override
	public void register(faqVO faq) {
		log.info("Faq register");
		mapper.register(faq);
		
	}
	

//	@Override
//	public List<faqVO> list() {
//		return mapper.list();
//	}

	@Override
	public faqVO detail(String faqBoardNo) {
		//mapper.incrementHit(inboardVO);
		return mapper.detail(faqBoardNo);
	}


	@Override
	public void deleteOne(String faqBoardNo) {
		mapper.deleteOne(faqBoardNo);
	}


	@Override
	public void update(faqVO faq) {
		mapper.update(faq);
	}


	@Override
	public int selectFaqCount(PaginationInfoVO<faqVO> pagingVO) {
		return mapper.selectFaqCount(pagingVO);
	}

	@Override
	public List<faqVO> selectFaqList(PaginationInfoVO<faqVO> pagingVO) {
		return mapper.selectFaqList(pagingVO);
	}


	@Override
	public int selectDelete(String msg) {
		return mapper.selectDelete(msg);
		
	}

	
}
