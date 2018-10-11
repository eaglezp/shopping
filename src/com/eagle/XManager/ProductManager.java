package com.eagle.XManager;

import com.eagle.dao.ProductDAO;
import com.eagle.entity.Product;

public class ProductManager {

    private static ProductManager productManager = null;

    private ProductManager(){}

    static {
        if(productManager == null){
            productManager = new ProductManager();
            productManager.setProductDAO(new ProductDAO());
        }
    }

    public static ProductManager getInstance(){
        return productManager;
    }



    private ProductDAO productDAO = null;

    public ProductDAO getProductDAO() {
        return productDAO;
    }

    public void setProductDAO(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    public int addProduct(Product product){
        return productDAO.addProduct(product);
    }
}
