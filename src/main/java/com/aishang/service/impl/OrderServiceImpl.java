package com.aishang.service.impl;

import com.aishang.dao.RedisDao;
import com.aishang.mapper.*;
import com.aishang.po.*;
import com.aishang.service.CategorySecondService;
import com.aishang.service.CategoryService;
import com.aishang.service.OrderService;
import com.aishang.util.JsonUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 11:52
 * @Description:
 *             订单的service实体类
 */
@Service
public class OrderServiceImpl implements OrderService {
    //TODO 注入参数
    @Resource
    private AddressMapper addressMapper;
    @Resource
    private ProductMapper productMapper;
    @Resource
    private RegionMapper regionMapper;
    @Resource
    private OrderMapper orderMapper;
    @Resource
    private OrderItemMapper orderItemMapper;
    @Resource
    private PayMapper payMapper;
    @Resource
    private RedisDao redisDao;
    @Resource
    private CategoryService categoryService;
    @Resource
    private CategorySecondService categorySecondService;


    //根据用户ID获得地址集合
    @Override
    public List<Address> getAddressAll(Integer uid) {
       return addressMapper.getAddressAll(uid);
    }

    //根据商品ID获得商品信息
    @Override
    public Product getProductByID(Integer pid) {
        return productMapper.getProductByID(pid);
    }
    // 根据地址ID获取地址信息
    @Override
    public Address getAddressByAid(Integer aid) {
        return addressMapper.getAddressByAid(aid);
    }

    //获得全国所有省份集合
    @Override
    public List<Region> getAllProvince() {
        return regionMapper.getAllProvince();
    }
    // 根据省份ID获取该省下属城市
    @Override
    public List<Region> getCityByProvinceID(Integer id) {
        return regionMapper.getCityByProvinceID(id);
    }
    //返回回显的城市map
    @Override
    public Map<String, List<Region>> getRegionMap() {
        Map<String,List<Region>> regionMap = new HashMap<String,List<Region>>();
        for (Region region:getAllProvince()) {
            regionMap.put(region.getRegionName(),getCityByProvinceID(region.getId()));
        }
        return regionMap;
    }

    // 添加待付款订单
    @Override
    public Integer addOrderWithoutPay(OrderExt orderExt) {
        if(orderMapper.getOrderByOrderNumber(orderExt.getOrderNumber()).size()==0) {
            //添加订单
            orderExt.setPayId(0);
            orderExt.setState(0);
            orderMapper.addOrder(orderExt);
            //获取oid
            Integer oid = orderMapper.getOid(orderExt);
            // 添加订单项
            for (OrderItemExt orderItemExt : orderExt.getOrderItemExtsList()) {
                orderItemExt.setOid(oid);
                Date date = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                orderItemExt.setOrderItemDate(sdf.format(date));
                orderItemMapper.addOrderItem(orderItemExt);
            }
            return oid;
        }else{
            return null;
        }

    }
    // 根据订单oid 查询并返回OrderExt对象
    @Override
    public OrderExt getOrderExtByOid(Integer oid) {
        System.out.println(oid+"=======================================");
        OrderExt orderExt = orderMapper.getOrderByoid(oid);
        List<OrderItemExt> orderItemExtList = orderItemMapper.getOrderitemListByOid(oid);
        for (OrderItemExt orderItemExt:orderItemExtList ) {
            orderItemExt.setProduct(productMapper.getProductByID(orderItemExt.getPid()));
        }
        orderExt.setOrderItemExtsList(orderItemExtList);
        return orderExt;
    }
    // 根据银行卡账号查询Pay信息
    @Override
    public Integer checkAccount(String bankAccount) {
        return payMapper.checkAccount(bankAccount);
    }



    // 检查是否支付成功若支付成功修改订单支付状态
    @Override
    public boolean checkPay(Pay pay,Integer withoutPayOid,Integer uid) {
        boolean flag=false;
        Integer i = payMapper.checkPay(pay);
        if(i>0){
            Order order = new Order();
            order.setOid(withoutPayOid);
            order.setPayId(i);// 填入支付方式id
            order.setState(1);//更改为已支付状态
            orderMapper.updatePayIDByOid(order);

            List<OrderItemExt> orderItemExtList = orderItemMapper.getOrderitemListByOid(withoutPayOid);
            List<String> pidList = new ArrayList<String>();
            for (OrderItemExt orderItemExt:orderItemExtList ) {
                productMapper.updateStock(orderItemExt);//下单成功更改库存
                pidList.add(orderItemExt.getPid()+"");
            }
            delBasket(pidList,"basket"+uid);//下单成功将已下单商品从购物车中移除
            flag=true;
        }
        return flag;
    }
    //返回以state字段为四种订单状态所定义的map集合
    @Override
    public Map<Long,List<OrderExt>> getOrderGroupMap() {
        Map<Long,List<OrderExt>> orderGroupMap = new HashMap<Long,List<OrderExt>>();
        for (Integer i=0;i<4;i++){
            List<OrderExt> orderExtList= orderMapper.getOrderByState(i);
            for (OrderExt orderExt:orderExtList) {
                List<OrderItemExt> orderItemList = orderItemMapper.getOrderitemListByOid(orderExt.getOid());
                orderExt.setOrderItemExtsList(orderItemList);
                for (OrderItemExt orderItemExt:orderItemList) {
                    Product product = productMapper.getProductByID(orderItemExt.getPid());
                    orderItemExt.setProduct(product);
                }
            }
            orderGroupMap.put(i.longValue(),orderExtList);
        }

        return orderGroupMap;
    }

    //TODO 购物车操作

    //添加至购物车
    @Override
    public void addBasket(OrderItemExt orderItem, Integer uid) {
        List<OrderItemExt> orderItems = null;
        //判断该用户是否存在购物车
       if(redisDao.existsKeys("basket"+uid)){
           String strings = redisDao.getBasket("basket" + uid);
           orderItems=JsonUtils.jsonToList(strings);
           boolean isExist = false;
           //如果商品id存在证明购物车中已有该商品，则只需将两个订单项商品数相加
           for (OrderItemExt orderItem1:orderItems) {
               if(orderItem1.getPid()==orderItem.getPid()){
                   isExist=true;
                   orderItem1.setCount(orderItem1.getCount()+orderItem.getCount());
                   break;
               }
           }
           //如果不存在则向集合中加入该商品的订单项
           if(!isExist){
               orderItems.add(orderItem);
           }

       }else{//如果不存在购物车则创建购物车
           orderItems = new ArrayList<OrderItemExt>();
           orderItems.add(orderItem);
       }
        String listToJson = JsonUtils.listToJson(orderItems);
        redisDao.addBasket("basket"+uid,listToJson);
    }

    //拿到购物车中商品集合
    @Override
    public List<OrderItemExt> getBasket(String key) {
        String basket = redisDao.getBasket(key);
        List<OrderItemExt> orderItems = JsonUtils.jsonToList(basket);
        return orderItems;
    }

    //删除购物车商品集合列表
    @Override
    public void delBasket(List<String> pidList,String key) {
        //先拿到该用户的购物车得到商品集合判断要删除的商品将其从集合中移除
        //，并重新生成json字符串添加至redis中
        String basket = redisDao.getBasket(key);
        List<OrderItemExt> orderItems = JsonUtils.jsonToList(basket);
        List<OrderItemExt> delorderItems = JsonUtils.jsonToList(basket);
        Iterator<OrderItemExt> iterator = orderItems.iterator();
        while (iterator.hasNext()){
            OrderItemExt next = iterator.next();
            for (String pid: pidList) {
                if(pid!=null){
                    if((next.getPid()+"").equals(pid)){
                        delorderItems.add(next);
                        break;
                    }
                }
            }
        }
        for (OrderItemExt orderItem:delorderItems) {
            orderItems.remove(orderItem);
        }
        String listToJson = JsonUtils.listToJson(orderItems);
        System.out.println(listToJson);
        redisDao.addBasket(key,listToJson);
    }



    //TODO 类目查询操作
    // 返回一级类目列表
    @Override
    public List<Category> findCategoryAll() {
        return categoryService.findAll();
    }

    // 返回二级类目CategorySecondExt列表其中包括该类目下的三级类目
    @Override
    public List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid) {
        return categorySecondService.findAllByCid(cid);
    }

    // 获取二级类目map<cid,categorySecondList>集合
    @Override
    public Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList) {
        Map<Integer, List<CategorySecondExt>> categorySecondMap = new HashMap<Integer, List<CategorySecondExt>>();
        for (Category category : categoryList) {
            List<CategorySecondExt> categorySecondList = findCategorySecondExtAllByCid(category.getCid());
            categorySecondMap.put(category.getCid(), categorySecondList);
        }
        return categorySecondMap;
    }


    //TODO 订单管理

    // 删除订单
    @Override
    public void delOrder(List<String> oidList) {
        for (String oid:oidList) {
            if(oid!=null&&!"".equals(oid.trim())){
                orderMapper.delOrder(Integer.parseInt(oid));
                orderItemMapper.delOrderItem(Integer.parseInt(oid));
            }

        }
    }

    //根据用户id和支付密码判断是否存在该账户
    @Override
    public boolean checkFirmProduct(OrderExt orderExt, String bankPass) {
        Integer a = payMapper.checkFirmProduct(orderExt.getUid(),bankPass);

        if(a>0){
            orderMapper.updatePayIDByOid(orderExt);
            return true;
        }else{
            return false;
        }

    }
    //分页查询历史订单
    @Override
    public List<OrderExt> getOrderPageBeanList(OrderBean orderBean) {
        // 得到该用户的订单总数
        orderBean.setTotalCount(orderMapper.getTotalCount(orderBean));
        // 返回历史订单集合
        List<OrderExt> orderPageBeanList = orderMapper.getOrderPageBeanList(orderBean);
        for (OrderExt orderExt : orderPageBeanList) {
            List<OrderItemExt> orderitemListByOid = orderItemMapper.getOrderitemListByOid(orderExt.getOid());
            for (OrderItemExt orderItemExt : orderitemListByOid) {
                Product productByID = productMapper.getProductByID(orderItemExt.getPid());
                orderItemExt.setProduct(productByID);
            }
            orderExt.setOrderItemExtsList(orderitemListByOid);
        }
        return orderPageBeanList;
    }

}
