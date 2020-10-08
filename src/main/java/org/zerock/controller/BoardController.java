package org.zerock.controller;


import lombok.AllArgsConstructor;

import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria cri, Model model) {
        log.info("list");


        // service의 getList() 메서드를 호출해서
        // list라는 이름에 담아준다.
        // model에 객체를 담아 주면, 뷰까지 전달될 수 있다.
        log.info("list : "+cri);
        model.addAttribute("list", service.getList(cri));
        // pageDTO를 사용할 수 있도록 model 담아서 화면에 전달해 주어야 한다.
        // 123은 전체 데이터 수에 대한 처리가 당장은 안 되어 있기 때문에 임의로 담아 준 것이다.

        int total = service.getTotal(cri);

        model.addAttribute("pageMaker", new PageDTO(cri, total));

    }


    // register는 입력 페이지를 보여주는 역할만을 수행한다.
    // 이런 식으로 get 방식으로 url이 들어오면
    // 스프링은 알아서 views/board 에서 그 url에 해당하는 .jsp를 찾는다.
    @GetMapping("/register")
    public void register() {

    }


    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {

        log.info("register: "+board);

        service.register(board);

        // 등록 후 result 라는 이름에 board에 번호를 넣어준다.
        rttr.addFlashAttribute("result", board.getBno());

        return "redirect:/board/list";

    }

    // 아래처럼 사용하면
    // get과 modify 둘 다 여기서 처리할 수 있게 된다.
/*    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, Model model) {
        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));

    }*/

    // pageNum과 amount를 목록 페이지에서 조회 페이지로 넘길 때 보내는 것으로 바꾸었기 때문에
    // 아래처럼 Criteria cri가 추가되었다.
    // @ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담아준다.
    // 물론 @ModelAttribute를 사용하지 않아도 controller에서 화면으로 파라미터가 된 객체는 전달이 된다.
    // 다만 좀 더 명시적으로 전달하기 위해서..
    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {

        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));

    }



/*    @PostMapping("/modify")
    public String modify(BoardVO board, RedirectAttributes rttr) {
        log.info("modify: "+board);

        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list";

    }*/

/*    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("modify: "+board);

        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }

        // RedirectAttributes는 딱 한 번만 유효하다.
        // 여기에 pageNum과 amount를 추가해줬으니
        // board/list로 갈 때 url은
        // localhost:8081/board/list?pageNum=00&amount=00 이 될 것이다.
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/list";

    }*/


    @PostMapping("/modify")
    public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
        log.info("modify: "+board);

        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }



        return "redirect:/board/list"+cri.getListLink();

    }


/*    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {

        log.info("remove...."+bno);
        if(service.remove(bno)) {
            rttr.addFlashAttribute("result", "success");

        }

        return "redirect:/board/list";


    }*/

/*    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

        log.info("remove...."+bno);
        if(service.remove(bno)) {
            rttr.addFlashAttribute("result", "success");

        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/list";

    }*/

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {

        log.info("remove...."+bno);
        if(service.remove(bno)) {
            rttr.addFlashAttribute("result", "success");

        }
        return "redirect:/board/list"+cri.getListLink();

    }

}
