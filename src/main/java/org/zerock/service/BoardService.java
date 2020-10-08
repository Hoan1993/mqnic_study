package org.zerock.service;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import java.util.List;

public interface BoardService {

    // 컨트롤러에서 이 서비스에 있는 기능을 활용해 비즈니스 로직을 처리할 것.

    // 등록 기능, 매개변수로 boardVO를 받아서, 정보 입력
    public void register(BoardVO boardVO);

    // 조회 기능
    public BoardVO get(Long bno);

    // 수정 기능
    public boolean modify(BoardVO board);

    // 삭제 기능
    public boolean remove(Long bno);

    // 전체 데이터를 가져오는 기능
    /*public List<BoardVO> getList();*/

    public List<BoardVO> getList(Criteria cri);

    public int getTotal(Criteria cri);


}
