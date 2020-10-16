package org.zerock.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import java.util.List;

public interface BoardMapper {


    /*@Select("select * from tbl_board where bno > 0")*/
    public List<BoardVO> getList();

    public List<BoardVO> getListWithPaging(Criteria cri);

    // insert만 처리되고 생성된 pk 값을 알 필요가 없는 경우
    public void insert(BoardVO board);
    // insert문이 실행되고 생성된 pk 값을 알아야 하는 경
    public void insertSelectKey(BoardVO board);


    // read 처리
    public BoardVO read(Long bno);

    // delete 처리
    public int delete(Long bno);

    // update 처리
    public int update(BoardVO board);

    // 게시물의 목록과 전체 데이터 수를 구하는 작업은 Criteria가 필요하지 않지만
    //
    public int getTotalCount(Criteria cri);

    public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
