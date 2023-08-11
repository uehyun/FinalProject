package kr.or.ddit.travelmaker.flight.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.alarm.mapper.AlarmMapper;
import kr.or.ddit.travelmaker.alarm.vo.AlarmVO;
import kr.or.ddit.travelmaker.flight.mapper.FlightMapper;
import kr.or.ddit.travelmaker.flight.service.IFlightService;
import kr.or.ddit.travelmaker.flight.vo.FlightVO;

@Service
public class FlightServiceImpl implements IFlightService{
	
	@Inject
	private FlightMapper flightMapper;
	
	@Inject
	private AlarmMapper alarmMapper;
	
	@Override
	public List<FlightVO> getAirport() {
		return flightMapper.getAirport();
	}
	
	@Override
	public int insertFlightData(List<FlightVO> flightList) {
		int res = 0;
		for (int i = 0; i < flightList.size(); i++) {
			res = flightMapper.insertFlightData(flightList.get(i));
		}
		return res;
	}
	
	@Override
	public List<FlightVO> getAirportByName(String flightName) {
		return flightMapper.getAirportByName(flightName);
	}
	
	@Override
	public List<FlightVO> flightList(FlightVO flightVO) {
		int itemsPerPage = flightVO.getItemsPerPage();
		int startNo = flightVO.getStartNo();
        int endNo = startNo + itemsPerPage - 1;
        
        flightVO.setStartNo(startNo);
        flightVO.setEndNo(endNo);
		
		return flightMapper.flightList(flightVO);
	}
	
	@Override
	public List<FlightVO> flightListFilter(FlightVO flightVO) {
		int itemsPerPage = flightVO.getItemsPerPage();
		System.out.println("serItemsPerPage: " + itemsPerPage);
		int startNo = flightVO.getStartNo();
		System.out.println("serStartNo : " + startNo);
        int endNo = startNo + itemsPerPage - 1;
        System.out.println("serEndNo : " + endNo);
        
        flightVO.setStartNo(startNo);
        flightVO.setEndNo(endNo);
        
		return flightMapper.flightListFilter(flightVO);
	}

	@Override
	public List<FlightVO> selectSeats(String flightNo) {
		return flightMapper.selectSeats(flightNo);
	}

	@Override
	public List<FlightVO> reservationDetail(String flightNo) {
		return flightMapper.reservationDetail(flightNo);
	}

	@Override
	public void insertReservation(List<FlightVO> flightList) {
		flightMapper.insertReservation(flightList.get(0));
		for (int i = 1; i < flightList.size(); i++) {
			flightList.get(i).setFreservationNo(flightList.get(0).getFreservationNo());
		}
		for (int i = 0; i < flightList.size(); i++) {
			flightMapper.insertPassenger(flightList.get(i));
			flightMapper.insertReservationSeat(flightList.get(i));
		}
		
	}

	@Override
	public void insertPayment(Map<String, Object> map) {
		flightMapper.insertPayment(map);
		
		AlarmVO vo = new AlarmVO();
		vo.setAlarmType("비행기 예약");
		vo.setAlarmUrl("/member/payment");
		vo.setAlarmContent("비행기가 예약되었습니다.");
		vo.setMemNo(map.get("memNo").toString());
		alarmMapper.insertAlarm(vo);
	}
}

