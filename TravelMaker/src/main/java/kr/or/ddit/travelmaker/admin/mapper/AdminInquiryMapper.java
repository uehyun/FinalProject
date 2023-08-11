package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.travelmaker.admin.vo.inquiryVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Mapper
public interface AdminInquiryMapper {

	public inquiryVO detail(String inqBoardNo);
	public List<inquiryVO> list();
	public void register(inquiryVO inquiry);
	public void update(inquiryVO inquiry);
	public int delete(@Param("inqBoardNo") String inqBoardNo, @Param("memNo") String memNo);
	//페이징처리
	public int selectInboardCount(PaginationInfoVO<inquiryVO> pagingVO);
	public List<inquiryVO> selectInboardList(PaginationInfoVO<inquiryVO> pagingVO);
	
}
