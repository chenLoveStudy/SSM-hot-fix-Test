package com.cg.ssm.service;

import com.cg.ssm.dao.BookFactoryMapper;
import com.cg.ssm.pojo.BookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookFacService {
    @Autowired
    BookFactoryMapper bookFactoryMapper;
    public List<BookFactory> getAllFactory() {
        List<BookFactory> bfs = bookFactoryMapper.selectByExample(null);
        return bfs;
    }
}
