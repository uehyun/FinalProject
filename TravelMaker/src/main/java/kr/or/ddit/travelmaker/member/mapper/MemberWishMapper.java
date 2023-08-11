package kr.or.ddit.travelmaker.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.main.vo.WishlistCategoryVO;
import kr.or.ddit.travelmaker.main.vo.WishlistVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

@Mapper
public interface MemberWishMapper {

	public List<WishlistCategoryVO> selectWishlistByaccNo(String memNo);

	public List<WishlistVO> selectWishlistDetail(String wishlistCategoryNo);

	public WishlistCategoryVO selectWishlistCategory(String wishlistCategoryNo);

	public int updateWishlist(WishlistVO wishlist);

	public int updateNullWishlist(WishlistVO wishlist);

}
