package kr.or.ddit.travelmaker.utils.vo;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileVO {
	private String attGroupNo;
	private String attNo;
	private String attExt;
	private String originalName;
	private String saveName;
	private Long attSize;
	private String attRegDate;
	private String attPath;
	
	public void setFile(HttpServletRequest req, MultipartFile file, String folderName, String group) {
		this.attGroupNo = group;
		this.attExt = file.getContentType();
		this.originalName = file.getOriginalFilename();
		this.saveName = UUID.randomUUID() + "_" + originalName;
		this.attSize = file.getSize();
		
//		String filePath = req.getServletContext().getRealPath("/resources/" + folderName);
		String filePath = "D:\\uploadFiles\\" + folderName;
		File folder = new File(filePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		filePath = filePath + "/" + saveName;
		
		try {
			file.transferTo(new File(filePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		this.attPath = "\\uploadFiles\\" + folderName + "\\" + saveName;
	}
}
