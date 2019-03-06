package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 11:40
 * @Description:
 *          订单实体类
 */

public class Order {
    private Integer oid;
    private String orderNumber;
    private Double total;
    private Integer aid;
    private Integer payId;
    private String date;
    private Integer uid;

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    private Integer state;


    public Integer getOid() {
        return oid;
    }

    public void setOid(Integer oid) {
        this.oid = oid;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public Integer getPayId() {
        return payId;
    }

    public void setPayId(Integer payId) {
        this.payId = payId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    @Override
    public String toString() {
        return "Order{" +
                "oid=" + oid +
                ", orderNumber='" + orderNumber + '\'' +
                ", total=" + total +
                ", aid=" + aid +
                ", payId=" + payId +
                ", date='" + date + '\'' +
                ", uid=" + uid +
                '}';
    }
}
