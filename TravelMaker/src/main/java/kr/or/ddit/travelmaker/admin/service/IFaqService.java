package kr.or.ddit.travelmaker.admin.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

public interface IFaqService {
	
	public void register(faqVO faq);
	//public List<faqVO> list();
	public faqVO detail(String faqBoardNo);
	public void deleteOne(String faqBoardNo);
	public void update(faqVO faq);
	public int selectDelete(String msg);
	
	// 페이징 처리
	public int selectFaqCount(PaginationInfoVO<faqVO> pagingVO);
	public List<faqVO> selectFaqList(PaginationInfoVO<faqVO> pagingVO);
	
}
