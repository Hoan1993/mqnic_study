package org.zerock.service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
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
    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private BoardAttachMapper attachMapper;


    @Override
    public void register(BoardVO board) {

        log.info("register......"+board);
        mapper.insertSelectKey(board);

        if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
            return;
        }

        board.getAttachList().forEach(attach -> {
            attach.setBno(board.getBno());
            // 위에서 tbl_board에 데이터를 추가하고,
            // 그 다음 tbl_board에서 bno를 얻어온다.
            // tbl_attach 테이블에 데이터를 추가한다.
            attachMapper.insert(attach);
        });

    }

    @Override
    public BoardVO get(Long bno) {

        log.info("read bno : "+mapper.read(bno));

        return mapper.read(bno);
    }

    @Transactional
    @Override
    public boolean modify(BoardVO board) {

        log.info("modify....."+board);
        // 그 번호에 해당하는 첨부파일을 다 지운다. DB에서.
        attachMapper.deleteAll(board.getBno());

        // DB에 다시 올린다. 수정된 첨부파일을
        boolean modifyResult = mapper.update(board) == 1;

        if(modifyResult && board.getAttachList() != null && board.getAttachList().size() >0) {
            board.getAttachList().forEach(attach -> {
                attach.setBno(board.getBno());
                attachMapper.insert(attach);
            });
        }


        return modifyResult;
    }

/*    @Override
    public boolean remove(Long bno) {
        log.info("removce....."+bno);
        return mapper.delete(bno) == 1;
    }*/

    @Transactional
    @Override
    public boolean remove(Long bno) {
        log.info("remove...."+bno);
        attachMapper.deleteAll(bno);
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

    @Override
    public List<BoardAttachVO> getAttachList(Long bno) {
        log.info("get Attach list by bno "+bno);

        return attachMapper.findByBno(bno);
    }
}
