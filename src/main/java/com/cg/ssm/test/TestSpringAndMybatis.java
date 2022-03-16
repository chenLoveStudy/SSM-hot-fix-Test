package com.cg.ssm.test;

import com.cg.ssm.dao.BookMapper;
import com.cg.ssm.pojo.Book;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestSpringAndMybatis {
    @Autowired
    BookMapper bookMapper;
    @Autowired
    SqlSessionTemplate sqlSession;//批量操作session
    @Test
    public void test() {
//        bookMapper.selectByExample(null);
//        List<Book> books = bookMapper.selectByExample(null);
//        System.out.println(books);
//        BookMapper mapper = sqlSession.getMapper(BookMapper.class);
//        for (int i = 0; i < 300; i++) {
//            String s = UUID.randomUUID().toString().substring(0, 5);
//            mapper.insertSelective(new Book(null,s+i,new BigDecimal(1.4*i),"Mr."+s,i*12,i%2==0?1:3));
//        }
//        System.out.println("批量插入完成");
        List<Book> books = bookMapper.selectAllBookAndFac();
        books.forEach(b-> System.out.println(b.getFactory().getFname()));


    }
}
