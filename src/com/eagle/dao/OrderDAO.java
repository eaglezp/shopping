package com.eagle.dao;

import com.eagle.entity.*;
import com.eagle.util.DB;

import java.sql.*;
import java.util.List;

public class OrderDAO {




    public int getOrders(List<SalesOrder> orderList,int pageNo,int pageSize){
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        ResultSet totalResultSet = null;
        int pageCount = 0;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            totalResultSet = statement.executeQuery("select count(1) from salesorder");
            if(totalResultSet.next()){
                pageCount = (totalResultSet.getInt(1) + pageSize -1) / pageSize;
            }

            String sql = "select o.id,o.userid,o.addr,o.odate,o.status,u.id uid, u.username, u.password,u.phone,u.addr uaddr,u.rdate " +
                        " from salesorder o left join user u on o.userid=u.id ";
            sql += " limit "+(pageNo-1)*pageSize+","+ pageSize;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            initOrderFromResult(orderList,resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }

        return pageCount;
    }

    private void initOrderFromResult(List<SalesOrder> orderList, ResultSet resultSet) throws SQLException {
        while (resultSet.next()){
            SalesOrder order = new SalesOrder();
            order.setId(resultSet.getInt("id"));
            order.setOdate(resultSet.getTimestamp("odate"));
            order.setAddr(resultSet.getString("addr"));
            User user = new User();
            user.setId(resultSet.getInt("uid"));
            user.setAddr(resultSet.getString("uaddr"));
            user.setPhoneNum(resultSet.getString("phone"));
            user.setUsername(resultSet.getString("username"));
            user.setPassword(resultSet.getString("password"));
            order.setUser(user);
            orderList.add(order);
        }
    }

    public int saveOrder(SalesOrder salesOrder){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSetKey = null;
        int result = 0;
        try {
            connection = DB.getConn();
            connection.setAutoCommit(false);
            String sql = "insert into salesorder values(null,?,?,?,?)";
            pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, salesOrder.getUser().getId());
            pstmt.setString(2, salesOrder.getAddr());
            pstmt.setTimestamp(3, salesOrder.getOdate());
            pstmt.setInt(4, salesOrder.getStatus());
            result = pstmt.executeUpdate();
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
