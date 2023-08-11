package kr.or.ddit.travelmaker.review.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

public interface IReviewService {
	public List<MemberReviewVO> selectSomeMemberReview(String memNo);

	public PaginationInfoVO<?> selectAllReview(Map<String, Object> map);

	public ServiceResult deleteAccReview(String accReviewNo);

	public ServiceResult updateAccReview(Map<String, Object> map);

	public ServiceResult blameAcc(Map<String, Object> map);

	public ServiceResult insertAccReview(Map<String, Object> map);

	public ServiceResult insertMemReview(Map<String, Object> map);
	
	public String selectMemberByReview(String accReviewNo);
}
