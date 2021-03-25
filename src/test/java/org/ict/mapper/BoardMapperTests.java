package org.ict.mapper;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
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
		BoardVO boardOne=mapper.read(6L);
		log.info(boardOne);
	}
	//@Test
	public void testDelete() {
		mapper.delete(1L);
		log.info("delete 성공");
		testGetList();
	}
	//@Test
	public void testUpdate() {
	// 수정 내역은 BoardVO에 담아서 보내야합니다.
	//BoardVO를 생성해 주시고 필요정보(bno, title, content);
	//를세팅해서 수정구문을 실행해주세요.
		
		BoardVO board=new BoardVO();
		board.setBno(3L);
		board.setTitle("update Test");
		board.setContent("updater");
		int count =mapper.update(board);
		log.info("번경된 컬럼수 :" +count);
	
	


	}

//	@Test
//	public void limit() {
//		Criteria cri= new Criteria();
//		cri.setPage(1);
//		cri.setNumber(2);
//		List<BoardVO> boards = mapper.listPage(cri);
//		
//		boards.forEach(board -> {
//			log.info(board);
//		});
//	}
}
