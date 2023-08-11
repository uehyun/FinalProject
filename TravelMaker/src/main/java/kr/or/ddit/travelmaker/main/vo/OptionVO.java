package kr.or.ddit.travelmaker.main.vo;

import java.util.List;

import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import lombok.Data;

@Data
public class OptionVO {
	private String accNo;
	private String optionNo;
	private int optionCount;
	private String optionName;
	private String attGroupNo;
	
	private List<OptionitemVO>  optionList;
}
