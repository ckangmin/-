package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
"file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	
	@Autowired
	private BoardService service;
	
	//@Test
	public void testRegister() {
		// BoardVO를생성하고 service의 register 메서드를 이용
		
		BoardVO board=new BoardVO();
		board.setContent("레지스터 본문");
		board.setTitle("레지스터 제목");
		board.setWriter("레지스터 글쓴이");
		service.register(board);
	}
	//@Test
	public void serviceGetOne() {
		BoardVO boardOne=service.get(6L);
		log.info(boardOne);
	}
	
	public void serviceRemove() {
		service.remove(4L);
		log.info("delete 성공");
		
	}
	public void serviceModify() {
		// 수정 내역은 BoardVO에 담아서 보내야합니다.
		//BoardVO를 생성해 주시고 필요정보(bno, title, content);
		//를세팅해서 수정구문을 실행해주세요.
			
			BoardVO board=new BoardVO();
			board.setBno(3L);
			board.setTitle("update Test");
			board.setContent("updater");
			service.modify(board);
	}
	@Test
	public void serviceGetList() {
		List<BoardVO> boards = service.getList();
		boards.forEach(board -> {
			log.info(board);
		});
	}
}
