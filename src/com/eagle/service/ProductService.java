package com.eagle.service;

import com.eagle.entity.Product;
import java.util.Date;
import java.util.List;

public class ProductService {

    public List<Product> getProducts(){

        return null;
    }

    public List<Product> getProducts(int pageNo,int pageSize){


        return null;
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


        return null;
    }

    public List<Product> findProducts(String name){

        return null;
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
}
