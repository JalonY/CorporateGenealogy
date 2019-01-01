<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen"/>
    <title>千企地图_千企查</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta content="telephone=no" name="format-detection"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="css/class.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/size.css"/>
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=q7IDDpeG6pBgm2vRYOCLyI9phWdUD6jY"></script>
    <script src="js/echarts.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.bootcss.com/vue/2.5.13/vue.min.js"></script>
    <script src="https://cdn.bootcss.com/vue-resource/1.3.4/vue-resource.js"></script>
    <script src="https://cdn.bootcss.com/vuex/3.0.1/vuex.min.js"></script>
</head>
<body class="innerbox">

<!--网站头部电脑端-->
<div id="hd" style="height: 60px">
    <div class="wp">
        <div class="logo" style="height: 60px"><a href="search_corp.do" style="line-height: 60px;"><img src="icon/logo_48.png" alt=""></a></div>
        <div id="nav" style="line-height: 60px">
            <ul>
                <li style="line-height: 60px;"><a href="search_corp.do" style="height: 60px">查企业</a></li>
                <li style="line-height: 60px;"><a href="search_boss.do" style="height: 60px">查老板</a></li>
                <li style="line-height: 60px;"><a href="search_rela.do" style="height: 60px">查关系</a></li>
                <li style="line-height: 60px;"><a href="contact_us.do" style="height: 60px">联系反馈</a></li>
                <li style="line-height: 60px;"><a href="search_map.do" style="color:#1db5ee; border-bottom:3px solid #1db5ee;height: 60px">千企地图</a></li>
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

<!--左侧信息展示、右侧地图-->
<div id="wholeDiv">
    <!--企业信息区域-->
    <div id="mapinfo_div" style="position: absolute;top: 61px;left: 0px;width: 35%;height: 86%;">
        <div class="innerbox" style="position: absolute;top: 0px;left: 2px;width: 100%;height: 44%;border: 1px solid darkgray;overflow-x: auto">
            <div id="mapCorp1" style="position: absolute;left: 0px;top: 0px;width: 420px;height: 100%;float: left;"></div>
            <div id="mapCorp2" style="position: absolute;left: 450px;top: 0px;width: 420px;height: 100%;float: left;"></div>
            <font class="mapMessage" size="3" color="#808080" style="position: absolute;left: 33%;top: 45%;display: none">地图当前区域未搜到相关企业</font>
        </div>

        <div id="mapCorpList" class="innerbox" style="position: absolute;top: 45%;left: 2px;width: 100%;height: 60%;overflow-y: auto;border: 1px solid darkgray;" >
            <ul v-for="(corp, corpIndex) in corpList">
                <li style="height: 100px;border-bottom:#1db5ee 1px dashed;padding-bottom:10px;margin-bottom:0px;overflow:hidden;">
                    <a href=""><img width="90" height="90" alt="logo" v-bind:src="corp.corpLogo" style="margin-top: 5px;border:#ccc 1px solid;padding:2px;float:left;"/></a>
                    <a target="_blank" v-bind:href="'http://localhost:8080/see_details.do?corp_id='+corp.corpId" >
                        <font id = "map_corpName" style="padding:10px;" size="3"><b>{{ corp.corpName}}</b></font>
                    </a><br/>
                    <font style="padding:10px;" size="3">法人：</font>
                    <font style="padding:0px;color: gray" size="3">{{ corp.operManName}}</font>
                    <font style="padding:10px;" size="3">注册资本：</font>
                    <font style="padding:0px;color: gray" size="3">{{ corp.regCapi}}万元</font><br/>
                    <font style="padding:10px;" size="3">行业：</font>
                    <font style="padding:0px;color: gray" size="3">{{ corp.belongTrade}}</font><br/>
                    <span v-if="corp.admitMain != '——'" style="margin-left: 10px;background-color: #1db5ee;"><font size="1.5" color="#ffffff">{{ corp.admitMain}}</font></span>
                </li>
            </ul>
            <font class="mapMessage" size="3" color="#808080" style="position: absolute;left: 33%;top: 45%;display: none">地图当前区域未搜到相关企业</font>
        </div>

        <div id="mapCorpTable" class="innerbox" style="position: absolute;top: 45%;left: 2px;width: 100%;height: 60%;overflow-y: auto;border: 1px solid darkgray;display: none">
            <table id="showCorpTable" class="display" style="margin-top: 5px">
                <thead>
                <tr align="left">
                    <th>公司名称</th>
                    <th>法人</th>
                    <th>注册资本(万)</th>
                    <th>所属行业</th>
                    <th>详细地址</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <!--地图区域-->
    <div id="mapCorp_div" style="position: absolute;top: 61px;left: 36%;width: 64%;height: 90%;border: 1px solid lightgray;overflow: hidden;font-family: '微软雅黑';">
        <div id="allmap" style="width: 100%;height: 100%;float:left;">
        </div>
        
        <div style="position: absolute;top: 38%;left: 0px;width: 50px;height: 100px;border-radius:0 50px 50px 0;background-color: darkred;opacity:0.6;float:left;">
            <img id = "map_right" src="icon/map_right.png" width="60" height="50" style="margin-top: 25px"/>
            <img id = "map_left" src="icon/map_left.png" width="60" height="50" style="margin-top: 25px;display: none"/>
        </div>
    </div>

    <!--搜索区域-->
    <div id="search" style="position: fixed;top: 10%;left: 76%;width: 20%;height: 7%;background-color: white;box-shadow: 0px 4px 8px rgba(44, 35, 35, 0.6)">
        <input type="text" ref="cityName" placeholder="请输入城市名称" @keyup.enter="locationByCityName"
               style="height: 35px;width: 220px;border: none;outline:none;font-size: 18px;margin-top: 7px"/>
        <div style="position: absolute;top: 15%;left: 84%;height: 68%;width: 12%;background-image: url(/icon/map_search.png)" v-on:click="locationByCityName();">
        </div>
    </div>
</div>

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

<script type="text/javascript" src="js/roll.js"></script>
<script type="text/javascript" src="js/flexslider.js"></script>
<script type="text/javascript" src="js/other.js"></script>
<script type="text/javascript" src="js/map-vue.js"></script>
</body>
</html>

