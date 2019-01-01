<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen" />
    <title>千企查-企业关系查询</title>
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
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/echarts.js"></script>
    <script type="text/javascript">
        function checkA() {
            var checkA = document.getElementById("checkboxA").checked;
            var check1 = document.getElementById("checkboxA");
            if(checkA == true){
                $("#selectA").empty();
                var corpA = document.getElementById("corpA").value;
                if(corpA != ""){
                    $("#selectA").show("slow");
                    $.ajax({
                        url: 'http://localhost:8080/getPeopleByCorpName.do?corpName=' + corpA,
                        type: 'post',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            console.info(result);
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    $("#selectA").append("<option>"+ result[i].personName +"</option>");
                                }
                            }
                            if(result.length == 0){
                                setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
                                document.getElementById("showMessageFont3").innerText = "提示：当前企业暂无人员信息！";
                                setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
                                check1.checked = false;
                                $("#selectA").hide("slow");
                            }
                        }
                    });
                }else{
                    setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
                    document.getElementById("showMessageFont3").innerText = "提示：请输入企业A的名称！";
                    setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
                    check1.checked = false;
                }
            }else {
                $("#selectA").hide("slow");
            }
        }

        function checkB() {
            var checkB = document.getElementById("checkboxB").checked;
            var check2 = document.getElementById("checkboxB");
            if(checkB == true){
                $("#selectB").empty();
                var corpB = document.getElementById("corpB").value;
                if(corpB != ""){
                    $("#selectB").show("slow");
                    $.ajax({
                        url: 'http://localhost:8080/getPeopleByCorpName.do?corpName=' + corpB,
                        type: 'post',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            console.info(result);
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    $("#selectB").append("<option>"+ result[i].personName +"</option>");
                                }
                            }
                            if(result.length == 0){
                                setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
                                document.getElementById("showMessageFont3").innerText = "提示：当前企业暂无人员信息！";
                                setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
                                check2.checked = false;
                                $("#selectB").hide("slow");
                            }
                        }
                    });
                }else{
                    setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
                    document.getElementById("showMessageFont3").innerText = "提示：请输入企业B的名称！";
                    setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
                    check2.checked = false;
                }
            }else {
                $("#selectB").hide("slow");
            }
        }
    </script>
</head>
<body class="innerbox" style="background-color: #eef0f2">

<!--网站头部电脑端-->
<div id="hd">
    <div class="wp">
        <div class="logo"><a href="search_corp.do"><img src="icon/logo_64.png" alt=""></a></div>
        <div id="nav">
            <ul>
                <li><a href="search_corp.do">查企业</a></li>
                <li><a href="search_boss.do">查老板</a></li>
                <li><a href="search_rela.do" style="color:#1db5ee; border-bottom:3px solid #1db5ee;">查关系</a></li>
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


<!--查关系区域-->
<div style="position: relative;top: 120px;left: 5%;width: 90%;height: 600px;">
    <!--左侧菜单栏-->
    <div style="position: absolute;top: 0px;left: 0px;width: 24%;height: 62%;background-color: #ffffff">
        <div style="position: relative;left: 0px;top: 0px;height: 50px;width: 100%;">
            <div id="relaLeftDiv1" style="position: relative;left: 0px;top: 0px;width: 50%;height: 100%;text-align: center;line-height: 50px;float: left;border-bottom: 1px solid darkgray;background-color: #1db5ee">
                <font  id="relaLeftFont1"size="2.5" color="white">两家企业</font>
            </div>
            <div id="relaLeftDiv2" style="position: relative;left: 0px;top: 0px;width: 50%;height: 100%;text-align: center;line-height: 50px;float: left;border-bottom: 1px solid darkgray">
                <font id="relaLeftFont2" size="2.5">多家企业</font>
            </div>
        </div>

        <div style="position: relative;left: 0px;top: 20px;height: 150px;width: 100%;">
            <div id="corpASearch_main" style="position: relative;top: 0px;left: 0px;width: 100%;height: 50%;">
                <span style="background-color: #1db5ee;position: relative;top: 20%;">&nbsp;&nbsp;&nbsp;</span>
                <input id="corpA" type="text" style="height: 30px;width: 86%;border: 1px solid darkgray;font-size: 14px;position: relative;top: 20%;left: 11px" placeholder="在此添加企业A" /><br/><br/>
                <input id="checkboxA" type="checkbox" style="position: relative;left: 25px;" onchange="checkA()">
                <font style="position: relative;left: 25px">选择人员</font>
                <select id="selectA"style="position: relative;left: 50px;height: 25px;width: 100px;display: none"></select>
            </div>
            <div style="position: relative;top: 0px;left: 0px;width: 100%;height: 50%;">
                <span style="background-color: #73bc6c;position: relative;top: 20%;">&nbsp;&nbsp;&nbsp;</span>
                <input id="corpB" type="text" style="height: 30px;width: 86%;border: 1px solid darkgray;font-size: 14px;position: relative;top: 20%;left: 11px" placeholder="在此添加企业B" /><br/><br/>
                <input id="checkboxB" type="checkbox" style="position: relative;left: 25px" onchange="checkB()">
                <font style="position: relative;left: 25px">选择人员</font>
                <select id="selectB" style="position: relative;left: 50px;height: 25px;width: 100px;display: none" ></select>
            </div>
        </div>

        <div style="position: relative;left: 5%;top: 30px;height: 80px;width: 90%;">
            <font size="2.5">显示路径数</font><br/>
            <input type="range" min="1" max="10" step="1" value="3" style="position: relative;left: 0px;top: 10px;width: 90%;">
            <font class="rangeNum" size="3" style="position: relative;left: 10px;top: 5px;">6</font>
        </div>

        <div style="position: relative;left: 5%;top: 50px;height: 40px;width: 90%;">
            <button id="startAnalyze" style="position: relative;left: 0px;width: 100%;height: 100%;border: none;background-color: #1db5ee">
                <font size="3.5" color="white">开始分析</font>
            </button>
        </div>
    </div>

    <!--图谱展示区-->
    <div style="position: absolute;top: 0px;left: 315px;width: 74%;height: 100%;background-color: #ffffff">
        <div id="relaEcharts" style="position: relative;left: 0px;top: 0px;width: 100%;height: 82%;">
            <img id="relaBackground" src="img/relaBackground.png" style="width: 100%;height: 100%">
        </div>
        <div style="position: relative;left: 0px;top: 20px;width: 100%;height: 10%;text-align: center;line-height: 80px;">
            <font size="3" color="darkgray">您可以添加两个公司或个人，点击分析即可查看其所有关联路径。</font>
        </div>
    </div>
</div>


<!-- 消息提示 -->
<div id="showMessage3" style="position: fixed;top: 40%;left: 40%;width: 400px;height: 60px;z-index: 99;text-align: center;line-height: 60px;background-color: #2b2b2b;display: none;">
    <font id="showMessageFont3" size="3" style="color: #1db5ee"></font>
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


<div style="position: relative;top: 120px;left: 5%;width: 90%;height: 200px;"></div>
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