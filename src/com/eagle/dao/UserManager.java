package com.eagle.dao;

import com.eagle.entity.User;
import com.eagle.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserManager {

    public static List<User> getUsers(){
        List<User> userList = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from user order by id desc");
            while(resultSet.next()){
                User user = new User();
                user.setId(resultSet.getInt("id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setPhoneNum(resultSet.getString("phone"));
                user.setAddr(resultSet.getString("addr"));
                user.setRdate(resultSet.getTimestamp("rdate"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }
        return userList;
    }


    public static void deleteUsers(int id){
        Connection connection = null;
        Statement statement = null;
        try{
            connection = DB.getConn();
            statement = connection.createStatement();
            statement.execute("delete from user where id="+id);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DB.close(statement);
            DB.close(connection);
        }
    }

    public static void saveUser(User user) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            connection = DB.getConn();

            String sql = "insert into user values(null,?,?,?,?,?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1,user.getUsername());
            pstmt.setString(2,user.getPassword());
            pstmt.setString(3,user.getPhoneNum());
            pstmt.setString(4,user.getAddr());
            pstmt.setTimestamp(5,user.getRdate());
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(pstmt);
            DB.close(connection);
        }
    }
}
