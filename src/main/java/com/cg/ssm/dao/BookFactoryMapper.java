package com.cg.ssm.dao;

import com.cg.ssm.pojo.BookFactory;
import com.cg.ssm.pojo.BookFactoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface BookFactoryMapper {
    int countByExample(BookFactoryExample example);

    int deleteByExample(BookFactoryExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(BookFactory record);

    int insertSelective(BookFactory record);

    List<BookFactory> selectByExample(BookFactoryExample example);

    BookFactory selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") BookFactory record, @Param("example") BookFactoryExample example);

    int updateByExample(@Param("record") BookFactory record, @Param("example") BookFactoryExample example);

    int updateByPrimaryKeySelective(BookFactory record);

    int updateByPrimaryKey(BookFactory record);
}