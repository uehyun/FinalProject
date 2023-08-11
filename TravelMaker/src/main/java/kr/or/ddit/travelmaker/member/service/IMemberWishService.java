package kr.or.ddit.travelmaker.member.service;

import java.util.List;

import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface IMemberWishService {

	public List<WishlistCategoryVO> selectWishlistByaccNo(String memNo);

	public List<WishlistVO> selectWishlistDetail(String wishlistCategoryNo);

	public WishlistCategoryVO selectWishlistCategory(String wishlistCategoryNo);

	public ServiceResult updateWishlist(WishlistVO wishlist);

	public ServiceResult editWishlist(WishlistVO wishlist);

}
