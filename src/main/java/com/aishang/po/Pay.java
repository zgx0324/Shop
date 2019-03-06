package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/3/3 10:48
 * @Description:
 */

public class Pay {
    private Integer payID;
    private Integer bankID;
    private String bankName;
    private String bankAccount;
    private Integer bankPass;
    private Integer uid;

    public Integer getPayID() {
        return payID;
    }

    public void setPayID(Integer payID) {
        this.payID = payID;
    }

    public Integer getBankID() {
        return bankID;
    }

    public void setBankID(Integer bankID) {
        this.bankID = bankID;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public Integer getBankPass() {
        return bankPass;
    }

    public void setBankPass(Integer bankPass) {
        this.bankPass = bankPass;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }
}
