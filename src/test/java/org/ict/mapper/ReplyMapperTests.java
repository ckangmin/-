package org.ict.mapper;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.ReplyVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Autowired
	private ReplyMapper mapper;
	

	@Test
	public void testGetList() {
		List<ReplyVO> vo = mapper.getList(2L);
		vo.forEach(board -> {
			log.info(board);
		});
	}
	
	//@Test
	public void testInsert() {
		//하기 BoardVO객체를 다음 조건으로 완성시켜 주세요
		//content: "insert본문"
		//title :"insert 제목"
		//writer:"insert글쓴이"
		ReplyVO vo=new ReplyVO();
		vo.setBno(2L);
		vo.setReplyer("나다");
		vo.setReplytext("테스트 성공");
		mapper.create(vo);
	}
	

	//@Test
	public void testDelete() {
		mapper.delete(11);
	}
	//@Test
	public void testUpdate() {
		//수정 내역은 BoardVO에 담아서 보내야합니다.
	//BoardVO를 생성해 주시고 필요정보(bno, title, content);
	//를세팅해서 수정구문을 실행해주세요.
		
		ReplyVO vo=new ReplyVO();
		vo.setRno(11);
		vo.setReplytext("수정성공");

		mapper.update(vo);
	}

}
