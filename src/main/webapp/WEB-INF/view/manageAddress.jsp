<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/10
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>管理收货地址</title>
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
    <script type="text/javascript">
        //省份onclick事件
        function province1(id) {
            $("#city").html("")
            var flag = true;
            $.ajax({
                type: "get",
                dataType: "json",
                url: "${pageContext.request.contextPath}/region/getCity.do",
                data: {
                    id: id,
                },
                success: function (data) {
                    var dataobj = eval(data);//能把字符串转成js的对象
                    $.each(
                        dataobj, function (key, val) {
                            var id = val.id;
                            var depName = val.regionName;
                            if (flag) {
                                $("#pCity").html(depName)
                            }
                            flag = false;
                            if ($("#pCity").html() == depName) {
                                $("#city").append("<li class='current' name='cityLi' id='cityLi" + id + "'><a href='JavaScript:;' id='city" + id + "' onclick='funCity1(" + id + ")'>" + depName + "</a></li>");
                            } else {
                                $("#city").append("<li name='cityLi' id='cityLi" + id + "'><a href='JavaScript:;' id='city" + id + "' onclick='funCity1(" + id + ")'>" + depName + "</a></li>");
                            }

                        });

                }

            })

        }

        //市onclick事件
        function funCity1(id) {
            $("[name='cityLi']").attr("class", "");
            $("#cityLi" + id).attr("class", "current");
            $("#pCity").html("");
            $("#pCity").html($("#city" + id).html());
            $("#cityUl").css({display: "none"});
        }

        //新增地址
        $(function () {
            $("#addSub").click(function () {
                if ($("#name").val() == null || $("#name").val().trim() == "") {
                    alert("请填写收货人")
                } else if (!/^1[3-9]\d{9}$/.test($("#tel").val())) {
                    alert("电话号码输入错误请检查")
                } else if ($("#detailAddr").val() == null || $("#detailAddr").val().trim() == "") {
                    alert("请填写详细地址")
                } else {
                    $.ajax({
                        type: "get",
                        dataType: "json",
                        url: "${pageContext.request.contextPath}/address/addAddress.do",
                        data: {
                            aid: $("#toUpdateID").val(),
                            name: $("#name").val(),
                            tel: $("#tel").val(),
                            addr: $("[name='province']").html() + "-" + $("#pCity").html() + "-" + $("#detailAddr").val(),
                        },
                        success: function (data) {
                            var dataobj = eval(data);//能把字符串转成js的对象
                            $.each(
                                dataobj, function (key, val) {
                                    var id = val.aid;
                                    var name = val.name;
                                    var tel = val.tel;
                                    var addr = val.addr;
                                    if ($("#li" + id).length > 0) {
                                        alert("修改成功")
                                        $("#toUpdateID").val("")
                                        $("#span1" + id).html($("[name='province']").html());
                                        $("#span2" + id).html($("#pCity").html());
                                        $("#" + id + "p3").html($("#detailAddr").val());
                                        $("#" + id + "p1").html($("#name").val());
                                        $("#" + id + "p5").html($("#tel").val());
                                    } else {
                                        alert("添加成功")
                                        $("#addressUl").append("<li id=\"li" + id + "\">\n" +
                                            "                        <p class=\"p1\">" + name + "</p>\n" +
                                            "                        <p class=\"p2\">" + addr.split("-")[0] + " " + addr.split("-")[1] + "</p>\n" +
                                            "                        <p class=\"p3\">" + addr.split("-")[2] + "</p>\n" +
                                            "                        <p class=\"p4\">164000</p>\n" +
                                            "                        <p class=\"p5\">" + tel + "</p>\n" +
                                            "                        <p class=\"p6\">\n" +
                                            "                            <a href=\"JavaScript:;\" onclick=\"funUpdate(${address.aid})\">修改</a> |\n" +
                                            "                            <a href=\"JavaScript:;\" onclick=\"fundel(" + id + ")\">删除</a>\n" +
                                            "                        </p>\n" +
                                            "                        <p class=\"p7\"><a href=\"JavaScript:;\" name=\"defaultAddress\"><input type=\"hidden\" value=\"" + id + "\">默认地址</a></p>\n" +
                                            "                        <div style=\"clear:both;\"></div>\n" +
                                            "                    </li>");
                                        $("#addressNum").html(Number($("#addressNum").html()) + 1);
                                    }
                                });
                        }
                    })
                }

            })
        })

        // TODO 删除地址信息
        function fundel(id) {
            $.ajax({
                type: "get",
                dataType: "text",
                url: "${pageContext.request.contextPath}/address/delAddress.do",
                data: {
                    aid: id,
                },
                success: function (data) {
                    alert("删除成功")
                    $("#li" + id).remove();
                }
            })
        }

        function funUpdate(id) {
            $("[name='province']").html($("#span1" + id).html());
            $("#pCity").html($("#span2" + id).html());
            $("#detailAddr").val($("#" + id + "p3").html());
            $("#name").val($("#" + id + "p1").html());
            $("#tel").val($("#" + id + "p5").html());
            $("#toUpdateID").val(id)
        }

        $(function () {
            $("[name='defaultAddress']").click(function () {
                $.ajax({
                    type: "get",
                    dataType: "text",
                    url: "${pageContext.request.contextPath}/address/defaultAddress.do",
                    data: {
                        aid: $(this).find("input").val(),
                    },
                    success: function (data) {
                        alert("设置成功")
                        $("[name='defaultAddress']").each(function () {
                            if ($(this).find("input").val() == data) {
                                $(this).css("color", "red");
                            } else {
                                $(this).css("color", "black");
                            }
                        })
                    }
                })
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
            <li class="per-li2"><a href="${pageContext.request.contextPath}/user/personal.do">个人资料<span>></span></a>
            </li>
            <li class="per-li3"><a href="${pageContext.request.contextPath}/order/toMyOrder.do">我的订单<span>></span></a>
            </li>
            <li class="per-li5"><a href="${pageContext.request.contextPath}/order/toBasket.do">购物车<span>></span></a>
            </li>
            <li class="current-li per-li6"><a href="${pageContext.request.contextPath}/order/toManagerAddress.do">管理收货地址<span>></span></a>
            </li>
            <li class="per-li8"><a
                    href="${pageContext.request.contextPath}/order/toGetOrderAll.do">购买记录<span>></span></a></li>
        </ul>
    </div>
    <div class="management f-r">
        <div class="tanchuang-con">
            <div class="tc-title">
                <h3>我的收货地址</h3><input type="hidden" id="toUpdateID"/>
            </div>
            <font class="xinxi">请认真填写以下信息！</font>
            <ul class="tc-con2">
                <li class="tc-li1">
                    <p class="l-p">所在地区<span>*</span></p>
                    <div class="xl-dz">
                        <div class="dz-left f-l">
                            <p style="width: 100px" name="province">新疆</p>
                            <ul style="height: 90px;overflow: auto;width: 100px">
                                <c:forEach var="region" items="${regionList}">
                                    <li name="liProvince"><a href="JavaScript:;" name="aProvince"
                                                             onclick="province1(${region.id})">${region.regionName}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="dz-right f-l">
                            <p id="pCity">乌鲁木齐</p>
                            <ul id="cityUl">
                            <span id="city">
                                <c:forEach items="${regionMap[fn:split(chooseAddress.addr,'-')[0]]}" var="city">
                                    <li class="${city.regionName==fn:split(chooseAddress.addr,'-')[1]?"current":""}"><a
                                            href="JavaScript:;">${city.regionName}</a></li>
                                </c:forEach>
                            </span>
                                <div style="clear:both;"></div>
                            </ul>
                        </div>
                        <div style="clear:both;"></div>
                    </div>
                    <div style="clear:both;"></div>
                </li>
                <li class="tc-li1">
                    <p class="l-p">详细地址<span>*</span></p>
                    <textarea class="textarea1" placeholder="请如实填写您的详细信息，如街道名称、门牌号、楼层号和房间号。" id="detailAddr"></textarea>
                    <div style="clear:both;"></div>
                </li>
                <li class="tc-li1">
                    <p class="l-p">邮政编码<span></span></p>
                    <input type="text"/>
                    <div style="clear:both;"></div>
                </li>
                <li class="tc-li1">
                    <p class="l-p">收货人姓名<span>*</span></p>
                    <input type="text" id="name"/>
                    <div style="clear:both;"></div>
                </li>
                <li class="tc-li1">
                    <p class="l-p">联系电话<span>*</span></p>
                    <input type="text" id="tel"/>
                    <div style="clear:both;"></div>
                </li>
            </ul>
            <button class="btn-pst2" id="addSub">保存</button>
        </div>
        <div class="man-info">
            <font>您已经保存<span id="addressNum">${fn:length(addressAll)}</span>个地址！</font>
            <div class="man-if-con">
                <div class="man-tit">
                    <p class="p1">收货人</p>
                    <p class="p2">所在地区</p>
                    <p class="p3">详细地址</p>
                    <p class="p4">邮编</p>
                    <p class="p5">电话/手机</p>
                    <p class="p6">操作</p>
                </div>
                <ul class="man-ul1" id="addressUl">
                    <c:forEach items="${addressAll}" var="address" varStatus="vs">
                        <li id="li${address.aid}">
                            <p class="p1" id="${address.aid}p1">${address.name}</p>
                            <p class="p2" id="${address.aid}p2"><span
                                    id="span1${address.aid}">${fn:split(address.addr,"-")[0]}</span> <span
                                    id="span2${address.aid}">${fn:split(address.addr,"-")[1]}</span></p>
                            <p class="p3" id="${address.aid}p3">${fn:split(address.addr,"-")[2]}</p>
                            <p class="p4" id="${address.aid}p4">164000</p>
                            <p class="p5" id="${address.aid}p5">${address.tel}</p>
                            <p class="p6">
                                <a href="JavaScript:;" onclick="funUpdate(${address.aid})">修改</a> |
                                <a href="JavaScript:;" onclick="fundel(${address.aid})">删除</a>
                            </p>
                            <p class="p7"><a href="JavaScript:;" name="defaultAddress" id="defaultAddress${address.aid}"
                                             style="${address.state==1?"color:red;":"color:black;"}"><input
                                    type="hidden" value="${address.aid}">默认地址</a></p>
                            <div style="clear:both;"></div>
                        </li>
                    </c:forEach>
                </ul>
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

