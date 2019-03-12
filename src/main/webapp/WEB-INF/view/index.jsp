<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/20
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>爱尚微购首页</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css" />
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
                                location.reload();
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
        $(function () {
            //热门商品立即购买
            $("[name=btn1]").click(function () {
                if("${user}"==""){
                    showDialog();
                }else {
                    var pid = $(this).val();
                    $("#hotProduct" + pid).find("[name=count]").val(Number($("#hotCount" + pid).html()));
                    $("#hotProduct" + pid).submit();
                }
            })
            //加入购物车
            $("[name='btn2']").click(function () {
                if("${user}"==""){
                    showDialog();
                }else{
                    var pid=$(this).val();
                    $.ajax({
                        url:"${pageContext.request.contextPath}/order/addBasket.do",
                        data:{
                            pid:pid,
                            count:$("#hotCount"+pid).html(),
                        },
                        success:function (msg) {
                            if(msg=="ok"){
                                alert("添加至购物车成功")
                            }else{
                                alert("添加至购物车失败")
                            }

                        }
                    })
                }
                })
        })
        $(function () {
            //热门商品立即购买
            $("[name=nbtn1]").click(function () {
                if("${user}"==""){
                    showDialog();
                }else {
                    var pid = $(this).val();
                    $("#newProduct" + pid).find("[name=count]").val(Number($("#newCount" + pid).html()));
                    $("#newProduct" + pid).submit();
                }
            })
            //加入购物车
            $("[name='nbtn2']").click(function () {
                if("${user}"==""){
                    showDialog();
                }else{
                var pid=$(this).val();
                $.ajax({
                    url:"${pageContext.request.contextPath}/order/addBasket.do",
                    data:{
                        pid:pid,
                        count:$("#newCount"+pid).html(),
                    },
                    success:function (msg) {
                        if(msg=="ok"){
                            alert("添加至购物车成功")
                        }else{
                            alert("添加至购物车失败")
                        }

                    }
                })
                }
            })
        })
    </script>
</head>

<body>
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
        <div class="nav-kuaijie f-l">
            <a href="JavaScript:;" class="kj-tit1">商品分类快捷</a>
            <div class="kuaijie-box">
                <c:forEach items="${categoryList}" var="category">
                    <div class="kuaijie-info">
                        <dl class="kj-dl1">
                            <dt><img src="${pageContext.request.contextPath}/images/zl2-09.gif" /><a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${category.cid}">${category.cname}</a></dt>
                        </dl>
                        <div class="kuaijie-con">
                            <c:forEach items="${categorySecondMap[category.cid]}" var="categorySecond">
                                <dl class="kj-dl2" style="display:inline-block">
                                    <dt><a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCsid=${categorySecond.csid}">${categorySecond.csname}</a></dt>
                                    <dd>
                                        <c:forEach items="${categorySecond.categoryThirdList}" var="categoryThird" varStatus="vs">
                                            <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCtid=${categoryThird.ctid}">${categoryThird.ctname}</a><c:if test="${!vs.last}"><span>|</span></c:if>
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

<!--banner-->
<div class="banner">
    <ul class="ban-ul1">
        <li><a href="#"><img src="${pageContext.request.contextPath}/images/banner.png" /></a></li>
        <li><a href="#"><img src="${pageContext.request.contextPath}/images/banner.png" /></a></li>
        <li><a href="#"><img src="${pageContext.request.contextPath}/images/banner.png" /></a></li>
        <li><a href="#"><img src="${pageContext.request.contextPath}/images/banner.png" /></a></li>
    </ul>
    <div class="ban-box w1200">
        <ol class="ban-ol1">
            <li class="current"></li>
            <li></li>
            <li></li>
            <li></li>
            <div style="clear:both;"></div>
        </ol>
    </div>
</div>

<!--商品内容页面-->
<div class="shopping-content w1200">
        <div class="sp-con-info">
            <h3 class="sp-info-tit">热门推荐</h3>
            <div class="sp-info-l f-l">
                <a href="#"><img src="${pageContext.request.contextPath}/images/rementuijian.png" width="210" /></a>
                <div class="sp-l-b">
                    <h3 class="sp-info-tit">热门推荐</h3>
                </div>
            </div>
            <ul class="sp-info-r f-r">
                <c:forEach varStatus="vs" var="hotProduct" items="${hotProductList}">
                    <form action="${pageContext.request.contextPath}/order/firmOrder.do" method="post" id="hotProduct${hotProduct.pid}">
                        <li style="${vs.count==4?"width:240px;border-right:0;":""}">
                            <div class="li-top">
                                <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${hotProduct.pid}" class="li-top-tu"><img src="${pageContext.request.contextPath}/images/sp-con-r-tu.gif" /></a>
                                <p class="jiage"><span class="sp1">${hotProduct.marketPrice}</span><span class="sp2">${hotProduct.shopPrice}</span></p>
                                <input type="hidden" name="count" value=""/>
                                <input type="hidden" name="pid" value="${hotProduct.pid}"/>
                            </div>
                            <p class="miaoshu">${hotProduct.pName}</p>
                            <div class="li-md">
                                <div class="md-l f-l">
                                    <p class="md-l-l f-l" ap="" id="hotCount${hotProduct.pid}">1</p>
                                    <div class="md-l-r f-l">
                                        <a href="JavaScript:;" class="md-xs" at="">∧</a>
                                        <a href="JavaScript:;" class="md-xx" ab="">∨</a>
                                    </div>
                                    <div style="clear:both;"></div>
                                </div>
                                <div class="md-r f-l">
                                    <button class="md-l-btn1" name="btn1"type="button" value="${hotProduct.pid}">立即购买</button>
                                    <button class="md-l-btn2" name="btn2" type="button" value="${hotProduct.pid}">加入购物车</button>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                            <p class="pingjia">销量：${hotProduct.score}</p>
                            <p class="weike">微克宅购自营</p>
                        </li>
                    </form>
                </c:forEach>
            </ul>
            <div style="clear:both;"></div>
        </div>
    <c:forEach items="${categoryList}" var="category" varStatus="vs">
            <div class="sp-con-info">
                <h3 class="sp-info-tit"><span>${vs.count}F</span>${category.cname}</h3>
                <div class="sp-info-l f-l">
                    <a href="#"><img src="${pageContext.request.contextPath}/images/sp-con-l-tu.gif" /></a>
                    <div class="sp-l-b">
                        <c:forEach items="${categorySecondMap[category.cid]}" var="categorySecond">
                            <a href="#">${categorySecond.csname}</a>
                        </c:forEach>
                    </div>
                </div>
                <ul class="sp-info-r f-r">
                <c:forEach varStatus="vs" var="newProduct" items="${newProductMap[category.cid]}">
                    <form action="${pageContext.request.contextPath}/order/firmOrder.do" method="post" id="newProduct${newProduct.pid}">
                    <li style="${vs.count==4?"width:240px;border-right:0;":""}">
                        <div class="li-top">
                            <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${newProduct.pid}" class="li-top-tu"><img src="${pageContext.request.contextPath}/images/sp-con-r-tu.gif" /></a>
                            <p class="jiage"><span class="sp1">${newProduct.marketPrice}</span><span class="sp2">${newProduct.shopPrice}</span></p>
                            <input type="hidden" name="count" value=""/>
                            <input type="hidden" name="pid" value="${newProduct.pid}"/>
                        </div>
                        <p class="miaoshu">${newProduct.pName}</p>
                        <div class="li-md">
                            <div class="md-l f-l">
                                <p class="md-l-l f-l" ap="" id="newCount${newProduct.pid}">1</p>
                                <div class="md-l-r f-l">
                                    <a href="JavaScript:;" class="md-xs" at="">∧</a>
                                    <a href="JavaScript:;" class="md-xx" ab="">∨</a>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                            <div class="md-r f-l">
                                <button class="md-l-btn1" name="nbtn1" value="${newProduct.pid}" type="button">立即购买</button>
                                <button class="md-l-btn2" name="nbtn2" value="${newProduct.pid}" type="button">加入购物车</button>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                        <p class="pingjia">时间：${newProduct.date}</p>
                        <p class="weike">微克宅购自营</p>
                    </li>
                    </form>
                </c:forEach>
                </ul>
                <div style="clear:both;"></div>
            </div>
    </c:forEach>
</div>

<!--底部一块-->
<div class="footer-box">
    <ul class="footer-info1 w1200">
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-86.gif" /></a>
            </div>
            <h3><a href="JavaScript:;">号码保障</a></h3>
            <P>所有会员，手机短信验证</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-87.gif" /></a>
            </div>
            <h3><a href="JavaScript:;">6*12小时客服</a></h3>
            <P>有任何问题随时免费资讯</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-88.gif" /></a>
            </div>
            <h3><a href="JavaScript:;">专业专攻</a></h3>
            <P>我们只专注于建筑行业的信息服务</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-89.gif" /></a>
            </div>
            <h3><a href="JavaScript:;">注册有礼</a></h3>
            <P>随时随地注册有大礼包</P>
        </li>
        <li>
            <div class="ft-tu1">
                <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-90.gif" /></a>
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
            <p>周一至周日  9:00-24:00</p>
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
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-91.gif" /></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-92.gif" /></a>
            <a href="#"><img src="${pageContext.request.contextPath}/images/zl2-93.gif" /></a>
        </div>
    </div>
</div>

<!--固定右侧-->
<ul class="youce">
    <li class="li1">
        <a href="${pageContext.request.contextPath}/aishang/index.do" class="li1-tu1"><img src="${pageContext.request.contextPath}/images/zl2-94.png" /></a>
        <a href="${pageContext.request.contextPath}/aishang/index.do" class="li1-zi1">返回首页</a>
    </li>
    <li class="li2">
        <a href="${pageContext.request.contextPath}/order/toBasket.do"><img src="${pageContext.request.contextPath}/images/zl2-95.png" />购</br>物</br>车</a>
    </li>
    <li class="li3">
        <a href="#" class="li1-tu2"><img src="${pageContext.request.contextPath}/images/zl2-96.png" /></a>
        <a href="#" class="li1-zi2">我关注的品牌</a>
    </li>
    <li class="li3">
        <a href="浏览记录.html" class="li1-tu2"><img src="${pageContext.request.contextPath}/images/zl2-97.png" /></a>
        <a href="浏览记录.html" class="li1-zi2">我看过的</a>
    </li>
    <li class="li4">
        <a href="JavaScript:;" class="li1-tu2"><img src="${pageContext.request.contextPath}/images/zl2-98.gif" /></a>
        <div class="li4-ewm">
            <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-101.gif" /></a>
            <p>扫一扫</p>
        </div>
    </li>
    <li class="li3 li5">
        <a href="#top" class="li1-tu2"><img src="${pageContext.request.contextPath}/images/zl2-99.gif" /></a>
        <a href="#top" class="li1-zi2">返回顶部</a>
    </li>
</ul>

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
