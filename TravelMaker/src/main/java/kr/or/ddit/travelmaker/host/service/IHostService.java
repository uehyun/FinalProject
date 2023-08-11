package kr.or.ddit.travelmaker.host.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

public interface IHostService {

	public String memNoById(String memName);

	public ServiceResult insertAcommodation(AcommodationVO acommodationVO);

	public ServiceResult SessionUpdate1(AcommodationVO acommodationVO);

	public ServiceResult SessionUpdate2(AcommodationVO acommodationVO);

	public ServiceResult uploadImagesByaccNo(List<FileVO> fileList, AcommodationVO acommodationVO);

	public Map<String, List<OptionitemVO>> selectOptionItems();

	public ServiceResult insertTypeOption(AcommodationVO acommodationVO);

	public ServiceResult SessionUpdate6(AcommodationVO acommodationVO);

	public ServiceResult SessionUpdate8(AcommodationVO acommodationVO);

	public ServiceResult SessionUpdate9(AcommodationVO acommodationVO);

	public ServiceResult updateConTypeOption(AcommodationVO acommodationVO);

	public AcommodationVO accommodationDetailByAccNo(String accNo);

}
