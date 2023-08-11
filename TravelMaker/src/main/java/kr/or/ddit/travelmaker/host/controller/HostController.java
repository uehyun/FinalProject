package kr.or.ddit.travelmaker.host.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.travelmaker.host.service.IHostService;
import kr.or.ddit.travelmaker.host.vo.AcommodationVO;
import kr.or.ddit.travelmaker.host.vo.OptionitemVO;
import kr.or.ddit.travelmaker.member.service.IMemberService;
import kr.or.ddit.travelmaker.member.vo.MemberVO;
import kr.or.ddit.travelmaker.utils.ServiceResult;
import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/host")
@Slf4j
public class HostController {
	
	@Inject
	private IHostService hostService;
	
	@Inject
	private IMemberService memberService;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String accommodationForm(Model model, Principal principal) {
		
		MemberVO member = getMemNo(principal.getName());
//		MemberVO member = getMemNo("a001");
		
		// 상태가 register일 때 sideBar 숨김
		model.addAttribute("status", "r");
		model.addAttribute("member", member);
		
		Map<String, List<OptionitemVO>> selectOptionItems = hostService.selectOptionItems();
		for (String key : selectOptionItems.keySet()) {
			List<OptionitemVO> optionItems = selectOptionItems.get(key);
			model.addAttribute(key, optionItems);
		}
		
		return "host/accommodationForm";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateAccommodationForm(
			@RequestParam(value = "accNo") String accNo
			, @RequestParam(value="accCount", defaultValue="1") String accCount
			, Model model, Principal principal) {
		MemberVO member = getMemNo(principal.getName());
//		MemberVO member = getMemNo("a001");
		
		AcommodationVO acommodation = hostService.accommodationDetailByAccNo(accNo);
		
		Map<String, List<OptionitemVO>> selectOptionItems = hostService.selectOptionItems();
		for (String key : selectOptionItems.keySet()) {
			List<OptionitemVO> optionItems = selectOptionItems.get(key);
			model.addAttribute(key, optionItems);
		}
		
		model.addAttribute("status", "u");
		model.addAttribute("member", member);
		model.addAttribute("accCount", accCount);
		model.addAttribute("acommodation", acommodation);
		
		return "host/accommodationForm";
	}
	
	
	@PostMapping(value = "/register")
	public ResponseEntity<String> accommodationRegister(Authentication authentication, @RequestBody AcommodationVO acommodationVO) {
		boolean saveAndExitClicked = false;
		ServiceResult result = null;

		User user = (User) authentication.getPrincipal();
		String memNo = hostService.memNoById(user.getUsername());
//		String memNo = hostService.memNoById("a001");
		acommodationVO.setMemNo(memNo);
		log.info("check : " + acommodationVO.getIsUpdate());
		
		if (acommodationVO.getAccCount().equals("0")) {
			if (acommodationVO.getAccRegProcess().equals("true")) {
				result = hostService.insertAcommodation(acommodationVO);
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("1")) {
			result = hostService.SessionUpdate1(acommodationVO);
			return ResponseEntity.ok(acommodationVO.getAccNo());
		} else if (acommodationVO.getAccCount().equals("2")) {
			result = hostService.SessionUpdate2(acommodationVO);
			return ResponseEntity.ok(acommodationVO.getAccNo());
		} else if (acommodationVO.getAccCount().equals("4")) {
			result = hostService.insertTypeOption(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("5")) {
			result = hostService.updateConTypeOption(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("6")) {
			result = hostService.SessionUpdate6(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("7")) {
			result = hostService.insertTypeOption(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("8")) {
			result = hostService.SessionUpdate8(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok(acommodationVO.getAccNo());
			}
		} else if (acommodationVO.getAccCount().equals("9")) {
			result = hostService.SessionUpdate9(acommodationVO);
			if (result.equals(ServiceResult.OK)) {
				return ResponseEntity.ok("success");
			}
		}
		 
		if (!saveAndExitClicked) {
			// Check 여부를 가려서 체크를 안했을 시 지워버린다.
		}
		
		return ResponseEntity.ok(acommodationVO.getAccNo());
	}
	
	@RequestMapping(value = "/imgRegister", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> imgRegister(@RequestParam("files") List<MultipartFile> files, @RequestParam("accNo") String accNo, 
												@RequestParam("accCount") String accCount, HttpServletRequest req) {
		int count = 0;
		
		log.info("accNo -> " + accNo);
		log.info("accStatus -> " + accCount);
		AcommodationVO acommodationVO = new AcommodationVO();
		acommodationVO.setAccNo(accNo);
		acommodationVO.setAccCount(accCount);
		acommodationVO.setAccAttGroupNo(accNo);
		
		
		List<FileVO> fileList = new ArrayList<FileVO>();
		
		for (MultipartFile file : files) {
			count++;
			
			FileVO fileVO = new FileVO();
			String folder = "acommodationImage";
			fileVO.setAttGroupNo(accNo);
			
			try {
				fileVO.setFile(req, file, folder, accNo);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
			
			String saveFilePath = "/uploadFiles/" + folder + "/";
			fileVO.setAttPath(saveFilePath + fileVO.getSaveName());
			fileVO.setAttNo(count + "");
			
			fileList.add(fileVO);
			
			try {
				InputStream inputStream = new FileInputStream("D:" + fileVO.getAttPath());
				BufferedImage originalImage = ImageIO.read(inputStream);

				int thumbnailSize = 500;
				BufferedImage thumbnailImage = Scalr.resize(originalImage, Scalr.Method.AUTOMATIC, thumbnailSize);

				String thumbnailFolderPath = saveFilePath + "thumbnails\\";
				File thumbnailFolder = new File(thumbnailFolderPath);

				if (!thumbnailFolder.exists()) {
					thumbnailFolder.mkdirs();
				}

				String thumbnailFileName = "s_" + fileVO.getSaveName();
				String thumbnailPath = thumbnailFolderPath + "/" + thumbnailFileName;
				File thumbnailFile = new File(thumbnailPath);

				ImageIO.write(thumbnailImage, "JPEG", thumbnailFile);

				
				// 썸네일 작업까지 추가로 데이터 집어넣기
				FileVO SFileVO = new FileVO();
				SFileVO.setAttGroupNo(accNo);
				SFileVO.setAttNo(files.size() + count + "");
				SFileVO.setAttExt(getExtension(thumbnailFile));
				SFileVO.setOriginalName(fileVO.getOriginalName());
				SFileVO.setSaveName(thumbnailFileName);
				SFileVO.setAttSize(thumbnailFile.length());
				SFileVO.setAttPath(thumbnailFolderPath + thumbnailFileName);
				
				fileList.add(SFileVO);
				
				inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
		
		ServiceResult result = hostService.uploadImagesByaccNo(fileList, acommodationVO);
		if (result.equals(ServiceResult.OK)) {
			return ResponseEntity.ok(acommodationVO.getAccNo());
		}
		
		return ResponseEntity.ok(accNo);
	}

	private String getExtension(File thumbnailFile) {
		String fileName = thumbnailFile.getName();
		String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
		return extension;
	}
	
	public MemberVO getMemNo(String memId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		MemberVO member = memberService.selectMember(map);
		return member;
	}
}




















