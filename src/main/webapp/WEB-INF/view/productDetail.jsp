<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/26
  Time: 13:57
  To change this template use File | Settings | File Templates. 商品详情页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>商品详情</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shopping-mall-index.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhonglin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/zhongling2.js"></script>
    <script type="text/javascript">
        $(function () {
            var num=1;
            $("#reduce").click(function () {
                if(num<=1){
                    $("#num").val(1);
                }else {
                    num=num-1
                    $("#num").val(num);
                }
            })
            $("#add").click(function () {
                num=num+1;
                $("#num").val(num);
            })
        })
        $(function () {
            //立即购买
            $("#btn1").click(function () {
                $("#productForm").attr("action","${pageContext.request.contextPath}/order/firmOrder.do");
                $("#productForm").submit();
            })
            //加入购物车
            $("#btn2").click(function () {
               $.ajax({
                   url:"${pageContext.request.contextPath}/order/addBasket.do",
                   data:{
                       pid:"${productDetail.pid}",
                       aid:$("[name='aid']").val(),
                       count:$("#num").val(),
                       date:$("[name='date']").val()
                   },
                   success:function (msg) {
                       if(msg=="ok"){
                           alert("添加至购物车成功")
                       }else{
                           alert("添加至购物车失败")
                       }

                   }
               })
            })
            //
            $("#btn3").click(function () {

            })
        })
    </script>
</head>

<body style="position:relative;">
<!--header-->
<div class="zl-header">
    <div class="zl-hd w1200">
        <p class="hd-p1 f-l">
            Hi!您好，欢迎来到宅客微购，请登录  <a href="注册.html">【免费注册】</a>
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
            <a href="index.html" title="中林logo"><img src="${pageContext.request.contextPath}/images/zl2-01.gif" /></a>
        </div>
        <div class="shangjia f-l">
            <a href="JavaScript:;" class="shangjia-a1">[ 切换城市 ]</a>
            <a href="JavaScript:;" class="shangjia-a2">商家入口</a>
            <div class="select-city">
                <div class="sl-city-top">
                    <p class="f-l">切换城市</p>
                    <a class="close-select-city f-r" href="JavaScript:;">
                        <img src="${pageContext.request.contextPath}/images/close-select-city.gif" />
                    </a>
                </div>
                <div class="sl-city-con">
                    <p>西北</p>
                    <dl>
                        <dt>重庆市</dt>
                        <dd>
                            <a href="JavaScript:;">长寿区</a>
                            <a href="JavaScript:;">巴南区</a>
                            <a href="JavaScript:;">南岸区</a>
                            <a href="JavaScript:;">九龙坡区</a>
                            <a href="JavaScript:;">沙坪坝区</a>
                            <a href="JavaScript:;">北碚</a>
                            <a href="JavaScript:;">江北区</a>
                            <a href="JavaScript:;">渝北区</a>
                            <a href="JavaScript:;">大渡口区</a>
                            <a href="JavaScript:;">渝中区</a>
                            <a href="JavaScript:;">万州</a>
                            <a href="JavaScript:;">武隆</a>
                            <a href="JavaScript:;">晏家</a>
                            <a href="JavaScript:;">长寿湖</a>
                            <a href="JavaScript:;">云集</a>
                            <a href="JavaScript:;">华中</a>
                            <a href="JavaScript:;">林封</a>
                            <a href="JavaScript:;">双龙</a>
                            <a href="JavaScript:;">石回</a>
                            <a href="JavaScript:;">龙凤呈祥</a>
                            <a href="JavaScript:;">朝天门</a>
                            <a href="JavaScript:;">中华</a>
                            <a href="JavaScript:;">玉溪</a>
                            <a href="JavaScript:;">云烟</a>
                            <a href="JavaScript:;">红塔山</a>
                            <a href="JavaScript:;">真龙</a>
                            <a href="JavaScript:;">天子</a>
                            <a href="JavaScript:;">娇子</a>
                        </dd>
                        <div style="clear:both;"></div>
                    </dl>
                    <dl>
                        <dt>新疆</dt>
                        <dd>
                            <a href="JavaScript:;">齐乌鲁木</a>
                            <a href="JavaScript:;">昌吉</a>
                            <a href="JavaScript:;">巴音</a>
                            <a href="JavaScript:;">郭楞</a>
                            <a href="JavaScript:;">伊犁</a>
                            <a href="JavaScript:;">阿克苏</a>
                            <a href="JavaScript:;">喀什</a>
                            <a href="JavaScript:;">哈密</a>
                            <a href="JavaScript:;">克拉玛依</a>
                            <a href="JavaScript:;">博尔塔拉</a>
                            <a href="JavaScript:;">吐鲁番</a>
                            <a href="JavaScript:;">和田</a>
                            <a href="JavaScript:;">石河子</a>
                            <a href="JavaScript:;">克孜勒苏</a>
                            <a href="JavaScript:;">阿拉尔</a>
                            <a href="JavaScript:;">五家渠</a>
                            <a href="JavaScript:;">图木舒克</a>
                            <a href="JavaScript:;">库尔勒</a>
                        </dd>
                        <div style="clear:both;"></div>
                    </dl>
                    <dl>
                        <dt>甘肃</dt>
                        <dd>
                            <a href="JavaScript:;">兰州</a>
                            <a href="JavaScript:;">天水</a>
                            <a href="JavaScript:;">巴音</a>
                            <a href="JavaScript:;">白银</a>
                            <a href="JavaScript:;">庆阳</a>
                            <a href="JavaScript:;">平凉</a>
                            <a href="JavaScript:;">酒泉</a>
                            <a href="JavaScript:;">张掖</a>
                            <a href="JavaScript:;">武威</a>
                            <a href="JavaScript:;">定西</a>
                            <a href="JavaScript:;">金昌</a>
                            <a href="JavaScript:;">陇南</a>
                            <a href="JavaScript:;">临夏</a>
                            <a href="JavaScript:;">嘉峪关</a>
                            <a href="JavaScript:;">甘南</a>
                        </dd>
                        <div style="clear:both;"></div>
                    </dl>
                    <dl>
                        <dt>宁夏</dt>
                        <dd>
                            <a href="JavaScript:;">银川</a>
                            <a href="JavaScript:;">吴忠</a>
                            <a href="JavaScript:;">石嘴山</a>
                            <a href="JavaScript:;">中卫</a>
                            <a href="JavaScript:;">固原</a>
                        </dd>
                        <div style="clear:both;"></div>
                    </dl>
                    <dl>
                        <dt>青海</dt>
                        <dd>
                            <a href="JavaScript:;">西宁</a>
                            <a href="JavaScript:;">海西</a>
                            <a href="JavaScript:;">海北</a>
                            <a href="JavaScript:;">果洛</a>
                            <a href="JavaScript:;">海东</a>
                            <a href="JavaScript:;">黄南</a>
                            <a href="JavaScript:;">玉树</a>
                            <a href="JavaScript:;">海南</a>
                        </dd>
                        <div style="clear:both;"></div>
                    </dl>
                </div>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div class="erweima f-r">
        <a href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/zl2-04.gif" /></a>
    </div>
    <div class="search f-r">
        <div class="search-info">
            <input type="text" placeholder="请输入商品名称" />
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
<div class="details w1200">
    <div class="deta-info1">
        <div class="dt-if1-l f-l">
            <div class="dt-if1-datu">
                <ul qie-da="">
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda1.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda2.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda3.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda4.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda5.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda6.gif" /></a></li>
                    <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-l-tuda7.gif" /></a></li>
                    <div style="clear:both;"></div>
                </ul>
            </div>
            <div class="dt-if1-qietu">
                <a class="dt-qie-left f-l" href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu-left.gif" /></a>
                <div class="dt-qie-con f-l">
                    <ul qie-xiao="">
                        <li class="current"><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu1.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu2.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu3.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu4.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu5.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu6.gif" /></a></li>
                        <li><a href="#"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu7.gif" /></a></li>
                        <div style="clear:both;"></div>
                    </ul>
                </div>
                <a class="dt-qie-right f-r" href="JavaScript:;"><img src="${pageContext.request.contextPath}/images/dt-if1-qietu-right.gif" /></a>
            </div>
            <div class="dt-if1-fx">
                <span>商品编码:128618586</span>
                <p>分享到：<a href="#"><img src="${pageContext.request.contextPath}/images/dt-xl.gif" /></a><a href="#"><img src="${pageContext.request.contextPath}/images/dt-kj.gif" /></a><a href="#"><img src="${pageContext.request.contextPath}/images/dt-wx.gif" /></a></p>
            </div>
        </div>
        <form action="#" method="post" id="productForm">
            <div class="dt-if1-m f-l">
            <div class="dt-ifm-hd">
                <h3><a href="#">${productDetail.pName}</a></h3>
            </div>
            <div class="dt-ifm-gojia">
                <dl>
                    <dt>宅购价</dt>
                    <dd>
                        <p class="p1">
                            <span class="sp1"> <input type="hidden" name="singlePrice" value="${productDetail.marketPrice}">${productDetail.marketPrice}</span><span class="sp2">${productDetail.shopPrice}</span>
                        </p>
                        <p class="p2">
                            <span class="sp1">库存：${productDetail.stock} 件</span>
                        </p>
                    </dd>
                    <div style="clear:both;"></div>
                </dl>
            </div>
            <dl class="dt-ifm-spot">
                <dt>活动</dt>
                <dd>
                    <P><span>包邮</span>本店满50.00元免运费</P>
                    <P><span>满赠</span>本店满500.00元赠300.00元礼品（随机赠送）</P>
                </dd>
                <div style="clear:both;"></div>
            </dl>
            <dl class="dt-ifm-box1">
                <dt>送时</dt>
                <dd>
                    <input type="date" name="date"/>
                    <p>如果选择的送达日期在下单后的两天之内按默认时间送达呦！</p>
                </dd>
                   <input type="hidden" name="pid" value="${productDetail.pid}">
                <div style="clear:both;"></div>
            </dl>
            <dl class="dt-ifm-box2">
                <dt>送至</dt>
                <dd>
                    <select name="aid">
                        <c:forEach items="${addressList}" var="address">
                            <option value="${address.aid}">${address.addr}</option>
                        </c:forEach>
                    </select>
                    <span>请选择配送地址</span>
                </dd>
                <div style="clear:both;"></div>
            </dl>
            <dl class="dt-ifm-box3">
                <dt>数量</dt>
                <dd>
                    <a class="box3-left" href="JavaScript:;" id="reduce">-</a>
                    <input type="text" id="num" name="count" value="1" readonly>
                    <a class="box3-right" href="JavaScript:;" id="add">+</a>
                </dd>
                <div style="clear:both;"></div>
            </dl>
            <div class="dt-ifm-box4">
                <button class="btn1" id="btn1">立即购买</button>
                <button class="btn2" id="btn2" type="button">加入购物车</button>
                <button class="btn3" id="btn3">收藏</button>
            </div>
        </div>
        </form>
        <div class="dt-if1-r f-r">
            <div class="dt-ifr-hd">
                <div class="dt-ifr-tit">
                    <h3>三只松鼠百货专营店</h3>
                </div>
                <ul class="dt-ifr-ul1">
                    <li>
                        <p class="p1">4.61 ↑</p>
                        <p class="p2">商品评分</p>
                    </li>
                    <li>
                        <p class="p1">4.61 ↑</p>
                        <p class="p2">商品评分</p>
                    </li>
                    <li>
                        <p class="p1">4.61 ↑</p>
                        <p class="p2">商品评分</p>
                    </li>
                    <div style="clear:both;"></div>
                </ul>
                <div class="dt-ifr-tel">
                    <p>地址：重庆渝北区高新园昆仑大道60号　　　龙头寺火车站旁</p>
                    <p>TEL：18616854445</p>
                </div>
                <button class="dt-r-btn1">进入店铺</button>
                <button class="dt-r-btn2">收藏店铺</button>
            </div>
            <div class="dt-ifr-fd">
                <div class="dt-ifr-tit">
                    <h3>同类推荐</h3>
                </div>
                <dl>
                    <dt><a href="#"><img src="${pageContext.request.contextPath}/images/dt-ifr-fd-dt-tu.gif" /></a></dt>
                    <dd>
                        <a href="#">【观音桥】罗兰钢管舞舞蹈体验</a>
                        <p>¥9.90</p>
                    </dd>
                    <div style="clear:both;"></div>
                </dl>
                <dl>
                    <dt><a href="#"><img src="${pageContext.request.contextPath}/images/dt-ifr-fd-dt-tu.gif" /></a></dt>
                    <dd>
                        <a href="#">【观音桥】罗兰钢管舞舞蹈体验</a>
                        <p>¥9.90</p>
                    </dd>
                    <div style="clear:both;"></div>
                </dl>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>

    <div class="deta-info2">
        <div class="dt-if2-l f-l">
            <div class="if2-l-box1">
                <div class="if2-tit">
                    <h3>浏览记录</h3>
                </div>
                <ul>
                    <li>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                    <li>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                    <li style="border-bottom:0;">
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                </ul>
            </div>
            <div class="if2-l-box1" style="margin-top:18px;">
                <div class="if2-tit">
                    <h3>看了又看</h3>
                </div>
                <ul>
                    <li>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                    <li>
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                    <li style="border-bottom:0;">
                        <a href="#"><img src="${pageContext.request.contextPath}/images/if2-l-box1-tu1.gif" /></a>
                        <a class="if2-li-tit" href="#">乐事Lay's 无限薯片（翡翠黄瓜味）104g/罐</a>
                        <p>¥6.90</p>
                    </li>
                </ul>
            </div>
        </div>
        <div class="dt-if2-r f-r">
            <ul class="if2-tit2">
                <li class="current" com-det="dt1"><a href="JavaScript:;">产品信息</a></li>
                <div style="clear:both;"></div>
            </ul>
            <div style="border:1px solid #DBDBDB;" com-det-show="dt1">
                <div class="if2-tu1">
                    <img src="${pageContext.request.contextPath}/images/if2-tu1.gif" />
                    <img src="${pageContext.request.contextPath}/images/if2-tu2.gif" style="margin-top:47px;" />
                    <div style="clear:both;"></div>
                </div>
                <div class="if2-tu2">
                    <img src="${pageContext.request.contextPath}/images/if2-tu3.gif" />
                    <div style="clear:both;"></div>
                </div>
                <div class="if2-tu3">
                    <img src="${pageContext.request.contextPath}/images/if2-tu4.gif" />
                </div>
                <ul class="if2-tu4">
                    <li><img src="${pageContext.request.contextPath}/images/if2-tu5.gif" /></li>
                    <li><img src="${pageContext.request.contextPath}/images/if2-tu6.gif" /></li>
                    <li><img src="${pageContext.request.contextPath}/images/if2-tu7.gif" /></li>
                    <div style="clear:both;"></div>
                </ul>
            </div>
        </div>
        <div style="clear:both;"></div>
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

