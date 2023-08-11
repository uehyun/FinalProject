package kr.or.ddit.travelmaker.flight.vo;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FlightVO {
	
	// 비행기 예약
	private String freservationNo;			// 비행기 예약 번호
	private int freservationTotalPrice;		// 비행기 예약 총금액
	private String freservationDate;		// 비행기 예약날짜
	private int freservationPassengerCount;	// 비행기 예약 승객 수
	private String memNo;					// 회원번호
	private String memName;					// 회원이름
	private String memEmail;				// 회원이메일
	private String memPhone;				// 회원전화번호
	
	// 비행기 좌석
	private String flightSeatNo;		// 비행기 좌석번호
	private int adultPrice;				// 성인 금액
	private int childPrice;				// 유소년 금액
	
	// 비행기 예약 좌석
	private int freservationPrice;		// 비행기 에약 금액
	
	// 공항
	private String airportCode; 		// 공항코드
	private String airportName;			// 공항이름
	
	// 비행기	
	private String flightNo;			// 비행기번호		
	private String flightAirline;		// 항공사
	private String flightModel;			// 비행기 모델
	private String flightDate;			// 출발날짜
	private String flightDepartTime;	// 출발시간
	private String flightArriveTime;	// 도착시간
	private String departAirport;		// 출발공항
	private String arriveAirport;		// 도착공항
	private int durationHour;			// 걸린시간
	private int durationMinute;			// 걸린분
	private String sortOption;			// 필터 
	
	
	// 승객
	private String passengerNo;			// 승객 번호
	private String passengerEmail;		// 승객 이메일
	private String passengerPhone;		// 승객 전화번호
	private String passengerFirstname;	// 승객 성
	private String passengerLastname;	// 승객 이름
	private String passportNo;			// 여권번호
	private String passportEndDate;		// 여권만기일
	private String passengerBirth;		// 승객 생년월일
	private String passengerType;		// 승객 타입(성인인지 유아인지)
	
	private int adultCount;			// 성인 수
	private int childCount;			// 유소년 수
	
	private int itemsPerPage;
	private int startNo;
	private int endNo;
}






















