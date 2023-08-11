package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.ireplyVO;

@Mapper
public interface AdminRepMapper {
	public int insert(ireplyVO vo);
	public List<ireplyVO> list(String inqBoardNo);
	public int replyCnt(String inqBoardNo);
//	public int remove(String inqBoardNo);
//	public int modify(ireplyVO vo);
	public int delete(ireplyVO vo);
	public int update(ireplyVO vo);
}
