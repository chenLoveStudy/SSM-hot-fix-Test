package com.cg.ssm.controller;

import com.cg.ssm.pojo.BookFactory;
import com.cg.ssm.pojo.MSG;
import com.cg.ssm.service.BookFacService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class FactoryController{
    @Autowired
    BookFacService bookFacService;

//    得到所有书厂信息
    @ResponseBody
    @RequestMapping("/factory")
    public MSG getFactory() {

        List<BookFactory> bfs = bookFacService.getAllFactory();
        return MSG.succeed().addMap("bfs", bfs);


    }
}
