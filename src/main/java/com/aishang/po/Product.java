package com.aishang.po;

import java.util.Date;
// TODO 商品po类
public class Product {

    private Integer pid;
    private String pName;
    private Double marketPrice;
    private Double shopPrice;
    private String pDesc;
    private Integer isHot;
    private Date date;
    private Integer ctid;
    private Integer stock;
    private Double score;

    @Override
    public String toString() {
        return "Product{" +
                "pid=" + pid +
                ", pName='" + pName + '\'' +
                ", marketPrice=" + marketPrice +
                ", shopPrice=" + shopPrice +
                ", pDesc='" + pDesc + '\'' +
                ", isHot=" + isHot +
                ", date=" + date +
                ", ctid=" + ctid +
                ", stock=" + stock +
                ", score=" + score +
                '}';
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public Double getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(Double marketPrice) {
        this.marketPrice = marketPrice;
    }

    public Double getShopPrice() {
        return shopPrice;
    }

    public void setShopPrice(Double shopPrice) {
        this.shopPrice = shopPrice;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public Integer getIsHot() {
        return isHot;
    }

    public void setIsHot(Integer isHot) {
        this.isHot = isHot;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getCtid() {
        return ctid;
    }

    public void setCtid(Integer ctid) {
        this.ctid = ctid;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }



}
