package kr.or.ddit.travelmaker.member.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.travelmaker.member.mapper.MemberMapper;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberAuth;
import kr.or.ddit.travelmaker.member.vo.MemberSocial;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import net.nurigo.java_sdk.api.Message;

@Service
public class MemberServiceImpl implements IMemberService {

	@Inject
	private MemberMapper memberMapper;

	@Inject
	private PasswordEncoder pe;
	
	@Transactional(rollbackFor=Exception.class)
	@Override
	public ServiceResult insertMember(Map<String, Object> map) {
		ServiceResult result = null;
		
		MemberVO member = new MemberVO();
		
		if("N".equals(map.get("isSocial").toString())) {
			member.setMemId(map.get("memId").toString());
			member.setMemPw(map.get("memPw").toString());
			member.setMemName(map.get("memName").toString());
			member.setMemPhone(map.get("memPhone").toString());
			member.setMemEmail(map.get("memEmail").toString() + map.get("domain").toString());
		} else {
			member.setMemId(map.get("memId").toString());
			member.setMemPw(map.get("memPw").toString());
			member.setMemName(map.get("memName").toString());
			member.setMemEmail(map.get("memEmail").toString());
		}
		
		// 비밀번호 암호화
		String encodedPW = pe.encode(member.getMemPw());
		member.setMemPw(encodedPW);

		// 권한 부여
		List<MemberAuth> authList = new ArrayList<MemberAuth>();
		MemberAuth auth = new MemberAuth();
		auth.setAuth("ROLE_MEMBER");
		authList.add(auth);
		member.setAuthList(authList);
		map.put("authList", authList);
		
		List<MemberSocial> socialList = new ArrayList<MemberSocial>();
		socialList.add(new MemberSocial(member.getMemNo(), "GOOGLE", "N"));
		socialList.add(new MemberSocial(member.getMemNo(), "NAVER", "N"));
		socialList.add(new MemberSocial(member.getMemNo(), "KAKAO", "N"));
		member.setSocialList(socialList);
		
		int res = memberMapper.insertMember(member);
		map.put("memNo", member.getMemNo());
		
		if (res > 0) {
			if("Y".equals(map.get("isSocial").toString())) {
				memberMapper.updateSocial(map);
			}
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}

		return result;
	}
	
	@Override
	public MemberVO selectMember(Map<String, Object> map) {
		return memberMapper.selectMember(map);
	}
	
	@Override
	public ServiceResult profileUpdate(HttpServletRequest req, MemberVO vo) {
		ServiceResult res = null;

		// 프로필 이미지
		String uploadPath = "D:\\uploadFiles\\profile";
		File file = new File(uploadPath);

		if (!file.exists()) {
			file.mkdirs();
		}

		MultipartFile imgFile = vo.getImgFile();

		if(imgFile.getOriginalFilename() != null && !imgFile.getOriginalFilename().equals("")) {
			String fileName = UUID.randomUUID().toString();
			fileName += "_" + imgFile.getOriginalFilename();
			uploadPath += "/" + fileName;
			
			try {
				imgFile.transferTo(new File(uploadPath));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			vo.setMemProfilePath("/uploadFiles/profile/" + fileName);
		}
		
		String email = vo.getMemEmail() + vo.getMemDomain();
		
		vo.setMemEmail(email);
		
		int status = memberMapper.profileUpdate(vo);

		if (status > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult updatePassword(Map<String, Object> map) {
		ServiceResult res = null;
		
		String pw = map.get("memPw").toString();
		map.put("encodedPw", pe.encode(pw));
		
		int status = memberMapper.updatePassword(map);
		
		if(status > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public MemberVO findData(Map<String, Object> map) {
		return memberMapper.findData(map);
	}

	@Override
	public long sendMessage(String memPhone, String str) {
		long res = 0;
		
		String apiKey = "";
	    String apiSecret = "";
	    Message coolsms = new Message(apiKey, apiSecret);

	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", memPhone);
	    params.put("from", "");
	    params.put("type", "SMS");
	    params.put("text", "인증번호는 " + "[" + str + "] 입니다.");
	    params.put("app_version", "test app 1.2"); 
		
	    try {
			JSONObject result = coolsms.send(params);
			System.out.println(result);
			res = (long) result.get("success_count");
		} catch (Exception e) {
			e.printStackTrace();
			res = 0;
		}
	    
		return res;
	}

	@Override
	public ServiceResult updateSocial(Map<String, Object> map) {
		ServiceResult res = null;
		
		int result = memberMapper.updateSocial(map);
		
		if(result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	@Override
	public ServiceResult updatePrefer(MemberVO vo) {
		ServiceResult res = null;
		
		int result = memberMapper.updatePrefer(vo);
		
		if(result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}
}
