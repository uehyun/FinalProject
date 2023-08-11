package kr.or.ddit.travelmaker.main.vo;

import lombok.Data;

@Data
public class PaymentVO {
	private String paymentNo;
	private String freservationNo;
	private String aresNo;
	private String memNo;
	private String accNo;
	private int paymentTotalPrice;
	private String paymentDate;
}
