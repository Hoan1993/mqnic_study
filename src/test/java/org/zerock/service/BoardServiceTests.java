package org.zerock.service;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardServiceTests {

    /*@Setter(onMethod = @_({@Autowired}))*/
    @Autowired
    private BoardService service;

    @Test
    public void testExist() {
        // 이 첫번째 테스트의 목적은 BoardService 객체가 제대로 주입이 가능한지
        // 확인하는 작업.

        log.info(service);
        assertNotNull(service);

    }


    @Test
    public void testRegister() {
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성하는 글");
        board.setContent("새로 작성하는 내용");
        board.setWriter("newbie");

        service.register(board);
        log.info("생성된 게시물의 번호 : "+board.getBno());

    }

/*    @Test
    public void testGetList() {
        service.getList().forEach(board -> log.info(board));

    }*/

    @Test
    public void testGetList() {
        service.getList(new Criteria(2,10)).forEach(board -> log.info(board));

    }

    @Test
    public void testGet() {
        log.info(service.get(1L));
    }

    @Test
    public void testDelete() {
        log.info(service.remove(2L));
    }

    @Test
    public void testUpdate() {


        BoardVO board = service.get(1L);
        if(board ==null) {
            return;
        }
        board.setTitle("제목 수정되었습니다.");
        log.info("MODIFY RESULT: "+service.modify(board));
    }
}
