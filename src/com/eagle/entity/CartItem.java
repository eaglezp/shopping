package com.eagle.entity;

import java.util.HashMap;
import java.util.Map;

public class CartItem {

    private int productId;
    private String productName;
    private int count;
    private double normalPrice;
    private double memberPrice;

    public CartItem() {
    }

    public CartItem(int productId, String productName, int count, double normalPrice, double memberPrice) {
        this.productId = productId;
        this.productName = productName;
        this.count = count;
        this.normalPrice = normalPrice;
        this.memberPrice = memberPrice;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public double getNormalPrice() {
        return normalPrice;
    }

    public void setNormalPrice(double normalPrice) {
        this.normalPrice = normalPrice;
    }

    public double getMemberPrice() {
        return memberPrice;
    }

    public void setMemberPrice(double memberPrice) {
        this.memberPrice = memberPrice;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", count=" + count +
                ", normalPrice=" + normalPrice +
                ", memberPrice=" + memberPrice +
                '}';
    }

    public Map<String, Double> getTotalPriceMap(){
        Map<String, Double> priceMap = new HashMap<>();
        priceMap.put("normalPrice",normalPrice*count);
        priceMap.put("memberPrice",memberPrice*count);
        return priceMap;
    }
}
