package com.cg.ssm.pojo;

import java.util.HashMap;
import java.util.Map;
//自定义的对象要转为json时必须有get方法
public class MSG {
    private int code;
    private String mes;
    private  Map<String, Object> map = new HashMap<>();

    public Map<String, Object> getMap() {
        return map;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public MSG(int code, String mes) {
        this.code = code;
        this.mes = mes;
    }

    public static MSG succeed() {
        MSG msg = new MSG(100,"发送成功");
        return msg;

    }
    public static MSG fail() {
        MSG msg = new MSG(200,"发送失败");
        return msg;

    }
    public MSG addMap(String s,Object obj) {
        this.map.put(s, obj);
        return this;
    }

}
