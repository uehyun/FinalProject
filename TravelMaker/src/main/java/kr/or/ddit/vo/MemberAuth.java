package kr.or.ddit.vo;

import lombok.Data;

@Data
public class MemberAuth {
	private String userNo;
	private String auth;
	
	public MemberAuth() {
		super();
	}
	
	public MemberAuth(String auth) {
		this.auth = auth;
	}
}
