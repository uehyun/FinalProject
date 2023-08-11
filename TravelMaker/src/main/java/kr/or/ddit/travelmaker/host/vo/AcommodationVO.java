package kr.or.ddit.travelmaker.host.vo;

import java.util.List;

import kr.or.ddit.travelmaker.accreservation.vo.AccReservationVO;
import kr.or.ddit.travelmaker.admin.vo.AdminEventVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.Data;

@Data
public class AcommodationVO {
	private String accNo;
	private String memNo;
	private String accName;
	private String accContent;
	private String accCategory;
	private String accReservationMessage;
	private String accPostcode;
	private String accLocation;
	private int accPrice;
	private String accStandardCheckin;
	private String accStandardCheckout;
	private String accStatus;
	private float accScore;
	private String accLogitide;
	private String accLatitude;
	private int accWishlistCount;
	private String accCount;
	private int accReservationCount;
	private int accAppropriatePeople;
	private int accGuestExtraPrice;
	private String accRegDate;
	private String accModDate;
	private String accDelDate;
	private int accCleanFee;
	private String reservationInvailableDate;
	private String accAttGroupNo;
	private String eventNo;
	private String accThumbnailPath;
	private String accRejectComment;
	
	private String isUpdate;
	
	private AdminEventVO adminEvent;
	private List<FileVO> files;
	private List<AccoptionVO> accOption;
	private List<String> invalidDate;
	private List<EventVO> eventList;
	private List<AccReservationVO> accReservationList;
	
	private String accRegProcess;
}
