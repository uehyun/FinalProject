package kr.or.ddit.travelmaker.login.oauth;

public interface SnsUrls {
	//토큰을 받아오는 URL
	static final String NAVER_ACCESS_TOKEN = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	static final String NAVER_AUTH = "https://nid.naver.com/oauth2.0/authorize";
	
	//받아온 토큰을 들고 정보를 요청하는 URL
	static final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";
}
