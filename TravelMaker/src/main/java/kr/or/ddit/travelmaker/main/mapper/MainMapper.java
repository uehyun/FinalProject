package kr.or.ddit.travelmaker.main.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.host.vo.AccoptionVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.EventVO;
import kr.or.ddit.travelmaker.main.vo.OptionVO;
import kr.or.ddit.travelmaker.main.vo.PaymentVO;
import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.review.vo.MemberReviewVO;
import kr.or.ddit.travelmaker.review.vo.ReviewScoreVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import kr.or.ddit.travelmaker.utils.vo.PaginationInfoVO;

@Mapper
public interface MainMapper {
	public List<AcommodationVO> getAllAcommodations(Map<String,Object> map);
	public AcommodationVO accommodationDetailByAccNo(String accNo);
	public List<AccoptionVO> accommodationOptionsByAccNo(String accNo);
	public List<EventVO> accommodationEventByAccNo(String accNo);
	public MemberVO hostProfileByAccNo(String accNo);

	public List<OptionVO> getCategory();
	
	public List<String> accommodationInvalidDateByAccNo(String accNo);
	public List<AccReservationVO> accommodationReservationDateByAccNo(String accNo);
	public String memNoById(String username);
	public int insertWishlistCategory(WishlistCategoryVO wishlistCategory);
	public int insertWishlist(WishlistVO wishlist);
	public int selectIsWished(Map<String, String> paramMap);
	public List<WishlistCategoryVO> selectWishCategoryList(String memNo);
	public int deleteWishList(Map<String, String> paramMap);
	public int isnertAccBlame(BlameVO blame);
	
	public AdminEventVO selectAdminEventByEventNo(String eventNo);
	public int selectAccCount(PaginationInfoVO<AcommodationVO> pagingVO);
	public List<AcommodationVO> selectAccList(PaginationInfoVO<AcommodationVO> pagingVO);
	public List<FileVO> getImg(String accNo);
	
	public AcommodationVO accommodationReservationDetailByAccNo(String accNo);
	public MemberVO memberBymemId(String username);
	public int insertAccReservation(AccReservationVO accReservation);
	public int insertPayment(PaymentVO payment);
	public List<MemberReviewVO> selectReviewByAccNo(String accNo);
	public List<ReviewScoreVO> selectReviewScoreByAccNo(String accNo);
	public void updateAccHit(String accNo);
}
