package kr.or.ddit.travelmaker.utils.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.utils.vo.FileVO;

@Mapper
public interface FileMapper {
	public void insertFile(FileVO vo);
	
	public List<FileVO> getSaveName(String groupNo);
	
	public int deleteFile(String attGroupNo);
}
