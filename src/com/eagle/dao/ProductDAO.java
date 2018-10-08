package com.eagle.dao;

import com.eagle.entity.Product;
import com.eagle.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductDAO {


    public List<Product> getProducts(){
        List<Product> productList = new ArrayList<>();
        Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                connection = DB.getConn();
                statement = connection.createStatement();
                String sql = "select * from product";
                System.out.println(sql);
                resultSet = statement.executeQuery(sql);
                initProductFromResult(productList, resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }

        return productList;
    }


    private void initProductFromResult(List<Product> productList, ResultSet resultSet) throws SQLException {
        while (resultSet.next()){
            Product product = new Product();
            product.setId(resultSet.getInt("id"));
            product.setName(resultSet.getString("name"));
            product.setDescr(resultSet.getString("descr"));
            product.setNormalprice(resultSet.getDouble("normalprice"));
            product.setMemberprice(resultSet.getDouble("memberprice"));
            product.setPdate(resultSet.getTimestamp("pdate"));
            product.setCategoryid(resultSet.getInt("categoryid"));
            productList.add(product);
        }
    }

    public List<Product> getProducts(int pageNo,int pageSize){
        List<Product> productList = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select * from product limit "+(pageNo-1)*pageSize+","+ pageSize;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            initProductFromResult(productList, resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }

        return productList;
    }

    public int getProducts(List<Product> productList,int pageNo,int pageSize){
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        ResultSet totalResultSet = null;
        int pageCount = 0;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            totalResultSet = statement.executeQuery("select count(1) from product");
            if(totalResultSet.next()){
                pageCount = (totalResultSet.getInt(1) + pageSize -1) / pageSize;
            }
            String sql = "select * from product limit "+(pageNo-1)*pageSize+","+ pageSize;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            initProductFromResult(productList, resultSet);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }

        return pageCount;
    }

    public List<Product> findProducts(int[] ids,
                                             String name,
                                             String descr,
                                             double lowNormalPrice,
                                             double highNormalPrice,
                                             double lowMemberPrice,
                                             double highMemberPrice,
                                             Date startDate,
                                             Date endDate,
                                             int pageNo,
                                             int pageSize){
        List<Product> productList = new ArrayList<>();

        return productList;
    }

    public List<Product> findProducts(String name){
        List<Product> productList = new ArrayList<>();

        return productList;
    }

    public boolean deleteProductById(int id){

        return false;
    }

    public boolean deleteProductByIds(int[] idArray){

        return false;
    }

    public boolean updateProduct(Product product){

        return false;
    }

    public boolean addProduct(Product product) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        boolean result = false;
        try {
            connection = DB.getConn();
            String sql = "";
            sql = "insert into product values(null,?,?,?,?,?,?)";
            System.out.println(sql);
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescr());
            pstmt.setDouble(3, product.getNormalprice());
            pstmt.setDouble(4, product.getMemberprice());
            pstmt.setTimestamp(5, product.getPdate());
            pstmt.setInt(6, product.getCategoryid());
            result = pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(pstmt);
            DB.close(connection);
        }
        return result;
    }
}