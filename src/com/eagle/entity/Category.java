package com.eagle.entity;

public class Category {
    private int id;
    private int pid;
    private String name;
    private String descr;
    private boolean isleaf;
    private int grade;

    public Category(){}

    public Category(int id, int pid, String name, String descr, boolean isleaf, int grade) {
        this.id = id;
        this.pid = pid;
        this.name = name;
        this.descr = descr;
        this.isleaf = isleaf;
        this.grade = grade;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
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

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public boolean isLeaf() {
        return isleaf;
    }

    public void setLeaf(boolean leaf) {
        isleaf = leaf;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", pid=" + pid +
                ", name='" + name + '\'' +
                ", descr='" + descr + '\'' +
                ", isleft='" + isleaf + '\'' +
                ", grade=" + grade +
                '}';
    }
}
