package kr.or.ddit.travelmaker.member.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	public MemberVO readByUser(String username);

	public int insertMember(MemberVO member);

	public MemberVO selectMember(Map<String, Object> map);
	
	public int profileUpdate(MemberVO member);

	public int updatePassword(Map<String, Object> map);

	public MemberVO findData(Map<String, Object> map);

	public int updateSocial(Map<String, Object> map);

	public int updatePrefer(MemberVO vo);
}
