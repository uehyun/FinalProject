package kr.or.ddit.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mapper.member.MemberMapper;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {
	@Inject
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		log.info("load User by username : " + username);
		
		MemberVO member = memberMapper.readByUserId(username);
		
		if(member == null) {
			throw new UsernameNotFoundException("없는 회원입니다. 다시 확인해 주세요.");
		}
		
		return new CustomUser(member);
	}
}
