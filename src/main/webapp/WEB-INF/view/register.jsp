<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
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
        var telCode=null;
        //前台表单验证
        $(function () {
            $("#sub").click(function(){
            var flag = true;

            // 声明表单变量
            var userName = $("[name='userName']");
            var passWord = $("[name='passWord']");
            var doPassWord = $("[name='doPassWord']");
            var imageCode = $("[name='imageCode']");

            // 校验用户名
                if(userName.val().trim()==""){
                    $("#checkUerName").attr("class", "cuo");
                    $("#checkUerName").html("");
                    $("#checkUerName").append("用户名不可为空");
                    flag=false;
                }else{
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/checkUserName.do?userName=" + userName.val(),
                        success: function (data) {
                            if (data == "true") {
                                $("#checkUerName").attr("class", "dui");
                                $("#checkUerName").html("");
                            } else {
                                $("#checkUerName").attr("class", "cuo");
                                $("#checkUerName").html("");
                                $("#checkUerName").append("用户名已存在");
                                flag=false;
                            }
                        }
                    })
                }


            // 校验密码
                var num = /\d/
                var letter = /[a-zA-Z]/
                var symbol = /[^a-zA-Z0-9]/
                if(!num.test(passWord.val())||!letter.test(passWord.val())||!symbol.test(passWord.val())||passWord.val().trim()==""||6 > passWord.val().length||passWord.val().length>16){
                    $("#checkPassWord").html("");
                    $("#checkPassWord").attr("class","cuo");
                    $("#checkPassWord").append("密码由6-16的字母、数字、符号组成");
                    flag=false;
                }else{
                    $("#checkPassWord").html("");
                    $("#checkPassWord").attr("class", "dui");
                }

            //  确认密码校验
                if(doPassWord.val()==passWord.val() && doPassWord.val().trim()!=""){
                    $("#checkDoPassWord").html("");
                    $("#checkDoPassWord").attr("class", "dui");
                }else{
                    $("#checkDoPassWord").html("");
                    $("#checkDoPassWord").attr("class", "cuo");
                    $("#checkDoPassWord").append("密码不一致，请重新输入");
                    flag=false;
                }

            //校验图形验证码是否正确
                $.ajax({
                    url: "${pageContext.request.contextPath}/doValidate.do?code=" + imageCode.val(),
                    success: function (data) {
                        if (data == "true") {
                            $("#checkImageCode").html("");
                            $("#checkImageCode").attr("class", "dui");
                        } else {
                            $("#checkImageCode").html("");
                            $("#checkImageCode").attr("class", "cuo");
                            $("#checkImageCode").append("验证码输入错误，请重新输入");
                            flag=false;
                        }
                    }
                })

                // 校验电话号
                if(!/^1[3-9]\d{9}$/.test($("[name='tel']").val())){
                    $("#checkTel").html("");
                    $("#checkTel").attr("class", "cuo");
                    $("#checkTel").append("手机号格式不正确");
                    flag=false;
                }
                // 校验手机验证码

                if (!(telCode == $("[name='telCode']").val() && telCode != null)) {
                    $("#checkTelCode").html("");
                    $("#checkTelCode").attr("class", "cuo");
                    $("#checkTelCode").append("短信验证码错误");
                    flag=false;
                }

                 if(!flag){
                    alert("您有未填写信息请检查");
                }else if($("[name='hobby']").attr("checked")!="checked"){
                     alert("请勾选网站服务协议");
                 }else{
                    $("#from").submit();
                }

            });
        });
        $(function () {
            $("#messageCode").click(function () {
                if(/^1[3-9]\d{9}$/.test($("[name='tel']").val())){
                   $.ajax({
                        url: "${pageContext.request.contextPath}/tel.do?tel="+$("[name='tel']").val(),
                        success: function (data) {
                            telCode=data;
                        }
                    })
                }

            })
        })
        // 更换验证码图片
        $(function(){
            $("#changePic").click(function () {
                $("#codeImg").attr("src","${pageContext.request.contextPath}/validate.do");
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


<!--内容开始-->
<div class="password-con registered">
    <form id="from" action="${pageContext.request.contextPath}/registerSubmit.do" method="post">
        <div class="psw">
            <p class="psw-p1">用户名</p>
            <input type="text" placeholder="请输入用户名" name="userName"/>
            <span id="checkUerName">${nameError}</span>
        </div>
        <div class="psw">
            <p class="psw-p1">输入密码</p>
            <input type="text" placeholder="请输入密码" name="passWord" />
            <span id="checkPassWord">${passError}</span>
        </div>
        <div class="psw">
            <p class="psw-p1">确认密码</p>
            <input type="text" placeholder="请再次确认密码" name="doPassWord"/>
            <span id="checkDoPassWord"></span>
        </div>
        <div class="psw psw2">
            <p class="psw-p1">手机号</p>
            <input type="text" placeholder="请输入手机号" name="tel"/>
            <button id="messageCode" type="button">获取短信验证码</button>
            <span id="checkTel">${telError}</span>
        </div>
        <div class="psw psw3">
            <p class="psw-p1">验证码</p>
            <input type="text" placeholder="请输入手机验证码" name="telCode"/>
            <span id="checkTelCode"></span>
        </div>
        <div class="psw psw3">
            <p class="psw-p1">验证码</p>
            <input type="text" placeholder="请输入验证码" name="imageCode"/>
            <span id="checkImageCode"></span>
        </div>
        <div class="yanzhentu">
            <div class="yz-tu f-l">
                <img id="codeImg" src="${pageContext.request.contextPath}/validate.do"/>
            </div>
            <p class="f-l">看不清？<a id="changePic" href="javascript:(0)">换张图</a></p>
            <div style="clear:both;"></div>
        </div>
        <div class="agreement">
            <input type="checkbox" name="hobby" value="hobby"></input>
            <p>我有阅读并同意<span>《宅客微购网站服务协议》</span></p>
        </div>
        <button class="psw-btn" id="sub" type="button">立即注册</button>
    </form>
    <p class="sign-in">已有账号？请<a href="${pageContext.request.contextPath}/login.do">登录</a></p>
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
