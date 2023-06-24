package kr.or.ddit.service.member;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.member.MemberMapper;
import kr.or.ddit.vo.MemberAuth;
import kr.or.ddit.vo.MemberVO;

@Service
public class MemberServiceImpl implements IMemberService {
	
	@Inject
	private MemberMapper memberMapper;
	
	@Override
	public MemberVO selectMemberBySocialId(MemberVO member) {
		//return memberMapper.selectMemberBySocialId(member);
		
		MemberVO vo = new MemberVO();
		
		List<MemberAuth> list = new ArrayList<MemberAuth>();
		MemberAuth auth = new MemberAuth();
		auth.setUserNo("1");
		auth.setAuth("ROLE_USER");
		list.add(auth);
		
		vo.setMemNo("1");
		vo.setAuthList(list);
		vo.setEnabled("1");
		vo.setMemEmail("abc");
		vo.setMemId("a001");
		
		return vo;
	}
}
