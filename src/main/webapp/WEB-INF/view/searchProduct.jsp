<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/22
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>搜索列表页(有品牌)</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css"/>
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
            $("#sort").click(function () {
                if ("${productBean.selectpDesc}" == 1) {
                    $("#sort").attr("href", "${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectpName=${productBean.selectpName}&selectpDesc=0");
                } else {
                    $("#sort").attr("href", "${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectpName=${productBean.selectpName}&selectpDesc=1");
                }

            })
            if ("${productBean.selectpDesc}" == 1) {
                $("#sort").html("")
                $("#sort").html("综合 ↓")
            } else {
                $("#sort").html("")
                $("#sort").html("综合 ↑")
            }

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
                }else {
                var pid = $(this).val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/addBasket.do",
                    data: {
                        pid: pid,
                        count: $("#hotCount" + pid).html(),
                    },
                    success: function (msg) {
                        if (msg == "ok") {
                            alert("添加至购物车成功")
                        } else {
                            alert("添加至购物车失败")
                        }

                    }
                })
                }
            })
        })
        $(function () {
            //最新商品立即购买
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
                }else {
                var pid = $(this).val();
                $.ajax({
                    url: "${pageContext.request.contextPath}/order/addBasket.do",
                    data: {
                        pid: pid,
                        count: $("#newCount" + pid).html(),
                    },
                    success: function (msg) {
                        if (msg == "ok") {
                            alert("添加至购物车成功")
                        } else {
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
<!--筛选结果-->
<div class="screening-results w1200">
    <p class="tiao">找到共 ${productBean.totalCount} 条</p>
    <div class="results">
        <p class="re-p1 f-l">
            全部结果：${productBean.selectpName} >
        </p>
        <div class="re-search f-l">
            <form action="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectpDesc=${productBean.selectpDesc}"
                  method="post">
                <input type="text" name="selectpName" value="${productBean.selectpName}" class="f-l"
                       onfocus="this.value = '';"
                       onblur="if (this.value == '') {this.value = '${productBean.selectpName}';}"/>
                <button type="submit"></button>
            </form>
            <div style="clear:both;"></div>
        </div>
        <p class="re-p2 f-r">
            <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}">清空筛选条件</a>
        </p>
        <div style="clear:both;"></div>
    </div>
</div>


<!--内容↓↑-->
<div class="shop-page-con w1200">
    <div class="shop-pg-left f-l" style="width:215px">
        <div class="shop-left-buttom" style="margin-top:0;">
            <div class="sp-tit1">
                <h3>商品推荐</h3>
            </div>
            <ul class="shop-left-ul">
                <c:forEach items="${isHotList}" var="isHotProduct">
                    <form action="${pageContext.request.contextPath}/order/firmOrder.do" method="post"
                          id="hotProduct${isHotProduct.pid}">
                        <li>
                            <div class="li-top">
                                <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${isHotProduct.pid}"
                                   class="li-top-tu"><img
                                        src="${pageContext.request.contextPath}/images/sp-con-r-tu.gif"/></a>
                                <p class="jiage"><span class="sp1">${isHotProduct.marketPrice}</span><span
                                        class="sp2">${isHotProduct.shopPrice}</span></p>
                            </div>
                            <input type="hidden" name="count" value=""/>
                            <input type="hidden" name="pid" value="${isHotProduct.pid}"/>
                            <p class="miaoshu">${isHotProduct.pName}</p>
                            <div class="li-md">
                                <div class="md-l f-l">
                                    <p class="md-l-l f-l" ap="" id="hotCount${isHotProduct.pid}">1</p>
                                    <div class="md-l-r f-l">
                                        <a href="JavaScript:;" class="md-xs" at="">∧</a>
                                        <a href="JavaScript:;" class="md-xx" ab="">∨</a>
                                    </div>
                                    <div style="clear:both;"></div>
                                </div>
                                <div class="md-r f-l">
                                    <button class="md-l-btn1" name="btn1" type="button" value="${isHotProduct.pid}">
                                        立即购买
                                    </button>
                                    <button class="md-l-btn2" name="btn2" type="button" value="${isHotProduct.pid}">
                                        加入购物车
                                    </button>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                            <p class="pingjia">${isHotProduct.date}</p>
                            <p class="weike">微克宅购自营</p>
                        </li>
                    </form>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="shop-pg-right f-r">
        <div class="shop-right-cmp" style="margin-top:0;">
            <ul class="shop-cmp-l f-l">
                <li class="current" id="1"><a id="sort" href="JavaScript:;">综合 ↓</a></li>
                <div style="clear:both;"></div>
            </ul>
            <form action="${pageContext.request.contextPath}/aishang/searchProduct.do?selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}"
                  method="post">
                <div class="shop-cmp-m f-l">
                    <span>价格</span><input type="text" name="selectMinPrice"
                                          value="${productBean.selectMinPrice}"/><span>-</span><input type="text"
                                                                                                      name="selectMaxPrice"
                                                                                                      value="${productBean.selectMaxPrice}"/>
                </div>
                <div class="shop-cmp-r f-l">
                    <ul class="f-l">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <div style="clear:both;"></div>
                    </ul>
                    <button type="submit">确定</button>
                </div>
            </form>
            <div style="clear:both;"></div>
        </div>
        <div class="shop-right-con">
            <ul class="shop-ul-tu shop-ul-tu1">
                <c:forEach items="${categoryThirdProductList}" var="categoryThirdProduct" varStatus="vs">
                    <form action="${pageContext.request.contextPath}/order/firmOrder.do" method="post"
                          id="newProduct${categoryThirdProduct.pid}">
                        <li style="${vs.count%4==0?"margin-right:0;":""}">
                            <div class="li-top">
                                <a href="${pageContext.request.contextPath}/product/productDetail.do?pid=${categoryThirdProduct.pid}"
                                   class="li-top-tu"><img
                                        src="${pageContext.request.contextPath}/images/sp-con-r-tu.gif"/></a>
                                <p class="jiage"><span class="sp1">${categoryThirdProduct.marketPrice}</span><span
                                        class="sp2">${categoryThirdProduct.shopPrice}</span></p>
                            </div>
                            <input type="hidden" name="count" value=""/>
                            <input type="hidden" name="pid" value="${categoryThirdProduct.pid}"/>
                            <p class="miaoshu">${categoryThirdProduct.pName}</p>
                            <div class="li-md">
                                <div class="md-l f-l">
                                    <p class="md-l-l f-l" ap="" id="newCount${categoryThirdProduct.pid}">1</p>
                                    <div class="md-l-r f-l">
                                        <a href="JavaScript:;" class="md-xs" at="">∧</a>
                                        <a href="JavaScript:;" class="md-xx" ab="">∨</a>
                                    </div>
                                    <div style="clear:both;"></div>
                                </div>
                                <div class="md-r f-l">
                                    <button class="md-l-btn1" name="nbtn1" value="${categoryThirdProduct.pid}"
                                            type="button">立即购买
                                    </button>
                                    <button class="md-l-btn2" name="nbtn2" value="${categoryThirdProduct.pid}"
                                            type="button">加入购物车
                                    </button>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                            <p class="pingjia">${categoryThirdProduct.date}</p>
                            <p class="weike">微克宅购自营</p>
                        </li>
                    </form>
                </c:forEach>
                <div style="clear:both;"></div>
            </ul>

            <!--分页-->
            <div class="paging">
                <c:if test="${productBean.pageCount==0}"><br/><br/><span
                        style="font-size: xx-large">对不起，您搜索的商品不存在...</span></c:if>
                <div class="pag-left f-l">
                    <c:if test="${productBean.pageNow!=1}">
                        <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${productBean.pageNow}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}"
                           class="about left-l f-l" style="font-size: 3px;background:#FFFFFF;color: #1D1D1D;">首页</a>
                        <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${productBean.pageNow-1}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}"
                           class="about left-r f-l"><</a>
                    </c:if>
                    <ul class="left-m f-l">
                        <c:if test="${productBean.pageNow<=3}">
                            <c:if test="${productBean.pageCount<5}">
                                <c:forEach begin="1" end="${productBean.pageCount}" step="1"
                                           varStatus="vs" var="i">
                                    <li class="${productBean.pageNow==vs.index?"current":""}"><a
                                    href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${vs.index}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}">${vs.index}</a>
                                </c:forEach></li>
                            </c:if>
                            <c:if test="${productBean.pageCount>5}">
                                <c:forEach begin="1" end="5" step="1" varStatus="vs" var="i">
                                    <li class="${productBean.pageNow==vs.index?"current":""}"><a
                                            href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${vs.count}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}">${vs.count}</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <c:if test="${productBean.pageNow>3 && productBean.pageNow<productBean.pageCount-2}">
                            <c:forEach begin="${productBean.pageNow-2}" end="${productBean.pageNow+2}" step="1"
                                       varStatus="vs">
                                <li class="${productBean.pageNow==vs.index?"current":""}">
                                    <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${vs.index}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}">${vs.index}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <c:if test="${productBean.pageNow>=productBean.pageCount-2&&productBean.pageNow <= productBean.pageCount&&productBean.pageNow>3}">
                            <c:forEach begin="${productBean.pageNow-2}" end="${productBean.pageCount}" step="1"
                                       varStatus="vs">

                                <li class="${productBean.pageNow==vs.index?"current":""}">
                                    <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${vs.index}&selectpDesc=${productBean.selectpDesc}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}">${vs.index}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <div style="clear:both;"></div>
                    </ul>
                    <c:if test="${productBean.pageNow!=productBean.pageCount&&productBean.pageCount>1}">
                        <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${productBean.pageNow+1}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}"
                           class="about left-l f-l">></a>
                        <a href="${pageContext.request.contextPath}/aishang/searchProduct.do?pageNow=${productBean.pageCount}&selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}"
                           class="about left-l f-l" style="font-size: 3px;background: #FFFFFF ;color: #1D1D1D;">尾页</a>
                    </c:if>
                    <div style="clear:both;"></div>
                </div>
                <div class="pag-right f-l">
                    <c:if test="${productBean.pageCount>1}">
                        <form action="${pageContext.request.contextPath}/aishang/searchProduct.do?selectpName=${productBean.selectpName}&selectCid=${productBean.selectCid}&selectCsid=${productBean.selectCsid}&selectCtid=${productBean.selectCtid}&selectpDesc=${productBean.selectpDesc}&selectMinPrice=${productBean.selectMinPrice}&selectMaxPrice=${productBean.selectMaxPrice}"
                              method="post">
                            <div class="jump-page f-l">
                                到第<input type="number" name="pageNow" step="1" min="1" max="${productBean.pageCount}"/>页
                            </div>
                            <button class="f-l" type="submit">确定</button>
                            <div style="clear:both;"></div>
                        </form>
                    </c:if>
                </div>
                <div style="clear:both;"></div>
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

