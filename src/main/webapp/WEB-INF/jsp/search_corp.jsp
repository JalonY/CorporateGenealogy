<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen" />
	<title>千企查-企业信息查询_工商信息查询</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta content="telephone=no" name="format-detection" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="renderer" content="webkit">
	<meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
	<meta name="full-screen" content="yes">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="css/class.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/size.css"/>
    <link rel="stylesheet" href="css/WTMap.css"/>
    <link rel="stylesheet" href="css/calendar.css"/>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.bootcss.com/vue/2.5.13/vue.min.js"></script>
    <script src="https://cdn.bootcss.com/vue-resource/1.3.4/vue-resource.js"></script>
    <script type="text/javascript">
        function EnterPress(e){
            var e = e || window.event;
            if(e.keyCode == 13){
                var search_input = document.getElementById("search_input1").value;
                var searchType = document.getElementById("searchType").innerText;
                if(searchType == "企业名"){
                    window.location.href = 'http://localhost:8080/select_corpByName.do?key=' + search_input;
                }else if(searchType == "法人/股东"){
                    window.location.href = 'http://localhost:8080/select_corpByStock.do?key=' + search_input;
                }else if(searchType == "高管"){
                    window.location.href = 'http://localhost:8080/select_corpByManager.do?key=' + search_input;
                }else if(searchType == "所属行业"){
                    window.location.href = 'http://localhost:8080/select_corpByIndu.do?key=' + search_input;
                }
            }
        }
    </script>
    <script language="javascript" src="js/PCASClass.js"></script>
</head>
<body class="innerbox">

<!--网站头部电脑端-->
<div id="hd">
    <div class="wp">
        <div class="logo"><a href="search_corp.do"><img src="icon/logo_64.png" alt=""></a></div>
        <div id="nav">
            <ul>
                <li><a href="search_corp.do" style="color:#1db5ee; border-bottom:3px solid #1db5ee;">查企业</a></li>
                <li><a href="search_boss.do" >查老板</a></li>
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
                <img src="img/photo2.jpg">
            </li>
        </ul>
    </div>
    <div style="position: relative;top: -400px;width: 100%;height: 100px;text-align: center">
        <font color="#fff" size="6">查企业，就用千企查！</font><br/>
        <font color=" #fff" size="3.5">——&nbsp;&nbsp;变信息为价值&nbsp;&nbsp;——</font>
    </div>

    <div class="search-nav hidden-xs" style="position: relative;top: -380px;left: 450px;height: 30px">
        <ul class="V3_index_search_item">
            <li class="search-type active" data-index="0">企业名</li>
            <li></li>
            <li class="search-type" data-index="2">法人/股东</li>
            <li></li>
            <li class="search-type" data-index="4">高管</li>
            <li></li>
            <li class="search-type" data-index="6">所属行业</li>
        </ul>
    </div>

    <div id="search_main" style="position: relative;top: -360px;left: -200px;width: 100%;height: 50px;text-align: center">
        <input id="search_input1" type="text" name="search1" placeholder="请输入企业名称。如“阿里巴巴”或“alibaba”"
               style="height: 50px;width: 720px;border: none;font-size: 18px;" onkeypress="EnterPress(event)" onkeydown="EnterPress()"
               v-model="searchText" v-on:keyup="showName(searchText)"/>
        <img id="voice" src="icon/voice1.png" width="35" height="35" style="position: absolute;left: 1145px;top: 7px;"/>
        <button id="search_button1" type="button" style="position: relative;left: -4px;top: 1px;height: 50px;width: 100px;border: none;background-color: #1db5ee">
            <font size="4" color="white" style="align-content: center">搜索</font>
        </button>
        <font id="searchType" style="display: none">企业名</font>
        <div id="parentRelationSearch" v-for="(company, cIndex) in companyList" style="position: relative;top: 0px;left: 474px;height: auto;width: 719px;background-color: #ffffff;z-index: 99">
            <div class="relationSearch" v-on:click="putVal(company.name)" v-on:mouseenter="mouseEnter($event)" v-on:mouseleave="mouseLeave($event)" style="position: relative;top: 0px;left: 0px;width: 100%;height: 35px;border-bottom: 1px solid #e8e8e8;line-height: 35px;">
                <font size="2" style="position: absolute;left: 5px">{{company.name}}</font>
                <font size="1.5" style="position: absolute;left: 92%;">{{company.score}}</font>
            </div>
        </div>
    </div>


    <div style="position: relative;top: -330px;left: 250px;width: 100%;height: 20px;">
        <ul class="hot_search_ul">
            <li><img src="icon/function.png"></li>
            <li style="margin-left: -15px;margin-top: 3px"><font size="3">其它查询：</font></li>
            <li class="hot_search_corp"><font id="topSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">高级查询</font></li>
            <li class="hot_search_corp"><font id="taxSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">税号查询</font></li>
            <li class="hot_search_corp"><font id="jobSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">招聘查询</font></li>
            <li class="hot_search_corp"><font id="batSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">批量查询</font></li>
            <li class="hot_search_corp"><font id="indSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">行业查询</font></li>
            <li class="hot_search_corp"><a target="_blank" href="search_map.do"><font id="mapSearch" color="#ffffff" size="3" style="position: relative;left: 10px;top: 1px;">地图查询</font></a></li>
        </ul>
    </div>
</div>
<div class="c"></div>


<!--网站各企业分类-->
<div class="tab-search" style="position: relative;top: -250px;">
    <div class="b-c-gray" style="width: 100%;">
        <div class="company_container mainv2_tab3">
            <div class="title">
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span style="background-color: #1db5ee"  id="classes1" class="not_change">按行业查询</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span id="classes2">按区域查询</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span id="classes3">按日期查询</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span id="classes4">最新注册企业</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span id="classes5">最新上市企业</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common">
                    <span id="classes6">最新融资企业</span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common" style="visibility: hidden">
                    <span></span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common" style="visibility: hidden">
                    <span></span><i class="triangle"></i>
                </div>
                <div class="mainv2_tab3_title_common js-tab-title-common" style="visibility: hidden">
                    <span></span><i class="triangle"></i>
                </div>
            </div>
            <div class="industry_container js-industry-container hidden search-industry innerbox" >
                <div class="ind_row1" id="corp_class1" >
                    <table>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>农、林、牧、渔业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">渔业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">农、林、牧、渔服务业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">农业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">林业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">畜牧业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=制造业" href-new-event event-name="分类搜索"><b>制造业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">专用设备制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">汽车制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">金属制品业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">通用设备制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">计算机、通信和其他电子设备制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">铁路、船舶、航空航天和其他运输设备制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">电气机械和器材制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">金属制品、机械和设备修理业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">废弃资源综合利用业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">其他制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">仪器仪表制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">造纸和纸制品业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">印刷和记录媒介复制业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">文教、工美、体育和娱乐用品制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">石油加工、炼焦和核燃料加工业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">化学原料和化学制品制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">医药制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">化学纤维制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">橡胶和塑料制品业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">非金属矿物制品业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">有色金属冶炼和压延加工业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">黑色金属冶炼和压延加工业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">皮革、毛皮、羽毛及其制品和制鞋业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">纺织业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">纺织服装、服饰业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">酒、饮料和精制茶制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">烟草制品业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">农副食品加工业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">食品制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">家具制造业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">木材加工和木、竹、藤、棕、草制品业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=科学" href-new-event event-name="分类搜索"><b>科学研究和技术服务业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=科学" href-new-event event-name="分类搜索">研究和试验发展</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=技术" href-new-event event-name="分类搜索">专业技术服务业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=科学" href-new-event event-name="分类搜索">科技推广和应用服务业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=建筑业" href-new-event event-name="分类搜索"><b>建筑业</b></a>
                            </td>
                            <td style="width: 70%;"><a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=建筑业" href-new-event event-name="分类搜索">建筑安装业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=建筑业" href-new-event event-name="分类搜索">土木工程建筑业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=建筑业" href-new-event event-name="分类搜索">房屋建筑业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=建筑业" href-new-event event-name="分类搜索">建筑装饰和其他建筑业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>电力、热力、燃气及水生产和供应业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">燃气生产和供应业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">电力、热力生产和供应业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">水的生产和供应业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=批发和零售业" href-new-event event-name="分类搜索"><b>批发和零售业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=批发" href-new-event event-name="分类搜索">批发业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=零售业" href-new-event event-name="分类搜索">零售业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>交通运输、仓储和邮政业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">仓储业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">装卸搬运和运输代理业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">管道运输业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">航空运输业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">水上运输业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">邮政业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">铁路运输业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">道路运输业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>采矿业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">开采辅助活动</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">其他采矿业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">黑色金属矿采选业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">有色金属矿采选业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">煤炭开采和洗选业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">石油和天然气开采业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">非金属矿采选业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=服务" href-new-event event-name="分类搜索"><b>租赁和商务服务业</b></a>
                            </td>
                            <td style="width: 70%;"><a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=租赁" href-new-event event-name="分类搜索">租赁业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=服务" href-new-event event-name="分类搜索">商务服务业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=水利" href-new-event event-name="分类搜索"><b>水利、环境和公共设施管理业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=公共设施管理" href-new-event event-name="分类搜索">公共设施管理业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=环境" href-new-event event-name="分类搜索">生态保护和环境治理业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=水利" href-new-event event-name="分类搜索">水利管理业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>居民服务、修理和其他服务业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">居民服务业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">机动车、电子产品和日用产品修理业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">其他服务业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=住宿和餐饮业" href-new-event event-name="分类搜索"><b>住宿和餐饮业</b></a></td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=餐饮业" href-new-event event-name="分类搜索">餐饮业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=住宿" href-new-event event-name="分类搜索">住宿业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=信息传输" href-new-event event-name="分类搜索"><b>信息传输、软件和信息技术服务业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=信息传输" href-new-event event-name="分类搜索">互联网和相关服务</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=软件" href-new-event event-name="分类搜索">软件和信息技术服务业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">电信、广播电视和卫星传输服务</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=市场服务" href-new-event event-name="分类搜索"><b>金融业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=市场服务" href-new-event event-name="分类搜索">资本市场服务</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">货币金融服务</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">其他金融业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">保险业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=房地产业" href-new-event event-name="分类搜索"><b>房地产业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=房地产业" href-new-event event-name="分类搜索">房地产业</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>国际组织</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">国际组织</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>卫生和社会工作</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">卫生</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">社会工作</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="#" href-new-event event-name="分类搜索"><b>教育</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">教育</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=社会团体" href-new-event event-name="分类搜索"><b>公共管理、社会保障和社会组织</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">基层群众自治组织</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=社会团体" href-new-event event-name="分类搜索">群众团体、社会团体和其他成员组织</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">社会保障</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">人民政协、民主党派</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">国家机构</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">中国共产党机关</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <a class="industry_name a3 search-total" href="http://localhost:8080/select_corpByIndu.do?key=文化艺术" href-new-event event-name="分类搜索"><b>文化、体育和娱乐业</b></a>
                            </td>
                            <td style="width: 70%;">
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">体育</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">娱乐业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">广播、电视、电影和影视录音制作业</a>
                                <a class="c3 search-detail" href="http://localhost:8080/select_corpByIndu.do?key=文化艺术" href-new-event event-name="分类搜索">文化艺术业</a>
                                <a class="c3 search-detail" href="#" href-new-event event-name="分类搜索">新闻和出版业</a></td>
                        </tr>
                    </table>
                </div>
                <div class="ind_row1" id="corp_class2" style="display: none">
                    <input id="full_address" type="text" value="点击地图选择区域！"  readonly="readonly" style="width: 250px;height: 30px;font-size: 18px"/>
                    <button id = "searchByAddress" type="button" style="position: relative;top: 0px;left: -4px;border: none;background-color: #1db5ee;height: 30px;width: 50px">
                        <font color="white" size="2.5">搜索</font>
                    </button>
                    <input type="image" src="img/China.png" wtmap="{c:&#39;full_address&#39;,cb:true}" style="width: 770px;height: 500px;border: none;outline:medium;margin-left: 50px;"/>
                </div>
                <div class="ind_row1" id="corp_class3" style="display: none">
                    <input id="custom-date-input" type="text" value="选择日期区间！" readonly="readonly" style="width: 250px;height: 30px;font-size: 18px"/>
                    <button id = "searchByDate" type="button" style="position: relative;top: 0px;left: -4px;border: none;background-color: #1db5ee;height: 30px;width: 50px">
                        <font color="white" size="2.5">搜索</font>
                    </button>
                    <button id="date_sure" type="button" style="position: relative;top: 20px;left: 210px;border: none;outline:medium;background-color: #1db5ee;height: 20px;width: 40px">
                        <font color="white" size="1.5">确定</font>
                    </button>
                    <select id="custom-date-select" class='custom-date' name='select' style="display: none;">
                        <option value='7'>7 Days</option>
                        <option value='30'>30 Days</option>
                        <option selected='selected' value='90'>90 Days</option>
                        <option value='180'>180 Days</option>
                        <option value='365'>365 Days</option>
                        <option value='custom'>Custom</option>
                    </select>
                </div>
                <div class="ind_row1" id="corp_class4" style="display: none">
                    <div style="margin: 0 auto;overflow: hidden;">
                        <div id='tag-cloud' style="width:800px;height:480px;margin: -50px auto;"></div>
                    </div>
                </div>
                <div class="ind_row1" id="corp_class5" style="display: none;">
                    <div class="scrollbox1">
                        <ul class="scroll_list">
                            <c:forEach items="${allNewMarCorps }" var="allNewMarCorp" varStatus="status">
                            <li>
                                <a href=""><img width="48" height="48" alt="logo" class="pic"  src="img/corp_icon.png" /></a>
                                <span class="text">
                                    <c:if test="${fn:length(allNewMarCorp.fareScope) > 60}">
                                        ${fn:substring(allNewMarCorp.fareScope, 0, 60)}...... <br/>
                                    </c:if>
                                    <c:if test="${fn:length(allNewMarCorp.fareScope) <= 60}">
                                        ${allNewMarCorp.fareScope}<br/>
                                    </c:if>
                                    <a href="http://localhost:8080/see_details.do?corp_id=${allNewMarCorp.id}">查看详情&raquo;</a>
                                </span>
                                <font style="padding:5px 0px 10px 140px;" size="2.5">${allNewMarCorp.corpName}</font>
                                <font style="margin-left: 30px;"><span>法定代表人：</span><a href="">${allNewMarCorp.operManName}</a></font>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <script type="text/javascript">
                        $(function(){
                            setInterval(function(){
                                $('.scrollbox1 ul li:last').hide().insertBefore($(".scrollbox1 ul li:first")).slideDown(1000);
                            }, 4000);
                        });
                    </script>
                </div>
                <div class="ind_row1" id="corp_class6" style="display: none">
                    <div class="scrollbox2">
                        <ul class="scroll_list">
                            <c:forEach items="${allNewFinCorps }" var="allNewFinCorp" varStatus="status">
                            <li>
                                <a href=""><img width="48" height="48" alt="logo" class="pic"  src="img/corp_icon.png" /></a>
                                <span class="text">
                                    <c:if test="${fn:length(allNewFinCorp.fareScope) > 60}">
                                        ${fn:substring(allNewFinCorp.fareScope, 0, 60)}...... <br/>
                                    </c:if>
                                    <c:if test="${fn:length(allNewFinCorp.fareScope) <= 60}">
                                        ${allNewFinCorp.fareScope}<br/>
                                    </c:if>
                                    <a href="http://localhost:8080/see_details.do?corp_id=${allNewFinCorp.id}">查看详情&raquo;</a>
                                </span>
                                <font style="padding:5px 0px 10px 140px;" size="2.5">${allNewFinCorp.corpName}</font>
                                <font style="margin-left: 30px;"><span>法定代表人：</span><a href="">${allNewFinCorp.operManName}</a></font>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <script type="text/javascript">
                        $(function(){
                            setInterval(function(){
                                $('.scrollbox2 ul li:last').hide().insertBefore($(".scrollbox2 ul li:first")).slideDown(1000);
                            }, 4000);
                        });
                    </script>
                </div>
            </div>

        </div>
    </div>
</div>


<!--网站介绍-->
<div style="position: relative;top: -200px;left: 5%;width: 90%;height: 150px;">
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


<%--高级查询模态框--%>
<div class = "topSearchDiv" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 15%;top: 5%;border-radius: 15px;width: 70%;height:600px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>高级查询</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "topClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>

        <font size="2" color="#a8a8af" style="position: relative;top: 40px;left: 5%">*根据您提供的详细条件，帮助您更精确地查找企业。在下列条件中请您至少提供一种信息。</font>

        <div style="position: relative;top: 60px;left: 5%;width: 90%;height: 480px;">
            <table style="width: 100%;height: auto">
                <tr style="height: 45px">
                    <td><font size="3">企业名称：</font></td>
                    <td colspan="4"><input id="top_inputName" type="text" placeholder="请输入企业关键字"
                                           style="margin-left: -100px;height: 45px;width: 115%;border: 1px solid #a8a8af;font-size: 18px;"/></td>
                </tr>
                <tr style="height: 22px">
                    <td colspan="5"></td>
                </tr>
                <tr style="height: 45px">
                    <td><font size="3">企业位置：</font></td>
                    <td><select id = "top_select1" name="P1" style="margin-left: -100px;width: 150px;height: 45px;border: 1px solid #a8a8af;font-size: 18px">
                    </select>
                    </td>
                    <td><select id = "top_select2" name="C1" style="margin-left: -40px;width: 150px;height: 45px;border: 1px solid #a8a8af;font-size: 18px">
                    </select>
                    </td>
                    <td colspan="2"><input id="top_inputAddress" type="text" placeholder="请输入地址详细信息"
                                           style="margin-left: -140px;width: 170%;height: 45px;border: 1px solid #a8a8af;font-size: 18px;"/></td>
                </tr>
                <script language="javascript" defer>
                    new PCAS("P1","C1");
                </script>
                <tr style="height: 22px">
                    <td colspan="5"></td>
                </tr>
                <tr style="height: 45px">
                    <td><font size="3">注册资金：</font></td>
                    <td><input id="top_CapiStart" type="text" placeholder="0" style="margin-left: -100px;height: 45px;width: 120px;border: 1px solid #a8a8af;font-size: 15px;"/>&nbsp;&nbsp;&nbsp;&nbsp;<font size="3" color="#a8a8af">至</font></td>
                    <td><input id="top_CapiEnd" type="text" placeholder="0" style="margin-left: -40px;height: 45px;width: 120px;border: 1px solid #a8a8af;font-size: 15px;"/>&nbsp;&nbsp;&nbsp;&nbsp;<font size="3" color="#a8a8af">万元</font></td>
                    <td colspan="2"></td>
                </tr>
                <tr style="height: 22px">
                    <td colspan="5"></td>
                </tr>
                <tr style="height: 45px">
                    <td><font size="3">法人姓名：</font></td>
                    <td colspan="4"><input id="top_ManName" type="text" placeholder="请输入企业法人姓名，如“张三”"
                                           style="margin-left: -100px;height: 45px;width: 115%;border: 1px solid #a8a8af;font-size: 18px;"/></td>
                </tr>
                <tr style="height: 22px">
                    <td colspan="5"></td>
                </tr>
                <tr style="height: 45px">
                    <td><font size="3">股东高管：</font></td>
                    <td colspan="4"><input id="top_StockName" type="text" placeholder="请输入企业股东高管，如“李四”"
                                           style="margin-left: -100px;height: 45px;width: 115%;border: 1px solid #a8a8af;font-size: 18px;"/></td>
                </tr>
                <tr style="height: 22px">
                    <td colspan="5"></td>
                </tr>
                <tr style="height: 45px">
                    <td><font size="3">经营范围：</font></td>
                    <td colspan="4"><input id="top_inputScope" type="text" placeholder="请输入企业经营范围，如“信息传输”"
                                           style="margin-left: -100px;height: 45px;width: 115%;border: 1px solid #a8a8af;font-size: 18px;"/></td>
                </tr>
            </table>
        </div>

        <div style="position: relative;top: 10px;left: 30%;width: 40%;height: 45px;">
            <button id="top_Clean" style="position: relative;left: 0px;width: 40%;height: 100%;border: none;background-color: #a8a8af">
                <font size="3.5" color="white">清空</font>
            </button>
            <button id="top_Search" style="position: relative;left: 20%;width: 40%;height: 100%;border: none;background-color: #1db5ee">
                <font size="3.5" color="white">查询</font>
            </button>
        </div>
    </div>
</div>

<%--税号查询模态框--%>
<div class = "taxSearchDiv" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 32%;top: 5%;border-radius: 10px;width: 36%;height:500px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>税号查询</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "taxClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>

        <div id="taxSearch_main" style="position: relative;top: 40px;left: 0%;width: 90%;height: 40px;text-align: center">
            <input id="tax_input" type="text" name="searchTax" placeholder="请输入企业关键字"
                   style="height: 40px;width: 88%;border: 1px solid #a8a8af;font-size: 15px;" onkeypress="EnterPress(event)" onkeydown="EnterPress()" v-model="taxSearchText" v-on:keyup="taxShowName(taxSearchText)"/>
            <button id="tax_button" type="button"
                    style="position: relative;left: 218px;top: -40px;height: 40px;width: 12%;border: none;background-color: #1db5ee">
                <font size="3" color="white" style="align-content: center">搜索</font>
            </button>
            <div id="taxParentRelationSearch" v-for="(company, cIndex) in taxCompanyList" style="position: relative;top: -40px;left: 25px;height: auto;width: 438px;background-color: #ffffff;box-shadow: 0px 4px 8px rgba(44, 35, 35, 0.2);z-index: 99">
                <div class="taxRelationSearch" v-on:click="taxPutVal(company.name)" v-on:mouseenter="mouseEnter($event)" v-on:mouseleave="mouseLeave($event)" style="position: relative;top: 0px;left: 0px;width: 100%;height: 30px;border-bottom: 1px solid #e8e8e8;line-height: 30px;">
                    <font size="2" style="position: absolute;left: 5px">{{company.name}}</font>
                    <font size="1.5" style="position: absolute;left: 90%;">{{company.score}}</font>
                </div>
            </div>
        </div>

        <div style="position: relative;top: 90px;left: 5%;width: 90%;height: 360px;">
            <table style="width: 100%;height: auto">
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">公司全称：</font></td>
                    <td colspan="2"><font size="3" id="taxCorpName"></font></td>
                </tr>
                <tr>
                    <td colspan="3"><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">法人代表：</font></td>
                    <td colspan="2"><font size="3" id="taxManName"></font></td>
                </tr>
                <tr>
                    <td colspan="3" ><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">发票税号：</font></td>
                    <td><font size="3" id="taxNum"></font></td>
                    <td><font id="taxCopy" size="3" color="#1db5ee" style="position: absolute;left: 92%">复制</font></td>
                </tr>
                <tr>
                    <td colspan="3" ><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">联系方式：</font></td>
                    <td colspan="2"><font size="3" id="taxPhone"></font></td>
                </tr>
                <tr>
                    <td colspan="3" ><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">公司地址：</font></td>
                    <td colspan="2"><font size="3" id="taxAddress"></font></td>
                </tr>
                <tr>
                    <td colspan="3" ><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">开户银行：</font></td>
                    <td colspan="2"><font size="3" id="taxBankName"></font></td>
                </tr>
                <tr>
                    <td colspan="3" ><hr style="height: 1px;background-color: #e0e0e0"/></td>
                </tr>
                <tr style="height: 40px">
                    <td><font size="3" color="#a8a8af">银行账号：</font></td>
                    <td colspan="2"><font size="3" id="taxAccount"></font></td>
                </tr>
            </table>
        </div>
    </div>
</div>

<%--招聘查询模态框--%>
<div class = "jobSearchDiv" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 15%;top: 5%;border-radius: 15px;width: 70%;height:600px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>招聘查询</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "jobClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>

        <font size="2" color="#a8a8af" style="position: relative;top: 40px;left: 5%">*根据发布时间，为您提供最新的企业招聘信息，点击可了解企业详细信息。</font>

        <div class="innerbox" style="position: relative;top: 50px;left: 3%;width: 94%;height: 480px;overflow-y: auto;overflow-x: hidden">
            <table style="width: 100%">
                <thead>
                <td style="width: 32%;position: relative;left: 80px"><font size="2.5" color="#a8a8af">职位名称</font></td>
                <td style="width: 32%;position: relative;left: 60px"><font size="2.5" color="#a8a8af">企业名称</font></td>
                <td style="width: 10%;position: relative;left: -15px"><font size="2.5" color="#a8a8af">工作地点</font></td>
                <td style="width: 15%;position: relative;left: 28px"><font size="2.5" color="#a8a8af">薪资</font></td>
                <td style="width: 11%;position: relative;left: 12px"><font size="2.5" color="#a8a8af">发布日期</font></td>
                </thead>
                <tr><td colspan="5"><hr style="height: 2px;background-color: #a8a8af"/></td></tr>
                <c:forEach items="${allCorpRecruits }" var="jobCorp" varStatus="status" begin="0" end="100">
                    <tr style="height: 35px">
                        <td style="width: 32%">
                            <font class="jobInfo" size="3">
                                <c:if test="${fn:length(jobCorp.jobName) > 18}">
                                    ${fn:substring(jobCorp.jobName, 0, 17)}...
                                </c:if>
                                <c:if test="${fn:length(jobCorp.jobName) <= 18}">
                                    ${jobCorp.jobName }
                                </c:if>
                            </font>
                        </td>
                        <td style="width: 32%"><font class="jobCorp" id="job_${jobCorp.corpId}" size="2.5" color="#a8a8af">${jobCorp.corpName }</font></td>
                        <td style="width: 10%"><font size="2.5" color="#a8a8af">${jobCorp.jobAddress }</font></td>
                        <td style="width: 15%"><font size="2.5" color="1db5ee">${jobCorp.jobMoney }</font></td>
                        <td style="width: 11%"><font size="2.5" color="#a8a8af">${jobCorp.publicDate }</font></td>
                    </tr>
                    <tr><td colspan="5"><hr style="height: 1px;background-color: #d1d4d6"/></td></tr>
                </c:forEach>
            </table>
        </div>


    </div>
</div>

<%--批量查询模态框--%>
<div class = "batSearchDiv" style="position:absolute;top:0%;left:0%;background:rgba(0,0,0,0.4);width:100%;height:100%;position:fixed;z-index:9999;display: none">
    <div class = "content innerbox" style="position: absolute;left: 15%;top: 5%;border-radius: 15px;width: 70%;height:600px;background-color: #ffffff;overflow-y:auto;">
        <div style="position: relative;top: 20px;left: 0px;float: left;width: 100%;height: 30px;z-index: 2;border-bottom: 1px solid #1db5ee">
            <span style="position: relative;top: 15px;left: 5%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                <font size="3.5"><b>批量查询</b></font>
                <font size="3.5">&nbsp;&nbsp;</font>
            </span>
            <img id = "batClose" src="icon/close.png" width="15px" height="15px" style="position: absolute;top: -5px;right: 20px;"/>
        </div>

        <div style="position: relative;top: 60px;left: 5%;width: 90%;height: 480px;">
            <div style="position: relative;top: -10px;left: 0px;width: 46%;height: 90%;float: left">
                <textarea id="note_text" style="position: relative;top: 0px;left: 0px;width: 100%;height: 100%;border: 1px solid #d1d4d6;font-size:20px;padding: 10px;"
                          onfocus="document.getElementById('note').style.display='none'" onblur="if(value=='')document.getElementById('note').style.display='block'"></textarea>
                <div id="note" class="note" style="position: relative;top: -250px;left: 40px;">
                    <font size="2" color="#777">*输入的文字需要包含公司全名，否则匹配不出来</font><br/>
                    <font size="2" color="#777">*输入的文字不能超过500字，否则将自动截断</font>
                </div>
            </div>

            <div id="batCorpResult" style="position: relative;top: -10px;left: 8%;width: 46%;height: 90%;border: 1px solid #d1d4d6;float: left;">
                <span style="position: relative;top: -15px;left: 30%;background-color: #ffffff;">
                <font size="3.5">&nbsp;&nbsp;</font>
                    <font size="3.5">共查询&nbsp;</font>
                    <font id="batNumResult"size="4" color="#1db5ee"><b>0</b></font>
                    <font size="3.5">&nbsp;条结果</font>
                <font size="3.5">&nbsp;&nbsp;</font>
                </span>

                <ul class="batCorpUl" style="margin-top: 10px"></ul>
                <font id="batCorpFont" size="3" style="color: #1db5ee;position: absolute;left: 36%;top: 48%;">暂无查询结果！</font>
            </div>
        </div>

        <div style="position: relative;top: 60px;left: 15%;width: 70%;height: 45px;">
            <button id="bat_create" style="position: relative;left: 0px;width: 25%;height: 100%;border: none;background-color: #73bc6c">
                <font size="3.5" color="white">生成查询结果</font>
            </button>
            <button id="bat_export" style="position: relative;left: 50%;width: 25%;height: 100%;border: none;background-color: #1db5ee">
                <font size="3.5" color="white">导出企业信息</font>
            </button>
        </div>
    </div>
</div>

<!-- 消息提示 -->
<div id="showMessage0" style="position: fixed;top: 40%;left: 40%;width: 400px;height: 60px;z-index: 9999;text-align: center;line-height: 60px;background-color: #2b2b2b;display: none;">
    <font id="showMessageFont0" size="3" style="color: #1db5ee"></font>
</div>

<!-- 语音提示 -->
<div id="voiceMessage" style="position: absolute;top: 48%;left: 40%;width: 240px;height: 100px;z-index: 9999;background-color:rgba(43,43,43,0.9);display: none">
    <img src="icon/voiceGif.gif" style="position: relative;top: 10px;left: 95px;width: 50px;height: 50px;">
    <font size="3" color="#ffffff" style="position: relative;top: 40px;left: 10px;">语音识别中……</font>
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
<script type="text/javascript" src="js/WTMap.min.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<script type="text/javascript" src="js/tagcloud.min.js"></script>
<script type="text/javascript" src="js/other.js"></script>
</body>
</html>