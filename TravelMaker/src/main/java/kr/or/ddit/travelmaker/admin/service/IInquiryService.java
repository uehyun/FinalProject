package kr.or.ddit.travelmaker.admin.service;

import java.util.List;

import kr.or.ddit.travelmaker.admin.vo.inquiryVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

public interface IInquiryService {

	public inquiryVO detail(String inqBoardNo);
	public List<inquiryVO> list();
	public void register(inquiryVO inquiry);
	public void update(inquiryVO inquiry);
	public ServiceResult delete(String inqBoardNo, String memNo);
	
	//페이징 처리
	public int selectInboardCount(PaginationInfoVO<inquiryVO> pagingVO);
	public List<inquiryVO> selectInboardList(PaginationInfoVO<inquiryVO> pagingVO);

}
