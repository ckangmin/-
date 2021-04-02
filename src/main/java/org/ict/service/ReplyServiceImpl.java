package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private BoardMapper boardMapper;
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
		Long bno = (long)vo.getBno();
		boardMapper.updateReplyCount(bno, +1);
	}

	@Override
	public List<ReplyVO> listReply(Long bno) {
		// TODO Auto-generated method stub
		return mapper.getList(bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		 mapper.update(vo);
		
	}
	@Transactional
	@Override
	public void removeReply(int rno) {
		mapper.delete(rno);
		Long bno=mapper.getBno(rno);
		boardMapper.updateReplyCount(bno, -1);;
		
	}

}
