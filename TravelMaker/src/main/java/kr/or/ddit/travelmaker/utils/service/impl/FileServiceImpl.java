package kr.or.ddit.travelmaker.utils.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.travelmaker.utils.mapper.FileMapper;
import kr.or.ddit.travelmaker.utils.service.FileService;
import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Service
public class FileServiceImpl implements FileService {
	
	@Inject
	private FileMapper fileMapper;

	@Override
	public void insertFile(List<FileVO> fileList) {
		for(int i = 1; i <= fileList.size(); i++) {
			FileVO fileVO = fileList.get(i-1);
			fileVO.setAttNo(String.valueOf(i));
			fileMapper.insertFile(fileVO);
		}
	}

	@Override
	public List<FileVO> getSaveName(String groupNo) {
		return fileMapper.getSaveName(groupNo);
	}
}
