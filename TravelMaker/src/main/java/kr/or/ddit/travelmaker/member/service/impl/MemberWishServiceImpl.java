package kr.or.ddit.travelmaker.member.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.member.mapper.MemberWishMapper;
import kr.or.ddit.travelmaker.member.service.IMemberWishService;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Service
public class MemberWishServiceImpl implements IMemberWishService {

	
	@Inject
	private MemberWishMapper memberWishMapper;

	@Override
	public List<WishlistCategoryVO> selectWishlistByaccNo(String memNo) {
		List<WishlistCategoryVO> wishlistCategoryList = memberWishMapper.selectWishlistByaccNo(memNo);
		return wishlistCategoryList;
	}

	@Override
	public List<WishlistVO> selectWishlistDetail(String wishlistCategoryNo) {
		return memberWishMapper.selectWishlistDetail(wishlistCategoryNo);
	}

	@Override
	public WishlistCategoryVO selectWishlistCategory(String wishlistCategoryNo) {
		return memberWishMapper.selectWishlistCategory(wishlistCategoryNo);
	}

	@Override
	public ServiceResult updateWishlist(WishlistVO wishlist) {
		ServiceResult result = null;
		int status = 0;
		
		status = memberWishMapper.updateWishlist(wishlist);
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult editWishlist(WishlistVO wishlist) {
		ServiceResult result = null;
		int status = 0;
		
		if (wishlist.getWishlistMemo().trim().equals("")) {
			status = memberWishMapper.updateNullWishlist(wishlist);
		} else {
			status = memberWishMapper.updateWishlist(wishlist);
		}
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
}
