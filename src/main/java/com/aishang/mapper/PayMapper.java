package com.aishang.mapper;

import com.aishang.po.Pay;

/**
 * @Author: ZGX
 * @Date: 2019/3/3 14:21
 * @Description:
 */

public interface PayMapper {

    // 根据银行卡账号查询Pay信息
    Integer checkAccount(String bankAccount);
    // 检查是否支付成功
    Integer checkPay(Pay pay);
}
