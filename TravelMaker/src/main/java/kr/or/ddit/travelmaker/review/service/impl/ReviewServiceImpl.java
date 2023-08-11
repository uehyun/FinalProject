package kr.or.ddit.travelmaker.review.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.travelmaker.alarm.mapper.AlarmMapper;
import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;
import kr.or.ddit.travelmaker.review.mapper.ReviewMapper;
import kr.or.ddit.travelmaker.review.service.IReviewService;
import kr.or.ddit.travelmaker.review.vo.AccReviewVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Service
public class ReviewServiceImpl implements IReviewService {
	
	@Inject
	private ReviewMapper mapper;
	
	@Inject
	private AlarmMapper alarmMapper;
	
	@Override
	public List<MemberReviewVO> selectSomeMemberReview(String memNo) {
		return mapper.selectSomeMemberReview(memNo);
	}

	@Override
	public PaginationInfoVO<?> selectAllReview(Map<String, Object> map) {
		if("host".equals(map.get("type").toString())) {
			PaginationInfoVO<MemberReviewVO> pagingVO = new PaginationInfoVO<MemberReviewVO>();
			pagingVO.setScreenSize(3);
			pagingVO.setCurrentPage((int) map.get("currentPage"));
			
			int totalCount = mapper.memberReviewCount(map.get("memNo").toString());
			pagingVO.setTotalRecord(totalCount);
			
			map.put("startRow", pagingVO.getStartRow());
			map.put("endRow", pagingVO.getEndRow());
			map.put("memNo", map.get("memNo").toString());
			
			List<MemberReviewVO> memReview = mapper.selectAllMemberReview(map);
			pagingVO.setDataList(memReview);
			
			return pagingVO;
		} else {
			PaginationInfoVO<AccReviewVO> pagingVO = new PaginationInfoVO<AccReviewVO>();
			pagingVO.setScreenSize(3);
			pagingVO.setCurrentPage((int) map.get("currentPage"));
			
			int totalCount = mapper.accReviewCount(map.get("memNo").toString());
			pagingVO.setTotalRecord(totalCount);
			
			map.put("startRow", pagingVO.getStartRow());
			map.put("endRow", pagingVO.getEndRow());
			map.put("memNo", map.get("memNo").toString());
			
			List<AccReviewVO> accReview = mapper.selectAllAccReview(map);
			
			for (int i = 0; i < accReview.size(); i++) {
				Double rating = mapper.selectRating(accReview.get(i).getAccReviewNo());
				accReview.get(i).setRating(rating);
			}
			
			pagingVO.setDataList(accReview);
			
			return pagingVO;
		}
	}
	
	@Transactional(rollbackFor=Exception.class)
	@Override
	public ServiceResult insertAccReview(Map<String, Object> map) {
		ServiceResult result = null;
		
		int res = mapper.insertAccReview(map);
		if(res > 0) {
			Map<String, Object> scoreMap = new HashMap<String, Object>();
			scoreMap.put("accReviewNo", map.get("accReviewNo").toString());
			for (String key : map.keySet()) {
				if("clean".equals(key)) {
					System.out.println("클린탐");
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.insertScore(scoreMap);
				} else if("location".equals(key)) {
					System.out.println("위치탐");
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.insertScore(scoreMap);
				} else if("checkin".equals(key)) {
					System.out.println("체크인탐");
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.insertScore(scoreMap);
				} else if("valueformoney".equals(key)) {
					System.out.println("가성비탐");
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.insertScore(scoreMap);
				}
			}
		
			result = ServiceResult.OK;
			
			String memNo = mapper.selectMemberByAcc(map.get("accNo").toString());
			
			AlarmVO vo = new AlarmVO();
			vo.setAlarmContent("숙소 리뷰가 작성되었습니다.");
			vo.setAlarmType("숙소 리뷰");
			vo.setMemNo(memNo);
			vo.setAlarmUrl("/main/detail/" + map.get("accNo").toString());
			
			alarmMapper.insertAlarm(vo);
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Override
	public ServiceResult deleteAccReview(String accReviewNo) {
		ServiceResult res = null;
		
		mapper.deleteRate(accReviewNo);
		int result = mapper.deleteAccReview(accReviewNo);
		
		if(result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public ServiceResult updateAccReview(Map<String, Object> map) {
		ServiceResult res = null;
		
		int result = mapper.updateAccReview(map);
		
		if(result > 0) {
			Map<String, Object> scoreMap = new HashMap<String, Object>();
			scoreMap.put("accReviewNo", map.get("accReviewNo").toString());
			for (String key : map.keySet()) {
				if("clean".equals(key)) {
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.updateScore(scoreMap);
				} else if("location".equals(key)) {
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.updateScore(scoreMap);
				} else if("checkin".equals(key)) {
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.updateScore(scoreMap);
				} else if("valueformoney".equals(key)) {
					scoreMap.put("reviewScoreCategory", key);
					scoreMap.put("score", map.get(key).toString());
					mapper.updateScore(scoreMap);
				}
			}
			
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public ServiceResult blameAcc(Map<String, Object> map) {
		int res = mapper.blameAcc(map);
		
		ServiceResult result = null;
		
		if(res > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
	@Transactional(rollbackFor=Exception.class)
	@Override
	public ServiceResult insertMemReview(Map<String, Object> map) {
		int res = mapper.insertMemReview(map);
		
		ServiceResult result = null;
		
		if(res > 0) {
			AlarmVO vo = new AlarmVO();
			vo.setAlarmContent("호스트가 리뷰를 남겼습니다.");
			vo.setAlarmType("회원 리뷰");
			vo.setMemNo(map.get("memNo").toString());
			vo.setAlarmUrl("/member/review");
			
			alarmMapper.insertAlarm(vo);
			
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public String selectMemberByReview(String accReviewNo) {
		return mapper.selectMemberByReview(accReviewNo);
	}
}
