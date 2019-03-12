<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/11
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>购买记录</title>
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
<div class="personal w1200">
    <div class="personal-left f-l">
        <div class="personal-l-tit">
            <h3>个人中心</h3>
        </div>
        <ul>
            <li class="per-li2"><a href="${pageContext.request.contextPath}/user/personal.do">个人资料<span>></span></a></li>
            <li class="per-li3"><a href="${pageContext.request.contextPath}/order/toMyOrder.do">我的订单<span>></span></a></li>
            <li class="per-li5"><a href="${pageContext.request.contextPath}/order/toBasket.do">购物车<span>></span></a></li>
            <li class="per-li6"><a href="${pageContext.request.contextPath}/order/toManagerAddress.do">管理收货地址<span>></span></a></li>
            <li class="current-li per-li8"><a href="${pageContext.request.contextPath}/order/toGetOrderAll.do">购买记录<span>></span></a></li>
        </ul>
    </div>
    <div class="purchase-records f-r">
        <div class="pr-tit">
            <P class="pr-p1">宝贝</P>
            <P class="pr-p2">单价(元)</P>
            <P class="pr-p3">数量</P>
            <P class="pr-p4">实付款(元)</P>
            <P class="pr-p5">交易状态</P>
            <P class="pr-p6">交易操作</P>
        </div>
        <c:forEach items="${orderExtList}" var="orderExt">
            <div class="pr-info">
                <div class="pr-tit2">
                    <input type="checkbox" value="" name="hobby"></input>
                    <p class="pr-p1">${orderExt.date}</p>
                    <p class="pr-p2">订单号：${orderExt.orderNumber}</p>
                    <a class="pr-a2" href="#">删除</a>
                </div>
                <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt">
                    <div class="pr-con">
                        <div class="pr-con-tu f-l">
                            <a href="#"><img src="${pageContext.request.contextPath}/images/dai1.gif" /></a>
                        </div>
                        <a class="pr-con-bt f-l" href="#">${orderItemExt.product.pName}</a>
                        <div class="pr-con-sz1 f-l">
                            <span>${orderItemExt.product.shopPrice}</span>
                            <p>${orderItemExt.product.marketPrice}</p>
                        </div>
                        <p class="pr-con-sl f-l">${orderItemExt.count}</p>
                        <div class="pr-con-yf f-l">
                            <p>${orderItemExt.subTotal}</p>
                            <span>(含运费：0.00 )</span>
                        </div>
                        <div class="pr-con-jiaoyi f-l">
                            <a href="#">${map[orderExt.state]}</a>
                        </div>
                        <div class="pr-con-pj f-l">
                            <a href="#">评价</a>
                            <a href="#">再次购买</a>
                        </div>

                        <div style="clear:both;"></div>
                    </div>
                </c:forEach>
            </div>

        </c:forEach>


        <!--分页-->
        <div class="paging">
            <c:if test="${orderBean.pageCount==0}"><br/><br/><span
                    style="font-size: xx-large">对不起，您搜索的商品不存在...</span></c:if>
            <div class="pag-left f-l">
                <c:if test="${orderBean.pageNow!=1}">
                    <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=1" class="about left-l f-l" style="font-size: 3px;background:#FFFFFF;color: #1D1D1D;">首页</a>
                    <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${orderBean.pageNow-1}"class="about left-r f-l"><</a>
                </c:if>
                <ul class="left-m f-l">
                    <c:if test="${orderBean.pageNow<=3}">
                        <c:if test="${orderBean.pageCount<5}">
                            <c:forEach begin="1" end="${orderBean.pageCount}" step="1"
                                       varStatus="vs" var="i">
                                <li class="${orderBean.pageNow==vs.index?"current":""}">
                                <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${orderBean.pageNow-1}">${vs.index}</a>
                            </c:forEach></li>
                        </c:if>
                        <c:if test="${orderBean.pageCount>=5}">
                            <c:forEach begin="1" end="5" step="1" varStatus="vs" var="i">
                                <li class="${orderBean.pageNow==vs.index?"current":""}">
                                    <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${vs.count}">${vs.count}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <c:if test="${orderBean.pageNow>3 && orderBean.pageNow<orderBean.pageCount-2}">
                        <c:forEach begin="${orderBean.pageNow-2}" end="${orderBean.pageNow+2}" step="1"
                                   varStatus="vs">
                            <li class="${orderBean.pageNow==vs.index?"current":""}">
                                <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${vs.index}">${vs.index}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${orderBean.pageNow>=orderBean.pageCount-2&&orderBean.pageNow <= orderBean.pageCount&&orderBean.pageNow>3}">
                        <c:forEach begin="${orderBean.pageNow-2}" end="${orderBean.pageCount}" step="1"
                                   varStatus="vs">
                            <li class="${orderBean.pageNow==vs.index?"current":""}">
                                <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${vs.index}">${vs.index}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <div style="clear:both;"></div>
                </ul>
                <c:if test="${orderBean.pageNow!=orderBean.pageCount&&orderBean.pageCount>1}">
                    <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${orderBean.pageNow+1}" class="about left-l f-l">></a>
                    <a href="${pageContext.request.contextPath}/order/toGetOrderAll.do?pageNow=${orderBean.pageCount}" class="about left-l f-l" style="font-size: 3px;background: #FFFFFF ;color: #1D1D1D;">尾页</a>
                </c:if>
                <div style="clear:both;"></div>
            </div>
            <div class="pag-right f-l">
                <c:if test="${orderBean.pageCount>1}">
                    <form action="${pageContext.request.contextPath}/order/toGetOrderAll.do"
                          method="post">
                        <div class="jump-page f-l">
                            到第<input type="number" name="pageNow" step="1" min="1" max="${orderBean.pageCount}"/>页
                        </div>
                        <button class="f-l" type="submit">确定</button>
                        <div style="clear:both;"></div>
                    </form>
                </c:if>
            </div>
            <div style="clear:both;"></div>
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

