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
	@Test
	public void serviceRemove() {
		service.remove(4L);
		if(service.get(4L)==null) {
		log.info("delete 성공");
		}
	}
	//@Test
	public void serviceModify() {
		//실제 수정로직은 수정 이전에
		//1. 특정 글의 전체 내용을 가져와 수정창에 뿌린다.
		//2. 뿌려진 내용 중 수정하고 싶은 내용을 수정한다.
		//3. 수정된 내용을 제출버튼을 통해 최종 반영한다.
		//따라서 위 로직을 따라가기 위해 이번에는
		//BoardVO를 생성하는 대신
		//get메서드를 활용해서 실제 글 내용을 먼저 가져온다음
		//수정된 내용이 DB에 반영되도록 하겠다.
		
			
			BoardVO board=service.get(4L);
			// get으로 가져온 번호의 게시글이 없는 경우 중지
			if(board==null) {
				return;
			}
			board.setTitle("Modify반영제목");
			board.setContent("Modify반영 본문");
			service.modify(board);
			log.info(board);
	}
	//@Test
	public void serviceGetList() {
		service.getList().forEach(board -> {
			log.info(board);
		});
	}
}
