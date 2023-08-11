package kr.or.ddit.travelmaker.review.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.review.vo.AccReviewVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;

@Mapper
public interface ReviewMapper {
	public List<MemberReviewVO> selectSomeMemberReview(String memNo);
	
	public List<MemberReviewVO> selectAllMemberReview(Map<String, Object> map);
	
	public int memberReviewCount(String memNo);

	public List<AccReviewVO> selectAllAccReview(Map<String, Object> map);
	
	public int accReviewCount(String memNo);

	public int deleteAccReview(String accReviewNo);

	public int updateAccReview(Map<String, Object> map);

	public void updateScore(Map<String, Object> scoreMap);

	public Double selectRating(String accReviewNo);

	public int deleteRate(String accReviewNo);

	public int blameAcc(Map<String, Object> map);

	public int insertAccReview(Map<String, Object> map);

	public void insertScore(Map<String, Object> scoreMap);

	public int insertMemReview(Map<String, Object> map);
	
	public String selectMemberByReview(String accReviewNo);
	
	public String selectMemberByAcc(String accNo);
}
