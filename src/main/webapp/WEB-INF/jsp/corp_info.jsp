<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen"/>
    <title>${Corp_Info.corpName}_${Corp_Info.operManName} 【工商信息_企业图谱】查询_千企查</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta content="telephone=no" name="format-detection"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/class.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/size.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/echarts.js"></script>
    <script src="js/chainmap.js"></script>
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.6&key=29d882686dc347b92d3db3f35015706b&plugin=AMap.Geocoder"></script>
    <script type="text/javascript">//全屏,退出全屏方法
        function requestFullScreen(element) {
            // 判断各种浏览器，找到正确的方法
            var requestMethod = element.requestFullScreen || //W3C
                element.webkitRequestFullScreen || //Chrome等
                element.mozRequestFullScreen || //FireFox
                element.msRequestFullScreen; //IE11
            if (requestMethod) {
                requestMethod.call(element);
            }
            else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript !== null) {
                    wscript.SendKeys("{F11}");
                }
            }
        }
        function exitFull() {
            // 判断各种浏览器，找到正确的方法
            var exitMethod = document.exitFullscreen || //W3C
                document.mozCancelFullScreen || //Chrome等
                document.webkitExitFullscreen || //FireFox
                document.webkitExitFullscreen; //IE11
            if (exitMethod) {
                exitMethod.call(document);
            }
            else if (typeof window.ActiveXObject !== "undefined") {//for Internet Explorer
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript !== null) {
                    wscript.SendKeys("{F11}");
                }
            }
        }
    </script>
    <script type="text/javascript">//地图全屏、退出按钮隐藏显示
        $(function () {
            $("#exit").hide();

            $("#full").click(function () {
                $("#exit").show();
                $("#full").hide();
            });
            $("#exit").click(function () {
                $("#full").show();
                $("#exit").hide();
            })
        });
    </script>
    <script type="text/javascript">//模态框全屏、退出按钮隐藏显示
        $(function () {
            $("#exit1").hide();

            $("#full1").click(function () {
                $("#exit1").show();
                $("#full1").hide();
            });
            $("#exit1").click(function () {
                $("#full1").show();
                $("#exit1").hide();
            })
        });
    </script>
</head>
<body class="innerbox" style="background-color: #eef0f2">

<!--网站头部电脑端-->
<div id="hd">
    <div class="wp">
        <div class="logo"><a href="search_corp.do"><img src="icon/logo_48.png" alt=""></a></div>
        <div style="position: relative;top: 25px;left: -50px;width: 100%;height: 50px;text-align: center">
            <input id="search_input3" type="text" name="search3" style="height: 40px;width: 700px;border: 1px solid #1db5ee;font-size: 16px;" value="${Corp_Info.corpName}" onkeypress="EnterPress(event)" onkeydown="EnterPress()"/>
            <button id="search_button3" type="button" style="position: relative;left: -4px;top: 2px;height: 40px;width: 100px;border: none;background-color: #1db5ee">
                <font size="4" color="white" style="align-content: center">搜索</font>
            </button>
        </div>
        <div class="log_reg" style="position: relative;top: -50px;left: 30px;">
            <c:if test="${status == '登录' }">
                <font size="2.5" id="login">${status }</font>
            </c:if>
            <c:if test="${status != '登录' }">
                <font size="2.5" id="login">${status }</font>
                <font size="2.5" >&nbsp;&nbsp;| &nbsp;&nbsp;</font>
                <font size="2.5" id="exitLogin">退出</font>
            </c:if>
        </div>
        <c:if test="${status != '登录' }">
        <div style="position: relative;top: 12px;left: 1115px;width: 150px;height: 25px">
            <img src="icon/handClick.png" width="20" height="20" style="position: absolute;top: 5px;left: 0px"/>
            <font size="1.5" style="color: #1db5ee;position: absolute;left: 25px;top: 5px;">查看收藏与关注！</font>
        </div>
        </c:if>
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

<div id = "returnHome" style="position: absolute;top: 110px;left: 5%;width: 36px;height: 30px;background-image: url(icon/returnHome.png)">
</div>
<!--公司详细信息-->
<div style="position: absolute;top: 150px;left: 5%;width: 90%;height: 2500px;">
    <!--头部简介-->
    <div style="position: relative;top: 0px;left: 0px;width: 100%;height: 250px;background-color: #ffffff">
        <div style="position: relative;top: 8%;left: 3%;width: 12%;height: 50%;">
            <img src="${Corp_Info.corpLogo}" width="100%" height="100%"/>
        </div>

        <div style="position: relative;top: -37%;left: 20%;width: 78%;height: 70%;">
            <font id="CORP_ID" style="display: none">${Corp_Info.id}</font>
            <font size="4" id="CORP_NAME">${Corp_Info.corpName}</font><br/>
            <c:if test="${Corp_Info.admitMain != '——' }">
            <span style="position: relative;top: 5px;background-color: #1db5ee;"><font size="1.5" color="#ffffff" id="ADMIT_MAIN1">${Corp_Info.admitMain}</font></span>
            </c:if>
            <div style="position: relative;top: 15px;width: 100%;height: 100px;border: 1px solid #d1d4d6;">
                <div style="position: relative;top: 0px;width: 50%;height: 60%;">
                    <font color="#666666" size="2.5">电话：</font>
                    <font size="2.5" id="CORP_TEL">${Corp_Info.corpTel}</font><br/>
                    <font color="#666666" size="2.5" style="position: relative;top: 7px;">网址：</font>
                    <c:if test="${Corp_Info.corpWebUrl != '暂无' }">
                    <a target="_blank" href="${Corp_Info.corpWebUrl}">
                        <font size="2.5" style="position: relative;top: 7px;">${Corp_Info.corpWebUrl}</font>
                    </a>
                    </c:if>
                    <c:if test="${Corp_Info.corpWebUrl == '暂无' }">
                    <font size="2.5" style="position: relative;top: 7px;">${Corp_Info.corpWebUrl}</font>
                    </c:if>
                </div>
                <div style="position: relative;top: -58px;left: 50%;width: 50%;height: 60%;">
                    <font color="#666666" size="2.5">邮箱：</font>
                    <font size="2.5" id="CORP_EMAIL">${Corp_Info.corpEmail}</font><br/>
                    <font color="#666666" size="2.5" style="position: relative;top: 7px;">地址：</font>
                    <font size="2.5" style="position: relative;top: 7px;" id="CORP_ADDR1">${Corp_Info.corpAddr}</font>
                </div>
                <div style="position: relative;top: -55px;left: 0px;width: 100%;height: 30%;">
                    <font color="#666666" size="2.5">简介：</font>
                    <font size="1.5" id="CORP_INTRO">${Corp_Info.corpInfo}</font><br/>
                </div>
            </div>
        </div>

        <div style="position: relative;top: -35%;left: 3%;width: 95%;height: 15%;border-top: 1px solid #d1d4d6;">
            <button id="collectCorp" class="info_top_button">
                <font size="1.5">收藏</font>
            </button>
            <button id="downloadExcel" class="info_top_button" style="margin-left: 60%;">
                <font size="1.5">导出EXCEL</font>
            </button>
            <button id="downloadPdf" class="info_top_button" style="margin-left: 24px;">
                <font size="1.5">导出PDF</font>
            </button>
            <button id="attentionCorp" class="info_top_button" style="margin-left: 25px;">
                <font size="1.5">关注</font>
            </button>
        </div>
    </div>

    <!--详细信息-->
    <div style="position: relative;top: 0px;left: 0px;width: 100%;height: auto;">
        <!--左部详细信息-->
        <div style="position: absolute;top: 10px;left: 0%;width: 75%;height: auto;">

            <!--头部图谱-->
            <div style="position: relative;top: 0px;left: 0px;width: 100%;height: 200px;">
                <!--疑似控股人-->
                <div style="position: absolute;top: 0px;left: 0%;width: 32%;height: 100%;background-color: #ffffff">
                    <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                        <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                        <font size="3" >疑似控股人</font>
                    </div>
                    <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 55%;background-image: url(/icon/suspectedMap.png);">
                    </div>
                    <div style="position: relative;left: 5%;top: 22%;width: 85%;height: 20%;">
                        <button id = "seeSuspected" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                            <font id = "seeSuspectedFont" size="2.5" style="color: #ffffff">查看疑似控股</font>
                        </button>
                    </div>
                </div>

                <!--股权结构-->
                <div style="position: absolute;top: 0px;left: 33%;width: 32%;height: 100%;background-color: #ffffff">
                    <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                        <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                        <font size="3" >股权结构</font>
                    </div>
                    <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 55%;background-image: url(/icon/stockMap.png);">
                    </div>
                    <div style="position: relative;left: 5%;top: 22%;width: 85%;height: 20%;">
                        <button id = "seeStockMap" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                            <font id = "seeStockMapFont" size="2.5" style="color: #ffffff">查看股权结构</font>
                        </button>
                    </div>
                </div>

                <!--投资族谱-->
                <div style="position: absolute;top: 0px;left: 66%;width: 34%;height: 100%;background-color: #ffffff">
                    <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                        <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                        <font size="3" >投资族谱</font>
                    </div>
                    <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 55%;background-image: url(/icon/investMap.png);">
                    </div>
                    <div style="position: relative;left: 5%;top: 22%;width: 85%;height: 20%;">
                        <button id = "seeInvestMap" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                            <font id = "seeInvestMapFont" size="2.5" style="color: #ffffff">查看投资族谱</font>
                        </button>
                    </div>
                </div>
            </div>

            <!--基本信息-->
            <div style="position: relative;top: 10px;left: 0px;width: 100%;height: 600px;background-color: #ffffff">
                <div style="position: relative;top: 10px;left: 3%;width: 95%;height: 30px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3.5" >基本信息</font>
                </div>
                <div style="position: relative;top: 35px;left: 3%;width: 95%;height: 450px;">

                    <table id="info_table" style="width: 100%;height: 115%;" border="1 solid #d1d4d6">
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">法定代表人：</font></td>
                            <td><font size="2.5" id="OPER_MAN_NAME">${Corp_Info.operManName}</font></td>
                            <td class="singular_info_td"><font size="2.5">成立日期：</font></td>
                            <td><font size="2.5" id="START_DATE">${Corp_Info.startDate}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">注册资本：</font></td>
                            <td><font size="2.5" id="REG_CAPI">${Corp_Info.regCapi}万元</font></td>
                            <td class="singular_info_td"><font size="2.5">实缴资本：</font></td>
                            <td><font size="2.5" id="PAID_CAPI">${Corp_Info.paidCapi}万元</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">经营状态：</font></td>
                            <td><font size="2.5" id="CORP_STATUS">${Corp_Info.corpStatus}</font></td>
                            <td class="singular_info_td"><font size="2.5">统一社会信用代码：</font></td>
                            <td><font size="2.5" id="UNI_SCID">${Corp_Info.uniScid}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">纳税人识别号：</font></td>
                            <td><font size="2.5" id="TAXPAY_NUM">${Corp_Info.taxpayNum}</font></td>
                            <td class="singular_info_td"><font size="2.5">注册号：</font></td>
                            <td><font size="2.5" id="REG_NO">${Corp_Info.regNo}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">组织机构代码：</font></td>
                            <td><font size="2.5" id="ORG_INST_CODE">${Corp_Info.orgInstCode}</font></td>
                            <td class="singular_info_td"><font size="2.5">公司类型：</font></td>
                            <td><font size="2.5" id="ECON_KIND">${Corp_Info.econKind}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">人员规模：</font></td>
                            <td><font size="2.5" id="STAFF_SIZE">${Corp_Info.staffSize}</font></td>
                            <td class="singular_info_td"><font size="2.5">营业期限：</font></td>
                            <td>
                                <font size="2.5" id="FARE_TERM_START">${Corp_Info.fareTermStart}</font>
                                <font size="2.5">至</font>
                                <font size="2.5" id="FARE_TERM_END">${Corp_Info.fareTermEnd}</font>
                            </td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">登记机关：</font></td>
                            <td><font size="2.5" id="BELONG_ORG">${Corp_Info.belongOrg}</font></td>
                            <td class="singular_info_td"><font size="2.5">核准日期：</font></td>
                            <td><font size="2.5" id="CHECK_DATE">${Corp_Info.checkDate}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">英文名：</font></td>
                            <td><font size="2.5" id="ENGLISH_NAME">${Corp_Info.englishName}</font></td>
                            <td class="singular_info_td"><font size="2.5">曾用名：</font></td>
                            <td><font size="2.5" id="FORMER_NAME">${Corp_Info.formerName}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">所属地区：</font></td>
                            <td><font size="2.5" id="BELONG_DIST_ORG">${Corp_Info.belongDistOrg}</font></td>
                            <td class="singular_info_td"><font size="2.5">所属行业：</font></td>
                            <td><font size="2.5" id="BELONG_TRADE">${Corp_Info.belongTrade}</font></td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">企业地址：</font></td>
                            <td colspan="3">
                                <font size="2.5" id="CORP_ADDR2">${Corp_Info.corpAddr}&nbsp;&nbsp;</font>
                                <a href="#" id="see_Map"><font size="2.5" color="#1db5ee">查看地图</font></a>
                            </td>
                        </tr>
                        <tr style="border: 1px solid #d1d4d6;">
                            <td class="singular_info_td"><font size="2.5">经营范围：</font></td>
                            <td colspan="3">
                                <font size="2.5" id="FARE_SCOPE">${Corp_Info.fareScope}</font>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!--投资分布-->
            <div style="position: relative;top: 20px;left: 0px;width: 100%;height: 580px;background-color: #ffffff">
                <div style="position: relative;top: 10px;left: 3%;width: 95%;height: 30px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3.5" >投资分布</font>
                </div>
                <div  style="position: relative;top: 10px;left: 3%;width: 95%;height: 520px;">
                    <div  id="invest" style="position: relative;left: 0px;width: 100%;height: 100%;">
                        <div  id="investDistMap" style="position: relative;left: 0px;width: 100%;height: 100%;">
                            <%--根据ID，这里填充投资分布图谱--%>
                        </div>
                        <div id="distMapDiv" style="position: relative;left: 0px;width: 100%;height: 100%;display: none;">
                            <font size="3" color="#1db5ee" style="position: absolute;top: 45%;left: 2%;">
                                *【${Corp_Info.corpName}】由于注册号暂无信息，投资分布图暂无数据！
                            </font>
                        </div>
                        <div style=" float: right;width: 40px;margin-top: -40%;height: 60%;border: 1px solid #d1d4d6;z-index: 9999">
                            <div id="full" onclick="requestFullScreen(document.getElementById('invest'))" class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/full_screen.png);display: block;width: 30px;height: 30px;"></span>
                                <span ><font size="1.5" color="#727a83">全屏</font></span>
                            </div>
                            <div id="exit" onclick="exitFull()" class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/full_screen.png);display: block;width: 30px;height: 30px;"></span>
                                <span ><font size="1.5" color="#727a83">关闭</font></span>
                            </div>
                            <div  class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/refurbish.png);display: block;width: 30px;height: 30px;"></span>
                                <span ><font size="1.5" color="#727a83">刷新</font></span>
                            </div>
                            <div  class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/change_big.png);display: block;width: 30px;height: 30px;"></span>
                                <span><font size="1.5" color="#727a83">放大</font></span>
                            </div>
                            <div  class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/change_small.png);display: block;width: 30px;height: 30px;"></span>
                                <span><font size="1.5" color="#727a83">缩小</font></span>
                            </div>
                            <div class="operation_img" style="position: relative;float: left;width: 100%;height: 20%;padding: 5px;">
                                <span style="background-image: url(/icon/img_download.png);display: block;width: 30px;height: 30px;"></span>
                                <span><font size="1.5" color="#727a83">下载</font></span>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--右部详细信息-->
        <div style="position: absolute;top: 10px;left: 76%;width: 24%;height: auto;">
            <!--下载报告-->
            <div style="position: relative;top: 0px;left: 0px;width: 100%;height: 250px;background-color: #ffffff">
                <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3" >下载报告</font>
                </div>
                <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 70%;background-image: url(/icon/download_report.png);">
                </div>
                <div style="position: relative;left: 5%;top: 12%;width: 85%;height: 15%;">
                    <button id = "downloadReport" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                        <font size="2.5" style="color: #ffffff">下载报告</font>
                    </button>
                </div>
            </div>

            <!--企业图谱-->
            <div style="position: relative;top: 10px;left: 0px;width: 100%;height: 250px;background-color: #ffffff">
                <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3" >企业图谱</font>
                </div>
                <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 65%;background-image: url(/icon/companyMap.png);">
                </div>
                <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 15%;">
                    <button id = "seeCompanyMap" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                        <font id = "seeCompanyMapFont" size="2.5" style="color: #ffffff">查看企业图谱</font>
                    </button>
                </div>
            </div>

            <!--疑似关系-->
            <div style="position: relative;top: 20px;left: 0px;width: 100%;height: 260px;background-color: #ffffff">
                <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3" >疑似关系</font>
                </div>
                <div style="position: relative;left: 10%;top: 15%;width: 78%;height: 68%;background-image: url(/icon/relationshipMap.png);">
                </div>
                <div style="position: relative;left: 5%;top: 15%;width: 85%;height: 15%;">
                    <button id = "seeRelationshipMap" style="position: relative;left: 27%;top: 20%;width: 45%;height: 80%;background-color: #1db5ee;border: none;">
                        <font id = "seeRelationshipMapFont" size="2.5" style="color: #ffffff">查看疑似关系</font>
                    </button>
                </div>
            </div>

            <!--其他人还搜过的企业-->
            <div style="position: relative;top: 30px;left: 0px;width: 100%;height: 260px;background-color: #ffffff">
                <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3" >其他人还搜过</font>
                </div>
                <div style="position: relative;top: 30px;left: 0px;width: 100%;height: 230px;">
                    <c:forEach items="${otherSearchCorpLists }" var="otherSearchCorpList" varStatus="status" begin="0" end="0">
                    <div class="relationCorpDiv" style="position: relative;top: 0px;left: 0px;width: 100%;height: 20%;border-bottom: 1px solid #e8e8e8;line-height: 0px;">
                        <a href="http://localhost:8080/select_corpByName.do?key=${otherSearchCorpList }">
                            <font class="relationCorpFont" size="2.5" style="position: relative;left: 10px;color: gray">${otherSearchCorpList }</font>
                        </a>
                    </div>
                    </c:forEach>
                    <c:forEach items="${otherSearchCorpLists }" var="otherSearchCorpList" varStatus="status" begin="1" end="4">
                    <div class="relationCorpDiv" style="position: relative;top: 0px;left: 0px;width: 100%;height: 20%;border-bottom: 1px solid #e8e8e8;line-height: 46px;">
                        <a href="http://localhost:8080/select_corpByName.do?key=${otherSearchCorpList }">
                            <font class="relationCorpFont" size="2.5" style="position: relative;left: 10px;color: gray">${otherSearchCorpList }</font>
                        </a>
                    </div>
                    </c:forEach>
                </div>
            </div>

            <!--您可能感兴趣的企业-->
            <div style="position: relative;top: 40px;left: 0px;width: 100%;height: 260px;background-color: #ffffff">
                <div style="position: relative;top: 5px;left: 3%;width: 95%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
                    <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
                    <font size="3" >您可能感兴趣的企业</font>
                </div>
                <div style="position: relative;top: 30px;left: 0px;width: 100%;height: 230px;">
                    <c:forEach items="${interestedCorpLists }" var="interestedCorpList" varStatus="status" begin="0" end="0">
                        <div class="relationCorpDiv" style="position: relative;top: 0px;left: 0px;width: 100%;height: 20%;border-bottom: 1px solid #e8e8e8;line-height: 0px;">
                            <a href="http://localhost:8080/select_corpByName.do?key=${interestedCorpList }">
                                <font class="relationCorpFont" size="2.5" style="position: relative;left: 10px;color: gray">${interestedCorpList }</font>
                            </a>
                        </div>
                    </c:forEach>
                    <c:forEach items="${interestedCorpLists }" var="interestedCorpList" varStatus="status" begin="1" end="4">
                        <div class="relationCorpDiv" style="position: relative;top: 0px;left: 0px;width: 100%;height: 20%;border-bottom: 1px solid #e8e8e8;line-height: 45px;">
                            <a href="http://localhost:8080/select_corpByName.do?key=${interestedCorpList }">
                                <font class="relationCorpFont" size="2.5" style="position: relative;left: 10px;color: gray">${interestedCorpList }</font>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<%--企业点评区--%>
<div style="position: absolute;top: 1820px;left: 5%;width: 90%;height: 500px;background-color: #ffffff">
    <div style="position: relative;top: 5px;left: 2%;width: 97%;height: 25px;border-bottom: 2px solid #d1d4d6;float: left;">
        <span style="background-color: #1db5ee;">&nbsp;&nbsp;</span>
        <font size="3" >企业点评</font>
    </div>
    <div class="innerbox" style="position: relative;top: 10px;left: 2%;width: 73%;height: 92%;float: left;overflow-y: auto;overflow-x: hidden">
        <table style="margin-left: 10px;margin-top: 10px">
            <c:if test="${fn:length(tCorpEvaluates) < 1}">
                <tr style="height: 200px">
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <font size="3" color="#1db5ee">*【${Corp_Info.corpName}】当前还没有点评，赶快评论吧！</font>
                    </td>
                </tr>
            </c:if>
            <c:forEach items="${tCorpEvaluates }" var="tCorpEvaluate" varStatus="status" begin="0" end="20">
            <tr>
                <td style="width: 5%">
                    <img src="icon/userPhoto.png" style="width:40px; height:40px; border-radius:50%;-webkit-border-radius:50%;-moz-border-radius:50%;"/>
                </td>
                <td colspan="2" style="width: 75%">
                    &nbsp;&nbsp;<font size="2.5" color="#1db5ee">${tCorpEvaluate.user.name }</font>&nbsp;&nbsp;/&nbsp;&nbsp;
                    <font size="2" color="#d1d4d6">${tCorpEvaluate.evaluateDate }</font>
                </td>
                <td style="width: 12%"></td>
                <td style="width: 8%">
                    <font id="good_num_${status.index}" size="1.5" color="gray">${tCorpEvaluate.goodNum }</font>&nbsp;
                    <img id="click_${status.index}" class="click_good" src="icon/good.png" width="20" height="20">
                </td>
            </tr>
            <tr>
                <td style="width: 5%"></td>
                <td colspan="4" style="width: 94%;">
                    <font size="3">${tCorpEvaluate.evaluateInfo }</font>
                </td>
            </tr>
            <tr>
                <td style="width: 5%"></td>
                <td colspan="3" style="width: 90%">
                    <c:if test="${tCorpEvaluate.label1 == 1 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">信誉好</font>
                    </c:if>
                    <c:if test="${tCorpEvaluate.label1 == 2 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">信誉差</font>
                    </c:if>
                    <c:if test="${tCorpEvaluate.label2 == 1 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">产品质量好</font>
                    </c:if>
                    <c:if test="${tCorpEvaluate.label2 == 2 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">产品质量差</font>
                    </c:if>
                    <c:if test="${tCorpEvaluate.label3 == 1 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">实力强</font>
                    </c:if>
                    <c:if test="${tCorpEvaluate.label3 == 2 }">
                        <img src="icon/label.png" width="20" height="20" style="margin-top: 5px"/>
                        <font size="2" color="gray" style="margin-left: -5px;">实力差</font>
                    </c:if>
                </td>
                <td style="width: 5%">
                    <font size="2" color="gray">回复</font>
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <hr style="height: 1px;background-color: #d1d4d6"/>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
    <div style="position: relative;top: 10px;left: 3%;width: 24%;height: 92%;float: left">
        <textarea id="evaluate_info" style="position: relative;top: 0px;left: 0px;width: 96%;height: 60%;border: 1px solid #d1d4d6;font-size:20px;padding: 10px;"
                  onfocus="document.getElementById('user_evaluate').style.display='none'" onblur="if(value=='')document.getElementById('user_evaluate').style.display='block'"></textarea>
        <div id="user_evaluate" class="note" style="position: relative;top: -170px;left: 5%;width: 90%">
            <font size="2" color="#777">*说说你对【${Corp_Info.corpName}】的看法。</font><br/>
        </div>
        <div style="position: absolute;top: 290px;left: 0px;">
            <font size="3" color="gray">选择标签：</font>
            <font id="label1_good" size="3" color="#777" style="background-color: #d1d4d6;">信誉好</font>
            <font id="label2_good" size="3" color="#777" style="background-color: #d1d4d6;margin-left: 20px;">产品质量好</font><br/>
            <font id="label3_good" size="3" color="#777" style="background-color: #d1d4d6;margin-top: 5px">实力强</font>
            <font id="label1_bad" size="3" color="#777" style="background-color: #d1d4d6;margin-left: 10px;">信誉差</font>
            <font id="label2_bad" size="3" color="#777" style="background-color: #d1d4d6;margin-left: 10px;">产品质量差</font>
            <font id="label3_bad" size="3" color="#777" style="background-color: #d1d4d6;margin-left: 10px;">实力差</font>
        </div>
        <button id="user_submit" style="position: absolute;top: 370px;left: 180px;width: 35%;height: 35px;border: none;background-color: #1db5ee">
            <font size="3.5" color="white">提交</font>
        </button>
    </div>
</div>

<%--图谱模态框--%>
<div class = "bg-model1" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none;">
    <div class = "content innerbox" style="position: absolute;left: 3%;top: 5%;border-radius: 15px;width: 94%;height:600px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b id = "operationName"></b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "modelClose" src="icon/close.png" width="15px" height="15px" style="position: relative;top: -15px;left: 87%;"/>
        </div>

        <div style="position: relative;top: 60px;left: 3%;width: 96%;height: 90%;">
            <div id = "sundryMap" style="position: relative;left: 0px;width: 1200px;height: 800px;">
                <div  style="position: relative;left: 0px;width: 1200px;height: 750px;">
                    <div id = "sundryMaps">
                        <div  id="sundryMap0" style="position: absolute;left: 0px;width: 100%;top: 10px;height: 98%;display: none;">
                            <%--根据ID，这里填充疑似控股--%>
                        </div>
                        <div id = "sundryMap0Info" style="position: absolute;width:95%;height: 60px;margin-left: 50px;margin-top: 20px;z-index:99;display: none">
                            <font id="Suspected_Name" size="3" style="position: relative;top: 5px;"></font>
                            <img src="icon/point_to_right.png" width="70" height="12" style="margin-left: 5px;position: relative;top: 5px;"/>
                            <font id="Suspected_Percent" size="1.5" color="#1db5ee" style="position: relative;top: -5px;left: -65px;"></font>
                            <font id="Suspected_Corp" size="3" style="position: relative;left: -30px;top: 5px;"></font><br/>
                            <span style="background-color: #b87070;display: block;width: 20px;height: 20px;margin-top: 15px"></span>
                            <font style="position: relative;top: -20px;left: 25px;" size="2">大股东</font>
                            <span style="background-color: #73bc6c;display: block;width: 20px;height: 20px;margin-top: 15px"></span>
                            <font style="position: relative;top: -20px;left: 25px;" size="2">自然人股东</font>
                            <span style="background-color: #dd4649;display: block;width: 20px;height: 20px;margin-top: 15px"></span>
                            <font style="position: relative;top: -20px;left: 25px;" size="2">企业股东</font>
                        </div>
                        <div  id="sundryMap1" style="position: absolute;left: 0px;width: 100%;top: 10px;height: 98%;display: none;">
                            <%--根据ID，这里填充股权结构--%>
                        </div>
                        <div  id="sundryMap2" style="position: absolute;left: 0px;width: 100%;top: 10px;height: 98%;display: none;">
                            <%--根据ID，这里填充投资族谱--%>
                        </div>
                        <div id = "sundryMap2Info" style="position: absolute;width:95%;height: 40px;margin-left: 50px;margin-top: 20px;z-index:99;display: none">
                            <font size="3" color="#555e68">对外投资、股东层次&nbsp;</font>
                            <select id = "distSelect" style="width: 60px;height: 20px;">
                                <option selected="selected">一层</option>
                                <option>二层</option>
                                <option>三层</option>
                                <option>四层</option>
                            </select>
                        </div>
                        <div  id="sundryMap3" style="position: absolute;left: 0px;width: 100%;top: 10px;height: 98%;display: none;">
                            <%--根据ID，这里填充企业图谱--%>
                            <font id="sundryMap3Message" size="3" style="position: absolute;top: 48%;left: 42%;display: none;">提示：该企业暂无图谱!</font>
                        </div>
                        <div  id="sundryMap4" style="position: absolute;left: 0px;width: 100%;top: 10px;height: 98%;display: none;">
                            <%--根据ID，这里填充疑似关系--%>
                        </div>
                        <div id = "sundryMap4Info" style="position: absolute;width:95%;height: 50px;margin-left: 100px;margin-top: 10px;z-index:99;display: none">
                            <div style="width: 100px; height: 20px;margin-left: 300px;margin-top: 5px">
                                <a href="#" class="btn btn-circle disabled" style=" width: 10px;height: 10px;padding: 5px;font-size: 18px;border-radius: 15px;background-color: #4F94CD"></a>
                                <span style=" height: 30px">当前节点</span>
                            </div>
                            <div style="width: 80px; height: 20px;margin-left: 400px;margin-top: -20px">
                                <a href="#" class="btn btn-circle disabled" style=" width: 10px;height: 10px;padding: 5px;font-size: 18px;border-radius: 15px;background-color: #388E8E"></a>
                                <span style=" height: 30px">公司</span>
                            </div>
                            <div style="width: 80px; height: 20px;margin-left: 470px;margin-top: -20px">
                                <a href="#" class="btn btn-circle disabled" style=" width: 10px;height: 10px;padding: 5px;font-size: 18px;border-radius: 15px;background-color: red"></a>
                                <span style=" height: 30px">人员</span>
                            </div>
                            <div style="width: 80px; height: 20px;margin-left: 530px;margin-top: -20px">
                                <a href="#" style="color: #BF3EFF;"><span class="glyphicon glyphicon-arrow-right"></span></a>
                                <span style=" height: 30px">任职</span>
                            </div>
                            <div style="width: 80px; height: 20px;margin-left: 600px;margin-top: -20px">
                                <a href="#" style="color: #f41122;"><span class="glyphicon glyphicon-arrow-right"></span></a>
                                <span style=" height: 30px">投资</span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--地图模态框--%>
<div class = "bg-model2" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 3%;top: 5%;border-radius: 15px;width: 94%;height:600px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>${Corp_Info.corpName}</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "mapClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>
        <div id="mapTip" style="position: relative;top: 25px;left: 55%;width: 52%;height: 25px;">
            <span id="mapResult"></span>
        </div>
        <div id="mapContainer" style="position: relative;top: 52px;left: 1%;width: 98%;height: 86%;">
        </div>
    </div>
</div>

<%--收藏关注模态框--%>
<div class = "bg-model3" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 20%;top: 15%;border-radius: 15px;width: 60%;height:500px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>收藏关注</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "personClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>

        <div style="position: relative;top: 60px;left: 0px;width: 100%;height: 440px;">
            <div style="position: relative;top: -30px;left: 2%;background-color: #e8e8e8;width: 47%;height: 430px;float: left;overflow: hidden">
                <div class="tipDiv" style="position: absolute;right: -35px;top: -35px;width: 70px;height: 70px;background-color: #e8e8e8;z-index: 99">
                    <div style="position: absolute;bottom: 0;">
                        <span style="width: 70px;background-color: #1db5ee;display: block">
                            <font size="2.5" style="color: #ffffff">&nbsp;&nbsp;&nbsp;&nbsp;收藏</font>
                        </span>
                    </div>
                </div>

                <div class="userCollectDiv innerbox" style="position: absolute;left: 0px;top: 0px;width: 100%;height: 420px;overflow-y: auto">
                    <ul class="userCollectUl" style="margin-top: 10px"></ul>
                    <font id="collectFont" size="3" style="display: none;color: #1db5ee;position: absolute;left: 36%;top: 48%;">暂无收藏企业！</font>
                </div>

            </div>
            <div style="position: relative;top: -30px;left: 4%;background-color: #e8e8e8;width: 47%;height: 430px;float: left;overflow: hidden">
                <div class="tipDiv" style="position: absolute;right: -35px;top: -35px;width: 70px;height: 70px;background-color: #e8e8e8;z-index: 99">
                    <div style="position: absolute;bottom: 0;">
                        <span style="width: 70px;background-color: #1db5ee;display: block">
                            <font size="2.5" style="color: #ffffff">&nbsp;&nbsp;&nbsp;&nbsp;关注</font>
                        </span>
                    </div>
                </div>

                <div class="userAttentionDiv innerbox" style="position: absolute;left: 0px;top: 0px;width: 100%;height: 420px;overflow-y: auto">
                    <ul class="userAttentionUl" style="margin-top: 10px"></ul>
                    <font id="attentionFont" size="3" style="display: none;color: #1db5ee;position: absolute;left: 36%;top: 48%;">暂无关注企业！</font>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 消息提示 -->
<div id="showMessage2" style="position: fixed;top: 40%;left: 40%;width: 400px;height: 60px;z-index: 99;text-align: center;line-height: 60px;background-color: #2b2b2b;display: none;">
    <font id="showMessageFont2" size="3" style="color: #1db5ee"></font>
</div>


<!-- 网站侧边栏 -->
<div class="side">
    <ul>
        <li><a href="">
            <div class="sidebox"><img src="icon/side_icon02.png">15755332393</div>
        </a></li>
        <li><a href="">
            <div class="sidebox"><img src="icon/side_icon01.png">2419304297</div>
        </a></li>
        <li><a href="javascript:void(0);">
            <div class="sidebox"><img src="icon/side_icon03.png">15755332393</div>
        </a></li>
    </ul>
</div>
<div class="side2">
    <ul>
        <li><a href=""><img src="icon/r_icon1.png" alt=""></a>
            <div class="weixin"><em></em><img src="icon/ewm.jpg" alt=""></div>
        </li>
        <li><a href="javascript:goTop();" class="sidetop"><img src="icon/r_icon2.png"></a></li>
    </ul>
</div>


<!-- 网站底部 -->
<div id="fd" class="index-fd pr" style="position: relative;top: 2400px;">
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
<%--搜索栏回车键事件--%>
<script type="text/javascript">
    function EnterPress(e){
        var e = e || window.event;
        if(e.keyCode == 13){
            var corp_name = document.getElementById("search_input3").value;
            window.location.href='http://localhost:8080/select_corpByName.do?key='+corp_name;
        }
    }
</script>
<%--投资分布--%>
<script type="text/javascript">
    var temp = "${Corp_Info.regNo}";
    if( temp == "——"){
        $("#investDistMap").css("display","none");
        $("#distMapDiv").css("display","block");
    }else{
        $("#investDistMap").css("display","block");
        $("#distMapDiv").css("display","none");
        var arrbelongDistOrg=[];      //省份
        var arrvalue=[];              //每个省份数量
        var arrupdatebelongDistOrg=[];//存放修改后的省份
        var data=[];                  //存放数据集
        var myChart = echarts.init(document.getElementById('investDistMap'));

        function arrTest1(){
            $.ajax({
                url: 'getStockAndDistByRegNo.do?corpRegNo=' + "${Corp_Info.regNo}",
                type:'get',
                async:false,
                dataType:"json",
                success:function(result){
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            console.log(result[i].belongDistOrg);
                            arrbelongDistOrg.push(result[i].belongDistOrg);
                            arrvalue.push(result[i].value);
                        }
                    }
                }
            })
            if(arrbelongDistOrg.length==0){
                var name1 = '${Corp_Info.belongDistOrg}';
                var name = name1;
                if (name=="内蒙古自治区"){
                    name="内蒙古";
                }else if (name=="广西壮族自治区"){
                    name="广西";
                }else if (name=="西藏自治区"){
                    name="西藏";
                }else if (name=="宁夏回族自治区"){
                    name="宁夏";
                }else if (name=="新疆维吾尔自治区"){
                    name="新疆";
                }else if (name=="香港特别行政区"){
                    name="香港";
                }else if (name=="澳门特别行政区"){
                    name="澳门";
                }else{
                    name=name.substr(0,name.length-1);
                }
                name1=name;
                data.push({
                    name: name1,
                    value: 1,
                });
            }else {
                for (var i = 0; i < arrbelongDistOrg.length; i++) {
                    var name = arrbelongDistOrg[i];
                    if (name == "内蒙古自治区") {
                        name = "内蒙古";
                    } else if (name == "广西壮族自治区") {
                        name = "广西";
                    } else if (name == "西藏自治区") {
                        name = "西藏";
                    } else if (name == "宁夏回族自治区") {
                        name = "宁夏";
                    } else if (name == "新疆维吾尔自治区") {
                        name = "新疆";
                    } else if (name == "香港特别行政区") {
                        name = "香港";
                    } else if (name == "澳门特别行政区") {
                        name = "澳门";
                    } else {
                        name = name.substr(0, name.length - 1);
                    }
                    arrupdatebelongDistOrg[i] = name;
                }

                for (var k = 0; k < arrbelongDistOrg.length; k++) {
                    data.push({
                        name: arrupdatebelongDistOrg[k],
                        value: arrvalue[k],
                    });
                }
            }
            return arrbelongDistOrg,arrvalue.arrupdatebelongDistOrg,data
        }
        arrTest1();

        option = {
            visualMap: {
                min: 0,
                max: 10,
                left: 'left',
                top: 'bottom',
                text: ['高', '低'],
                calculable: true,
                //orient: 'horizontal',//水平放置
                realtime: false,
                inRange: {
                    color: ['#e0ffff', '#006edd'],
                    symbolSize: [30, 100]
                }
            },
            tooltip: {
                padding: 0,
                enterable: true,
                transitionDuration: 1,
                textStyle: {
                    color: '#000',
                    decoration: 'none',
                },
                // position: function (point, params, dom, rect, size) {
                //   return [point[0], point[1]];
                // },
                itemStyle: {
                    normal: {
                        label: {
                            show: false
                        }
                    },
                    emphasis: {
                        label: {
                            show: true
                        }
                    }
                },
            },
            series: [{
                name: '企业对外投资分布区域',
                type: 'map',
                mapType: 'china',
                roam:true,
                label: {
                    normal: {//通常情况下normal和emphasis是对应的,分别表示  “普通状态” 和 “选中状态” 下的样式.
                        show: true//是否显示省会名字.
                    },
                    emphasis: {
                        show: true
                    }
                },
                data: data
            },
            ]}
        myChart.setOption(option);
    }

</script>
</body>
</html>
