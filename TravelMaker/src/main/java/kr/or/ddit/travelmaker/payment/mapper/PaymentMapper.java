package kr.or.ddit.travelmaker.payment.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
	public List<Map<String, Object>> selectAllPayment(Map<String, Object> map);
	
	public Map<String, Object> selectAccReceipt(String paymentNo);
	
	public Map<String, Object> getHost(String accNo);

	public Map<String, Object> selectFlightReceipt(String paymentNo);

	public List<Map<String, Object>> selectPassenger(String freservationNo);
}
