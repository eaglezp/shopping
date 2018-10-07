package com.eagle.entity;

public class Category {
    private int id;
    private int pid;
    private String name;
    private String descr;
    private int cno;
    private boolean isLeaf;
    private int grade;

    public Category(){}

    public Category(int id, int pid, String name, String descr, int cno, boolean isLeaf, int grade) {
        this.id = id;
        this.pid = pid;
        this.name = name;
        this.descr = descr;
        this.cno = cno;
        this.isLeaf = isLeaf;
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

    public int getCno() {
        return cno;
    }

    public void setCno(int cno) {
        this.cno = cno;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean leaf) {
        isLeaf = leaf;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", pid=" + pid +
                ", name='" + name + '\'' +
                ", descr='" + descr + '\'' +
                ", cno=" + cno +
                ", grade=" + grade +
                '}';
    }
}
