package com.sample;


public class Product {

  private long id;
  private String name;
  private String descr;
  private double normalprice;
  private double memberprice;
  private java.sql.Timestamp pdate;
  private long categoryid;


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getDescr() {
    return descr;
  }

  public void setDescr(String descr) {
    this.descr = descr;
  }


  public double getNormalprice() {
    return normalprice;
  }

  public void setNormalprice(double normalprice) {
    this.normalprice = normalprice;
  }


  public double getMemberprice() {
    return memberprice;
  }

  public void setMemberprice(double memberprice) {
    this.memberprice = memberprice;
  }


  public java.sql.Timestamp getPdate() {
    return pdate;
  }

  public void setPdate(java.sql.Timestamp pdate) {
    this.pdate = pdate;
  }


  public long getCategoryid() {
    return categoryid;
  }

  public void setCategoryid(long categoryid) {
    this.categoryid = categoryid;
  }

}
