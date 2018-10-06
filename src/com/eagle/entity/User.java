package com.eagle.entity;

import java.sql.*;

public class User {

    private int id;
    private String username;
    private String password;
    private String phone;
    private String addr;
    private Timestamp rdate;

    public User() { }

    public User(String username, String password, String phone, String addr) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.addr = addr;
        this.rdate = new Timestamp(System.currentTimeMillis());
    }

    public User( String username, String password, String phone, String addr, Timestamp rdate) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.addr = addr;
        this.rdate = rdate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNum() {
        return phone;
    }

    public void setPhoneNum(String phoneNum) {
        this.phone = phoneNum;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public Timestamp getRdate() {
        return rdate;
    }

    public void setRdate(Timestamp rdate) {
        this.rdate = rdate;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", phoneNum='" + phone + '\'' +
                ", addr='" + addr + '\'' +
                ", rdate=" + rdate +
                '}';
    }
}
