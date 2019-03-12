<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/27
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>确认订单</title>
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
        var flag=0;
        //TODO 新增地址
        //省份onclick事件
        function province1(id) {
            $("#city").html("")
            var flag=true;
            $.ajax({
                type:"get",
                dataType:"json",
                url:"${pageContext.request.contextPath}/region/getCity.do",
                data:{
                    id:id,
                },
                success:function (data) {
                    var dataobj = eval(data);//能把字符串转成js的对象
                    $.each(
                        dataobj,function(key, val) {
                            var id = val.id;
                            var depName = val.regionName;
                            if(flag){
                                $("#pCity").html(depName)
                            }
                            flag=false;
                            if($("#pCity").html()==depName){
                                $("#city").append("<li class='current' name='cityLi' id='cityLi"+id+"'><a href='JavaScript:;' id='city"+id+"' onclick='funCity1("+id+")'>"+depName+"</a></li>");
                            }else {
                                $("#city").append("<li name='cityLi' id='cityLi"+id+"'><a href='JavaScript:;' id='city"+id+"' onclick='funCity1("+id+")'>"+depName+"</a></li>");
                            }

                        });

                }

            })

        }
        //市onclick事件
        function funCity1(id) {
          $("[name='cityLi']").attr("class","");
          $("#cityLi"+id).attr("class","current");
          $("#pCity").html("");
          $("#pCity").html($("#city"+id).html());
          $("#cityUl").css({display:"none"});
      }

      //新增地址
      $(function () {
          $("#addSub").click(function () {
              if($("#name").val()==null||$("#name").val().trim()==""){
                  alert("请填写收货人")
              }else if(!/^1[3-9]\d{9}$/.test($("#tel").val())){
                  alert("电话号码输入错误请检查")
              }else if($("#detailAddr").val()==null||$("#detailAddr").val().trim()==""){
                  alert("请填写详细地址")
              }else{
                  $.ajax({
                      type:"get",
                      dataType:"json",
                      url:"${pageContext.request.contextPath}/address/addAddress.do",
                      data:{
                          name:$("#name").val(),
                          tel:$("#tel").val(),
                          addr:$("[name='province']").html()+"-"+$("#pCity").html()+"-"+$("#detailAddr").val(),
                      },
                      success:function (data) {
                          var dataobj = eval(data);//能把字符串转成js的对象
                          $.each(
                              dataobj,function(key, val) {
                                  var id = val.aid;
                                  var name = val.name;
                                  var tel=val.tel;
                                  var addr=val.addr;
                                  $("[name='addAddrLi']").attr("class","");
                                  $("#addAddress").append("<li name='addAddrLi' id='addrLi"+id+"' onclick='funAddr("+id+")' class='current'><h3><span class='sp1' id='provinceSpan"+id+"'>"+addr.split("-")[0]+"</span><span class='sp2' id='citySpan"+id+"'>"+addr.split("-")[1]+"</span>（<span class='sp3' id='nameSpan"+id+"'>"+name+"</span>" +
                                      "收）</h3>" +
                                      "<p><span class='sp1' id='detailSpan"+id+"'>"+addr.split("-")[2]+"</span><span class='sp2' id='telSpan"+id+"'>"+tel+"</span> </p>" +
                                      "<a href='JavaScript:;' xiugai='' onclick='funUpdate("+id+")'>修改</a>"+
                                  "<a href='JavaScript:;' onclick='fundel("+id+")'>删除</a></li>")


                              });
                          flag++;
                          $("#divAdd").css({display:"none"});
                      }
                  })
              }

          })
      })
        function funAddr(id) {
            $("[name='addAddrLi']").attr("class","");
            $("#addrLi"+id).attr("class","current");
            $("[name='aid']").val(id);
        }
        $(function () {
            if("${chooseAddress.aid}"==""){
                $("[name='addAddrLi']").each(function () {
                    $(this).attr("class","current");
                    $("[name='aid']").val($(this).find("input").val());
                    return false;
                    }
                )
            }
        })
    // TODO 修改地址
        //点击修改弹出弹窗并回显信息
        function funUpdate(id) {
            $.ajax({
                type:"get",
                dataType:"json",
                url:"${pageContext.request.contextPath}/address/getAddressByID.do",
                data:{
                    aid:id,
                },
                success:function (data) {
                    var dataobj = eval(data);//能把字符串转成js的对象
                    $.each(
                        dataobj, function (key, val) {
                            var name = val.name;
                            var tel = val.tel;
                            var addr = val.addr;
                           $("#updateProvince").html(addr.split("-")[0]);
                           $("#updateCity").html(addr.split("-")[1]);
                           $("#updateDetailAddr").val(addr.split("-")[2]);
                           $("#updateTel").val(tel);
                           $("#updateName").val(name);
                           $("#updateAddressID").val(id);
                        });
                }
                });

           $("#updateAddrDiv").css({display:"inline"});
        }
        //省份onclick事件
        function province2(id) {
            $("#upCity").html("")
            var flag=true;
            $.ajax({
                type:"get",
                dataType:"json",
                url:"${pageContext.request.contextPath}/region/getCity.do",
                data:{
                    id:id,
                },
                success:function (data) {
                    var dataobj = eval(data);//能把字符串转成js的对象
                    $.each(
                        dataobj,function(key, val) {
                            var id = val.id;
                            var depName = val.regionName;
                            if(flag){
                                $("#updateCity").html(depName)
                            }
                            flag=false;
                            if($("#updateCity").html()==depName){
                                $("#upCity").append("<li class='current' name='upcityLi' id='upcityLi"+id+"'><a href='JavaScript:;' id='upcity"+id+"' onclick='funCity2("+id+")'>"+depName+"</a></li>");
                            }else {
                                $("#upCity").append("<li name='upcityLi' id='upcityLi"+id+"'><a href='JavaScript:;' id='upcity"+id+"' onclick='funCity2("+id+")'>"+depName+"</a></li>");
                            }

                        });

                }

            })

        }
        //市onclick事件
        function funCity2(id) {
            $("[name='upcityLi']").attr("class","");
            $("#upcityLi"+id).attr("class","current");
            $("#updateCity").html("");
            $("#updateCity").html($("#upcity"+id).html());
            $("#upcityUl").css({display:"none"});
        }
        // 修改完成提交
        $(function () {
            $("#updateSub").click(function () {
                if($("#updateName").val()==null||$("#updateName").val().trim()==""){
                    alert("请填写收货人")
                }else if(!/^1[3-9]\d{9}$/.test($("#updateTel").val())){
                    alert("电话号码输入错误请检查")
                }else if($("#updateDetailAddr").val()==null||$("#updateDetailAddr").val().trim()==""){
                    alert("请填写详细地址")
                }else{
                    $.ajax({
                        type:"get",
                        dataType:"json",
                        url:"${pageContext.request.contextPath}/address/updateAddress.do",
                        data:{
                            aid:$("#updateAddressID").val(),
                            name:$("#updateName").val(),
                            tel:$("#updateTel").val(),
                            addr:$("#updateProvince").html()+"-"+$("#updateCity").html()+"-"+$("#updateDetailAddr").val(),
                        },
                        success:function (data) {
                            var dataobj = eval(data);//能把字符串转成js的对象
                            $.each(
                                dataobj,function(key, val) {
                                    var id = val.aid;
                                    var name = val.name;
                                    var tel=val.tel;
                                    var addr=val.addr;

                                    $("#provinceSpan"+id).html(addr.split("-")[0]);
                                    $("#citySpan"+id).html(addr.split("-")[1]);
                                    $("#detailSpan"+id).html(addr.split("-")[2]);
                                    $("#telSpan"+id).html(tel);
                                    $("#nameSpan"+id).html(name);

                                });
                            $("#updateAddrDiv").css({display:"none"});
                        }
                    })
                }

            })
        })
        //校验地址数量
        $(function () {
            $("#useNewAddress").click(function () {
               if((Number("${fn:length(addressList)}")+flag)>=19){
                   alert("对不起您的地址添加已满")
                   $("#useNewAddress").css({display:"none"});
               }
            })
        })

        // TODO 删除地址信息
        function fundel(id) {
            $.ajax({
                type:"get",
                dataType:"text",
                url:"${pageContext.request.contextPath}/address/delAddress.do",
                data:{
                    aid:id,
                },
                success:function (data) {
                   $("#addrLi"+id).remove();
                    flag--;
                }
            })
        }
    </script>
    <script type="text/javascript">
        function add(id) {
            $("#je"+id).html(Number($("#dj"+id).html())+Number($("#je"+id).html()))
            $("#jehidden"+id).val($("#je"+id).html())
            var total=Number($("#total").html())+Number($("#dj"+id).html());

            $("#total").html(total)
            $("#pay").html(total)
            $("#payhidden").val($("#pay").html())
        }

        function reduce(id) {
            if($("#count"+id).val()>1){
                $("#je"+id).html(Number($("#je"+id).html())-Number($("#dj"+id).html()))
                $("#jehidden"+id).val($("#je"+id).html())
                var total=Number($("#total").html())-Number($("#dj"+id).html());
                $("#total").html(total)
                $("#pay").html(total)
                $("#payhidden").val($("#pay").html())
            }

        }
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


<!--内容开始-->
<div class="payment-interface w1200">
    <form action="${pageContext.request.contextPath}/order/toPay.do" method="post">
    <div class="pay-info">
        <div class="info-tit">
            <h3>选择收货地址</h3><input type="hidden" name="aid" value="${chooseAddress.aid}"/>
        </div>
        <ul class="pay-dz">
            <c:forEach var="address" items="${addressList}">
                <span id="addAddress"></span>
                <li class="${chooseAddress.aid==address.aid?"current":""}" name="addAddrLi" id="addrLi${address.aid}" onclick="funAddr(${address.aid})">
                    <h3><span class="sp1" id="provinceSpan${address.aid}">${fn:split(address.addr,'-')[0]}</span><span
                            class="sp2" id="citySpan${address.aid}">${fn:split(address.addr,'-')[1]}</span>（<span class="sp3" id="nameSpan${address.aid}">${address.name}</span>
                        收）</h3><input type="hidden" value="${address.aid}"/>
                    <p><span class="sp1" id="detailSpan${address.aid}">${fn:split(address.addr,'-')[2]}</span><span class="sp2" id="telSpan${address.aid}">${address.tel}</span>
                    </p>
                    <a href="JavaScript:;" xiugai="" onclick="funUpdate(${address.aid})">修改</a>
                    <a href="JavaScript:;" onclick="fundel(${address.aid})">删除</a>
                </li>
            </c:forEach>
            <div style="clear:both;"></div>
        </ul>
        <P class="pay-xgdz">修改地址和使用新地址样式一样。</P>
        <button class="pay-xdz-btn" id="useNewAddress" type="button">使用新地址</button>
    </div>
    <div class="pay-info">
        <div class="info-tit" style="border-bottom:0;">
            <h3>订单信息</h3>
        </div>
    </div>

    <div class="cart-con-info">
        <c:forEach items="${orderExt.orderItemExtsList}" var="orderItemExt"  varStatus="vs">
            <div class="cart-con-tit" style="margin:20px 0 5px;">
                <p class="p1" style="width:400px;">
                    <span>商品</span>
                </p>
                <p class="p3" style="width:145px;">规格</p>
                <p class="p4" style="width:130px;">数量</p>
                <p class="p8" style="width:75px;">运费</p>
                <p class="p5">单价（元）</p>
                <p class="p6" style="width:173px;">金额（元）</p>
                <p class="p7">配送方式</p>
            </div>

            <div class="info-mid" >
            <div class="mid-tu f-l">
                <a href="#"><img src="${pageContext.request.contextPath}/images/dai1.gif"/></a>
            </div>
            <div class="mid-font f-l" style="margin-right:40px;width: 150px" >
                <a href="#">${orderItemExt.product.pName}</a><input type="hidden" name="orderItemExtsList[${vs.index}].pid" value="${orderItemExt.product.pid}"/>
            </div>
            <div class="mid-guige1 f-l" style="margin-right:40px;">
                <p>颜色：蓝色</p>
                <p>尺码：XL</p>
            </div>
            <div class="mid-sl f-l" style="margin:10px 54px 0px 0px;">
                <a href="JavaScript:;" class="sl-left" id="reduce${vs.index}" onclick="reduce(${vs.index})">-</a>
                <input type="text" value="${orderItemExt.count}" readonly id="count${vs.index}" name="orderItemExtsList[${vs.index}].count"/>
                <a href="JavaScript:;" class="sl-right" id="add${vs.index}" onclick="add(${vs.index})">+</a>
            </div>
            <p class="mid-yunfei f-l">¥ ${orderItemExt.product.marketPrice}</p>
                <p class="mid-dj f-l">¥ <span id="dj${vs.index}">${orderItemExt.product.marketPrice}</span></p>
            <p class="mid-je f-l" style="margin:10px 120px 0px 0px;">¥<span id="je${vs.index}" name="je${vs.index}">${orderItemExt.product.marketPrice*orderItemExt.count}</span></p>
                <input type="hidden" id="jehidden${vs.index}" name="orderItemExtsList[${vs.index}].subTotal" value="${orderItemExt.subTotal}"/>
            <div class="mid-chaozuo f-l">
                <select>
                    <option>送货上门</option>
                    <option>快递包邮</option>
                </select>
            </div>
            <div style="clear:both;"></div>
        </div>
        </c:forEach>
        <div class="info-heji">
            <p class="f-r">店铺合计(含运费)：¥ <span id="total">${orderExt.total}</span></p>
            <h3 class="f-r">订单号：${orderExt.orderNumber}</h3>
            <input type="hidden" value="${orderExt.orderNumber}" name="orderNumber"/>
        </div>
        <div class="info-tijiao">
            <p class="p1">实付款：¥ <span id="pay">${orderExt.total}</span></p>
            <input type="hidden" id="payhidden" value="${orderExt.total}" name="total"/>
            <button class="btn">提交订单</button>
        </div>
    </div>
    </form>
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

<!--确认订单（新增地址）-->
<div class="confirmation-tanchuang" xgdz1="" id="divAdd">
    <div class="tanchuang-bg"></div>
    <div class="tanchuang-con">
        <div class="tc-title">
            <h3>新增地址</h3>
            <a href="JavaScript:;" dz-guan=""><img src="${pageContext.request.contextPath}/images/close-select-city.gif"/></a>
            <div style="clear:both;"></div>
        </div>
        <ul class="tc-con2">
            <li class="tc-li1">
                <p class="l-p">所在地区<span>*</span></p>
                <div class="xl-dz">
                    <div class="dz-left f-l">
                        <p style="width: 100px" name="province">${fn:split(chooseAddress.addr,'-')[0]}</p>
                        <ul style="height: 90px;overflow: auto;width: 100px">
                            <c:forEach var="region" items="${regionList}">
                                <li name="liProvince"><a href="JavaScript:;" name="aProvince" onclick="province1(${region.id})">${region.regionName}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="dz-right f-l">
                        <p id="pCity">${fn:split(chooseAddress.addr,'-')[1]}</p>
                        <ul id="cityUl">
                            <span id="city">
                                <c:forEach items="${regionMap[fn:split(chooseAddress.addr,'-')[0]]}" var="city">
                                    <li class="${city.regionName==fn:split(chooseAddress.addr,'-')[1]?"current":""}"><a href="JavaScript:;">${city.regionName}</a></li>
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
</div>

<!--修改地址-->
<div class="confirmation-tanchuang" xgdz2="" id="updateAddrDiv">
    <div class="tanchuang-bg"></div>
    <div class="tanchuang-con">
        <div class="tc-title">
            <h3>修改地址</h3>
            <a href="JavaScript:;" dz-guan=""><img src="${pageContext.request.contextPath}/images/close-select-city.gif"/></a>
            <div style="clear:both;"></div>
        </div>
        <ul class="tc-con2">
            <li class="tc-li1">
                <p class="l-p">所在地区<span>*</span></p>
                <div class="xl-dz">
                    <div class="dz-left f-l">
                        <p style="width: 100px" id="updateProvince"></p>
                        <ul style="height: 90px;overflow: auto;width: 100px">
                            <c:forEach var="region" items="${regionList}">
                            <li name="updateProvinceLi"><a href="JavaScript:;" name="updateProvinceA" onclick="province2(${region.id})">${region.regionName}</a></li>
                            </c:forEach>
                    </div>
                    <div class="dz-right f-l">
                        <p id="updateCity"></p>
                        <ul id="upcityUl">
                            <span id="upCity">
                                <c:forEach items="${regionMap[fn:split(chooseAddress.addr,'-')[0]]}" var="city">
                                    <li class="${city.regionName==fn:split(chooseAddress.addr,'-')[1]?"current":""}"><a href="JavaScript:;">${city.regionName}</a></li>
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
                <p class="l-p" >详细地址<span>*</span></p>
                <textarea class="textarea1" id="updateDetailAddr" placeholder="请如实填写您的详细信息，如街道名称、门牌号、楼层号和房间号。"></textarea>
                <div style="clear:both;"></div>
            </li>
            <li class="tc-li1">
                <p class="l-p">邮政编码<span></span></p>
                <input type="text"/>
                <div style="clear:both;"></div>
            </li>
            <li class="tc-li1">
                <p class="l-p">收货人姓名<span>*</span></p>
                <input type="text" class="shxm" id="updateName"/>
                <div style="clear:both;"></div>
            </li>
            <li class="tc-li1">
                <p class="l-p">联系电话<span>*</span></p>
                <input type="text" class="lxdh" id="updateTel"/>
                <div style="clear:both;"></div>
            </li>
        </ul>
        <input type="hidden" id="updateAddressID"/>
        <button class="btn-pst2" id="updateSub">保存</button>
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
