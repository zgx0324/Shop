<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/7
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>我的订单</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css"/>
    <style type="text/css">
        .nav {
            margin-top: 20px
        }

        .nav li {
            float: left;
            cursor: pointer;
        }

        .nav .current {
            border-bottom: 2px solid #F34737;
            margin-bottom: -2px;
        }

        .nav .current a {
            color: #F34737;
        }

        .nav li:hover {
            border-bottom: 2px solid #F34737;
            margin-bottom: -2px;
        }

        .nav li:hover a {
            color: #F34737;
        }

        .li a {
            display: block;
            font-size: 16px;
            color: #3B3B3B;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhonglin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhongling2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/show-login.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/htmleaf-demo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style-1.css">
    <script type="text/javascript">
        $(function () {
            if("${user}"==""){
                $("#personal").attr("href","javascript:showDialog()")
                $("#basket").attr("href","javascript:showDialog()")
                $("#myorder").attr("href","javascript:showDialog()")
            }
            var loginPass = $("[name='loginPass']");
            var loginName = $("[name='loginName']");
            var arr = document.cookie.split("; ");
            var name = "";
            var pass="";
            for (var i = 0; i < arr.length; i++) {
                var arr2 = arr[i].split("=");
                if (arr2[0] == "userName") {
                    name = decodeURI(arr2[1]);
                    loginName.val(name);
                }
                if (arr2[0] == "passWord") {
                    pass = decodeURI(arr2[1]);
                    loginPass.val(pass);
                }

            }

            $("#loginName").blur(function() {
                if (loginName.val() == '') {
                    loginName.val(name);
                }
            });
            $("#loginPass").blur(function() {
                if (loginPass.val() == '') {
                    loginPass.val(pass);
                }
            });
            $("#login").click(function () {
                var remember=null;
                if($("[name='remember']").attr("checked")=="checked"){
                    remember="remember";
                }
                if(loginPass.val().trim()!="" && loginName.val().trim()!=""){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/ajaxDoLogin.do",
                        data:{
                            remember:remember,
                            userName:loginName.val(),
                            passWord:loginPass.val(),
                        },
                        success:function (data) {
                            if(data=="ok"){
                                alert("登陆成功请重新操作")
                                $("#mask").hide();
                                $("#dialogMove").hide();
                                $("#personal").attr("href","${pageContext.request.contextPath}/user/personal.do")
                                $("#basket").attr("href","${pageContext.request.contextPath}/order/toBasket.do")
                                $("#myorder").attr("href","${pageContext.request.contextPath}/order/toMyOrder.do")
                            }else{
                                alert("登录失败")
                            }
                        }
                    })
                }else{
                    alert("请填写用户名及密码")
                }
            })
        })
    </script>
    <script type="text/javascript">
        //全选
        function selectAll(id) {
            if ($("#s" + id).attr("checked") == "checked") {
                $('input:checkbox').prop("checked", 'checked')
            } else {
                $('input:checkbox').prop("checked", '')
            }
        }

        function sel(id) {
            if (!($("#hobby" + id).attr("checked") == "checked")) {
                $("#s1").prop("checked", "")
                $("#s2").prop("checked", "")
            }
        }

        //按state分类列表的onclick事件
        function fun(i) {
            $("#li" + i).attr("class", "current");
            $("#div" + i).css({display: "inline"});
            if (i == 0) {
                $("#top").html("全选");
                $("#s1").show()
                $("#bottom").show()
            } else {
                $("#s1").hide();
                $("#bottom").hide()
                if (i == 1) {
                    $("#top").html("买家已付款");
                } else if (i == 2) {
                    $("#top").html("卖家已发货");
                }
            }
            for (var j = 0; j < 4; j++) {
                if (j != i) {
                    $("#li" + j).attr("class", "");
                    $("#div" + j).css({display: "none"});
                }
            }
        }

        //单条删除
        function shanchu(oid) {
            var i = $("#del" + oid).parent().find("input").val()
            if (confirm("确定删除该订单？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/deleteOrder.do",
                    data: {
                        oid: oid,
                    },
                    success: function (data) {
                        if (data == "ok") {
                            alert("删除成功")
                            $("#span" + oid).remove()
                            $("#span" + i).html(Number($("#span" + i).html()) - 1);
                        }
                    }

                })
            }
        }


        //批量删除
        $(function () {
            $("#delAll").click(function () {
                if (confirm("确定删除选中的订单？")) {
                    var oid = new Array();
                    var i = 0;
                    var a = 0;
                    $("[name='hobby']").each(function () {
                        if ($(this).attr("checked") == "checked") {
                            oid[i] = $(this).val();
                            i++;
                            if ($(this).val() != "") {
                                a = $(this).parent().find("input[type=hidden]").val();
                            }
                        }
                    })
                    $.ajax({
                        url: "${pageContext.request.contextPath}/order/deleteOrder.do",
                        data: {
                            oids: JSON.stringify(oid),
                        },
                        success: function (data) {
                            if (data == "ok") {
                                var y = 0;
                                for (var j = 0; j < oid.length; j++) {
                                    if (oid[j] != "") {
                                        $("#span" + oid[j]).remove()
                                        y++;
                                    }
                                }
                                $("#span" + a).html(Number($("#span" + a).html()) - y);
                                alert("删除成功")
                            }
                        }
                    })
                }
            })

        })
        //再次购买
        $(function () {
            $("[name=buyAgain]").click(function () {
                var count=$(this).children("[name=buyAgainNumber]").val()
                var pid=$(this).children("[name=buyAgainPid]").val()
                var subTotal=$(this).children("[name=buyAgainSubTotal]").val()
                location.href="${pageContext.request.contextPath}/order/firmOrder.do?count="+count+"&pid="+pid+"&subTotal="+subTotal
            })
        })
    </script>
</head>

<body style="position:relative;">

<!--header-->
<div class="zl-header">
    <div class="zl-hd w1200">
        <p class="hd-p1 f-l">
            Hi!您好，欢迎来到宅客微购，请<a href="${pageContext.request.contextPath}/login.do">登录</a>
            <a href="${pageContext.request.contextPath}/register.do">【免费注册】</a>
        </p>
        <p class="hd-p2 f-r">
            <a href="${pageContext.request.contextPath}/aishang/index.do">返回首页</a><span>|</span>
            <a href="${pageContext.request.contextPath}/user/personal.do" id="personal">个人中心</a><span>|</span>
            <a href="${pageContext.request.contextPath}/order/toBasket.do" id="basket">我的购物车</a><span>|</span>
            <a href="${pageContext.request.contextPath}/order/toMyOrder.do" id="myorder">我的订单</a>
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
            <form action="${pageContext.request.contextPath}/aishang/searchProduct.do" method="post">
                <input type="text" name="selectpName" placeholder="请输入商品名称" value="${productBean.selectpName}"/>
                <button>搜索</button>
            </form>
            <div style="clear:both;"></div>
        </div>
    </div>
    <div style="clear:both;"></div>
</div>

<!--nav-->
<div class="nav-box">
    <div class="nav-kuai w1200">
        <div class="nav-kuaijie yjp-hover1 f-l">
            <a href="JavaScript:;" class="kj-tit1">商品分类快捷</a>
            <div class="kuaijie-box yjp-show1" style="display:none;">
                <c:forEach items="${categoryList}" var="category">
                    <div class="kuaijie-info">
                        <dl class="kj-dl1">
                            <dt><img src="${pageContext.request.contextPath}/images/zl2-07.gif"/><a
                                    href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${category.cid}">${category.cname}</a>
                            </dt>
                            <dd>
                                <c:forEach items="${categorySecondMap[category.cid]}" var="categorySecond"
                                           varStatus="vs">
                                    <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCsid=${categorySecond.csid}">${categorySecond.csname}</a><c:if
                                        test="${!vs.last}"><span>|</span></c:if>
                                </c:forEach>
                            </dd>
                        </dl>
                        <div class="kuaijie-con">
                            <c:forEach items="${categorySecondMap[category.cid]}" var="categorySecond">
                                <dl class="kj-dl2">
                                    <dt>
                                        <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCsid=${categorySecond.csid}">${categorySecond.csname}</a>
                                    </dt>
                                    <dd>
                                        <c:forEach items="${categorySecond.categoryThirdList}" var="categoryThird"
                                                   varStatus="vs">
                                            <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCtid=${categoryThird.ctid}">${categoryThird.ctname}</a><c:if
                                                test="${!vs.last}"><span>|</span></c:if>
                                        </c:forEach>
                                    </dd>
                                </dl>
                            </c:forEach>
                            <div style="clear:both;"></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
</div>


<!--内容开始-->
<div class="personal w1200">
    <div class="personal-left f-l">
        <div class="personal-l-tit">
            <h3>个人中心</h3>
        </div>
        <ul>
            <li class="per-li2"><a href="${pageContext.request.contextPath}/user/personal.do">个人资料<span>></span></a></li>
            <li class="current-li per-li3"><a href="${pageContext.request.contextPath}/order/toMyOrder.do">我的订单<span>></span></a></li>
            <li class="per-li5"><a href="${pageContext.request.contextPath}/order/toBasket.do">购物车<span>></span></a></li>
            <li class="per-li6"><a href="${pageContext.request.contextPath}/order/toManagerAddress.do">管理收货地址<span>></span></a></li>
            <li class="per-li8"><a href="${pageContext.request.contextPath}/order/toGetOrderAll.do">购买记录<span>></span></a></li>
        </ul>
    </div>
    <div class="order-right f-r">
        <div class="order-hd">
            <dl class="f-l">
                <dt>
                    <a href="${pageContext.request.contextPath}/user/personal.do"><img src="${pageContext.request.contextPath}${user.iconPath}"
                                     style="width:70px;height:70px"/></a>
                </dt>
                <dd>
                    <h3><a href="#">${user.name}</a></h3>
                    <p>${user.userName}</p>
                </dd>
                <div style="clear:both;"></div>
            </dl>
            <ul class="nav">
                <li class="current" id="li0"><a href="JavaScript:;" id="state0"
                                                onclick="fun(0)">待付款 <span
                        id="span0">${fn:length(orderGroupMap[0])}</span></a></li>
                <li id="li1"><a href="JavaScript:;" id="state1" onclick="fun(1)">待发货 <span
                        id="span1">${fn:length(orderGroupMap[1])}</span></a>
                </li>
                <li id="li2"><a href="JavaScript:;" id="state2" onclick="fun(2)">待收货 <span
                        id="span2">${fn:length(orderGroupMap[2])}</span></a>
                </li>
                <li id="li3"><a href="JavaScript:;" id="state3" onclick="fun(3)">已收货 <span
                        id="span3">${fn:length(orderGroupMap[3])}</span></a>
                </li>
                <div style="clear:both;"></div>
            </ul>
        </div>
        <div class="order-md">
            <div class="md-tit">
                <h3>我的订单</h3>
            </div>
            <div class="md-hd">
                <P class="md-p1"><input type="checkbox" name="hobby" value="" onchange="selectAll(1)"
                                        id="s1"></input><span id="top">全选</span></P>
                <p class="md-p2">商品信息</p>
                <p class="md-p3">规格</p>
                <p class="md-p4">单价（元）</p>
                <p class="md-p5">金额（元）</p>
                <p class="md-p6">操作</p>
            </div>

            <div class="md-info" id="div0">
                <c:forEach items="${orderGroupMap[0]}" var="orderExt">
                    <span id="span${orderExt.oid}">
                        <div class="dai" style="margin-top: 10px">
                                <input type="hidden" value="0"/>
                                <input type="checkbox" name="hobby" value="${orderExt.oid}" id="hobby${orderExt.oid}"
                                       onchange="sel(${orderExt.oid})"/>
                                订单号：${orderExt.orderNumber}
                            </div>
                                <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                                    <div class="dai-con" \>
                                    <dl class="dl1">
                                        <dt>
                                            <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${orderItemExt.pid}" class="f-l"><img
                                                    src="${pageContext.request.contextPath}/images/dai.gif"/></a>
                                            <div style="clear:both;"></div>
                                        </dt>
                                        <dd>
                                            <p>${orderItemExt.product.pName}</p>
                                            <span>X ${orderItemExt.count}</span>
                                        </dd>
                                        <div style="clear:both;"></div>
                                    </dl>
                                    <div class="dai-right f-l">
                                        <P class="d-r-p1">颜色：蓝色<br/>尺码：XL</P>
                                        <p class="d-r-p2">¥ ${orderItemExt.product.marketPrice}</p>
                                        <p class="d-r-p3">¥ ${orderItemExt.subTotal}</p>
                                    </div>
                                    <div style="clear:both;"></div>
                                </div>
                                </c:forEach>
                            <div style="width: 961px;height :20px">
                            <div style="float: right">
                                <input type="hidden" value="0"/>
                                <a href="${pageContext.request.contextPath}/order/toPay.do?withoutPayOid=${orderExt.oid}"
                                   onclick="fukuan(${orderExt.oid})">付款</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="JavaScript:;" id="del${orderExt.oid}" onclick="shanchu(${orderExt.oid})">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                    </span>
                </c:forEach>
            </div>
            <div class="md-info" id="div1" style="display: none">
                <c:forEach items="${orderGroupMap[1]}" var="orderExt">
                    <div class="dai" style="margin-top: 10px">
                        订单号：${orderExt.orderNumber}
                    </div>
                    <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                        <div class="dai-con">
                            <dl class="dl1">
                                <dt>
                                    <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${orderItemExt.pid}" class="f-l"><img
                                            src="${pageContext.request.contextPath}/images/dai.gif"/></a>
                                    <div style="clear:both;"></div>
                                </dt>
                                <dd>
                                    <p>${orderItemExt.product.pName}</p>
                                    <span>X ${orderItemExt.count}</span>
                                </dd>
                                <div style="clear:both;"></div>
                            </dl>
                            <div class="dai-right f-l">
                                <P class="d-r-p1">颜色：蓝色<br/>尺码：XL</P>
                                <p class="d-r-p2">¥ ${orderItemExt.product.marketPrice}</p>
                                <p class="d-r-p3">¥ ${orderItemExt.subTotal}</p>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                    </c:forEach>
                    <div style="width: 961px;height :20px">
                        <div style="float: right">
                            <input type="hidden" value="0"/>
                            <a href="JavaScript:;">提醒发货</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="md-info" id="div2" style="display: none">
                <c:forEach items="${orderGroupMap[2]}" var="orderExt">
                    <div class="dai" style="margin-top: 10px">
                        订单号：${orderExt.orderNumber}
                    </div>
                    <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                        <div class="dai-con">
                            <dl class="dl1">
                                <dt>
                                    <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${orderItemExt.pid}" class="f-l"><img
                                            src="${pageContext.request.contextPath}/images/dai.gif"/></a>
                                    <div style="clear:both;"></div>
                                </dt>
                                <dd>
                                    <p>${orderItemExt.product.pName}</p>
                                    <span>X ${orderItemExt.count}</span>
                                </dd>
                                <div style="clear:both;"></div>
                            </dl>
                            <div class="dai-right f-l">
                                <P class="d-r-p1">颜色：蓝色<br/>尺码：XL</P>
                                <p class="d-r-p2">¥ ${orderItemExt.product.marketPrice}</p>
                                <p class="d-r-p3">¥ ${orderItemExt.subTotal}</p>
                                </p>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                    </c:forEach>
                    <div style="width: 961px;height :20px">
                        <div style="float: right">
                            <input type="hidden" value="0"/>
                            <a href="JavaScript:;" ckwl>查看物流</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="${pageContext.request.contextPath}/order/firmProduct.do?oid=${orderExt.oid}">确认收货</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="md-info" id="div3" style="display: none">
                <c:forEach items="${orderGroupMap[3]}" var="orderExt">
                    <div class="dai" style="margin-top: 10px">
                        订单号：${orderExt.orderNumber}
                    </div>
                    <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                        <div class="dai-con">
                            <dl class="dl1">
                                <dt>
                                    <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${orderItemExt.pid}" class="f-l"><img
                                            src="${pageContext.request.contextPath}/images/dai.gif"/></a>
                                    <div style="clear:both;"></div>
                                </dt>
                                <dd>
                                    <p>${orderItemExt.product.pName}</p>
                                    <span>X ${orderItemExt.count}</span>
                                </dd>
                                <div style="clear:both;"></div>
                            </dl>
                            <div class="dai-right f-l">
                                <P class="d-r-p1">颜色：蓝色<br/>尺码：XL</P>
                                <p class="d-r-p2">¥ ${orderItemExt.product.marketPrice}</p>
                                <p class="d-r-p3">¥ ${orderItemExt.subTotal}</p>
                                <p class="d-r-p4">
                                    <a href="JavaScript:;" name="buyAgain">再次购买
                                        <input type="hidden" name="buyAgainNumber" value="${orderItemExt.count}"/>
                                        <input type="hidden" name="buyAgainPid" value="${orderItemExt.pid}"/>
                                        <input type="hidden" name="buyAgainSubTotal" value="${orderItemExt.subTotal}"/>
                                    </a> </p>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                    </c:forEach>

                </c:forEach>
            </div>

            <div class="md-ft" id="bottom">
                <P class="md-p1"><input type="checkbox" name="hobby" value="" onchange="selectAll(2)"
                                        id="s2"/><span>全选</span></P>
                <a href="JavaScript:;" id="delAll"><input type="hidden" id="hiddenDel"/>删除</a>
            </div>
        </div>

    </div>
    <div style="clear:both;"></div>
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

<!--查看物流 弹窗-->
<div class="view-logistics">
    <div class="view-bg"></div>
    <div class="view-con">
        <div class="view-tit">
            <h3>物流信息</h3>
            <a href="JavaScript:;" guanbi="">
                <img src="${pageContext.request.contextPath}/images/close-select-city.gif"/>
            </a>
            <div style="clear:both;"></div>
        </div>
        <div class="view-bd">
            <ul>
                <li class="bd-pdl-li after"><span>1</span>2015-08-06　周四　　14:06:53您的订单开始处理</li>
                <li class="after"><span>2</span>14:08:44您的订单待配货</li>
                <li><span>3</span>14:16:04您的包裹已出库</li>
                <li><span>4</span>14:16:03商家正通知快递公司揽件</li>
                <li><span>5</span>21:47:54【惠州市】圆通速递 广东省惠州市惠东县收件员 已揽件</li>
                <li class="bd-pdb-li"><span>6</span>22:13:51广东省惠州市惠东县公司 已发出</li>
                <li class="bd-pdl-li"><span>7</span>2015-08-07　周五　　04:57:33广州转运中心公司 已收入</li>
                <li><span>8</span>04:58:54广州转运中心公司 已发出</li>
                <li><span>9</span>2015-08-08周六22:46:43重庆转运中心公司 已收入</li>
                <li class="bd-pdb-li"><span>10</span>23:01:49【重庆市】重庆转运中心 已发出</li>
                <li class="bd-pdl-li"><span>11</span>2015-08-09　周日　　00:57:11【重庆市】快件已到达 重庆市南岸区</li>
                <li><span>12</span>11:14:52重庆市南岸区 已收入</li>
                <li><span>13</span>11:14:52【重庆市】重庆市南岸区派件员：李天生 13330284757正在为您派件</li>
                <li class="bd-bd-li"><span>14</span>15:53:14【重庆市】重庆市南岸区公司 已签收 签收人：保安，感谢使用圆通速递，期待再次为您服务</li>
            </ul>
            <p class="sign">您的包裹已被签收！</p>
        </div>
    </div>
</div>

<!--登录弹窗-->
<div class="ui-mask" id="mask" onselectstart="return false"></div>
<div class="ui-dialog" id="dialogMove" onselectstart='return false;'>
    <div class="ui-dialog-title" id="dialogDrag"  onselectstart="return false;" >
        检测到您尚未登录
        <a class="ui-dialog-closebutton" href="javascript:hideDialog();"></a>
    </div>
    <div class="ui-dialog-content">
        <div class="ui-dialog-l40 ui-dialog-pt15">
            <input class="ui-dialog-input ui-dialog-input-username" type="input" placeholder="手机/邮箱/用户名" name="loginName" />
        </div>
        <div class="ui-dialog-l40 ui-dialog-pt15">
            <input class="ui-dialog-input ui-dialog-input-password" type="input" placeholder="密码" name="loginPass"/>
        </div>
        <div class="ui-dialog-l40">
            <input type="checkbox" name="remember" value="remember"/>记住密码
        </div>
        <div>
            <a class="ui-dialog-submit" href="#" id="login">登录</a>
        </div>
        <div class="ui-dialog-l40">
            <a href="${pageContext.request.contextPath}/register.do">立即注册</a>
        </div>
    </div>
</div>
</body>
</html>
