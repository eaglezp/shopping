package com.eagle.entity;

import java.util.List;

public class SalesItem {

    private int id;
    private Product product;
    private double unitprice;
    private int pcount;
    private SalesOrder order;

    public SalesItem() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getUnitprice() {
        return unitprice;
    }

    public void setUnitprice(double unitprice) {
        this.unitprice = unitprice;
    }

    public int getPcount() {
        return pcount;
    }

    public void setPcount(int pcount) {
        this.pcount = pcount;
    }

    public SalesOrder getOrder() {
        return order;
    }

    public void setOrder(SalesOrder order) {
        this.order = order;
    }

    @Override
    public String toString() {
        return "SalesItem{" +
                "id=" + id +
                ", product=" + product +
                ", unitprice=" + unitprice +
                ", pcount=" + pcount +
                ", order=" + order +
                '}';
    }
}
