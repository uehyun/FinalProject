package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.faqVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Mapper
public interface AdminFaqMapper {
	public void register(faqVO faq);
	public List<faqVO> list();
	public faqVO detail(String faqBoardNo);
	public void deleteOne(String faqBoardNo);
	public void update(faqVO faq);
	public int selectDelete(String msg);
	
	//페이징처리
	public int selectFaqCount(PaginationInfoVO<faqVO> pagingVO);
	public List<faqVO> selectFaqList(PaginationInfoVO<faqVO> pagingVO);
}

