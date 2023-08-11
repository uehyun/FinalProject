package kr.or.ddit.travelmaker.accreservation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccReservationVO {
	private String aresNo;
	private String memNo;
	private String memEmail;
	private String memName;
	private String memPhone;
	private String accNo;
	private String accName;
	private String aresCheckinDate;
	private String aresCheckoutDate;
	private int aresGuestCount;
	private int aresExtraGuest;
	private String aresStatus;
	private String aresRequest;
	private String aresRegDate;
	private String aresModDate;
	private String aresDelDate;
	
	private int aresAccDateCount;
	private String aresCheckin;
	private String aresCheckout;
	private int aresTotalPrice;
	private int aresPerPrice;
	private int aresExtraPrice;
	private int aresDiscountPrice;
	private String usedCoupon;
}
