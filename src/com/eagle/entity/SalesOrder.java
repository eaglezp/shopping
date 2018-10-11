package com.eagle.entity;

import java.sql.Timestamp;

public class SalesOrder {

    private int id;
    private User user;
    private String addr;
    private Timestamp odate;
    private Cart cart;
    private int status;

    public SalesOrder() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public Timestamp getOdate() {
        return odate;
    }

    public void setOdate(Timestamp odate) {
        this.odate = odate;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "SalesOrder{" +
                "id=" + id +
                ", user=" + user +
                ", addr='" + addr + '\'' +
                ", odate=" + odate +
                ", cart=" + cart +
                ", status=" + status +
                '}';
    }
}
