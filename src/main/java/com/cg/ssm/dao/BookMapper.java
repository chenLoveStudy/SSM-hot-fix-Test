package com.cg.ssm.dao;

import com.cg.ssm.pojo.Book;
import com.cg.ssm.pojo.BookExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BookMapper {
    //通过书籍id查询图书的信息和相应的书厂
    Book selectBookAndFactoryId(Integer id);
    //    查询书的信息和相关的书厂
    List<Book> selectAllBookAndFac();

    int countByExample(BookExample example);

    int deleteByExample(BookExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    List<Book> selectByExample(BookExample example);

    Book selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Book record, @Param("example") BookExample example);

    int updateByExample(@Param("record") Book record, @Param("example") BookExample example);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);
}