package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 11:40
 * @Description: 订单项实体类
 */

public class OrderItem {
    private Integer orderItemID;
    private Integer pid;
    private Integer count;
    private Double subTotal;
    private Integer oid;
    private String orderItemDate;

    public Integer getOrderItemID() {
        return orderItemID;
    }

    public void setOrderItemID(Integer orderItemID) {
        this.orderItemID = orderItemID;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Double subTotal) {
        this.subTotal = subTotal;
    }

    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public String getOrderItemDate() {
        return orderItemDate;
    }

    public void setOrderItemDate(String orderItemDate) {
        this.orderItemDate = orderItemDate;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemID=" + orderItemID +
                ", pid=" + pid +
                ", count=" + count +
                ", subTotal=" + subTotal +
                ", oid=" + oid +
                ", orderItemDate='" + orderItemDate + '\'' +
                '}';
    }
}
