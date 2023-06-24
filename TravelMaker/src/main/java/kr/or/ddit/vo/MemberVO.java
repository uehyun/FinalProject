package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String memNo;
	private String memId;
	private String memPw;
	private String memName;
	private String memPhone;
	private String memEmail;
	private String memAgree;
	
	private Date memRegdate;
	private Date memModdate;
	private Date memDeldate;
	private String memIshost;
	private String memIsdel;
	private String socialNo;
	private String enabled;
	private List<MemberAuth> authList;
}
