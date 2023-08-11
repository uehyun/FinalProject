package kr.or.ddit.travelmaker.member.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {
	private String memNo;
	private String memId;
	private String memPw;
	private String memName;
	private String memPhone;
	private String memEmail;
	private String memDomain;
	private String memAgree;
	
	private String memRegDate;
	private String memModDate;
	private String memDelDate;
	private String enabled;
	private String memDel;
	private String memIntroduce;
	
	private MultipartFile imgFile;
	private String memProfilePath;
	private int blameCount;
	private String memPreLanguage;
	private String memPreCurrency;
	
	private List<MemberSocial> socialList;
	private List<MemberAuth> authList;
}
