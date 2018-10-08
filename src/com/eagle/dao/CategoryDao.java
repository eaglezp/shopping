package com.eagle.dao;

import com.eagle.entity.Category;
import com.eagle.entity.User;
import com.eagle.excepton.PasswordNotCorrection;
import com.eagle.excepton.UserNotFoundException;
import com.eagle.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public static Category loadCategoryById(int id){
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        Category category = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select * from category where id ="+id;
            resultSet = statement.executeQuery(sql);
            if(resultSet.next()){
                category = new Category();
                category.setId(resultSet.getInt("id"));
                category.setPid(resultSet.getInt("pid"));
                category.setName(resultSet.getString("name"));
                category.setDescr(resultSet.getString("descr"));
                category.setLeaf(resultSet.getInt("isleaf") == 1 ? true:false);
                category.setGrade(resultSet.getInt("grade"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }
        return category;
    }

    public static void addChildCategory(int pid, String name, String descr){
        Connection connection = null;
        PreparedStatement pstmt = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = DB.getStatement(connection);
            resultSet = statement.executeQuery("select * from category where id="+pid);
            resultSet.next();
            int parentGrade = resultSet.getInt("grade");
            connection.setAutoCommit(false);
            String sql = "insert into category values(null,?,?,?,?,?)";
            System.out.println(sql);
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1,pid);
            pstmt.setString(2,name);
            pstmt.setString(3, descr);
            pstmt.setInt(4, 1);
            pstmt.setInt(5, parentGrade+1);
            pstmt.execute();
            //���¸��ڵ�isleaf
            DB.executeUpdate(statement,"update category set isleaf = 0 where id="+pid);
            connection.commit();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(pstmt);
            DB.close(connection);
        }
    }

    public static List<Category> getCategories(){
       List<Category> catgories = new ArrayList<>();
       getCategories(catgories,0);
       return catgories;
    }

    public static void getCategories(List<Category> categories, int id){
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DB.getConn();
            statement = connection.createStatement();
            String sql = "select * from category where pid ="+id;
            System.out.println(sql);
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()){
                Category category = new Category();
                category.setId(resultSet.getInt("id"));
                category.setPid(resultSet.getInt("pid"));
                category.setName(resultSet.getString("name"));
                category.setDescr(resultSet.getString("descr"));
                category.setLeaf(resultSet.getInt("isleaf") == 1 ? true:false);
                category.setGrade(resultSet.getInt("grade"));
                categories.add(category);
                if(!category.isLeaf()){
                    getCategories(categories,category.getId());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(resultSet);
            DB.close(statement);
            DB.close(connection);
        }
    }


    public static void addCategory(Category category){
        CategoryDao.saveCategory(category);
    }

    public static void addTopCategory(String name, String descr){
        Category category = new Category();
        category.setId(-1);
        category.setPid(0);
        category.setName(name);
        category.setDescr(descr);
        category.setGrade(1);
        category.setLeaf(true);
        addCategory(category);
    }

    public static void saveCategory(Category category) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            connection = DB.getConn();
            String sql = "";
            sql = "insert into category values(null,?,?,?,?,?)";
            System.out.println(sql);
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, category.getPid());
            pstmt.setString(2, category.getName());
            pstmt.setString(3, category.getDescr());
            pstmt.setInt(4, category.getGrade());
            pstmt.setInt(5, category.isLeaf() ? 1:0);
            pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DB.close(pstmt);
            DB.close(connection);
        }
    }

}