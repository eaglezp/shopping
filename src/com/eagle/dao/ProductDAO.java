package com.eagle.dao;

import com.eagle.entity.Category;
import com.eagle.entity.Product;
import com.eagle.util.DB;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class ProductDAO {

    /***
     * 获取最新上架的商品
     * @param count
     * @return
     */
    public List<Product> getLatestProducts(int count){
        List<Product> productList = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try{
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select * from product order by pdate desc limit 0,"+count;
            resultSet = statement.executeQuery(sql);
            initProductFromSimpleResult(productList,resultSet);
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }
        return productList;
    }
    /**
     *
     * @param id
     * @return
     */
    public Product loadProductById(int id){
        Product product = null;
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid,c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id where p.id = "+id;
            resultSet = statement.executeQuery(sql);
            if(resultSet.next()){
                product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setDescr(resultSet.getString("descr"));
                product.setNormalprice(resultSet.getDouble("normalprice"));
                product.setMemberprice(resultSet.getDouble("memberprice"));
                product.setPdate(resultSet.getTimestamp("pdate"));
                product.setCategoryid(resultSet.getInt("categoryid"));
                Category category = new Category();
                category.setId(resultSet.getInt("cid"));
                category.setPid(resultSet.getInt("pid"));
                category.setName(resultSet.getString("cname"));
                category.setDescr(resultSet.getString("cdescr"));
                category.setLeaf(resultSet.getInt("isleaf")== 1? true:false);
                category.setGrade(resultSet.getInt("grade"));
                product.setCategory(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }
        return  product;
    }

    public List<Product> getProducts(){
        List<Product> productList = new ArrayList<>();
        Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                connection = DB.getConn();
                statement = connection.createStatement();
                String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid, c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id";
                System.out.println(sql);
                resultSet = statement.executeQuery(sql);
                initProductFromResult(productList,resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }

        return productList;
    }

    private void initProductFromSimpleResult(List<Product> productList, ResultSet resultSet) throws SQLException {
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
            Category category = new Category();
            category.setId(resultSet.getInt("cid"));
            category.setPid(resultSet.getInt("pid"));
            category.setName(resultSet.getString("cname"));
            category.setDescr(resultSet.getString("cdescr"));
            category.setLeaf(resultSet.getInt("isleaf")== 1? true:false);
            category.setGrade(resultSet.getInt("grade"));
            product.setCategory(category);
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
            String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid, c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id";
            sql += " limit "+(pageNo-1)*pageSize+","+ pageSize;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            initProductFromResult(productList,resultSet);
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

            String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid,c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id ";
            sql += " limit "+(pageNo-1)*pageSize+","+ pageSize;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            initProductFromResult(productList,resultSet);
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
                                     String keyword,
                                     double lowNormalPrice,
                                     double highNormalPrice,
                                     double lowMemberPrice,
                                     double highMemberPrice,
                                     Date startDate,
                                     Date endDate,
                                     int pageNo,
                                     int pageSize){
        List<Product> productList = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid,c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id where 1=1 ";

            if(ids != null && ids.length >0){
                sql += " and p.categoryid in (";
                for(int i=0;i<ids.length;i++){
                    if(i<ids.length-1){
                        sql += ",";
                    }else {
                        sql += ids[i];
                    }
                }
                sql +=") ";
            }

            if(lowNormalPrice >= 0){
                sql += " and normalprice >="+lowNormalPrice;
            }
            if(highNormalPrice >= 0){
                sql += " and normalprice <="+highNormalPrice;
            }
            if(lowMemberPrice >= 0){
                sql += " and memberprice >="+lowMemberPrice;
            }
            if(highMemberPrice >= 0){
                sql += " and memberprice <="+highMemberPrice;
            }

            if(startDate != null){
                sql += " and pdate >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(startDate)+"'";
            }
            if(endDate != null){
                sql += " and pdate <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(endDate)+"'";
            }

            if(keyword != null && !keyword.trim().equals("")){
                sql += " and p.name like '%"+keyword+"%'"+" or p.descr like '%"+keyword+"%'";
            }

            sql += " limit "+(pageNo-1)*pageSize+","+pageSize;
            System.out.println("sql-----"+sql);


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

    public int findProducts(List<Product> productList,
                            int[] ids,
                            String keyword,
                            double lowNormalPrice,
                            double highNormalPrice,
                            double lowMemberPrice,
                            double highMemberPrice,
                            Date startDate,
                            Date endDate,
                            int pageNo,
                            int pageSize){

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        int pageCount = 0;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid,c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade from product p join category c on p.categoryid=c.id where 1=1 ";

            if(ids != null && ids.length >0){
                sql += " and p.categoryid in (";
                for(int i=0;i<ids.length;i++){
                    if(i<ids.length-1){
                        sql += ",";
                    }else {
                        sql += ids[i];
                    }
                }
                sql +=") ";
            }

            if(lowNormalPrice >= 0){
                sql += " and normalprice >= "+lowNormalPrice;
            }
            if(highNormalPrice >= 0){
                sql += " and normalprice <= "+highNormalPrice;
            }
            if(lowMemberPrice >= 0){
                sql += " and memberprice >= "+lowMemberPrice;
            }
            if(highMemberPrice >= 0){
                sql += " and memberprice <= "+highMemberPrice;
            }

            if(startDate != null){
                sql += " and pdate >= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(startDate)+"'";
            }
            if(endDate != null){
                sql += " and pdate <= '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(endDate)+"'";
            }

            if(keyword != null && !keyword.trim().equals("")){
                sql += " and p.name like '%"+keyword+"%'"+" or p.descr like '%"+keyword+"%'";
            }

            String countSql = sql.replaceFirst("select p.id,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid,c.id cid,c.name cname,c.pid,c.descr cdescr,c.isleaf,c.grade","select count(*)");
            System.out.println("countSql-----"+countSql);

            sql += " limit "+(pageNo-1)*pageSize+","+pageSize;
            System.out.println("sql-----"+sql);

            ResultSet countResultSet = statement.executeQuery(countSql);
            if(countResultSet.next()){
                pageCount = (countResultSet.getInt(1) + pageSize -1) / pageSize;
            }

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

    public int updateProduct(Product product){
        System.out.println("product:"+product);
        Connection connection = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            connection = DB.getConn();
            String sql = "update product set name=?, descr=?, normalprice=?, memberprice=?, categoryid=? where id="+product.getId();
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescr());
            pstmt.setDouble(3, product.getNormalprice());
            pstmt.setDouble(4, product.getMemberprice());
            pstmt.setInt(5, product.getCategoryid());
            System.out.println(sql);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(pstmt);
            DB.close(connection);
        }
        return result;
    }

    public int addProduct(Product product) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            connection = DB.getConn();
            String sql = "insert into product values(null,?,?,?,?,?,?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescr());
            pstmt.setDouble(3, product.getNormalprice());
            pstmt.setDouble(4, product.getMemberprice());
            pstmt.setTimestamp(5, product.getPdate());
            pstmt.setInt(6, product.getCategoryid());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(pstmt);
            DB.close(connection);
        }
        return result;
    }
}
