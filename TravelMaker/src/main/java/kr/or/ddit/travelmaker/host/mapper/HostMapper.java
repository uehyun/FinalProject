package kr.or.ddit.travelmaker.host.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.HostManageVO;
import kr.or.ddit.travelmaker.host.vo.AccoptionVO;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Mapper
public interface HostMapper {

	public String memNoById(String memName);

	public int insertAcommodation(AcommodationVO acommodationVO);

	public int SessionUpdate1(AcommodationVO acommodationVO);

	public int SessionUpdate2(AcommodationVO acommodationVO);

	public int SessionUpdate3(AcommodationVO acommodationVO);

	public int uploadImagesByaccNo(List<FileVO> fileList);

	public int SessionOptionUpdate(AcommodationVO acommodationVO);

	public List<OptionitemVO> facOptionItems();
	public List<OptionitemVO> typeOptionItems();
	public List<OptionitemVO> secOptionItems();
	public List<OptionitemVO> cotOptionItems();
	public List<OptionitemVO> danOptionItems();

	public int insertTypeOption(List<AccoptionVO> list);

	public int SessionUpdate6(AcommodationVO acommodationVO);

	public int SessionUpdate8(AcommodationVO acommodationVO);

	public int SessionUpdate9(AcommodationVO acommodationVO);

	public int updateConTypeOption(AccoptionVO accoptionVO);

	
	public AcommodationVO accommodationDetailByAccNo(String accNo);
	public List<AccoptionVO> accommodationOptionsByAccNo(String accNo);
	public int getRole(String memNo);
	public int insertRole(String memNo);

}
