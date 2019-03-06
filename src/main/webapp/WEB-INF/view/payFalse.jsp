<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/3
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>支付失败</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhonglin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhongling2.js"></script>
</head>

<body style="position:relative;">

<!--header-->
<div class="zl-header">
    <div class="zl-hd w1200">
        <p class="hd-p1 f-l">
            Hi!您好，欢迎来到宅客微购，请登录 <a href="注册.html">【免费注册】</a>
        </p>
        <p class="hd-p2 f-r">
            <a href="index.html">返回首页 (个人中心)</a><span>|</span>
            <a href="购物车.html">我的购物车</a><span>|</span>
            <a href="我的订单.html">我的订单</a>
        </p>
        <div style="clear:both;"></div>
    </div>
</div>

<!--logo search weweima-->
<div class="logo-search w1200">
    <div class="logo-box f-l">
        <div class="logo f-l">
            <a href="index.html" title="中林logo"><img src="${pageContext.request.contextPath}/images/zl2-01.gif"/></a>
        </div>
        <div class="shangjia f-l">
            <a href="JavaScript:;" class="shangjia-a1">[ 切换城市 ]</a>
            <a href="JavaScript:;" class="shangjia-a2">商家入口</a>
            <div class="select-city">
                <div class="sl-city-top">
                    <p class="f-l">切换城市</p>
                    <a class="close-select-city f-r" href="JavaScript:;">
                        <img src="${pageContext.request.contextPath}/images/close-select-city.gif"/>
                    </a>
                </div>
                <div class="sl-city-con" style="height: 400px;overflow: auto">
                    <c:forEach items="${regionList}" var="region">
                        <dl>
                            <dt>${region.regionName}</dt>
                            <dd>
                                <c:forEach items="${regionMap[region.regionName]}" var="city">
                                    <a href="JavaScript:;">${city.regionName}</a>
                                </c:forEach>
                            </dd>
                            <div style="clear:both;"></div>
                        </dl>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div class="erweima f-r">
        <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-04.gif"/></a>
    </div>
    <div class="search f-r">
        <div class="search-info">
            <input type="text" placeholder="请输入商品名称"/>
            <button>搜索</button>
            <div style="clear:both;"></div>
        </div>
        <ul class="search-ul">
            <li><a href="JavaScript:;">绿豆</a></li>
            <li><a href="JavaScript:;">大米</a></li>
            <li><a href="JavaScript:;">驱蚊</a></li>
            <li><a href="JavaScript:;">洗面奶</a></li>
            <li><a href="JavaScript:;">格力空调</a></li>
            <li><a href="JavaScript:;">洗发</a></li>
            <li><a href="JavaScript:;">护发</a></li>
            <li><a href="JavaScript:;">葡萄</a></li>
            <li><a href="JavaScript:;">脉动</a></li>
            <li><a href="JavaScript:;">海鲜</a></li>
            <li><a href="JavaScript:;">水产</a></li>
            <div style="clear:both;"></div>
        </ul>
    </div>
    <div style="clear:both;"></div>
</div>

<!--内容开始-->
<div class="payment w1200">
    <div class="payment-hd">
        <h3>支付失败</h3>
    </div>
    <div class="payment-bd">
        <dl class="dl-hd">
            <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                <dt><a href="#"><img src="${pageContext.request.contextPath}/images/in-matong3.gif" /></a></dt>
                <dd>
                    <h3><a href="#">${orderItemExt.product.pName}</a></h3>
                </dd>
            </c:forEach>
            <div style="clear:both;"></div>
        </dl>
        <ul class="ul-bd">
            <li><span>送货至</span><p>${fn:split(address.addr,"-")[0]}  ${fn:split(address.addr,"-")[1]} </p></li>
            <li><span>价格</span><p><i>¥${orderExt.total}</i></p></li>
            <li><span>卖家名称</span><p>爱尚自营店</p></li>
            <li><span>收货信息</span><p>${address.addr}， ${address.name}， ${address.tel}</p></li>
            <li><span>成交时间</span><p>${orderExt.date}</p></li>
            <li><span>订单号</span><p>${orderExt.orderNumber}</p></li>
        </ul>
    </div>
    <div class="payment-ft">
        <button class="btn1">重新支付</button>
        <button class="btn2">我的订单</button>
    </div>
</div>

<!--底部一块-->
<div class="footer-box">
    <ul class="footer-info1 w1200">
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-86.gif"/></a>
            </div>
            <h3><a href="JavaScript:;">号码保障</a></h3>
            <P>所有会员，手机短信验证</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-87.gif"/></a>
            </div>
            <h3><a href="JavaScript:;">6*12小时客服</a></h3>
            <P>有任何问题随时免费资讯</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-88.gif"/></a>
            </div>
            <h3><a href="JavaScript:;">专业专攻</a></h3>
            <P>我们只专注于建筑行业的信息服务</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-89.gif"/></a>
            </div>
            <h3><a href="JavaScript:;">注册有礼</a></h3>
            <P>随时随地注册有大礼包</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-90.gif"/></a>
            </div>
            <h3><a href="JavaScript:;">值得信赖</a></h3>
            <P>专业的产品，专业的团队</P>
        </li>
        <div style="clear:both;"></div>
    </ul>
    <div class="footer-info2 w1200">
        <div class="ft-if2-left f-l">
            <dl>
                <dt><a href="6-1服务协议.html">新手上路</a></dt>
                <dd>
                    <a href="6-1服务协议.html">购物流程</a>
                    <a href="6-1服务协议.html">在线支付</a>
                    <a href="6-1服务协议.html">投诉与建议</a>
                </dd>
            </dl>
            <dl>
                <dt><a href="6-1服务协议.html">配送方式</a></dt>
                <dd>
                    <a href="6-1服务协议.html">货到付款区域</a>
                    <a href="6-1服务协议.html">配送费标准</a>
                </dd>
            </dl>
            <dl>
                <dt><a href="6-1服务协议.html">购物指南</a></dt>
                <dd>
                    <a href="6-1服务协议.html">订购流程</a>
                    <a href="6-1服务协议.html">购物常见问题</a>
                </dd>
            </dl>
            <dl>
                <dt><a href="6-1服务协议.html">售后服务</a></dt>
                <dd>
                    <a href="6-1服务协议.html">售后服务保障</a>
                    <a href="6-1服务协议.html">退换货政策总则</a>
                    <a href="6-1服务协议.html">自营商品退换细则</a>
                </dd>
            </dl>
            <div style="clear:both;"></div>
        </div>
        <div class="ft-if2-right f-r">
            <h3>400-2298-223</h3>
            <p>周一至周日 9:00-24:00</p>
            <p>（仅收市话费）</p>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div class="footer-info3 w1200">
        <p>
            <a href="#">免责条款</a><span>|</span>
            <a href="#">隐私保护</a><span>|</span>
            <a href="#">咨询热点</a><span>|</span>
            <a href="#">联系我们</a><span>|</span>
            <a href="#">公司简介</a>
        </p>
        <p>
            <a href="#">沪ICP备13044278号</a><span>|</span>
            <a href="#">合字B1.B2-20130004</a><span>|</span>
            <a href="#">营业执照</a><span>|</span>
            <a href="#">互联网药品信息服务资格证</a><span>|</span>
            <a href="#">互联网药品交易服务资格证</a>
        </p>
        <div class="ft-if3-tu1">
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-91.gif"/></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-92.gif"/></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-93.gif"/></a>
        </div>
    </div>
</div>
</body>
</html>

