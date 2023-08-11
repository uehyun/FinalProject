package kr.or.ddit.travelmaker.flight.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.flight.vo.FlightVO;

@Mapper
public interface FlightMapper {

	public List<FlightVO> getAirport();

	public int insertFlightData(FlightVO flightVO);

	public List<FlightVO> getAirportByName(String flightName);
	
	public List<FlightVO> flightList(FlightVO flightVO);

	public List<FlightVO> selectSeats(String flightNo);

	public List<FlightVO> reservationDetail(String flightNo);

	public void insertReservation(FlightVO flightVO);

	public void insertPassenger(FlightVO flightVO);

	public void insertReservationSeat(FlightVO flightVO);

	public void insertPayment(Map<String, Object> map);

	public List<FlightVO> flightListFilter(FlightVO flightVO);

}
