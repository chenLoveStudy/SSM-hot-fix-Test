package com.cg.ssm.service;

import com.cg.ssm.dao.BookMapper;
import com.cg.ssm.pojo.Book;
import com.cg.ssm.pojo.BookExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {
    @Autowired
    BookMapper bookMapper;


    public List<Book> selectAllBookAndFactory() {
        List<Book> books = bookMapper.selectAllBookAndFac();
        return books;
    }

    public boolean selectBookNameNotExist(String bname) {
        BookExample bookExample = new BookExample();
        bookExample.createCriteria().andNameEqualTo(bname);
        List<Book> books = bookMapper.selectByExample(bookExample);
        if (books.size() == 0) {
            return true;
        }
        return false;
    }


    public boolean insertBook(Book book) {
        bookMapper.insertSelective(book);
        return true;
    }

    public Book selectBookAndFactoryId(Integer id) {
        Book book = bookMapper.selectBookAndFactoryId(id);
        return book;
    }


    public void updateBook(Book book) {

        bookMapper.updateByPrimaryKeySelective(book);
    }

    public void deleteBookById(Integer id) {
        bookMapper.deleteByPrimaryKey(id);
    }

    public void deleteBooksById(List<Integer> list) {
        BookExample example=new BookExample();
        example.createCriteria().andIdIn(list);
        bookMapper.deleteByExample(example);
    }
}
