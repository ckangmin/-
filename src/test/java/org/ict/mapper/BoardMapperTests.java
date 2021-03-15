package org.ict.mapper;

import java.util.List;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Autowired
	private BoardMapper mapper;
	
	//@Test
	public void testGetList() {
		List<BoardVO> boards = mapper.getList();
		boards.forEach(board -> {
			log.info(board);
		});
	}
	
	//@Test
	public void testInsert() {
		//하기 BoardVO객체를 다음 조건으로 완성시켜 주세요
		//content: "insert본문"
		//title :"insert 제목"
		//writer:"insert글쓴이"
		BoardVO board=new BoardVO();
		board.setContent("insert 본문");
		board.setTitle("insert 제목");
		board.setWriter("insert 글쓴이");
		mapper.insert(board);
	}
	
	public void getOne() {
		BoardVO boardOne=mapper.read(6);
		log.info(boardOne);
	}
	@Test
	public void testDelete() {
		mapper.delete(1);
		log.info("delete 성공");
		testGetList();
	}
}
