package com.eagle.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {

    public Cart() {
    }

    public Cart(List<CartItem> cartItemList) {
        this.cartItemList = cartItemList;
    }

    private List<CartItem> cartItemList = new ArrayList<>();

    public List<CartItem> getCartItemList() {
        return cartItemList;
    }

    public void setCartItemList(List<CartItem> cartItemList) {
        this.cartItemList = cartItemList;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartItemList=" + cartItemList +
                '}';
    }

    public void add(CartItem cartItemNew){
        for(CartItem cartItemOld : cartItemList){
            if(cartItemNew.getProductId() == cartItemOld.getProductId()){
                cartItemOld.setCount(cartItemOld.getCount() + 1);
                 return;
            }
        }
        cartItemList.add(cartItemNew);
    }

    public Map<String, Map<String,Double>> getTotalPriceMap(){
        Map<String, Map<String,Double>> priceMap = new HashMap<>();
        for(CartItem cartItem : cartItemList){
            priceMap.put(String.valueOf(cartItem.getProductId()),cartItem.getTotalPriceMap());
        }
        return priceMap;
    }
}
