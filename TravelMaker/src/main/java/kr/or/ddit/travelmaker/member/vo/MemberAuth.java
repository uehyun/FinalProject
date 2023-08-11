package kr.or.ddit.travelmaker.member.vo;

import lombok.Data;

@Data
public class MemberAuth {
	private String memNo;
	private String auth;
	
	public MemberAuth() {
		super();
	}
	
	public MemberAuth(String auth) {
		this.auth = auth;
	}
}
