package org.zerock.mapper;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;

public interface ReplyMapper {


    public int insert(ReplyVO vo);

    public ReplyVO read(Long bno);

    public int delete(Long rno);

    public int update(ReplyVO reply);

    // xml로 처리할 때에는 지정된 cri와 bno를 모두 사용할 수 있다.
    public List<ReplyVO> getListWithPaging(@Param("cri")Criteria cri, @Param("bno") Long bno);

    public int getCountByBno(Long bno);

}
