package kr.or.ddit.travelmaker.admin.vo;

import java.util.List;

import kr.or.ddit.travelmaker.host.vo.AccoptionVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.Data;

@Data
public class HostManageVO {
   private String accNo;
   private String memNo;
   private String accName;
   private String accPostcode;
   private String accLocation;
   private int accPrice;
   private String accStandardCheckin;
   private String accStandardCheckout;
   private String accStatus;
   private int accCount;
   private int accScore;
   private String accLogitide;
   private String accLatitude;
   private int accWishlistCount;
   private int accHit;
   private int accReservationCount;
   private String accAppropriatePeople;
   private int accGuestExtraPrice;
   private String accRegDate;
   private String accModDate;
   private String accDelDate;
   private String accCleanFee;
   private String reservationInvailableDate;
   private String accAttGroupNo;
   private String accCategory;
   private String accReservationMessage;
   private String accThumbnailPath;
   private String accContent;
   private String memId;
   private String memName;
   private String memPhone;
   private String memEmail;
   private String memRegDate;
   private String memDel;
   private String memProfilePath;
   private String memPreLanguage;
   private String memPreCurrency;
   private int facilities;
   
   private String flag;
   private String accRejectComment;
   
   
   private List<AdminEventVO> eventList;
   private List<AccoptionVO> accoptionList;
   private List<FileVO> fileList;
}
