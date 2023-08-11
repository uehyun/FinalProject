package kr.or.ddit.travelmaker.host.vo;

import java.util.List;

import lombok.Data;

@Data
public class AccoptionVO {
	private String accNo;
	private String optionNo;
	private int optionCount;
	
	private String optionName;
	private String attGroupNo;
	
	private List<OptionitemVO> optionList;
}
