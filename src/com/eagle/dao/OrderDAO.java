package com.eagle.dao;

import com.eagle.entity.Cart;
import com.eagle.entity.CartItem;
import com.eagle.entity.SalesOrder;
import com.eagle.util.DB;

import java.sql.*;
import java.util.List;

public class OrderDAO {

    public boolean saveOrder(SalesOrder salesOrder){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSetKey = null;
        boolean result = false;
        try {
            connection = DB.getConn();
            connection.setAutoCommit(false);
            String sql = "insert into salesorder values(null,?,?,?,?)";
            pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, salesOrder.getUser().getId());
            pstmt.setString(2, salesOrder.getAddr());
            pstmt.setTimestamp(3, salesOrder.getOdate());
            pstmt.setInt(4, salesOrder.getStatus());
            result = pstmt.execute();
            resultSetKey = pstmt.getGeneratedKeys();
            resultSetKey.next();
            int key = resultSetKey.getInt(1);

            String salesItemSql = "insert into salesitem values (null,?,?,?,?)";
            pstmt = connection.prepareStatement(salesItemSql);
            Cart cart = salesOrder.getCart();
            List<CartItem> cartItemList = cart.getCartItemList();
            for(CartItem cartItem : cartItemList){
                pstmt.setInt(1,cartItem.getProductId());
                pstmt.setDouble(2,cartItem.getNormalPrice());
                pstmt.setInt(3,cartItem.getCount());
                pstmt.setInt(4,key);
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            connection.commit();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            DB.close(resultSetKey);
            DB.close(pstmt);
            DB.close(connection);
        }
        return result;
    }
}
