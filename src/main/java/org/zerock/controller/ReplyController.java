package org.zerock.controller;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;
import org.zerock.service.ReplyService;

import java.util.List;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

    // @Setter 주입을 이용하거나,
    // @AllArgsConstructor를 이용해서
    // ReplyService 타입의 객체를 필요로 하는 생성자를 만들어서 사용한다.

    private ReplyService service;

    // create()는 @PostMapping으로 POST 방식으로만 동작하도록 설계하고
    // consumes와 produces를 이용해서 json 방식의 데이터만 처리하도록 한다.
    // 그리고 문자열을 반환하도록 한다.
    @PostMapping(value = "/new",
                consumes = "application/json",
                produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
        log.info("ReplyVO: "+vo);

        int insertCount = service.register(vo);

        log.info("Reply INSERT COUNT: "+insertCount);

        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

/*    @GetMapping(value = "/pages/{bno}/{page}",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<List<ReplyVO>> getList(
            @PathVariable("page") int page,
            @PathVariable("bno") Long bno) {

        log.info("getList...............");
        Criteria cri = new Criteria(page, 10);

        log.info(cri);

        return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);

    }*/

    @GetMapping(value = "/pages/{bno}/{page}",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<ReplyPageDTO> getList(
            @PathVariable("page") int page,
            @PathVariable("bno") Long bno) {

        log.info("getList...............");
        Criteria cri = new Criteria(page, 10);

        log.info(cri);

        return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);

    }


    @GetMapping(value = "/{rno}",
            produces = {MediaType.APPLICATION_XML_VALUE,
                        MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {

        log.info("get : "+rno);

        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);

    }

    @DeleteMapping(value = "/{rno}",
                    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
        log.info("remove : "+rno);

        return service.remove(rno) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

    }


    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{rno}",
                    consumes = "application/json",
                    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(
                    @RequestBody ReplyVO vo,
                    @PathVariable("rno") Long rno) {
        vo.setRno(rno);

        log.info("rno : "+rno);
        log.info("modify : "+vo);

        return service.modify(vo) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }






}
