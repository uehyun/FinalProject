package kr.or.ddit.travelmaker.main.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.main.vo.OptionVO;
import kr.or.ddit.travelmaker.main.vo.PaymentVO;
import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.review.vo.ReviewScoreVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

public interface IMainService {
	public List<AcommodationVO> getAllAcommodations(Map<String,Object> map);
	public AcommodationVO accommodationDetailByAccNo(String accNo);
	public MemberVO hostProfileByAccNo(String accNo);

	public List<OptionVO> getCategory();
	public String memNoById(String username);
	public ServiceResult insertWishlistCategory(WishlistCategoryVO wishlistCategory);
	public int insertWishlist(WishlistVO wishlist);
	public int selectIsWished(Map<String, String> paramMap);
	public List<WishlistCategoryVO> selectWishCategoryList(String memNo);
	public int deleteWishList(Map<String, String> paramMap);
	public ServiceResult isnertAccBlame(BlameVO blame);
	
	public AdminEventVO selectAdminEventByEventNo(String eventNo);
	public int selectAccCount(PaginationInfoVO<AcommodationVO> pagingVO);
	public List<AcommodationVO> selectAccList(PaginationInfoVO<AcommodationVO> pagingVO);
	
	public AcommodationVO accommodationReservationDetailByAccNo(String accNo);
	public MemberVO memberBymemId(String username);
	public ServiceResult insertAccReservation(AccReservationVO accReservation, String userName);
	public ServiceResult insertPayment(PaymentVO payment, AccReservationVO accReservation);
	public List<MemberReviewVO> selectReviewByAccNo(String accNo);
	public List<ReviewScoreVO> selectReviewScoreByAccNo(String accNo);

}
