<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen" />
    <title>千企查-企业老板查询_企业高管查询</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta content="telephone=no" name="format-detection" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="css/class.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/size.css" />
    <script src="js/jquery-3.2.1.js"></script>
</head>
<body class="innerbox">

<!--网站头部电脑端-->
<div id="hd">
    <div class="wp">
        <div class="logo"><a href="search_corp.do"><img src="icon/logo_64.png" alt=""></a></div>
        <div id="nav">
            <ul>
                <li><a href="search_corp.do">查企业</a></li>
                <li><a href="search_boss.do" style="color:#1db5ee; border-bottom:3px solid #1db5ee;">查老板</a></li>
                <li><a href="search_rela.do" >查关系</a></li>
                <li><a href="contact_us.do">联系我们</a></li>
            </ul>
        </div>
        <div class="log_reg">
            <c:if test="${status == '登录' }">
                <font size="2.5" id="login">${status }</font>
            </c:if>
            <c:if test="${status != '登录' }">
                <font size="2.5" id="login">${status }</font>
                <font size="2.5" >&nbsp;&nbsp;| &nbsp;&nbsp;</font>
                <font size="2.5" id="exitLogin">退出</font>
            </c:if>
        </div>
        <div id = "userId" style="display: none">${loginUser.id }</div>
    </div>
</div>
<div class="c"></div>


<!--网站登录注册-->
<div id="log_reg_div" style="position:absolute;top: 100px;left: 460px;">
    <!-- 登录界面  -->
    <div id="log_div">
        <font size="5" style="position:relative;top: 20px;">用户登录</font>
        <div id="log_div_d">
            <table>
                <tr>
                    <td>
                        <img id="log_div_d_i1" src="icon/phone_num.png" width="35px" height="30px"/>
                        <input id="log_div_d_in1" type="text" name="user_account" placeholder="账号"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img id="log_div_d_i2" src="icon/password.png" width="35px" height="30px"/>
                        <input id="log_div_d_in2" type="password" name="user_password" placeholder="密码"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img id="log_div_d_i3" src="icon/identifnum.png" width="35px" height="30px"/>
                        <div id="log_div_d_d1">
                            <div id="log_div_d_d1_d1">
                                <input type="text" name="code" class="code-input"/>
                                <p id="message"></p>
                                <span>>>></span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button id="log_div_d_b1" type="submit" name="dosubmit1">
                            <font size="3" color="white">登录</font>
                        </button>
                    </td>
                </tr>
                <tr>
                    <td style="position:relative;left: 175px;top: 115px;">
                        <a href=""><font size="2">忘记密码？</font></a>
                    </td>
                </tr>
                <tr>
                    <td id="log_div_d_td1">
                        <font id="log_div_d_td1_f1" size="2" color="#1296db">点击注册</font>
                    </td>
                </tr>
                <tr>
                    <td style="position:relative;left: -45px;top: 155px;">
                        <font id = "loginMessage" size="2.5" color="red"></font>
                    </td>
                </tr>
            </table>
        </div>
        <script>
            window.addEventListener('load', function () {
                var code = "", codeFn = new moveCode(code);
            });
        </script>

        <div id="close_log_div">
            <img src="icon/close.png" width="20px" height="20px"/>
        </div>

    </div>

    <!-- 注册界面  -->
    <div id="reg_div">
        <font size="5" style="position:relative;top: 20px;">用户注册</font>
        <div id="reg_div_d1">
            <table>
                <tr>
                    <td>
                        <img id="reg_div_d1_i1" src="icon/phone_num.png" width="35px" height="30px"/>
                        <input id="reg_div_d1_in1" type="text" name="regist_account" placeholder="手机号码"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img id="reg_div_d1_i2" src="icon/password.png" width="35px" height="30px"/>
                        <input id="reg_div_d1_in2" type="password" name="regist_password1" placeholder="登录密码"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img id="reg_div_d1_i3" src="icon/password.png" width="35px" height="30px"/>
                        <input id="reg_div_d1_in3" type="password" name="regist_password2" placeholder="确认密码"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img id="reg_div_d1_i4" src="icon/document.png" width="35px" height="30px"/>
                        <input id="reg_div_d1_in4" type="text" name="regist_name" placeholder="用户昵称"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button id="reg_div_d1_b1" type="submit" name="doregist1">
                            <font size="3" color="white">注册</font>
                        </button>
                    </td>
                </tr>
                <tr>
                    <td id="reg_div_d1_td1">
                        <font id="reg_div_d1_td1_f1" size="2" color="#1296db">点击返回</font>
                    </td>
                </tr>
                <tr>
                    <td style="position:relative;left: -15px;top: 160px;">
                        <font id = "registMessage" size="2.5" color="red"></font>
                    </td>
                </tr>
            </table>
        </div>

        <div id="close_reg_div">
            <img src="icon/close.png" width="20px" height="20px"/>
        </div>
    </div>
</div>


<!--网站搜索栏-->
<div id="bd"></div>
<div id="banner">
    <div class="flexslider">
        <ul class="slides">
            <li class="s1">
                <img src="img/photo1.jpg">
            </li>
        </ul>
    </div>
    <div style="position: relative;top: -400px;width: 100%;height: 100px;text-align: center">
        <font color="#fff" size="6">查企业，就用千企查！</font><br/>
        <font color=" #fff" size="3.5">——&nbsp;&nbsp;让信息更真实&nbsp;&nbsp;——</font>
    </div>


    <div style="position: relative;top: -360px;left: 0px;width: 100%;height: 50px;text-align: center">
        <input id="search_input" type="text" name="search" placeholder="请输入高管、法人或股东姓名，如“马云”"
               style="height: 50px;width: 720px;border: none;font-size: 18px;"/>
        <img id="voice" src="icon/voice1.png" width="35" height="35" style="position: absolute;left: 940px;top: 7px;"/>
        <button id="search_button" type="button"
                style="position: relative;left: -4px;top: 2px;height: 50px;width: 100px;border: none;background-color: #1db5ee">
            <font size="4" color="white" style="align-content: center">搜索</font>
        </button>
    </div>

    <div style="position: relative;top: -310px;left: 250px;width: 100%;height: 20px;">
        <ul class="hot_search_ul">
            <li><img src="icon/hot_search.png"></li>
            <li style="margin-left: -15px;margin-top: 3px"><font size="3">热搜人物：</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">马云</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">李彦宏</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">王健林</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">马化腾</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">雷军</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">曹德旺</font></li>
            <li class="hot_search_corp"><font color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">罗永浩</font></li>
        </ul>
    </div>
</div>
<div class="c"></div>

<!--网站介绍-->
<div style="position: relative;top: -50px;left: 5%;width: 90%;height: 150px;">
    <div style="position: relative;top: 10%;left: 4%;width: 17%;height: 80%;float: left;">
        <div style="position: relative;left: 0px;top: 0px;height: 100%;width: 30%;float: left">
            <img src="icon/spritesheet1.png"/>
        </div>
        <div style="position: relative;left: 0px;top: 10px;height: 100%;width: 58%;float: left">
            <span style="font-size: 16px;"><b>1.4亿+社会群体</b></span><br/>
            <font>支持多种查询，无需任何注册、登录，完全免费</font>
        </div>
    </div>
    <div style="position: relative;top: 10%;left: 12%;width: 17%;height: 80%;float: left;">
        <div style="position: relative;left: 0px;top: 0px;height: 100%;width: 30%;float: left">
            <img src="icon/spritesheet2.png"/>
        </div>
        <div style="position: relative;left: 0px;top: 10px;height: 100%;width: 58%;float: left">
            <span style="font-size: 16px;"><b>5000万+高管</b></span><br/>
            <font>多维度整合关联信息，智能匹配搜索结果</font>
        </div>
    </div>
    <div style="position: relative;top: 10%;left: 20%;width: 17%;height: 80%;float: left;">
        <div style="position: relative;left: 0px;top: 0px;height: 100%;width: 30%;float: left">
            <img src="icon/spritesheet3.png"/>
        </div>
        <div style="position: relative;left: 0px;top: 10px;height: 100%;width: 58%;float: left">
            <span style="font-size: 16px;"><b>权威来源</b></span><br/>
            <font>数据与国家权威网站同步,实时更新</font>
        </div>
    </div>
    <div style="position: relative;top: 10%;left: 28%;width: 17%;height: 80%;float: left;">
        <div style="position: relative;left: 0px;top: 0px;height: 100%;width: 30%;float: left">
            <img src="icon/spritesheet4.png"/>
        </div>
        <div style="position: relative;left: 0px;top: 10px;height: 100%;width: 58%;float: left">
            <span style="font-size: 16px;"><b>全量数据</b></span><br/>
            <font>工商数据，法律诉讼，新闻动态，企业年报等全量信息库</font>
        </div>
    </div>
</div>
<div style="position: relative;top: 120px;left: 30%;width: 40%;height: 100px;"></div>


<!-- 网站侧边栏 -->
<div class="side">
    <ul>
        <li><a href=""><div class="sidebox"><img src="icon/side_icon02.png">15755332393</div></a></li>
        <li><a href=""><div class="sidebox"><img src="icon/side_icon01.png">2419304297</div></a></li>
        <li><a href="javascript:void(0);" ><div class="sidebox"><img src="icon/side_icon03.png">15755332393</div></a></li>
    </ul>
</div>
<div class="side2">
    <ul>
        <li><a href=""><img src="icon/r_icon1.png" alt=""></a><div class="weixin"><em></em><img src="icon/ewm.jpg" alt=""></div></li>
        <li><a href="javascript:goTop();" class="sidetop"><img src="icon/r_icon2.png"></a></li>
    </ul>
</div>


<!-- 网站底部 -->
<div id="fd" class="index-fd pr">
    <div class="map-bg3"></div>
    <div class="wp">
        <div class="fd-top">
            <dl>
                <dt>关于千企查</dt>
                <dd>
                    <ul class="ul-fd">
                        <li><a href="">支持多种查询</a></li>
                        <li><a href="">多维度整合关联信息</a></li>
                        <li><a href="">数据与国家权威网站同步</a></li>
                        <li><a href="">企业年报等全量信息库</a></li>
                    </ul>
                </dd>
            </dl>
            <dl>
                <dt>千企查服务</dt>
                <dd>
                    <ul class="ul-fd">
                        <li><a href="">企业查询</a></li>
                        <li><a href="">高管查询</a></li>
                        <li><a href="">关系查询</a></li>
                        <li><a href="">联系我们</a></li>
                    </ul>
                </dd>
            </dl>
            <dl>
                <dt>千企查案例</dt>
                <dd>
                    <ul class="ul-fd">
                        <li><a href="">Elasticsearch搜索</a></li>
                        <li><a href="">Redis缓存</a></li>
                        <li><a href="">ECharts图谱</a></li>
                        <li><a href="">FPGrowth算法</a></li>
                        <li><a href="">朴素贝叶斯算法</a></li>
                        <li><a href="">Maven管理</a></li>
                    </ul>
                </dd>
            </dl>
            <dl>
                <dt>友情链接</dt>
                <dd>
                    <ul class="ul-fd">
                        <li><a href="http://www.aiit.edu.cn/" target="_blank">安徽信息工程学院</a></li>
                        <li><a href="http://www.cnsoftbei.com/" target="_blank">中国软件杯</a></li>
                        <li><a href="http://www.miit.gov.cn/" target="_blank">工业和信息化部</a></li>
                        <li><a href="http://www.jiangsu.gov.cn/" target="_blank">江苏省人民政府</a></li>
                    </ul>
                </dd>
            </dl>
            <dl>
                <dt>联系我们</dt>
                <dd class="pr">
                    <p><a href="" class="weixin"></a><a href="" class="sina"></a><span class="weixin-pic"><img
                            src="icon/ewm.jpg" alt=""></span></p>
                    <p><b class="tel">157-5533-2393</b></p>
                    <h5>千企查服务热线</h5>
                </dd>
            </dl>
        </div>
    </div>
    <div class="fd-copy">
        <div class="wp">
            <p>
                <span>千企查XXXX有限公司 Copyright&copy; 2007-2015 </span><a href=""><span>苏ICP备XXXXXXX号-1</span></a> <a
                    href=""></a>
            </p>
        </div>
    </div>
</div>


<script type="text/javascript" src="js/roll.js"></script>
<script type="text/javascript" src="js/flexslider.js"></script>
<script type="text/javascript" src="js/other.js"></script>
</body>
</html>