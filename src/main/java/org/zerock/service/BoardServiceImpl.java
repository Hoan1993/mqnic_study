package org.zerock.service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import java.util.List;

// @Service라는 어노테이션
// 이 컴포넌트가 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시.


@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

    // 스프링 4.3부터 단일 파라미터를 받는 생성자의 경우
    // 필요한 파라미터를 자동을 주입할 수 있다.
    @Setter(onMethod = @_({@Autowired}))
    private BoardMapper mapper;

    @Override
    public void register(BoardVO board) {

        log.info("register......"+board);
        mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(Long bno) {

        log.info("read bno : "+mapper.read(bno));

        return mapper.read(bno);
    }

    @Override
    public boolean modify(BoardVO board) {

        log.info("modify....."+board);
        return mapper.update(board) ==1;
    }

    @Override
    public boolean remove(Long bno) {
        log.info("removce....."+bno);
        return mapper.delete(bno) == 1;
    }

/*    @Override
    public List<BoardVO> getList() {
        log.info("getList.......");

        return mapper.getList();
    }*/

    @Override
    public List<BoardVO> getList(Criteria cri) {
        log.info("get List with criteria : "+cri);

        return mapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(Criteria cri) {
        return mapper.getTotalCount(cri);
    }
}
