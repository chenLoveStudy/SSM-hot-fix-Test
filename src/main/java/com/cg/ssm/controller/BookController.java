package com.cg.ssm.controller;

import com.cg.ssm.pojo.Book;
import com.cg.ssm.pojo.MSG;
import com.cg.ssm.service.BookService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Controller
public class BookController {
    @Autowired
    BookService bookService;

//    查询并显示某页的图书
    @ResponseBody  //需要引入json相关的依赖
    @RequestMapping("/books")
    public MSG getMsg(@RequestParam(value = "pn",defaultValue ="1") int pn) {
        PageHelper.startPage(pn, 5);
        List<Book> books = bookService.selectAllBookAndFactory();
        PageInfo<Book> pageInfo = new PageInfo<>(books, 5);
//        System.out.println(pageInfo);
        MSG msg = MSG.succeed().addMap("pageInfo",pageInfo);
        return msg;

    }

    //检查书名是否可用
    @ResponseBody
    @RequestMapping("/checkBook")
    public MSG checkBook(@RequestParam("bookName") String bname) {
        String regex = "^[\\u4E00-\\u9FA5A-Za-z0-9]+$";
        if (bname.matches(regex)){
            boolean b = bookService.selectBookNameNotExist(bname);
            if (b){//成立说明没有这个书名
                return MSG.succeed();
            }else {
                return MSG.fail();
            }
        }else {

            return null;
        }


    }
    //检查价格是否合法
    @ResponseBody
    @RequestMapping("/checkPrice")
    public MSG checkPrice(@RequestParam("price") String price) {
        String regex="(^[1-9]\\d*(\\.\\d{1,2})?$)|(^0(\\.\\d{1,2})?$)";
        boolean b = price.matches(regex);
        if (b){
            return MSG.succeed();
        }
        return MSG.fail();


    }
//    检查作者是否合法
    @ResponseBody
    @RequestMapping("/checkAuthor")
    public MSG checkAuthor(@RequestParam("author") String author) {
        String regex = "^([\\u4e00-\\u9fa5a-zA-Z]{1,20})$";
        boolean b = author.matches(regex);
        if (b){
           return MSG.succeed();
        }
        return MSG.fail();

    }

    //restful风格,post请求代表保存
//   JSR303这些校验注解仅仅会在Controller层创建入参对象的时候生效，对于Service或Dao层中的对象是无效的。

    //保存新增的图书
    @ResponseBody
    @RequestMapping(value = "/books",method = RequestMethod.POST)
    public MSG saveBook(@Valid Book book,BindingResult result) {//自动封装(需要表单中的name与实体类中的属性名相同)
        System.out.println(1111);
        System.out.println("将要插入的数据"+book);
        if (result.hasErrors()) {
            System.out.println("后端JSR303验证不通过");
            return MSG.fail();
        }
        boolean b = bookService.insertBook(book);
       return MSG.succeed();

    }

    //修改时查询图书信息
    @ResponseBody
    @GetMapping("/book/{id}")//是{id} 不应该是${id}
    public MSG getBookById(@PathVariable("id") Integer id) {
        Book book = bookService.selectBookAndFactoryId(id);

        return MSG.succeed().addMap("book", book);
    }
    //保存图书信息
    @ResponseBody
    @RequestMapping(value = "/book/{id}",method = RequestMethod.PUT)//是{id} 不应该是${id}
    public MSG saveBook(@PathVariable("id") Integer id,Book book) {
        bookService.updateBook(book);
        return MSG.succeed();

    }
    //删除图书信息
    @ResponseBody
    @RequestMapping(value = "/book/{id}",method = RequestMethod.DELETE)//是{id} 不应该是${id}
    public MSG saveBook(@PathVariable("id") String id) {
        String[] split = id.split("-");
        if (split.length == 0) {        //说明要删除的图书只有一个
            bookService.deleteBookById(Integer.parseInt(id));
            return MSG.succeed();
        }
        List<Integer> list = new ArrayList<>();
        for (String s : split) {
            list.add(Integer.parseInt(s));
        }
        bookService.deleteBooksById(list);//批量删除
        return MSG.succeed();

    }
}
