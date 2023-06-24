package kr.or.ddit.service.member;

import kr.or.ddit.vo.MemberVO;

public interface IMemberService {
	public MemberVO selectMemberBySocialId(MemberVO member);
}
