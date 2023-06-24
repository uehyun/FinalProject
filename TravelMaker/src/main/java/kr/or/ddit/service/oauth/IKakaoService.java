package kr.or.ddit.service.oauth;

import kr.or.ddit.vo.MemberVO;

public interface IKakaoService {
	public String getToken(String code);
	public MemberVO getUserInfo(String access_token);
}
