package org.zerock.controller;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import sun.reflect.annotation.ExceptionProxy;


// BoardController를 테스트하기 위한 코드
// was를 실행하지 않고도, 테스트가 가능하다.

// @WebAppConfiguration은 서블릿의 ServletContext를 이용하기 위해서이다.
// 스프링에서는 webapplicationcontext라는 존재를 이용하기 위해서이다.

// @Before는 모든 테스트 전에 매번 실행되는 메서드이다.
// MockMvc는 말 그대로 가짜 mvc이다.
// 가짜로 url과 파라미터 등을 브라우저에서 사용하는 것처럼 만들어서 controller를 실행해 볼 수 있다.


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // Test for controller
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class,
                                org.zerock.config.ServletConfig.class})
@Log4j
public class BoardControllerTests {


    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext ctx;

    private MockMvc mockMvc;


    @Before
    public void setUp() {
        // mockMvc를 제대로 사용하면서
        // build를 해야 하는 모양.
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }


    @Test
    public void testList() throws Exception {
        log.info(
                mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
                .andReturn()
                .getModelAndView()
                .getModelMap()

        );


    }

    @Test
    public void testRegister() throws Exception {

        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
                .param("title", "테스트 새글 제목")
                .param("content", "테스트 새글 내용")
                .param("writer", "user00")
            ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);

    };

    @Test
    public void testGet() throws Exception {
        log.info(mockMvc.perform(MockMvcRequestBuilders
                .get("/board/get")
                .param("bno", "1"))
                .andReturn()
                .getModelAndView().getModelMap()
        );

    }

    @Test
    public void testModify() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders
            .post("/board/modify")
                .param("bno", "1")
                .param("title", "1번이 이걸로 바뀜")
                .param("content", "수정 내용")
                .param("writer", "user00"))
                .andReturn().getModelAndView().getViewName();

        log.info(resultPage);

    }


    @Test
    public void testRemove() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders
                .post("/board/remove")
                .param("bno", "25"))
                .andReturn().getModelAndView().getViewName();

        log.info(resultPage);

    }

    @Test
    public void testListPaging() throws Exception {
        log.info(mockMvc.perform(
                MockMvcRequestBuilders.get("/board/list")
                        .param("pageNum", "2")
                        .param("amount", "50"))
                        .andReturn().getModelAndView().getModelMap());


    }




}
