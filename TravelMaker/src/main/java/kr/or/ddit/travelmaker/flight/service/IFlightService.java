package kr.or.ddit.travelmaker.flight.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.flight.vo.FlightVO;

public interface IFlightService {

	public List<FlightVO> selectSeats(String flightNo);

	public List<FlightVO> getAirport();

	public int insertFlightData(List<FlightVO> flightList);

	public List<FlightVO> getAirportByName(String flightName);
	
	public List<FlightVO> flightList(FlightVO flightVO);

	public List<FlightVO> reservationDetail(String flightNo);

	public void insertReservation(List<FlightVO> flightList);

	public void insertPayment(Map<String, Object> map);

	public List<FlightVO> flightListFilter(FlightVO flightVO);

//	public List<FlightVO> flightListFilter(String sortOption);

//	public int insertPassenger(List<FlightVO> flightList);
//
//	public int insertReservationSeat(List<FlightVO> flightList);

}
