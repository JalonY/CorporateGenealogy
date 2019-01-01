<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8" name="viewport" content="width=device-width">
    <link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen"/>
    <title>${userInput }的搜索结果_千企查</title>
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
    <script src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var value ="${userInput}";
            console.info(value);
            $(".searchValue").html(value);
        })

        function EnterPress(e){
            var e = e || window.event;
            if(e.keyCode == 13){
                var corp_name = document.getElementById("search_input2").value;
                window.location.href='http://localhost:8080/select_corpByName.do?key='+corp_name;
            }
        }
    </script>
</head>
<body class="innerbox" style="background-color: #eef0f2">

<!--网站头部电脑端-->
<div id="hd">
    <div class="wp">
        <div class="logo"><a href="search_corp.do"><img src="icon/logo_48.png" alt=""></a></div>
        <div style="position: relative;top: 25px;left: -50px;width: 100%;height: 50px;text-align: center">
            <input id="search_input2" type="text" name="search2" style="height: 40px;width: 700px;border: 1px solid #1db5ee;font-size: 16px;" value="${userInput }" onkeypress="EnterPress(event)" onkeydown="EnterPress()"/>
            <button id="search_button2" type="button" style="position: relative;left: -4px;top: 2px;height: 40px;width: 100px;border: none;background-color: #1db5ee">
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

<div id = "returnHome" style="position: absolute;top: 110px;left: 10%;width: 36px;height: 30px;background-image: url(/icon/returnHome.png)"></div>
<!--查询的企业列表区-->
<div style="position: absolute;top: 150px;left: 10%;width: 80%;height: auto;" id="paging">

    <div style="position: relative;top: 0px;left: 0px;width: 100%;height: 40px;float: left;background-color: #ffffff;">
        <div style="position: relative;top: 0px;left: 0px;width: 40%;height: 100%;float: left;line-height: 40px;">
            <c:if test="${pageInfo.total > 100}">
                <font id="corp_num" color="#a9a9a9" size="2.5">您的搜索词太宽泛，建议更换一下搜索词</font>
            </c:if>
            <c:if test="${pageInfo.total < 101}">
                <font color="#a9a9a9" size="2.5">千企查为你找到相关公司&nbsp;</font>
                <font id="corp_num" color="red" size="2.5">${pageInfo.total }</font>
                <font color="#a9a9a9" size="2.5">&nbsp;家</font>
            </c:if>
            <font id="type_tip" style="display: none">${type_tip}</font>
            <font id="tip_address" style="display: none">${tip_address}</font>
            <font id="tip_date" style="display: none">${tip_date}</font>
            <font id="tip_other" style="display: none">${tip_other}</font>
        </div>
        <div style="position: relative;top: 0px;right: 0px;width: 35%;height: 100%;float: right;line-height: 40px;">
            <select id="corp_sort" style="line-height:35px;height:25px;margin:10px auto;">
                <c:if test="${sort_type == '默认排序'}">
                    <option selected="selected">默认排序</option>
                    <option>注册资本升序</option>
                    <option>注册资本降序</option>
                    <option>注册时间升序</option>
                    <option>注册时间降序</option>
                </c:if>
                <c:if test="${sort_type == '注册资本升序'}">
                    <option selected="selected">注册资本升序</option>
                    <option>默认排序</option>
                    <option>注册资本降序</option>
                    <option>注册时间升序</option>
                    <option>注册时间降序</option>
                </c:if>
                <c:if test="${sort_type == '注册资本降序'}">
                    <option selected="selected">注册资本降序</option>
                    <option>默认排序</option>
                    <option>注册资本升序</option>
                    <option>注册时间升序</option>
                    <option>注册时间降序</option>
                </c:if>
                <c:if test="${sort_type == '注册时间升序'}">
                    <option selected="selected">注册时间升序</option>
                    <option>默认排序</option>
                    <option>注册资本升序</option>
                    <option>注册资本降序</option>
                    <option>注册时间降序</option>
                </c:if>
                <c:if test="${sort_type == '注册时间降序'}">
                    <option selected="selected">注册时间降序</option>
                    <option>默认排序</option>
                    <option>注册资本升序</option>
                    <option>注册资本降序</option>
                    <option>注册时间升序</option>
                </c:if>
                <c:if test="${sort_type == ''}">
                    <option selected="selected">默认排序</option>
                    <option>注册资本升序</option>
                    <option>注册资本降序</option>
                    <option>注册时间升序</option>
                    <option>注册时间降序</option>
                </c:if>
            </select>
            <img id="click_sort" src="icon/sort_refresh.png" style="position: relative;top: 5px;left: 5px;width: 20px;height: 20px;">
            <button id="batchContact" style="position: relative;top: 0px;left: 35px;height: 25px;width: 100px;background-color: #1db5ee;border: none;">
                <font color="white" size="2.5">批量联系</font>
            </button>
            <button id="exportData" style="position: relative;top: 0px;left: 40px;height: 25px;width: 100px;background-color: #1db5ee;border: none;">
                <font color="white" size="2.5">导出数据</font>
            </button>
        </div>
    </div>

    <c:if test="${pageInfo.total == 0}">
    <div class="corp_info_list">
        <div class="corp_info_list_img">
            <img src="img/unhappy.png" width="100%" height="100%"/>
        </div>
        <div class="corp_info_list_font">
            <font color="#a9a9a9" size="3" style="margin-top: 45%">暂无相关企业</font>
        </div>
    </div>
    </c:if>

    <c:if test="${pageInfo.total > 100 }">
    <div class="corp_info_list">
        <div class="corp_info_list_img">
            <img src="img/unhappy.png" width="100%" height="100%"/>
        </div>
        <div class="corp_info_list_font">
            <font color="#a9a9a9" size="3" style="margin-top: 45%">搜索范围太广</font>
        </div>
    </div>
    </c:if>

    <c:if test="${pageInfo.total > 0 && pageInfo.total < 101}">
        <c:forEach items="${listCorps }" var="listCorp" varStatus="status" begin="0" end="4">
        <div class="corp_info_list">
            <div class="corp_info_list_img">
                <img src="${listCorp.corpLogo }" width="100%" height="100%"/>
            </div>
            <div class="corp_info_list_font">
                <font color="black" size="3.5" class="search_corp_list_name" id="corp_${listCorp.id}">
                    <b>${fn:replace(listCorp.corpName, userInput, "<span style='color:red;' class='searchValue'></span>")}</b>
                </font><br/><br/>
                <font color="#a9a9a9" size="2.5">法定代表人：</font>
                <font color="#1db5ee" size="2.5">${listCorp.operManName }</font>
                <font color="#a9a9a9" size="2.5" style="position: relative;left: 40px;">注册资本：</font>
                <font size="2.5"  style="position: relative;left: 40px;">${listCorp.regCapi }&nbsp;万元</font>
                <font color="#a9a9a9" size="2.5" style="position: relative;left: 80px;">成立时间：</font>
                <font size="2.5"  style="position: relative;left: 80px;">${listCorp.startDate }</font><br/>
                <font color="#a9a9a9" size="2.5">联系电话：</font>
                <font size="2.5">${listCorp.corpTel }</font><br/>
                <font color="#a9a9a9" size="2.5">企业网站：</font>
                <font color="red" size="2.5">${listCorp.corpWebUrl }</font>
            </div>
        </div>
        </c:forEach>
    </c:if>

    <c:if test="${pageInfo.total > 0 && pageInfo.total < 101}">
        <!--显示分页信息-->
        <div style="margin-left:15%;width: 70%;height: 150px;">
            <div style="margin-top: 100px;width: 50%;float: left;">
                <font size="3.5">当前第 ${pageInfo.pageNum} 页&nbsp;&nbsp;&nbsp;总共 ${pageInfo.pages} 页&nbsp;&nbsp;&nbsp;一共 ${pageInfo.total} 条记录</font>
            </div>

            <!--点击分页-->
            <div style="margin-top: 100px;margin-left:10%;width: 40%;float: left;">
                <nav aria-label="Page navigation">
                    <ul>
                        <li style="float: left;">
                            <c:if test="${type_tip == 'select_corpByName'}">
                                <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${userInput}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByStock'}">
                                <a href="${pageContext.request.contextPath}/select_corpByStock.do?key=${tip_other}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByManager'}">
                                <a href="${pageContext.request.contextPath}/select_corpByManager.do?key=${tip_other}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByIndu'}">
                                <a href="${pageContext.request.contextPath}/select_corpByIndu.do?key=${tip_other}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByAddress'}">
                                <a href="${pageContext.request.contextPath}/select_corpByAddress.do?key=${tip_address}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByDate'}">
                                <a href="${pageContext.request.contextPath}/select_corpByDate.do?key=${tip_date}&pn=1&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">首页&nbsp;</font>
                                </a>
                            </c:if>
                        </li>

                        <li style="float: left;">
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <c:if test="${type_tip == 'select_corpByName'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${userInput}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByStock'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByStock.do?key=${tip_other}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByManager'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByManager.do?key=${tip_other}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByIndu'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByIndu.do?key=${tip_other}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByAddress'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByAddress.do?key=${tip_address}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByDate'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByDate.do?key=${tip_date}&pn=${pageInfo.pageNum-1}&sort_type=${sort_type}" aria-label="Previous">
                                        <span aria-hidden="true">&nbsp;&nbsp;«&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                            </c:if>
                        </li>

                        <!--循环遍历连续显示的页面，若是当前页就高亮显示，并且没有链接-->
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num == pageInfo.pageNum}">
                                <li style="float: left;">
                                    <a href="#">
                                        <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${page_num != pageInfo.pageNum}">
                                <li  style="float: left;">
                                    <c:if test="${type_tip == 'select_corpByName'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${userInput}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                    <c:if test="${type_tip == 'select_corpByStock'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByStock.do?key=${tip_other}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                    <c:if test="${type_tip == 'select_corpByManager'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByManager.do?key=${tip_other}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                    <c:if test="${type_tip == 'select_corpByIndu'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByIndu.do?key=${tip_other}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                    <c:if test="${type_tip == 'select_corpByAddress'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByAddress.do?key=${tip_address}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                    <c:if test="${type_tip == 'select_corpByDate'}">
                                        <a href="${pageContext.request.contextPath}/select_corpByDate.do?key=${tip_date}&pn=${page_num}&sort_type=${sort_type}">
                                            <font size="3.5">&nbsp;&nbsp;${page_num}&nbsp;&nbsp;</font>
                                        </a>
                                    </c:if>
                                </li>
                            </c:if>
                        </c:forEach>

                        <li style="float: left;">
                            <c:if test="${pageInfo.hasNextPage}">
                                <c:if test="${type_tip == 'select_corpByName'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${userInput}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByStock'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByStock.do?key=${tip_other}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByManager'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByManager.do?key=${tip_other}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByIndu'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByIndu.do?key=${tip_other}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByAddress'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByAddress.do?key=${tip_address}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                                <c:if test="${type_tip == 'select_corpByDate'}">
                                    <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${tip_date}&pn=${pageInfo.pageNum+1}&sort_type=${sort_type}" aria-label="Next">
                                        <span aria-hidden="true">&nbsp;&nbsp;»&nbsp;&nbsp;</span>
                                    </a>
                                </c:if>
                            </c:if>
                        </li>

                        <li style="float: left;">
                            <c:if test="${type_tip == 'select_corpByName'}">
                                <a href="${pageContext.request.contextPath}/select_corpByName.do?key=${userInput}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByStock'}">
                                <a href="${pageContext.request.contextPath}/select_corpByStock.do?key=${tip_other}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByManager'}">
                                <a href="${pageContext.request.contextPath}/select_corpByManager.do?key=${tip_other}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByIndu'}">
                                <a href="${pageContext.request.contextPath}/select_corpByIndu.do?key=${tip_other}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByAddress'}">
                                <a href="${pageContext.request.contextPath}/select_corpByAddress.do?key=${tip_address}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                            <c:if test="${type_tip == 'select_corpByDate'}">
                                <a href="${pageContext.request.contextPath}/select_corpByDate.do?key=${tip_date}&pn=${pageInfo.pages}&sort_type=${sort_type}">
                                    <font size="3.5" color="#1db5ee">&nbsp;尾页</font>
                                </a>
                            </c:if>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </c:if>

</div>

<!-- 消息提示 -->
<div id="showMessage1" style="position: fixed;top: 40%;left: 40%;width: 400px;height: 60px;z-index: 99;text-align: center;line-height: 60px;background-color: #2b2b2b;display: none;">
    <font id="showMessageFont1" size="3" style="color: #1db5ee"></font>
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
<div id="fd" class="index-fd pr" style="position: relative;top: 1600px;">
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
