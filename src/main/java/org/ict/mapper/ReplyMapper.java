package org.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ict.domain.ReplyVO;

public interface ReplyMapper {
	public List<ReplyVO> getList(Long bno);
	public void create(ReplyVO vo);
	public void update(ReplyVO vo);
	public void delete(int rno);
	public Long getBno(int rno);
	public void deleteAll(Long bno);
}
