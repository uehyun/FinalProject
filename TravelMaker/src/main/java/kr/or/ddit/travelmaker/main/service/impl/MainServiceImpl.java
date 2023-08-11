package kr.or.ddit.travelmaker.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.main.mapper.MainMapper;
import kr.or.ddit.travelmaker.main.service.IMainService;
import kr.or.ddit.travelmaker.main.vo.OptionVO;
import kr.or.ddit.travelmaker.main.vo.PaymentVO;
import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.review.vo.ReviewScoreVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainServiceImpl implements IMainService {
	
	@Inject
	private MainMapper mainMapper;

	@Override
	public List<AcommodationVO> getAllAcommodations(Map<String,Object> map) {
		return mainMapper.getAllAcommodations(map);
	}

	@Override
	public AcommodationVO accommodationDetailByAccNo(String accNo) {
		
		AcommodationVO acommodation = mainMapper.accommodationDetailByAccNo(accNo);
		
		acommodation.setAccOption(mainMapper.accommodationOptionsByAccNo(accNo));
		acommodation.setInvalidDate(mainMapper.accommodationInvalidDateByAccNo(accNo));
		acommodation.setAccReservationList(mainMapper.accommodationReservationDateByAccNo(accNo));
		acommodation.setEventList(mainMapper.accommodationEventByAccNo(accNo));
		
		mainMapper.updateAccHit(accNo);
		
		return acommodation;
	}

	@Override
	public MemberVO hostProfileByAccNo(String accNo) {
		return mainMapper.hostProfileByAccNo(accNo);
	}

	@Override
	public List<OptionVO> getCategory() {
		return mainMapper.getCategory();
	}

	@Override
	public String memNoById(String username) {
		return mainMapper.memNoById(username);
	}

	@Override
	public ServiceResult insertWishlistCategory(WishlistCategoryVO wishlistCategory) {
		ServiceResult result = null;
		int status = mainMapper.insertWishlistCategory(wishlistCategory);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int insertWishlist(WishlistVO wishlist) {
		return mainMapper.insertWishlist(wishlist);
	}

	@Override
	public int selectIsWished(Map<String, String> paramMap) {
		return mainMapper.selectIsWished(paramMap);

	}

	@Override
	public List<WishlistCategoryVO> selectWishCategoryList(String memNo) {
		return mainMapper.selectWishCategoryList(memNo);
	}

	@Override
	public int deleteWishList(Map<String, String> paramMap) {
		return mainMapper.deleteWishList(paramMap);
	}

	@Override
	public ServiceResult isnertAccBlame(BlameVO blame) {
		ServiceResult result = null;
		int status = mainMapper.isnertAccBlame(blame);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public AdminEventVO selectAdminEventByEventNo(String eventNo) {
		return mainMapper.selectAdminEventByEventNo(eventNo);
	}

	@Override
	public int selectAccCount(PaginationInfoVO<AcommodationVO> pagingVO) {
		return mainMapper.selectAccCount(pagingVO);
	}

	@Override
	public List<AcommodationVO> selectAccList(PaginationInfoVO<AcommodationVO> pagingVO) {
		List<AcommodationVO> list = mainMapper.selectAccList(pagingVO);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setFiles(mainMapper.getImg(list.get(i).getAccNo()));
		}
		return list;
	}

	
	@Override
	public AcommodationVO accommodationReservationDetailByAccNo(String accNo) {
		return mainMapper.accommodationReservationDetailByAccNo(accNo);
	}

	@Override
	public MemberVO memberBymemId(String username) {
		return mainMapper.memberBymemId(username);
	}

	@Override
	public ServiceResult insertAccReservation(AccReservationVO accReservation, String userName) {
		MemberVO member = mainMapper.memberBymemId(userName);
		
		accReservation.setMemNo(member.getMemNo());
		accReservation.setMemName(member.getMemName());
		accReservation.setMemEmail(member.getMemEmail());
		accReservation.setMemPhone(member.getMemPhone());
		
		ServiceResult result = null;
		int status = mainMapper.insertAccReservation(accReservation);
		
		if (status > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public ServiceResult insertPayment(PaymentVO payment, AccReservationVO accReservation) {
		payment.setAresNo(accReservation.getAresNo());
		payment.setMemNo(accReservation.getMemNo());
		payment.setAccNo(accReservation.getAccNo());
		
		
		
		ServiceResult result = null;
		int status = mainMapper.insertPayment(payment);
		
		if (status > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public List<MemberReviewVO> selectReviewByAccNo(String accNo) {
		return mainMapper.selectReviewByAccNo(accNo);
	}

	@Override
	public List<ReviewScoreVO> selectReviewScoreByAccNo(String accNo) {
		return mainMapper.selectReviewScoreByAccNo(accNo);
	}
	
}





























