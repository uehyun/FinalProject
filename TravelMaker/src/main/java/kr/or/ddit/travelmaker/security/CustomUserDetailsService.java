package kr.or.ddit.travelmaker.security;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.travelmaker.login.vo.CustomUser;
import kr.or.ddit.travelmaker.member.mapper.MemberMapper;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {
	@Inject
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		log.info("load User by username : " + username);
		
		MemberVO member = memberMapper.readByUser(username);
		
		if(member != null) {
			return new CustomUser(member);
		} else {
			throw new UsernameNotFoundException("");
		}
	}
}
