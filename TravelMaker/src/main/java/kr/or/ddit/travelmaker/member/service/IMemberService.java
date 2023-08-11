package kr.or.ddit.travelmaker.member.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;

public interface IMemberService {
	public ServiceResult insertMember(Map<String, Object> map);

	public MemberVO selectMember(Map<String, Object> map);

	public ServiceResult profileUpdate(HttpServletRequest req, MemberVO vo);

	public ServiceResult updatePassword(Map<String, Object> map);

	public MemberVO findData(Map<String, Object> map);

	public long sendMessage(String memPhone, String str);

	public ServiceResult updateSocial(Map<String, Object> map);

	public ServiceResult updatePrefer(MemberVO vo);
}
