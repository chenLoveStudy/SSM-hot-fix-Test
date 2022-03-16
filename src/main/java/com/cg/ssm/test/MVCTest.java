package com.cg.ssm.test;

import com.cg.ssm.pojo.Book;
import com.cg.ssm.service.BookService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
//导入spring和springmvc的配置文件
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:dispatcherServlet.xml"})
public class MVCTest {
    @Autowired
    WebApplicationContext webContext;//WebApplicationContext是mvc的ioc容器,要想注入需加上@WebAppConfiguration注解
    // 虚拟mvc请求，获取到处理结果。
    MockMvc mockMvc;
    @Autowired
    BookService bookService;
    @Before
    public void initMock() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webContext).build();
    }
    @Test
    public void test1() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/books")
                .param("pn", "5")).andReturn();

        PageHelper.startPage(5, 5);
        List<Book> books = bookService.selectAllBookAndFactory();
        PageInfo<Book> pageInfo = new PageInfo<>(books, 5);
        books.forEach(b-> System.out.println(b));
        System.out.println(pageInfo);


    }
}
