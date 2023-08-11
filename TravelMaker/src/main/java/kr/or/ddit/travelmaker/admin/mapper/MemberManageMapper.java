package kr.or.ddit.travelmaker.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.travelmaker.admin.vo.BlameVO;
import kr.or.ddit.travelmaker.admin.vo.MemberManageVO;

@Mapper
public interface MemberManageMapper {
	public List<MemberManageVO> list();
	public List<BlameVO> blameList();
	public int okUpdate(BlameVO blameVO);
	public int noUpdate(BlameVO blameVO);
}
