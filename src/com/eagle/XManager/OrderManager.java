package com.eagle.XManager;

import com.eagle.dao.OrderDAO;

public class OrderManager {

    private static OrderManager orderManager;

    private OrderManager(){}

    static {
        if(orderManager == null){
            orderManager = new OrderManager();
            orderManager.setOrderDAO(new OrderDAO());
        }
    }

    public static OrderManager getInstance(){
        return orderManager;
    }

    private OrderDAO orderDAO;

    public OrderDAO getOrderDAO() {
        return orderDAO;
    }

    public void setOrderDAO(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }
}
