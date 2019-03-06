<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/4
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>购物车</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhonglin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhongling2.js"></script>
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

            if(!($("#hobby"+id).attr("checked")=="checked")){
                $("#s1").prop("checked","")
                $("#s2").prop("checked","")
            }
        }

        //添加某一商品数量
        function add(id) {
            var num = Number($("#num" + id).val());
            num = num + 1;
            $("#num" + id).val(num);
            $("#je" + id).html(num * Number($("#dj" + id).html()))
            $("#subtoTal"+id).val(num * Number($("#dj" + id).html()))
            if ($("#hobby" + id).attr("checked") == "checked") {
                $("#sum").html(Number($("#sum").html()) + Number($("#dj" + id).html()))
            }
        }

        //减少某一商品数量
        function reduce(id) {
            var num = Number($("#num" + id).val());
            if (num <= 1) {
                $("#num" + id).val(1);
            } else {
                num = num - 1
                $("#num" + id).val(num);
                $("#je" + id).html(num * Number($("#dj" + id).html()))
                $("#subtoTal"+id).val(num * Number($("#dj" + id).html()))
                if ($("#hobby" + id).attr("checked") == "checked") {
                    $("#sum").html(Number($("#sum").html()) - Number($("#dj" + id).html()))
                }
            }
        }

        //计算选中的订单项总价
        $(function () {
            $("[name='hobby']").change(function () {
                var i = 0;
                var sum = 0;
                $("[name='je']").each(function () {
                    if ($("#hobby" + i).attr("checked") == "checked") {
                        sum = sum + Number($(this).html());
                    }
                    i++;
                })
                $("#sum").html(sum)
            })
        })

        //删除选中订单项
        $(function () {
            $("#del").click(function () {
                var i = 0;
                if (window.confirm("确认删除选中的商品吗？")) {
                    var pid = new Array();
                    $("[name='hobby']").each(function () {
                        if ($("#hobby" + i).attr("checked") == "checked") {
                            pid[i] = $("#hobby" + i).val();
                        }
                        i++;
                    })
                    if (pid != null) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/order/del.do",
                            data: {
                                pids: JSON.stringify(pid),
                            },
                            success: function (data) {
                                if (data == "ok") {
                                    for (var i = 0; i < pid.length; i++) {
                                        if (pid[i] != "") {
                                            $("#div" + i).remove()
                                        }
                                    }
                                    alert("删除成功")
                                }
                            }
                        })
                    }

                }
            })
        })

        //删除
        function del(id) {
            if (confirm("确认删除该商品吗")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/del.do",
                    data: {
                        pid: $("#hobby" + id).val(),
                    },
                    success: function (data) {
                        if (data == "ok") {
                            alert("删除成功")
                            $("#div" + id).remove()

                        }
                    }
                })
            }
        }

        //加入收藏夹

        //结算
        $(function () {
            $("#sub").click(function () {
                var i=0;
                var flag = false;
                var pid = new Array();
                $("[name='hobby']").each(function () {
                    if ($("#hobby" + i).attr("checked") == "checked") {
                        flag=true;
                    }else{
                        $("#subPid"+i).val("");
                        $("#subtoTal"+i).val("");
                    }
                    i++;
                })
                $("#total").val($("#sum").html());
                if(flag){
                    $("#from").submit();
                }

            })
        })
    </script>
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

<c:if test="${empty orderItems}">
    <div class="cart-content w1200"><h1 style="font-size:20px" align="center">购物车还没有商品哦,快去选购吧！</h1></div>
</c:if>


<c:if test="${!empty orderItems}">
    <form action="${pageContext.request.contextPath}/order/firmOrder.do" id="from" method="post">
    <div class="cart-content w1200">
        <ul class="cart-tit-nav">
            <li class="current"><a href="#">全部商品 ${fn:length(orderItems)}</a></li>
            <div style="clear:both;"></div>
        </ul>
        <div class="cart-con-tit">
            <p class="p1">
                <input type="checkbox" value="" name="hobby" onchange="selectAll(2)" id="s2"></input>
                <span>全选</span>
            </p>
            <p class="p2">商品信息</p>
            <p class="p3">规格</p>
            <p class="p4">数量</p>
            <p class="p5">单价（元）</p>
            <p class="p6">金额（元）</p>
            <p class="p7">操作</p>
        </div>
        <c:forEach items="${orderItems}" var="orderItem" varStatus="vs">
            <input type="hidden" name="orderItemExtsList[${vs.index}].pid" value="${orderItem.pid}" id="subPid${vs.index}"/>
            <div class="cart-con-info" id="div${vs.index}">
                <div class="info-top">
                </div>
                <div class="info-mid">
                    <input type="checkbox" value="${orderItem.pid}" name="hobby" id="hobby${vs.index}"
                           class="mid-ipt f-l" onchange="sel(${vs.index})"></input>
                    <div class="mid-tu f-l">
                        <a href="#"><img src="${pageContext.request.contextPath}/images/dai1.gif"/></a>
                    </div>
                    <div class="mid-font f-l" style="width: 230px">
                        <a href="#">${orderItem.product.pName}</a>
                        <span>满赠</span>
                    </div>
                    <div class="mid-guige f-l" style="width: 80px">
                        <p>颜色：蓝色</p>
                        <p>尺码：XL</p>
                        <a href="JavaScript:;" class="xg" xg="xg1">修改</a>
                        <div class="guige-xiugai" xg-g="xg1">
                            <div class="xg-left f-l">
                                <dl>
                                    <dt>颜 色</dt>
                                    <dd>
                                        <a href="JavaScript:;" class="current">黑色</a>
                                        <a href="JavaScript:;">白色</a>
                                    </dd>
                                    <div style="clear:both;"></div>
                                </dl>
                                <dl>
                                    <dt>尺 码</dt>
                                    <dd>
                                        <a href="JavaScript:;" class="current">M</a>
                                        <a href="JavaScript:;">L</a>
                                        <a href="JavaScript:;">XL</a>
                                    </dd>
                                    <div style="clear:both;"></div>
                                </dl>
                                <a href="JavaScript:;" class="qd">确定</a>
                                <a href="JavaScript:;" class="qx" qx="xg1">取消</a>
                            </div>
                            <div class="xg-right f-l">
                                <a href="#"><img src="${pageContext.request.contextPath}/images/dai2.gif"/></a>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                    </div>
                    <div class="mid-sl f-l">
                        <a href="JavaScript:;"  id="reduce${vs.index}"
                           onclick="reduce(${vs.index})">-</a>
                        <input type="text" value="${orderItem.count}" id="num${vs.index}" name="orderItemExtsList[${vs.index}].count"/>
                        <a href="JavaScript:;"  id="add${vs.index}" onclick="add(${vs.index})">+</a>
                    </div>
                    <p class="mid-dj f-l">¥ <span id="dj${vs.index}">${orderItem.product.marketPrice}</span></p>
                    <p class="mid-je f-l">¥ <span id="je${vs.index}"name="je">${orderItem.count*orderItem.product.marketPrice}</span></p>
                                                <input type="hidden" id="subtoTal${vs.index}" name="orderItemExtsList[${vs.index}].subTotal" value="${orderItem.count*orderItem.product.marketPrice}"/>
                    <div class="mid-chaozuo f-l">
                        <a href="JavaScript:;">移入收藏夹</a>
                        <a href="JavaScript:;" onclick="del(${vs.index})">删除</a>
                    </div>
                    <div style="clear:both;"></div>
                </div>
            </div>
        </c:forEach>


        <div class="cart-con-footer">

            <div class="quanxuan f-l">
                <input type="checkbox" value="1" name="hobby" onchange="selectAll(1)" id="s1"></input>
                <span>全选</span>
                <a href="JavaScript:;" id="del">删除</a>
                <a href="JavaScript:;">加入收藏夹</a>
                <p>（此处始终在屏幕下方）</p>
            </div>
            <div class="jiesuan f-r">
                <div class="jshj f-l">
                    <p>合计（不含运费）</p>
                    <p class="jshj-p2">
                        ￥：<span id="sum"></span><input name="total" type="hidden" id="total"/>
                    </p>
                </div>
                <a href="JavaScript:;" class="js-a1 f-l" id="sub">结算</a>
                <div style="clear:both;"></div>
            </div>
            <div style="clear:both;"></div>

        </div>

    </div>
    </form>
</c:if>
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
