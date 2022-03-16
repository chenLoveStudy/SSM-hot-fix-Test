package com.cg.ssm.pojo;

public class BookFactory {
    public BookFactory() {
    }

    private Integer id;

    private String fname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname == null ? null : fname.trim();
    }
}