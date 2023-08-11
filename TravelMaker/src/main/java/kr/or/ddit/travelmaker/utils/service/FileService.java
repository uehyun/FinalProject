package kr.or.ddit.travelmaker.utils.service;

import java.util.List;

import kr.or.ddit.travelmaker.utils.vo.FileVO;

public interface FileService {
	public void insertFile(List<FileVO> fileList);
	
	public List<FileVO> getSaveName(String groupNo);
}
