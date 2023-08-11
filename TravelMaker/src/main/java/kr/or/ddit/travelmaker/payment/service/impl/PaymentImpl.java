package kr.or.ddit.travelmaker.payment.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.payment.mapper.PaymentMapper;
import kr.or.ddit.travelmaker.payment.service.IPaymentService;
import kr.or.ddit.travelmaker.utils.mapper.FileMapper;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Service
public class PaymentImpl implements IPaymentService {
	@Inject
	private PaymentMapper paymentMapper;
	
	@Inject
	private FileMapper fileMapper;
	
	@Override
	public List<Map<String, Object>> selectAllPayment(Map<String, Object> map) {
		List<Map<String,Object>> list = paymentMapper.selectAllPayment(map);
		for (Map<String, Object> result : list) {
			if(!"notatt".equals(result.get("ATTPATH").toString())) {
				List<FileVO> saveName = fileMapper.getSaveName(result.get("ATTPATH").toString());
				result.put("ATTPATH", saveName.get(0).getAttPath());
			}
		}
		
		return list;
	}
	
	@Override
	public Map<String, Object> selectAccReceipt(String paymentNo) {
		Map<String, Object> map = paymentMapper.selectAccReceipt(paymentNo);
		
		List<FileVO> list = fileMapper.getSaveName(map.get("GROUPNO").toString());
		
		map.put("ATTPATH", list.get(0).getAttPath());
		
		return map;
	}

	@Override
	public Map<String, Object> getHost(String accNo) {
		return paymentMapper.getHost(accNo);
	}

	@Override
	public Map<String, Object> selectFlightReceipt(String paymentNo) {
		return paymentMapper.selectFlightReceipt(paymentNo);
	}

	@Override
	public List<Map<String, Object>> selectPassenger(String freservationNo) {
		return paymentMapper.selectPassenger(freservationNo);
	}
}
