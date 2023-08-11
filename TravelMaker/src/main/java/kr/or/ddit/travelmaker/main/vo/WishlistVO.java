package kr.or.ddit.travelmaker.main.vo;

import java.util.List;

import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.Data;

@Data
public class WishlistVO {
	private String wishlistCategoryNo;
	private String accNo;
	private String wishlistMemo;
	
	private List<FileVO> files;
}
