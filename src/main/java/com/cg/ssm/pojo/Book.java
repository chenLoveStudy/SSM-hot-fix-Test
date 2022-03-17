package com.cg.ssm.pojo;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class Book {
    private Integer id;
    @NotNull(message = "图书名不能为空")
    @Pattern(regexp = "^[\\u4E00-\\u9FA5A-Za-z0-9]+$",message = "图书名不能有特殊符号和空格")
    private String name;
    @NotNull(message = "价格不能为空")
    private double price;
    @NotNull
    @Pattern(regexp = "^([\\u4e00-\\u9fa5a-zA-Z]{1,20})$",message = "作者名不能包含特殊符号和数字")
    private String author;
//    Integer类型无法用pattern注解
//    @NotNull
    private Integer sales;//插入时没有选择销量,所以销量不作约束  hot-fix test

    private Integer stock;

    private String imgPath;

    private Integer fid;
    private BookFactory factory;


    public BookFactory getFactory() {
        return factory;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", author='" + author + '\'' +
                ", sales=" + sales +
                ", fid=" + fid +
                '}';
    }

    public void setFactory(BookFactory factory) {
        this.factory = factory;
    }

    public Book() {
    }

    public Book(Integer id, String name, double price, String author, Integer sales, Integer fid) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.author = author;
        this.sales = sales;
        this.fid = fid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public Integer getSales() {
        return sales;
    }

    public void setSales(Integer sales) {
        this.sales = sales;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath == null ? null : imgPath.trim();
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }
}