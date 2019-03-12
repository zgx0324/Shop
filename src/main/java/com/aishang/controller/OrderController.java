package com.aishang.controller;

import com.aishang.po.*;
import com.aishang.service.OrderService;
import com.aishang.util.PublicUtil;
import com.sun.org.apache.xpath.internal.operations.Mod;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.json.*;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 11:51
 * @Description: 订单控制器
 */
@Controller
@RequestMapping("order")
public class OrderController {

    // TODO 注入参数
    @Resource
    private OrderService orderService;
    @Resource
    private HttpSession session;

    //TODO 跳转页面

    // 去往确认订单页面
    @RequestMapping("firmOrder")
    public String firmOrder(Model model, OrderExt orderExt, OrderItemExt orderItemExt) {
        User user = (User) session.getAttribute("user");
        orderExt.setUid(user.getUid());
        orderExt.setOrderNumber(PublicUtil.getOrderIdByUUId());// 封装订单编号
        if (orderExt != null) {
            if (orderExt.getOrderItemExtsList() != null) {
                List<OrderItemExt> lists = new ArrayList<OrderItemExt>();
                for (OrderItemExt orderItemExt1 : orderExt.getOrderItemExtsList()) {
                    if (orderItemExt1.getPid() != null) {
                        // 向orderItemExt1中添加product对象
                        Product product = orderService.getProductByID(orderItemExt1.getPid());
                        orderItemExt1.setProduct(product);
                    } else {
                        lists.add(orderItemExt1);
                    }

                }
                if (lists.size() > 0) {
                    for (OrderItemExt list : lists) {
                        orderExt.getOrderItemExtsList().remove(list);
                    }
                }
            }
        }
        if (orderItemExt != null) {
            if (orderItemExt.getPid() != null && orderItemExt.getCount() != null) {
                // 向orderItemExt中添加product对象
                Product product = orderService.getProductByID(orderItemExt.getPid());
                orderItemExt.setProduct(product);
                orderExt.setTotal(product.getMarketPrice()*orderItemExt.getCount());
                // 向oderExt中添加orderItemExtList订单项集合
                List<OrderItemExt> orderItemExtList = new ArrayList<OrderItemExt>();
                orderItemExtList.add(orderItemExt);
                orderExt.setOrderItemExtsList(orderItemExtList);
            }
        }

        model.addAttribute("orderExt", orderExt);
        model.addAttribute("chooseAddress", orderService.getAddressByAid(orderExt.getAid()));//返回回显的地址对象
        model.addAttribute("addressList", orderService.getAddressAll(user.getUid()));//根据用户id向前台返回地址集合列表
        model.addAttribute("regionList", orderService.getAllProvince());//返回所有全国省份集合
        model.addAttribute("regionMap", orderService.getRegionMap());//返回回显的城市map
        return "firmOrder";
    }

    //去往确认收货页面
    @RequestMapping("firmProduct")
    public String firmProduct(Integer oid, Model model) {
        OrderExt orderExt = orderService.getOrderExtByOid(oid);
        Address address = orderService.getAddressByAid(orderExt.getAid());

        model.addAttribute("orderExt", orderExt);
        model.addAttribute("address", address);
        model.addAttribute("categoryList", orderService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", orderService.categorySecondMap(orderService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "firmProduct";
    }
    //确认收货
    @RequestMapping("checkFirmProduct")
    @ResponseBody
    public String checkFirmProduct(OrderExt orderExt,String bankPass){
        orderExt.setState(3);
       boolean flag=orderService.checkFirmProduct(orderExt,bankPass);
       if(flag){
           return "ok";
       }else{
           return "fail";
       }

    }

    //去往我的订单页面
    @RequestMapping("toMyOrder")
    public String toMyOrder(Model model) {
        Map<Long, List<OrderExt>> orderGroupMap = orderService.getOrderGroupMap();

        model.addAttribute("orderGroupMap", orderGroupMap);//返回以state字段为四种订单状态所定义的map集合
        model.addAttribute("categoryList", orderService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", orderService.categorySecondMap(orderService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "myOrder";
    }
    // 去往购买记录页面
    @RequestMapping("toGetOrderAll")
    public String toGetOrderAll(Model model,OrderBean orderBean){
        User user = (User) session.getAttribute("user");
        orderBean.setPageSize(5);

        OrderExt orderExt = new OrderExt();
        orderExt.setUid(user.getUid());
        orderBean.setOrderExt(orderExt);
        List<OrderExt> orderExtList=orderService.getOrderPageBeanList(orderBean);

        //交易状态map
        Map<Integer,String> map = new HashMap<Integer,String>();
        map.put(0,"待付款");
        map.put(1,"待发货");
        map.put(2,"待收货");
        map.put(3,"已收货");

        model.addAttribute("map",map);
        model.addAttribute("orderBean",orderBean);
        model.addAttribute("orderExtList",orderExtList);//返回订单列表
        model.addAttribute("categoryList", orderService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", orderService.categorySecondMap(orderService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "buyHistory";
    }

    // 去往管理地址页面
    @RequestMapping("toManagerAddress")
    public String toManagerAddress(Model model){
        User user = (User) session.getAttribute("user");
        List<Address> addressAll = orderService.getAddressAll(user.getUid());

        model.addAttribute("addressAll", addressAll);//该用户的地址集合
        model.addAttribute("categoryList", orderService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", orderService.categorySecondMap(orderService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        model.addAttribute("regionList", orderService.getAllProvince());//返回所有全国省份集合
        model.addAttribute("regionMap", orderService.getRegionMap());//返回回显的城市map
        return "manageAddress";
    }

    // 去往支付页面
    @RequestMapping("toPay")
    public String toPay(OrderExt orderExt, Model model, Integer withoutPayOid) {
        if (withoutPayOid == null) {
            User user = (User) session.getAttribute("user");
            orderExt.setUid(user.getUid());
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            orderExt.setDate(sdf.format(date));
            // 添加待付款订单 返回该订单oid
            withoutPayOid = orderService.addOrderWithoutPay(orderExt);
        }
        model.addAttribute("regionList", orderService.getAllProvince());//返回所有全国省份集合
        model.addAttribute("withoutPayOid", withoutPayOid);//返回该待支付订单oid
        model.addAttribute("regionMap", orderService.getRegionMap());//返回回显的城市map
        return "pay";
    }
    //TODO  支付

    // 支付订单
    @RequestMapping("payForOrder")
    public String payForOrder(Model model, Pay pay, Integer withoutPayOid) {
        User user = (User) session.getAttribute("user");
        //根据待支付订单信息查询出订单，订单项集合（包括商品）OrderExt对象返回前台
        OrderExt orderExt = orderService.getOrderExtByOid(withoutPayOid);
        Address address = orderService.getAddressByAid(orderExt.getAid());
        model.addAttribute("orderExt", orderExt);
        model.addAttribute("address", address);
        if (orderService.checkPay(pay, withoutPayOid, user.getUid())) {
            return "paySuccess";
        } else {
            return "payFalse";
        }

    }

    // ajax检查银行或支付宝账号是否存在
    @RequestMapping("checkAccount")
    public void checkAccount(String bankAccount, HttpServletResponse response) {
        if (orderService.checkAccount(bankAccount) > 0) {
            try {
                response.getWriter().print("ok");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    //TODO 购物车

    //添加商品到购物车
    @RequestMapping("addBasket")
    public void addBasket(OrderItemExt orderItemExt, HttpServletResponse response) {
        try {
            PrintWriter out = response.getWriter();
            User user = (User) session.getAttribute("user");
            orderService.addBasket(orderItemExt, user.getUid());
            out.print("ok");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //请求转发到购物车页面
    @RequestMapping("toBasket")
    public String toBasket(Model model) {
        User user = (User) session.getAttribute("user");
        List<OrderItemExt> orderItems = orderService.getBasket("basket" + user.getUid());
        for (OrderItemExt orderItemExt : orderItems) {
            orderItemExt.setProduct(orderService.getProductByID(orderItemExt.getPid()));
        }
        model.addAttribute("orderItems", orderItems);
        return "basket";
    }

    //删除购物车中的商品
    @RequestMapping("del")
    public void del(String pids, HttpServletResponse response, String pid) {
        User user = (User) session.getAttribute("user");
        try {
            PrintWriter out = response.getWriter();
            if (pids != null) {
                JSONArray jsonArray = JSONArray.fromObject(pids);
                List<String> pidList = (List<String>) JSONArray.toCollection(jsonArray);
                orderService.delBasket(pidList, "basket" + user.getUid());
                out.print("ok");
            }
            if (pid != null) {
                List<String> pidList = new ArrayList<String>();
                pidList.add(pid);
                orderService.delBasket(pidList, "basket" + user.getUid());
                out.print("ok");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //TODO 订单管理

    //删除订单
    @RequestMapping("deleteOrder")
    @ResponseBody
    public String deleteOrder(String oids, String oid) {
        if (oid != null) {
            List<String> oidList = new ArrayList<String>();
            oidList.add(oid);
            orderService.delOrder(oidList);
        }
        if (oids != null) {
            JSONArray jsonArray = JSONArray.fromObject(oids);
            List<String> oidList = (List<String>) JSONArray.toCollection(jsonArray);
            orderService.delOrder(oidList);
        }
        return "ok";
    }
}
