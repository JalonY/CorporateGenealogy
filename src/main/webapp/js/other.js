//用户反馈信息模块
$("#sub").click(function (e) {
    var name = $("#name").val();
    var tel = $("#tel").val();
    var txt = $("#txt").val();
    var re = /^[1][3587]\d{9}$/;
    if (name == "") {
        alert("姓名不能为空");
        return false;
    }
    if (!re.test(tel)) {
        alert("请输入正确的联系方式");
        return false;
    }
    if (txt == "") {
        alert("请输入您的需求");
        return false;
    }

    $.ajax({
        url: "",
        type: 'GET',
        data: {'name': name, 'tel': tel, 'txt': txt},
        //dataType:"text",
        async: false,
        error: function () {
            alert("error");
        },
        success: function (data) {
            alert(data);
        }
    })
});


//网站搜索区域模块
$('#banner .flexslider').flexslider({
    animation: "slide",
    animationLoop: true,
    slideshow: false,
    prevText: "",
    nextText: "",
    controlNav: false,
    directionNav: true,
    pauseOnHover: true,
    slideshowSpeed: 3000,
    start: function (slider) {
    },
    before: function () {
    },
    after: function (slider) {
    }
});

//自动补全模块
$(document).ready(function () {
        var vm1 = new Vue({
            el: '#search_main',
            data: {
                searchText: "",
                companyList: [],
            },
            mounted: function () {
                this.showName();
                this.putVal();
                this.mouseEnter();
                this.mouseLeave();
            },
            methods: {
                putVal: function (val) {
                    $("#search_input1").val(val);
                    $(".relationSearch").hide();
                    document.getElementById("search_input1").focus();
                },
                showName: function (key) {
                    console.log(key);
                    if (key.length != 0) {
                        var searchType = document.getElementById("searchType").innerText;
                        if (searchType == "全部" || searchType == "企业名") {
                            $(".relationSearch").show();
                            var _this = this;
                            this.$http.get("http://localhost:8080/auto_think.do?key=" + key).then(function (jsonResult) {
                                _this.companyList = (jsonResult.body);
                            });
                        }
                    } else {
                        $(".relationSearch").hide();
                    }
                },
                mouseEnter: function ($event) {
                    $event.currentTarget.className = "relationSearch searchActive";
                },
                mouseLeave: function ($event) {
                    $event.currentTarget.className = "relationSearch";
                }
            }
        });

    var vm2 = new Vue({
        el: '#taxSearch_main',
        data: {
            taxSearchText: "",
            taxCompanyList: [],
        },
        mounted: function () {
            this.taxShowName();
            this.taxPutVal();
            this.mouseEnter();
            this.mouseLeave();
        },
        methods: {
            taxPutVal: function (val) {
                $("#tax_input").val(val);
                $(".taxRelationSearch").hide();
                document.getElementById("tax_input").focus();
            },
            taxShowName: function (key) {
                console.log(key);
                if (key.length != 0) {
                    $(".taxRelationSearch").show();
                    var _this = this;
                    this.$http.get("http://localhost:8080/auto_think.do?key=" + key).then(function (jsonResult) {
                        _this.taxCompanyList = (jsonResult.body);
                    });
                } else {
                    $(".taxRelationSearch").hide();
                }
            },
            mouseEnter: function ($event) {
                $event.currentTarget.className = "taxRelationSearch taxSearchActive";
            },
            mouseLeave: function ($event) {
                $event.currentTarget.className = "taxRelationSearch";
            }
        }
    });
});


//搜索模块
$(function () {
    $('.search-type').click(function () {
        $('.search-type').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("#index").val(index);
        if (index == 0) {
            $("input[name='search1']").val("").focus();
            $(".relationSearch").hide();
            document.getElementById("searchType").innerText = "企业名";
            $('#search_input1').attr('placeholder', '请输入企业名称。如“阿里巴巴”或“alibaba”')
        } else if (index == 2) {
            $("input[name='search1']").val("").focus();
            $(".relationSearch").hide();
            document.getElementById("searchType").innerText = "法人/股东";
            $('#search_input1').attr('placeholder', '请输入法人名称或股东名称，如“雷军”或“leijun”')
        } else if (index == 4) {
            $("input[name='search1']").val("").focus();
            $(".relationSearch").hide();
            document.getElementById("searchType").innerText = "高管";
            $('#search_input1').attr('placeholder', '请输入企业高管名称，如“李彦宏”或“li yan hong”')
        } else if (index == 6) {
            $("input[name='search1']").val("").focus();
            $(".relationSearch").hide();
            document.getElementById("searchType").innerText = "所属行业";
            $('#search_input1').attr('placeholder', '请输入企业所属行业，如“信息传输”')
        } else {
            $("input[name='search1']").val("").focus();
            $(".relationSearch").hide();
            document.getElementById("searchType").innerText = "企业名";
            $('#search_input1').attr('placeholder', '请输入企业名称。如“阿里巴巴”或“alibaba”')
        }
    });
    $("#voice").mouseenter(function () {
        var element = document.getElementById('voice');
        element.src = "icon/voice2.png";
    });
    $("#voice").mouseleave(function () {
        var element = document.getElementById('voice');
        element.src = "icon/voice1.png";
    });
    $("#topSearch").click(function () {
        $(".topSearchDiv").slideDown();
    });
    $("#taxSearch").click(function () {
        $(".taxSearchDiv").slideDown();
    });
    $("#jobSearch").click(function () {
        $(".jobSearchDiv").slideDown();
    });
    $(".jobInfo").mouseenter(function(){
        $(this).css("color","#1db5ee");
    });
    $(".jobInfo").mouseleave(function(){
        $(this).css("color","#000000");
    });
    $(".jobCorp").click(function () {
        var job_id = $(this).attr("id").substr(4);
        window.location.href = 'http://localhost:8080/see_details.do?corp_id=' + job_id;
    });
    $(".jobCorp").mouseenter(function(){
        $(this).css("color","#1db5ee");
    });
    $(".jobCorp").mouseleave(function(){
        $(this).css("color","#a8a8af");
    });
    $("#batSearch").click(function () {
        $(".batSearchDiv").slideDown();
    });
    $("#indSearch").click(function () {
        window.location.hash = "#topSearch";
        $("#classes1").addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not("#classes1").removeClass("not_change");
        $("#classes1").css("background-color", "#1db5ee");
        $("#classes1").css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not("#classes1").css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not("#classes1").css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class1").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class1").fadeOut(0);
    });
    $('#topClose').click(function () {
        $(".topSearchDiv").fadeOut();
    });
    $('#taxClose').click(function () {
        $(".taxSearchDiv").fadeOut();
    });
    $('#jobClose').click(function () {
        $(".jobSearchDiv").fadeOut();
    });
    $('#batClose').click(function () {
        $(".batSearchDiv").fadeOut();
    });
    $("#taxCopy").mouseenter(function () {
        $(this).css("color","#1db5ez");
    });
    $("#taxCopy").mouseleave(function () {
        $(this).css("color","#1db5ee");
    });
    $("#taxCopy").click(function () {
        var text = document.getElementById('taxNum');
        if (document.body.createTextRange) {
            var range = document.body.createTextRange();
            range.moveToElementText(text);
            range.select();
        } else if (window.getSelection) {
            var selection = window.getSelection();
            var range = document.createRange();
            range.selectNodeContents(text);
            selection.removeAllRanges();
            selection.addRange(range);
        }
        document.execCommand('Copy');
        alert("提示：企业发票税号已复制！");
    });
    $("#top_Clean").click(function () {
        document.getElementById("top_inputName").value = "";
        document.getElementById("top_inputAddress").value = "";
        document.getElementById("top_CapiStart").value = "";
        document.getElementById("top_CapiEnd").value = "";
        document.getElementById("top_ManName").value = "";
        document.getElementById("top_StockName").value = "";
        document.getElementById("top_inputScope").value = "";
    });
    $("#top_Search").click(function () {
        var top_inputName = document.getElementById("top_inputName").value;
        var top_inputAddress = document.getElementById("top_inputAddress").value;
        var top_CapiStart = document.getElementById("top_CapiStart").value;
        var top_CapiEnd = document.getElementById("top_CapiEnd").value;
        var top_ManName = document.getElementById("top_ManName").value;
        var top_StockName = document.getElementById("top_StockName").value;
        var top_inputScope = document.getElementById("top_inputScope").value;

        if (top_inputName.length != 0 || top_inputAddress.length != 0 || top_CapiStart.length != 0 || top_CapiEnd.length != 0 || top_ManName.length != 0 || top_StockName.length != 0 || top_inputScope.length != 0) {
            $.ajax({
                type: 'post',
                async: false,
                url: "advancedSearch.do",
                data: {
                    "top_inputName": top_inputName,
                    "top_inputAddress": top_inputAddress,
                    "top_CapiStart": top_CapiStart,
                    "top_CapiEnd": top_CapiEnd,
                    "top_ManName": top_ManName,
                    "top_StockName": top_StockName,
                    "top_inputScope": top_inputScope
                },
                dataType: "json",
                success: function (result) {
                    if (result == "提示：未找到符合条件的企业！") {
                        setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
                        document.getElementById("showMessageFont0").innerText = result;
                        setTimeout("document.getElementById('showMessage0').style.display='none'", 2000);
                    } else {
                        window.location.href = 'http://localhost:8080/see_details.do?corp_id='+result;
                    }
                }
            });
        } else {
            setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
            document.getElementById("showMessageFont0").innerText = "提示：查询条件不能全部为空！";
            setTimeout("document.getElementById('showMessage0').style.display='none'", 2000);
        }
    });
    $("#tax_button").click(function () {
         var taxCorpName = document.getElementById("tax_input").value;
         $.ajax({
            type: 'post',
            async: false,
            url: "getTaxCorp.do?corp_name=" + taxCorpName,
            data: {},
            dataType: "json",
            success: function (result) {
                if (result) {
                    for (var i = 0; i < result.length; i++) {
                        document.getElementById("taxCorpName").innerText = result[i].corpName;
                        document.getElementById("taxManName").innerText = result[i].operManName;
                        document.getElementById("taxNum").innerText = result[i].uniScid;
                        document.getElementById("taxPhone").innerText = result[i].corpTel;
                        if(result[i].corpAddr.length > 21){
                            document.getElementById("taxAddress").innerText = result[i].corpAddr.substring(0,20)+"...";
                        }else {
                            document.getElementById("taxAddress").innerText = result[i].corpAddr;
                        }
                        // document.getElementById("taxBankName").innerText = result[i].;
                        // document.getElementById("taxAccount").innerText = result[i].;
                    }
                }
            }
         });
    });
    $("#bat_create").click(function () {
        var text = document.getElementById("note_text").value;
        $(".batCorpUl").html('');
        document.getElementById("batNumResult").innerText = "0";
        document.getElementById('batCorpFont').style.display = 'none';
        if(text.length > 500){
            setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
            document.getElementById("showMessageFont0").innerText = "提示：输入文字已超500字，将自动截断！";
            setTimeout("document.getElementById('showMessage0').style.display='none'", 3000);
            var newText = text.substring(0,500);
            $.ajax({
                type: 'post',
                async: false,
                url: "batSearchCorp.do?text=" + newText,
                data: {},
                dataType: "json",
                error: function () {
                    $("#batCorpFont").show();
                },
                success: function (result) {
                    if (result.length == 0) {
                        $("#batCorpFont").show();
                    }
                    if (result != "") {
                        var newresult = result.substring(0,result.length-1);
                        var n = (newresult.split('&')).length;
                        document.getElementById("batNumResult").innerText = n;
                        var char = newresult.split("&");
                        var li = "";
                        char.forEach(function (i,index) {
                            var corpInfo = i.split("_");
                            var c1 = corpInfo[0];
                            var c2 = corpInfo[1];
                            li += "<li>\n" +
                                    "<a href=\"http://localhost:8080/see_details.do?corp_id=" + c2 + "\"><font size=\"3\" style=\"margin-top: 20px;margin-left: 20px\">•"+ c1 +"</font></a>\n" +
                                  "</li>";
                            $(".batCorpUl").html(li);
                        });
                    }
                }
            });
        }else{
            $.ajax({
                type: 'post',
                async: false,
                url: "batSearchCorp.do?text=" + text,
                data: {},
                dataType: "json",
                error: function () {
                    $("#batCorpFont").show();
                },
                success: function (result) {
                    if (result.length == 0) {
                        $("#batCorpFont").show();
                    }
                    if (result != "") {
                        var newresult = result.substring(0,result.length-1);
                        var n = (newresult.split('&')).length;
                        document.getElementById("batNumResult").innerText = n;
                        var char = newresult.split("&");
                        var li = "";
                        char.forEach(function (i,index) {
                            var corpInfo = i.split("_");
                            var c1 = corpInfo[0];
                            var c2 = corpInfo[1];
                            li += "<li>\n" +
                                "<a href=\"http://localhost:8080/see_details.do?corp_id=" + c2 + "\"><font size=\"3\" style=\"margin-top: 20px;margin-left: 20px\">•"+ c1 +"</font></a>\n" +
                                "</li>";
                            $(".batCorpUl").html(li);
                        });
                    }
                }
            });
        }
    });
    $("#bat_export").click(function () {
        var key = [];
        $(".batCorpUl").each(function () {
            $(this).find('li').each(function() {
                var temp = $(this).text().replace("•","");
                key.push(temp);
            });
        });
        //遍历该数组可以获取所有值
        // for (var i = 0 ; i < key.length; i++) {
        //     console.log(key.toString());
        // }
        $.ajax({
            type: 'post',
            async: false,
            url: "batExport.do?corpList=" + key,
            data: {},
            dataType: "json",
            error: function () {
                setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
                document.getElementById("showMessageFont0").innerText = "提示：数据导出失败(企业部分信息为空)！";
                setTimeout("document.getElementById('showMessage0').style.display='none'", 3000);
            },
            success: function (result) {
                setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
                document.getElementById("showMessageFont0").innerText = result;
                setTimeout("document.getElementById('showMessage0').style.display='none'", 3000);
            }
        });
    });


    $('#returnHome').click(function () {
        window.location.href = 'http://localhost:8080/search_corp.do';
    });
    $('#search_button1').click(function () {
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
    });
    $('#searchByAddress').click(function () {
        var full_address = document.getElementById("full_address").value;
        window.location.href = 'http://localhost:8080/select_corpByAddress.do?key=' + full_address;
    });
    $('#searchByDate').click(function () {
        var date_input = document.getElementById("custom-date-input").value;
        window.location.href = 'http://localhost:8080/select_corpByDate.do?key=' + date_input;
    });
    $("#voice").click(function () {
        $('#voiceMessage').show();
        $.when(getVoiceData()).done(function(data){
            $('#voiceMessage').hide();
            document.getElementById("search_input1").value = data;
            if(data == ""){
                setTimeout("document.getElementById('showMessage0').style.display='inline'", 1);
                document.getElementById("showMessageFont0").innerText = "提示：未识别到语音，请重新识别！";
                setTimeout("document.getElementById('showMessage0').style.display='none'", 2000);
            }
        });
    });
});

function getVoiceData() {
    var defer = $.Deferred();
    $.ajax({
        type: 'post',
        url : "voiceSearch.do",
        //async : false,
        success: function(data){
            defer.resolve(data)
        }
    });
    return defer.promise();
}

//登陆注册模块
$(document).ready(function () {
    $("#login").click(function () {
        var status = document.getElementById("login").innerHTML;
        var userId = document.getElementById("userId").innerHTML;
        if (status == "登录") {
            $("#log_div").show("slow");
        } else {
            $(".bg-model3").show();
            $.ajax({
                type: 'post',
                async: false,
                url: "showCollect.do?userId=" + userId,
                data: {},
                dataType: "json",
                error: function () {
                    $("#collectFont").show();
                },
                success: function (result) {
                    $(".userCollectUl").html('');
                    if (result.length == 0) {
                        $("#collectFont").show();
                    }
                    var json = eval(result);
                    var li = "";
                    $.each(json, function (index, item) {
                        var s0 = json[index].corpLogo;
                        var s1 = json[index].corpName;
                        var s2 = json[index].operManName;
                        var s3 = json[index].id;
                        li += "<li>\n" +
                            "<a href=\"\"><img width=\"48\" height=\"48\" alt=\"logo\" class=\"pic\" src = "+ s0 +" /></a>\n" +
                            "<font style=\"padding:10px;\" size=\"2.5\">" + s1 + "</font><br/>\n" +
                            "<font style=\"padding:10px;\" size=\"2.5\">法人代表：</font>\n" +
                            "<font style=\"padding:0px;\" size=\"2.5\">" + s2 + "</font>\n" +
                            "<a href=\"http://localhost:8080/see_details.do?corp_id=" + s3 + "\"><font size=\"1.5\" style=\"margin-left: 230px;\">查看</font></a>\n" +
                            "<a href=\"http://localhost:8080/deleteCollect.do?corpId=" + s3 + "&userId=" + userId + "\"><font size=\"1.5\" style=\"margin-left: 10px;\">删除</font></a>\n" +
                            "</li>";
                        $(".userCollectUl").html(li);
                    });
                }
            });
            $.ajax({
                type: 'post',
                async: false,
                url: "showAttention.do?userId=" + userId,
                data: {},
                dataType: "json",
                error: function () {
                    $("#attentionFont").show();
                },
                success: function (result) {
                    $(".userAttentionUl").html('');
                    if (result.length == 0) {
                        $("#attentionFont").show();
                    }
                    var json = eval(result);
                    var li = "";
                    $.each(json, function (index, item) {
                        var s0 = json[index].corpLogo;
                        var s1 = json[index].corpName;
                        var s2 = json[index].operManName;
                        var s3 = json[index].id;
                        li += "<li>\n" +
                            "<a href=\"\"><img width=\"48\" height=\"48\" alt=\"logo\" class=\"pic\" src = "+ s0 +" /></a>\n" +
                            "<font style=\"padding:10px;\" size=\"2.5\">" + s1 + "</font><br/>\n" +
                            "<font style=\"padding:10px;\" size=\"2.5\">法人代表：</font>\n" +
                            "<font style=\"padding:0px;\" size=\"2.5\">" + s2 + "</font>\n" +
                            "<a href=\"http://localhost:8080/see_details.do?corp_id=" + s3 + "\"><font size=\"1.5\" style=\"margin-left: 230px;\">查看</font></a>\n" +
                            "<a href=\"http://localhost:8080/deleteAttention.do?corpId=" + s3 + "&userId=" + userId + "\"><font size=\"1.5\" style=\"margin-left: 10px;\">删除</font></a>" +
                            "</li>";
                        $(".userAttentionUl").html(li);
                    });
                }
            });
        }
    });

    $("#exitLogin").click(function () {
        window.location.href = 'http://localhost:8080/loginOut.do';
    });
    $("#exitLogin").mouseenter(function () {
        $(this).css("color", "#1db5ee");
    });
    $("#exitLogin").mouseleave(function () {
        $(this).css("color", "black");
    });
    $("#log_div_d_td1_f1").mouseenter(function () {
        $(this).css("color", "black");
    });
    $("#log_div_d_td1_f1").mouseleave(function () {
        $(this).css("color", "#1db5ee");
    });
    $("#log_div_d_td1_f1").click(function () {
        $("#log_div").hide("slow");
        $("#reg_div").show("slow");
    });
    $("#close_log_div").click(function () {
        $("#log_div").hide("slow");
    });
    $("#reg_div_d1_td1_f1").mouseenter(function () {
        $(this).css("color", "black");
    });
    $("#reg_div_d1_td1_f1").mouseleave(function () {
        $(this).css("color", "#1db5ee");
    });
    $("#reg_div_d1_td1_f1").click(function () {
        $("#reg_div").hide("slow");
        $("#log_div").show("slow");
    });
    $("#close_reg_div").click(function () {
        $("#reg_div").hide("slow");
    });
    $("#log_div_d_b1").click(function () {
        var message = document.getElementById("message").innerHTML;
        var login_account = document.getElementById("log_div_d_in1").value;
        var login_password = document.getElementById("log_div_d_in2").value;
        if (login_account.length != 0 && login_password.length != 0 && message == "验证成功") {
            $.ajax({
                type: 'post',
                async: false,
                url: "userLogin.do",
                data: {"login_account": login_account, "login_password": login_password},
                dataType: "json",
                success: function (result) {
                    if (result != "提示：登录成功！") {
                        document.getElementById("loginMessage").innerText = result;
                    } else {
                        window.location.href = 'http://localhost:8080/search_corp.do';
                    }
                }
            });
        } else if (login_account.length != 0 && login_password.length != 0 && message != "验证成功") {
            document.getElementById("loginMessage").innerText = "提示：请滑动验证！";
        } else {
            document.getElementById("loginMessage").innerText = "提示：输入内容不能为空！";
        }
    });

    $("#reg_div_d1_b1").click(function () {
        var regist_account = document.getElementById("reg_div_d1_in1").value;
        var regist_password1 = document.getElementById("reg_div_d1_in2").value;
        var regist_password2 = document.getElementById("reg_div_d1_in3").value;
        var regist_name = document.getElementById("reg_div_d1_in4").value;
        if (regist_account.length != 0 && regist_password1.length != 0 && regist_password2.length != 0 && regist_name.length != 0) {
            $.ajax({
                type: 'post',
                async: false,
                url: "userRegist.do",
                data: {
                    "regist_account": regist_account,
                    "regist_password1": regist_password1,
                    "regist_password2": regist_password2,
                    "regist_name": regist_name
                },
                dataType: "json",
                success: function (result) {
                    if (result != "提示：注册成功！") {
                        document.getElementById("registMessage").innerText = result;
                    } else {
                        window.location.href = 'http://localhost:8080/search_corp.do';
                    }

                }
            });
        } else {
            document.getElementById("registMessage").innerText = "提示：输入内容不能为空！";
        }

    });
});


//登录滑动验证模块
function getOffset(box, direction) {

    var setDirection = (direction == 'top') ? 'offsetTop' : 'offsetLeft';

    var offset = box[setDirection];

    var parentBox = box.offsetParent;
    while (parentBox) {

        offset += parentBox[setDirection];
        parentBox = parentBox.offsetParent;
    }
    parentBox = null;

    return parseInt(offset);
}
function moveCode(code) {

    var fn = {codeVluae: code};

    var box = document.querySelector("#log_div_d_d1_d1"),
        progress = box.querySelector("p"),
        codeInput = box.querySelector('.code-input'),
        evenBox = box.querySelector("span");

    var boxEven = ['mousedown', 'mousemove', 'mouseup'];
    if (typeof document.ontouchstart == 'object') {

        boxEven = ['touchstart', 'touchmove', 'touchend'];
    }

    var goX, offsetLeft, deviation, evenWidth, endX;

    function moveFn(e) {

        e.preventDefault();
        e = (boxEven['0'] == 'touchstart') ? e.touches[0] : e || window.event;


        endX = e.clientX - goX;
        endX = (endX > 0) ? (endX > evenWidth) ? evenWidth : endX : 0;

        if (endX > evenWidth * 0.7) {

            progress.innerText = '松开验证';
            progress.style.backgroundColor = "#66CC66";
        } else {

            progress.innerText = '';
            progress.style.backgroundColor = "#FFFF99";
        }

        progress.style.width = endX + deviation + 'px';
        evenBox.style.left = endX + 'px';
    }

    function removeFn() {

        document.removeEventListener(boxEven['2'], removeFn, false);
        document.removeEventListener(boxEven['1'], moveFn, false);

        if (endX > evenWidth * 0.7) {

            progress.innerText = '验证成功';
            progress.style.width = evenWidth + deviation + 'px';
            evenBox.style.left = evenWidth + 'px'

            codeInput.value = fn.codeVluae;
            evenBox.onmousedown = null;
        } else {

            progress.style.width = '0px';
            evenBox.style.left = '0px';
        }
    }

    evenBox.addEventListener(boxEven['0'], function (e) {

        e = (boxEven['0'] == 'touchstart') ? e.touches[0] : e || window.event;

        goX = e.clientX,
            offsetLeft = getOffset(box, 'left'),
            deviation = this.clientWidth,
            evenWidth = box.clientWidth - deviation,
            endX;

        document.addEventListener(boxEven['1'], moveFn, false);

        document.addEventListener(boxEven['2'], removeFn, false);
    }, false);

    fn.setCode = function (code) {
        if (code)
            fn.codeVluae = code;
    }

    fn.getCode = function () {

        return fn.codeVluae;
    }

    fn.resetCode = function () {

        evenBox.removeAttribute('style');
        progress.removeAttribute('style');
        codeInput.value = '';
    };

    return fn;
}


//行业分类导航模块
$(document).ready(function () {

    $(".mainv2_tab3_title_common").mouseenter(function () {
        $(this).children("span").not('.not_change').css("background-color", "#d3d9de");
    });
    $(".mainv2_tab3_title_common").mouseleave(function () {
        $(this).children("span").not('.not_change').css("background-color", "#e9eaec");
    });

    $("#classes1").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class1").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class1").fadeOut(0);
    });
    $("#classes2").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class2").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class2").fadeOut(0);
    });
    $("#classes3").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class3").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class3").fadeOut(0);
    });
    $("#classes4").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class4").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class4").fadeOut(0);
    });
    $("#classes5").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class5").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class5").fadeOut(0);
    });
    $("#classes6").click(function () {
        $(this).addClass("not_change");
        $(".mainv2_tab3_title_common").children("span").not(this).removeClass("not_change");
        $(this).css("background-color", "#1db5ee");
        $(this).css("color", "#ffffff");
        $(".mainv2_tab3_title_common").children("span").not(this).css("background-color", "#e9eaec");
        $(".mainv2_tab3_title_common").children("span").not(this).css("color", "#000000");
        $(".search-industry").children("div").filter("#corp_class6").fadeIn(0);
        $(".search-industry").children("div").not("#corp_class6").fadeOut(0);
    });
    $("#date_sure").click(function () {
        var date_section = document.getElementById("custom-date-select");
        var index = date_section.selectedIndex;
        $("#custom-date-input").val(date_section.options[index].text);
    });

    var entries = [];
    $.ajax({
        type: 'post',
        async: false,
        url: "getNewRegCorps.do",
        data: {},
        dataType: "json",
        success: function (result) {
            if (result) {
                for (var i = 0; i < result.length; i++) {
                    entries.push({
                        label: result[i].corpName,
                        url: 'http://localhost:8080/see_details.do?corp_id=' + result[i].id,
                        target: '_top',
                    });
                }

            }
        }
    });

    // 最新注册企业标签云
    entries;

    var settings = {
        entries: entries,
        width: 850,
        height: 500,
        radius: '100%',//标签分散度
        radiusMin: 75,
        bgDraw: true,
        bgColor: '#fff',
        opacityOver: 1.00,//选中标签透明度
        opacityOut: 0.2,//未选中标签透明度
        opacitySpeed: 6,
        fov: 800,
        speed: 0.2,
        fontFamily: 'Oswald, Arial, sans-serif',
        fontSize: '18',
        fontColor: '#000022',
        fontWeight: 'normal',//bold
        fontStyle: 'italic',//normal
        fontStretch: 'normal',//wider, narrower, ultra-condensed, extra-condensed, condensed, semi-condensed, semi-expanded, expanded, extra-expanded, ultra-expanded
        fontToUpperCase: true
    };

    $('#tag-cloud').svg3DTagCloud(settings);
});


//查询到的企业列表
$(document).ready(function () {
    $('#search_button2').click(function () {
        var corp_name = document.getElementById("search_input2").value;
        window.location.href = 'http://localhost:8080/select_corpByName.do?key=' + corp_name;
    });
    $("#click_sort").click(function () {
        var Sel = document.getElementById("corp_sort");
        var index = Sel.selectedIndex;
        var sort_name = Sel.options[index].text;
        var type_tip = document.getElementById("type_tip").innerText;
        var corp_name = document.getElementById("search_input2").value;
        var tip_address = document.getElementById("tip_address").innerText;
        var tip_date = document.getElementById("tip_date").innerText;
        var tip_other = document.getElementById("tip_other").innerText;

        if (type_tip == "select_corpByName") {
            window.location.href = 'http://localhost:8080/select_corpByName.do?key=' + corp_name + '&sort_type=' + sort_name;
        }  else if (type_tip == "select_corpByStock") {
            window.location.href = 'http://localhost:8080/select_corpByStock.do?key=' + tip_other + '&sort_type=' + sort_name;
        } else if (type_tip == "select_corpByManager") {
            window.location.href = 'http://localhost:8080/select_corpByManager.do?key=' + tip_other + '&sort_type=' + sort_name;
        } else if (type_tip == "select_corpByIndu") {
            window.location.href = 'http://localhost:8080/select_corpByIndu.do?key=' + tip_other + '&sort_type=' + sort_name;
        } else if (type_tip == "select_corpByAddress") {
            window.location.href = 'http://localhost:8080/select_corpByAddress.do?key=' + tip_address + '&sort_type=' + sort_name;
        } else if (type_tip == "select_corpByDate") {
            window.location.href = 'http://localhost:8080/select_corpByDate.do?key=' + tip_date + '&sort_type=' + sort_name;
        }

    });
    $(".corp_info_list").mouseenter(function () {
        $(this).css("box-shadow", "0px 4px 8px rgba(44, 35, 35, 0.2)");
    });
    $(".corp_info_list").mouseleave(function () {
        $(this).css("box-shadow", "none");
    });
    $(".search_corp_list_name").mouseenter(function () {
        $(this).css("color", "#1db5ee");
    });
    $(".search_corp_list_name").mouseleave(function () {
        $(this).css("color", "#000000");
    });
    $(".search_corp_list_name").click(function () {
        // var corp_id = document.getElementById($(this).attr("id")).innerText;
        var corp_id = $(this).attr("id").substr(5);
        window.location.href = 'http://localhost:8080/see_details.do?corp_id=' + corp_id;
    });
    $("#batchContact").click(function () {
        var corp_name = document.getElementById("search_input2").value;
        $.ajax({
            type: 'post',
            async: false,
            url: "batchContact.do",
            data: {"corp_name": corp_name},
            dataType: "json",
            success: function (result) {
                if (result) {
                    setTimeout("document.getElementById('showMessage1').style.display='inline'", 1);
                    document.getElementById("showMessageFont1").innerText = result;
                    setTimeout("document.getElementById('showMessage1').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：数据导出失败(企业部分信息为空)";
                setTimeout("document.getElementById('showMessage1').style.display='inline'", 1);
                document.getElementById("showMessageFont1").innerText = result;
                setTimeout("document.getElementById('showMessage1').style.display='none'", 4500);
            }
        });
    });

    $("#exportData").click(function () {
        var corp_name = document.getElementById("search_input2").value;
        $.ajax({
            type: 'post',
            async: false,
            url: "exportData.do",
            data: {"corp_name": corp_name},
            dataType: "json",
            success: function (result) {
                if (result) {
                    setTimeout("document.getElementById('showMessage1').style.display='inline'", 1);
                    document.getElementById("showMessageFont1").innerText = result;
                    setTimeout("document.getElementById('showMessage1').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：数据导出失败(企业部分信息为空)";
                setTimeout("document.getElementById('showMessage1').style.display='inline'", 1);
                document.getElementById("showMessageFont1").innerText = result;
                setTimeout("document.getElementById('showMessage1').style.display='none'", 4000);
            }
        });
    });
});


//查询到的企业详细信息
$(document).ready(function () {
    $('#search_button3').click(function () {
        var corp_name = document.getElementById("search_input3").value;
        window.location.href = 'http://localhost:8080/select_corpByName.do?key=' + corp_name;
    });
    $(".info_top_button").mouseenter(function () {
        $(this).css("border", "1px solid #1db5ee");
    });
    $(".info_top_button").mouseleave(function () {
        $(this).css("border", "1px solid #d1d4d6");
    });
    $(".operation_img").mouseenter(function () {
        $(this).css("background-color", "#1db5ee");
    });
    $(".operation_img").mouseleave(function () {
        $(this).css("background-color", "#ffffff");
    });
    $(".relationCorpDiv").mouseenter(function () {
        $(this).css("background-color", "#1db5ee");
        $(this).children("a").children("font").css("color", "#ffffff");
    });
    $(".relationCorpDiv").mouseleave(function () {
        $(this).css("background-color", "#ffffff");
        $(this).children("a").children("font").css("color", "gray");
    });
    $(".click_good").click(function () {
        var num = $(this).attr("id").substr(6);
        var element = document.getElementById("click_"+num);
        if(element.src != "http://localhost:8080/icon/red_good.png"){
            var good_num = parseInt(document.getElementById("good_num_"+num).innerText) + 1;
            document.getElementById("good_num_"+num).innerText = good_num;
            element.src = "icon/red_good.png";
        }else{
            alert("提示：该条点评您已点过赞！");
        }
    });
    $("#label1_good").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label1_bad").css("background-color") == "rgb(29, 181, 238)"){
            $("#label1_bad").css("background-color", "#d1d4d6");
        }
    });
    $("#label2_good").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label2_bad").css("background-color") == "rgb(29, 181, 238)"){
            $("#label2_bad").css("background-color", "#d1d4d6");
        }
    });
    $("#label3_good").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label3_bad").css("background-color") == "rgb(29, 181, 238)"){
            $("#label3_bad").css("background-color", "#d1d4d6");
        }
    });
    $("#label1_bad").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label1_good").css("background-color") == "rgb(29, 181, 238)"){
            $("#label1_good").css("background-color", "#d1d4d6");
        }
    });
    $("#label2_bad").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label2_good").css("background-color") == "rgb(29, 181, 238)"){
            $("#label2_good").css("background-color", "#d1d4d6");
        }
    });
    $("#label3_bad").click(function () {
        $(this).css("background-color", "#1db5ee");
        if($("#label3_good").css("background-color") == "rgb(29, 181, 238)"){
            $("#label3_good").css("background-color", "#d1d4d6");
        }
    });
    $("#user_submit").click(function () {
        var status = document.getElementById("login").innerHTML;
        if (status == "登录") {
            setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
            document.getElementById("showMessageFont2").innerText = "提示：您当前还未登录！";
            setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
        }else {
            var userId = document.getElementById("userId").innerHTML;
            var corpId = document.getElementById("CORP_ID").innerHTML;
            var evaluate_info = document.getElementById("evaluate_info").value;
            var label1 = 0;
            var label2 = 0;
            var label3 = 0;
            if($("#label1_good").css("background-color") == "rgb(29, 181, 238)"){label1 = 1;}
            if($("#label1_bad").css("background-color") == "rgb(29, 181, 238)"){label1 = 2;}
            if($("#label2_good").css("background-color") == "rgb(29, 181, 238)"){label2 = 1;}
            if($("#label2_bad").css("background-color") == "rgb(29, 181, 238)"){label2 = 2;}
            if($("#label3_good").css("background-color") == "rgb(29, 181, 238)"){label3 = 1;}
            if($("#label3_bad").css("background-color") == "rgb(29, 181, 238)"){label3 = 2;}
            if(userId != ""){
                var evaluate = "";
                $.ajax({
                    type: 'post',
                    async: false,
                    url: "userEvaluate.do",
                    data: {"corpId": corpId,"userId": userId,"evaluate_info": evaluate_info,"label1": label1,"label2": label2,"label3": label3},
                    dataType: "json",
                    success: function (result) {
                        if (result != "") {
                            evaluate = result;
                        }else{
                            setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                            document.getElementById("showMessageFont2").innerText = "提示：服务器内部错误！";
                            setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                        }
                    }
                });
                if(evaluate != ""){
                    window.location.href = 'http://localhost:8080/deleteCollect.do?userId=' + userId + '&corpId=' + corpId;
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = evaluate;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            }
        }

    });


    $('#collectCorp').click(function () {
        var corpId = document.getElementById("CORP_ID").innerText;
        var userId = document.getElementById("userId").innerText;
        $.ajax({
            type: 'post',
            async: false,
            url: "collectCorp.do",
            data: {"corpId": corpId, "userId": userId},
            dataType: "json",
            success: function (result) {
                if (result) {
                    var result = "提示：收藏成功，可点击昵称查看！";
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = result;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：收藏失败(当前没有登录)";
                setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                document.getElementById("showMessageFont2").innerText = result;
                setTimeout("document.getElementById('showMessage2').style.display='none'", 4500);
            }
        });
    });

    $('#attentionCorp').click(function () {
        var corpId = document.getElementById("CORP_ID").innerText;
        var userId = document.getElementById("userId").innerText;
        $.ajax({
            type: 'post',
            async: false,
            url: "attentionCorp.do",
            data: {"corpId": corpId, "userId": userId},
            dataType: "json",
            success: function (result) {
                if (result) {
                    var result = "提示：关注成功，可点击昵称查看！";
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = result;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：关注失败(当前没有登录)";
                setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                document.getElementById("showMessageFont2").innerText = result;
                setTimeout("document.getElementById('showMessage2').style.display='none'", 4500);
            }
        });
    });

    $('#downloadExcel').click(function () {
        var download_corp_id = document.getElementById("CORP_ID").innerText;
        $.ajax({
            type: 'post',
            async: false,
            url: "downloadExcel.do",
            data: {"download_corp_id": download_corp_id},
            dataType: "json",
            success: function (result) {
                if (result) {
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = result;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：数据导出失败(企业部分信息为空)";
                setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                document.getElementById("showMessageFont2").innerText = result;
                setTimeout("document.getElementById('showMessage2').style.display='none'", 4500);
            }
        });
    });

    $('#downloadPdf').click(function () {
        var download_corp_id = document.getElementById("CORP_ID").innerText;
        $.ajax({
            type: 'post',
            async: false,
            url: "downloadPdf.do",
            data: {"download_corp_id": download_corp_id},
            dataType: "json",
            success: function (result) {
                if (result) {
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = result;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：数据导出失败(企业部分信息为空)";
                setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                document.getElementById("showMessageFont2").innerText = result;
                setTimeout("document.getElementById('showMessage2').style.display='none'", 4500);
            }
        });
    });

    $('#modelClose').click(function () {
        $(".bg-model1").hide();
    });
    $('#mapClose').click(function () {
        $(".bg-model2").hide();
    });
    $('#personClose').click(function () {
        $(".bg-model3").hide();
    });

    //查看地图
    window.onload = function () {
        map.plugin(["AMap.ToolBar"], function () {
            map.addControl(new AMap.ToolBar());
        });
        if (location.href.indexOf('&guide=1') !== -1) {
            map.setStatus({scrollWheel: false})
        }
    }
    $('#see_Map').click(function () {
        var address = document.getElementById("CORP_ADDR2").innerText;
        var map = new AMap.Map("mapContainer", {
            resizeEnable: true
        });

        var geocoder = new AMap.Geocoder({
            // city: "010", //把范围限定在这个城市，不填的话默认：全国。
            // radius: 1000 //地图范围，不填的话默认：500。
        });
        //地理编码,返回地理编码结果
        geocoder.getLocation(address, function (status, result) {
            if (status === 'complete' && result.info === 'OK') {
                geocoder_CallBack(result, map);
            }
        });

        $(".bg-model2").show();
    });

    function addMarker(i, d, map) {
        var marker = new AMap.Marker({
            map: map,
            position: [d.location.getLng(), d.location.getLat()]
        });
        var infoWindow = new AMap.InfoWindow({
            content: d.formattedAddress,
            offset: {x: 0, y: -30}
        });
        marker.on("mouseover", function (e) {
            infoWindow.open(map, marker.getPosition());
        });
    }

    function geocoder_CallBack(data, map) {
        var resultStr = "";
        //地理编码结果数组
        var geocode = data.geocodes;
        for (var i = 0; i < geocode.length; i++) {
            //拼接输出html
            resultStr += "<span style=\"font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\">" + "<b>地址</b>：" + geocode[i].formattedAddress + "" + "&nbsp;&nbsp;<b>&nbsp;&nbsp;&nbsp;&nbsp;坐标</b>：" + geocode[i].location.getLng() + ", " + geocode[i].location.getLat() + "" + "<b>&nbsp;&nbsp;&nbsp;&nbsp;匹配级别</b>：" + geocode[i].level + "</span>";
            console.log(geocode[i].location.getLng() + ", " + geocode[i].location.getLat());
            addMarker(i, geocode[i], map);
        }
        map.setFitView();
        document.getElementById("mapResult").innerHTML = resultStr;
    }

    //查看疑似控股
    $('#seeSuspected').click(function () {
        var id = document.getElementById("CORP_ID").innerText;
        var operManName = document.getElementById("OPER_MAN_NAME").innerText;
        var corpName = document.getElementById("CORP_NAME").innerText;
        var operationName = document.getElementById("seeSuspectedFont").innerText;
        $(".bg-model1").show();
        document.getElementById("operationName").innerText = operationName;
        $('#sundryMaps').children("div").not("sundryMap0").css("display", "none");
        $("#sundryMap0").show();
        $("#sundryMap0Info").show();

        $.ajax({
            type: 'get',
            async: false,
            url: "getStockRatio.do",
            data: {"id": id, "operManName": operManName},
            dataType: "json",
            success: function (result) {
                if (result) {
                    var string = result.split(":");
                    console.log("姓名" + string[0]);
                    console.log("比例" + string[1]);
                    document.getElementById("Suspected_Name").innerHTML = string[0];
                    document.getElementById("Suspected_Percent").innerHTML = string[1];
                    document.getElementById("Suspected_Corp").innerHTML = corpName;
                }
            },
            error: function () {
                document.getElementById("Suspected_Name").innerHTML = '  ?  ';
                document.getElementById("Suspected_Percent").innerHTML = '  ?  ';
                document.getElementById("Suspected_Corp").innerHTML = corpName;
            }
        });

        var myChart = echarts.init(document.getElementById('sundryMap0'));
        var arrStock = [], arrStockmoney = [];
        var arrStockType = [];
        var Stock = [];

        function arrTest() {
            $.ajax({
                url: 'getCorpStock.do?corp_id2=' + id,
                type: 'post',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrStock.push(result[i].stockName);
                            arrStockmoney.push(result[i].stockCapi);
                            arrStockType.push(result[i].stockType);
                        }
                    }
                }
            })

            for (var k = 0; k < arrStock.length; k++) {
                if (arrStockType[k] == "大股东") {
                    Stock.push({
                        name: arrStock[k],
                        value: arrStockmoney[k],
                        itemStyle: {
                            color: '#b87070',

                        }
                    });
                } else if (arrStockType[k] == "自然人股东") {
                    Stock.push({
                        name: arrStock[k],
                        value: arrStockmoney[k],
                        itemStyle: {
                            color: '#73bc6c',

                        }
                    });
                } else if (arrStockType[k] == "企业股东") {
                    Stock.push({
                        name: arrStock[k],
                        value: arrStockmoney[k],
                        itemStyle: {
                            color: '#dd4649',

                        }
                    });
                }

            }
            return arrStock, arrStockmoney, arrStockType, Stock;
        }

        arrTest();
        option = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series: [
                {
                    name: '投资比例',
                    type: 'pie',
                    radius: [30, 110],
                    center: ['50%', 200],
                    roseType: 'area',
                    x: '50%',               // for funnel
                    max: 40,                // for funnel
                    data: Stock
                }
            ],
            toolbox: [
                {
                    show: true,
                    orient: 'vertical',
                    itemSize: 28,
                    itemGap: 25,
                    showTitle: true,
                    feature: {
                        saveAsImage: {
                            show: true,
                            title: '保存为图片',
                        },
                        restore: {
                            show: true,
                            title: '刷新',
                        },
                        dataView: {
                            show: true,
                            title: '数据视图',
                        },
                        dataZoom: {
                            show: true,
                            title: {
                                zoom: '区域缩放',
                                back: '区域缩放还原',
                            },
                        },
                        magicType: {
                            show: true,
                            title: {
                                line: '切换为折线图',
                                bar: '切换为柱状图',
                                stack: '切换为堆叠',
                                tiled: '切换为平铺',
                            },
                        },
                    },
                    top: '18%',
                    right: 15,
                }
            ],
        };

        myChart.setOption(option);
    });

    // 查看股权结构
    $('#seeStockMap').click(function () {
        var operationName = document.getElementById("seeStockMapFont").innerText;
        $(".bg-model1").show();
        document.getElementById("operationName").innerText = operationName;
        $('#sundryMaps').children("div").not("sundryMap1").css("display", "none");
        $("#sundryMap1").show();

        var myChart = echarts.init(document.getElementById('sundryMap1'));
        var arrcorpName = [];   //公司作为股东投资公司名
        var arrcorpNamemoney = [];   //公司作为股东投资公司股东占比
        var allnode = [];       //所有节点
        var alllink = [];       //所有连接线
        var arrStock = [];      //公司股东
        var corpname = document.getElementById("CORP_NAME").innerText;
        var first_line_corpname; //公司第一行名称
        var arrStockmoney = [];      //公司股东投资
        var regNo = document.getElementById("REG_NO").innerText;

        function arrTest1() {
            $.ajax({
                url: 'getStockAndDistByRegNo.do?corpRegNo=' + regNo,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrcorpName.push(result[i].corpName);
                            arrcorpNamemoney.push(result[i].paidCapi);
                        }
                    }
                }
            })

            var first_line_name;
            var names = [];
            //节点换行
            for (var i = 0; i < arrcorpName.length; i++) {
                var name = arrcorpName[i];
                if (name.length > 5) {
                    for (var j = 5; j < name.length; j++) {
                        first_line_name = name.substring(0, j) + "\n" + name.substring(j, j + 5) + "\n" + name.substring(j + 5, name.length);
                        break;
                    }
                } else {
                    first_line_name = name;
                }
                names.push(first_line_name)
            }

            // 根节点
            if (corpname.length > 5) {
                for (var j = 5; j < corpname.length; j++) {
                    first_line_corpname = corpname.substring(0, j) + "\n" + corpname.substring(j, j + 5) + "\n" + corpname.substring(j + 5, corpname.length);
                    break;
                }
            } else {
                first_line_corpname = corpname;
            }
            allnode.push({
                name: first_line_corpname,
                x: 450,
                y: 200
            })

            //根节点下方节点
            for (var i = 0; i < names.length; i++) {
                if (names.length % 2 == 0) {
                    if (i % 2 == 0) {
                        allnode.push({
                            name: names[i],
                            x: 400 - i / 2 * 100,
                            y: 280
                        })
                    } else {
                        allnode.push({
                            name: names[i],
                            x: 400 + (i + 1) / 2 * 100,
                            y: 280
                        })
                    }
                } else {
                    if (i % 2 == 0) {
                        allnode.push({
                            name: names[i],
                            x: 450 - i / 2 * 100,
                            y: 280
                        })
                    } else {
                        allnode.push({
                            name: names[i],
                            x: 450 + (i + 1) / 2 * 100,
                            y: 280
                        })
                    }
                }
            }

            //根节点下方节点连线
            for (var i = 0; i < names.length; i++) {
                alllink.push({
                    source: first_line_corpname,
                    target: names[i],
                    name: arrcorpNamemoney[i] + "%",
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#000000'

                        }
                    },
                })
            }
            return allnode, alllink
        }

        arrTest1();

        var id = document.getElementById("CORP_ID").innerText;

        function arrTest2() {
            $.ajax({
                url: 'getCorpStock.do?corp_id2=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrStock.push(result[i].stockName);
                            arrStockmoney.push(result[i].stockCapi);
                        }
                    }
                }
            })
            var first_line_name;
            var names = [];
            //节点换行
            for (var i = 0; i < arrStock.length; i++) {
                var name = arrStock[i];
                if (name.length > 5) {
                    for (var j = 5; j < name.length; j++) {
                        first_line_name = name.substring(0, j) + "\n" + name.substring(j, j + 5) + "\n" + name.substring(j + 5, name.length);
                        break;
                    }
                } else {
                    first_line_name = name;
                }
                names.push(first_line_name)
            }
            //根节点上方节点
            for (var i = 0; i < names.length; i++) {
                //循环定义节点位置
                if (names.length % 2 == 0) {
                    if (i % 2 == 0) {
                        allnode.push({
                            name: names[i],
                            x: 400 - i / 2 * 100,
                            y: 120
                        })
                    } else {
                        allnode.push({
                            name: names[i],
                            x: 400 + (i + 1) / 2 * 100,
                            y: 120
                        })
                    }
                } else {
                    if (i % 2 == 0) {
                        allnode.push({
                            name: names[i],
                            x: 450 - i / 2 * 100,
                            y: 120
                        })
                    } else {
                        allnode.push({
                            name: names[i],
                            x: 450 + (i + 1) / 2 * 100,
                            y: 120
                        })
                    }
                }
            }
            //根节点上方节点连线

            for (var i = 0; i < names.length; i++) {
                alllink.push({
                    source: names[i],
                    target: first_line_corpname,
                    name: arrStockmoney[i] + "%",
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#000000'

                        }
                    },
                })
            }
            return allnode, alllink
        }

        arrTest2();

        var option = {
            //title: { text: '关系图谱' },
            series: [
                {
                    type: 'graph',
                    top: 50,
                    width: "50%",
                    height: "auto",
                    layout: 'none',
                    symbolSize: 80,
                    roam: true,
                    focusNodeAdjacency: true,
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [4, 10],

                    draggable: true,
                    itemStyle: {
                        normal: {
                            color: '#1db5ee'
                        }
                    },
                    edgeLabel: {
                        normal: {
                            show: true,
                            formatter: function (x) {
                                return x.data.name;
                            }
                        }
                    },

                    label: {
                        normal: {
                            show: true,
                            textStyle: {}
                        }
                    },
                    data: allnode,
                    links: alllink
                }
            ],
            toolbox: [
                {
                    show: true,
                    orient: 'vertical',
                    itemSize: 28,
                    itemGap: 25,
                    showTitle: true,
                    feature: {
                        saveAsImage: {
                            show: true,
                            title: '保存为图片',
                        },
                        restore: {
                            show: true,
                            title: '刷新',
                        },
                        dataView: {
                            show: true,
                            title: '数据视图',
                        },
                        dataZoom: {
                            show: true,
                            title: {
                                zoom: '区域缩放',
                                back: '区域缩放还原',
                            },
                        },
                        magicType: {
                            show: true,
                            title: {
                                line: '切换为折线图',
                                bar: '切换为柱状图',
                                stack: '切换为堆叠',
                                tiled: '切换为平铺',
                            },
                        },
                    },
                    top: '18%',
                    right: 15,
                }
            ],
        };

        myChart.setOption(option);
    });

    // 查看投资族谱
    $('#seeInvestMap').click(function () {
        var operationName = document.getElementById("seeInvestMapFont").innerText;
        $(".bg-model1").show();
        document.getElementById("operationName").innerText = operationName;
        $('#sundryMaps').children("div").not("sundryMap2").css("display", "none");
        $("#sundryMap2").show();
        $("#sundryMap2Info").show();
        var chart;
        var id = document.getElementById("CORP_ID").innerText;
        var cname = document.getElementById("CORP_NAME").innerText;

        var arrStock = [];
        var arrStockCertificateNo = [];
        var arrDistName = [];
        var myChart = echarts.init(document.getElementById('sundryMap2'));
        var childrenStock = [];
        var childrenDist = [];
        var arrDist = [];

        function arrTest2() {
            $.ajax({
                url: 'getCorpStock.do?corp_id2=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrStock.push(result[i].stockName);
                            arrStockCertificateNo.push(result[i].certificateNo);
                        }
                    }
                }
            })
            return arrStock, arrStockCertificateNo;
        }
        arrTest2();

        function arrTest3() {
            $.ajax({
                url: 'getCorpDist.do?corp_id3=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrDist.push(result[i].distName);
                        }
                    }
                }
            })
            return arrDist
        }
        arrTest3();

        function arrTest4() {
            for (var m = 0; m < arrStockCertificateNo.length; m++) {
                var name = arrStock[m];
                var sonStock = [];
                var certificateNo = arrStockCertificateNo[m];
                var arrStockName = [];
                $.ajax({
                    url: 'getCorpStockByStockCertificateNo.do?certificateNo=' + certificateNo,
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                arrStockName.push(result[i].stockName);
                            }
                        }
                    }
                })
                for (var j = 0; j < arrStockName.length; j++) {
                    sonStock.push({
                        name: arrStockName[j],
                    });
                }
                childrenStock.push({
                    "name": arrStock[m],
                    "children": sonStock
                });
            }
            return arrDist, childrenStock;
        }
        arrTest4();

        function arrTest5() {
            for (var m = 0; m < arrDist.length; m++) {
                var sonDist = [];
                var distName = arrDist[m];
                var arrdistname = [];
                $.ajax({
                    url: 'getCorpDistByDistName.do?distName=' + distName,
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                arrdistname.push(result[i].distName);
                            }
                        }
                    }
                })
                for (var j = 0; j < arrdistname.length; j++) {
                    sonDist.push({
                        name: arrdistname[j],
                    });
                }
                childrenDist.push({
                    "name": arrDist[m],
                    "children": sonDist
                });
            }
            return arrDist, childrenDist;
        }
        arrTest5();

        var data1 = {
            "name": cname,
            "children": [
                {
                    "name": "股东",
                    "children": childrenStock
                },
                {
                    "name": "对外投资",
                    "children": childrenDist
                }
            ]
        };
        var depth = 2;
        $("#distSelect").change(function(){
            var selected_val = document.getElementById("distSelect").value;
            console.log(selected_val);
            if(selected_val == "一层"){
                depth = 2;
                myChart.clear();
                setOptions();
            }else if(selected_val == "二层"){
                depth = 3;
                myChart.clear();
                setOptions();
            }else if(selected_val == "三层"){
                depth = 4;
                myChart.clear();
                setOptions();
            }else if(selected_val == "四层"){
                depth = 5;
                myChart.clear();
                setOptions();
            }
        });

        function setOptions() {
            myChart.setOption(option = {
                tooltip: {
                    trigger: 'item',
                    triggerOn: 'mousemove'
                },
                legend: {
                    top: '0%',
                    left: '32%',
                    orient: 'vertical',
                    data: [{
                        name: 'tree1',
                        icon: 'rectangle'
                    },
                        {
                            name: 'tree2',
                            icon: 'rectangle'
                        }],
                    borderColor: '#c23531'
                },
                series: [
                    {
                        type: 'tree',
                        data: [data1],
                        top: '5%',
                        left: '25%',
                        bottom: '2%',
                        right: '60%',
                        symbolSize: 7,
                        label: {
                            normal: {
                                position: 'left',
                                verticalAlign: 'middle',
                                align: 'right',
                                fontSize: 15            //标签文字大小
                            }
                        },
                        lineStyle: {
                            width: 4 //default value:2
                        },
                        leaves: {
                            label: {
                                normal: {
                                    position: 'right',
                                    verticalAlign: 'middle',
                                    align: 'left'
                                }
                            }
                        },
                        expandAndCollapse: true,
                        animationDuration: 550,
                        animationDurationUpdate: 750,
                        initialTreeDepth: depth
                    },
                ],
                toolbox: [
                    {
                        show: true,
                        orient: 'vertical',
                        itemSize: 28,
                        itemGap: 25,
                        showTitle: true,
                        feature: {
                            saveAsImage: {
                                show: true,
                                title: '保存为图片',
                            },
                            restore: {
                                show: true,
                                title: '刷新',
                            },
                            dataView: {
                                show: true,
                                title: '数据视图',
                            },
                            dataZoom: {
                                show: true,
                                title: {
                                    zoom: '区域缩放',
                                    back: '区域缩放还原',
                                },
                            },
                            magicType: {
                                show: true,
                                title: {
                                    line: '切换为折线图',
                                    bar: '切换为柱状图',
                                    stack: '切换为堆叠',
                                    tiled: '切换为平铺',
                                },
                            },
                        },
                        top: '18%',
                        right: 15,
                    }
                ],
            });
        }
        setOptions();
    });

    // 下载报告
    $('#downloadReport').click(function () {
        var download_corp_id = document.getElementById("CORP_ID").innerText;
        $.ajax({
            type: 'post',
            async: false,
            url: "downloadPdf.do",
            data: {"download_corp_id": download_corp_id},
            dataType: "json",
            success: function (result) {
                if (result) {
                    setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                    document.getElementById("showMessageFont2").innerText = result;
                    setTimeout("document.getElementById('showMessage2').style.display='none'", 3000);
                }
            },
            error: function () {
                var result = "提示：数据导出失败(企业部分信息为空)";
                setTimeout("document.getElementById('showMessage2').style.display='inline'", 1);
                document.getElementById("showMessageFont2").innerText = result;
                setTimeout("document.getElementById('showMessage2').style.display='none'", 4500);
            }
        });
    });

    // 查看企业图谱
    $('#seeCompanyMap').click(function () {
        var operationName = document.getElementById("seeCompanyMapFont").innerText;
        $(".bg-model1").show();
        document.getElementById("operationName").innerText = operationName;
        $('#sundryMaps').children("div").not("sundryMap3").css("display", "none");
        $("#sundryMap3").show();


        var myChart1 = echarts.init(document.getElementById('sundryMap3'));
        var arrPertains = [];  //存放高管
        var arrStock = [];     //存放股东
        var arrDist = [];      //存放分公司
        var allNode = [];    //存放所有节点
        var allLine = [];    //存放所有连接线
        var size = 40;
        var size1 = 20;
        var yy1 = 130;
        var id = document.getElementById("CORP_ID").innerText;
        var corpname = document.getElementById("CORP_NAME").innerText;

        function arrTest1() {
            $.ajax({
                url: 'getCorpPertains.do?corp_id1=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(1);
                    console.info(result);
                    console.info(1);
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrPertains.push(result[i].personName);
                        }
                    }
                }
            })
            allNode.push({
                name: corpname,
                x: 150,
                y: 200,
                symbolSize: 60,
                itemStyle: {
                    normal: {
                        color: '#1db5ee',
                    }
                },
                label: {
                    normal: {
                        position: 'inside',
                        fontSize: 16,
                        color: '#4B0082',
                    }
                },
                draggable: true
            })
            allNode.push({
                name: '公司股东',
                x: 10,
                y: 50,
                symbolSize: size,
                category: '公司股东',
                itemStyle: {
                    normal: {
                        color: '#EECFA1',
                    }
                },
                label: {
                    normal: {
                        position: 'inside',
                        fontSize: 15,
                        color: '#4B0082',
                    }
                },
                draggable: true
            })
            allNode.push({
                name: '公司高管',
                x: 10,
                y: 150,
                symbolSize: size,
                category: '公司高管',
                itemStyle: {
                    normal: {
                        color: '#FFC125',
                    }
                },
                label: {
                    normal: {
                        position: 'inside',
                        fontSize: 15,
                        color: '#4B0082',
                    }
                },
                draggable: true
            })
            allNode.push({
                name: '对外投资',
                x: 10,
                y: 150,
                symbolSize: size,
                category: '对外投资',
                itemStyle: {
                    normal: {
                        color: '#FF4040',
                    }
                },
                label: {
                    normal: {
                        position: 'inside',
                        fontSize: 15,
                        color: '#4B0082',
                    }
                },
                draggable: true
            })
            for (var i = 0; i < arrPertains.length; i++) {
                allNode.push({
                    name: arrPertains[i],
                    x: 10 + i * 10,
                    y: yy1,
                    symbolSize: size1,
                    category: '公司高管',
                    itemStyle: {
                        normal: {
                            color: '#FFEC8B',
                        }
                    },
                    draggable: true,
                });
            }

            allLine.push({
                source: corpname,
                target: '公司高管',
            });
            allLine.push({
                source: corpname,
                target: '公司股东',
            });
            allLine.push({
                source: corpname,
                target: '对外投资',
            });
            for (var i = 0; i < arrPertains.length; i++) {
                allLine.push({
                    source: '公司高管',
                    target: arrPertains[i],
                });
            }
            return arrPertains, allNode, allLine
        }

        arrTest1();

        function arrTest2() {
            $.ajax({
                url: 'getCorpStock.do?corp_id2=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(2);
                    console.info(result);
                    console.info(2);
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrStock.push(result[i].stockName);
                        }
                    }
                }
            })
            for (var j = 0; j < arrStock.length; j++) {
                allNode.push({
                    name: arrStock[j],
                    x: 120 + j * 10,
                    y: yy1,
                    symbolSize: size1,
                    category: '公司股东',
                    itemStyle: {
                        normal: {
                            color: '#FFEFDB',
                        }
                    },
                    draggable: true,
                });
            }
            for (var j = 0; j < arrStock.length; j++) {
                allLine.push({
                    source: '公司股东',
                    target: arrStock[j],
                });
            }
            return arrStock, allLine, allNode
        }

        arrTest2();

        function arrTest3() {
            $.ajax({
                url: 'getCorpDist.do?corp_id3=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info(3);
                    console.info(result);
                    console.info(3)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrDist.push(result[i].distName);
                        }
                    }
                }
            })
            for (var k = 0; k < arrDist.length; k++) {
                allNode.push({
                    name: arrDist[k],
                    x: 60 + k * 10,
                    y: yy1,
                    symbolSize: size1,
                    category: '对外投资',
                    itemStyle: {
                        normal: {
                            color: '#FF6A6A',
                        }
                    },
                    draggable: true,
                });
            }

            for (var k = 0; k < arrDist.length; k++) {
                allLine.push({
                    source: '对外投资',
                    target: arrDist[k],
                });
            }
            return arrDist, allNode, allLine
        }

        arrTest3();

        // 指定图表的配置项和数据

        if (allNode.length == 0 || allLine.length == 0) {
            document.getElementById("sundryMap3Message").style.display = 'inline';
        }
        var option = {
            tooltip: {
                formatter: '{b}'
            },
            series: [{
                name: '企业图谱',
                type: 'graph',
                top: 40,
                width: "50%",
                height: 450,
                layout: 'force',
                force: {
                    repulsion: 30,
                    gravity: 0.1,
                    edgeLength: 30,
                    layoutAnimation: true,
                },
                // 名称及对应位置
                data: allNode,
                // 对应关系
                links: allLine,
                // 大的节点名称
                categories: [{
                    'name': corpname
                }, {
                    'name': '公司高管'
                }, {
                    'name': '公司股东'
                }, {
                    'name': '对外投资'
                }],
                focusNodeAdjacency: true,
                roam: true,
                label: {
                    normal: {
                        show: true,
                        color: '#000000',
                        formatter: '{b}',
                        fontSize: 12,
                        fontStyle: '600',
                        position: 'top',
                    }
                },
                lineStyle: {
                    normal: {
                        width: 3,
                        color: 'source',
                        curveness: 0,
                        type: "solid"
                    }
                }
            }],
            toolbox: [
                {
                    show: true,
                    orient: 'vertical',
                    itemSize: 28,
                    itemGap: 25,
                    showTitle: true,
                    feature: {
                        saveAsImage: {
                            show: true,
                            title: '保存为图片',
                        },
                        restore: {
                            show: true,
                            title: '刷新',
                        },
                        dataView: {
                            show: true,
                            title: '数据视图',
                        },
                        dataZoom: {
                            show: true,
                            title: {
                                zoom: '区域缩放',
                                back: '区域缩放还原',
                            },
                        },
                        magicType: {
                            show: true,
                            title: {
                                line: '切换为折线图',
                                bar: '切换为柱状图',
                                stack: '切换为堆叠',
                                tiled: '切换为平铺',
                            },
                        },
                    },
                    top: '18%',
                    right: 15,
                }
            ],
        };

        myChart1.setOption(option);
    });

    // 查看疑似关系
    $('#seeRelationshipMap').click(function () {
        var operationName = document.getElementById("seeRelationshipMapFont").innerText;
        $(".bg-model1").show();
        document.getElementById("operationName").innerText = operationName;
        $('#sundryMaps').children("div").not("sundryMap4").css("display", "none");
        $("#sundryMap4").show();
        $("#sundryMap4Info").show();


        var myChart2 = echarts.init(document.getElementById('sundryMap4'));
        var personNameinfo = [];//高管姓名信息
        var personTypeinfo = [];//高管职位信息
        var corpNameinfo = [];//公司信息
        var distNameinfo = [];//分公司名
        var BranchPersonNameinfo = [];//分公司高管姓名信息
        var BranchPersonTypeinfo = [];//分公司高管职位信息
        var nodeinfo = [];//节点信息
        var lineinfo = [];//连接线信息
        var rootName;//接收新的根节点信息
        var distName = [];//更新后分公司节点
        var corpName = [];//更新后公司节点
        var allCorpName = [];//所有公司
        var arrdistname2 = [];//存放所有公司分公司的分公司
        var arrStockName = [];//存放公司的股东
        var id = document.getElementById("CORP_ID").innerText;
        var corpname = document.getElementById("CORP_NAME").innerText;

        //公司高管
        function arrTest1() {
            $.ajax({
                url: 'getCorpPertains.do?corp_id1=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info("公司高管")
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            personNameinfo.push(result[i].personName);
                            personTypeinfo.push(result[i].personType);
                        }
                    }
                }
            })

            if (corpname.length > 6) {
                for (var j = 6; j < corpname.length; j++) {
                    rootName = corpname.substring(0, j) + "\n" + corpname.substring(j, j + 5) + "\n" + corpname.substring(j + 5, corpname.length);
                    break;
                }
            } else {
                rootName = corpname;
            }

            nodeinfo.push({
                name: rootName,
                des: rootName,
                itemStyle: {
                    normal: {
                        color: '#4F94CD'
                    }
                }
            });
            for (var i = 0; i < personNameinfo.length; i++) {
                nodeinfo.push({
                    name: personNameinfo[i],
                    des: personNameinfo[i],
                    symbolSize: 50,
                    itemStyle: {
                        normal: {
                            color: 'red'
                        }
                    }
                });
            }
            for (var i = 0; i < personNameinfo.length; i++) {
                lineinfo.push({
                    active: true,
                    source: personNameinfo[i],
                    target: rootName,
                    name: personTypeinfo[i],
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#BF3EFF'

                        }
                    },
                });

            }
            return personNameinfo, nodeinfo, lineinfo, personTypeinfo, rootName
        }
        arrTest1();

        //根据公司高管查看公司名
        function arrTest2() {
            $.ajax({
                url: 'getCorpNameByPersonName.do?list=' + personNameinfo,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info("根据公司高管查看公司名")
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            corpNameinfo.push(result[i].corpName);
                            BranchPersonNameinfo.push(result[i].tcorppertains.personName);
                            BranchPersonTypeinfo.push(result[i].tcorppertains.personType);
                            allCorpName.push(result[i].corpName);
                        }
                    }
                }
            })

            var nodename;//节点赋值
            var name;//接收节点
            //节点换行
            for (var i = 0; i < corpNameinfo.length; i++) {
                var name = corpNameinfo[i];
                if (name.length > 6) {
                    for (var j = 6; j < name.length; j++) {
                        nodename = name.substring(0, j) + "\n" + name.substring(j, j + 6) + "\n" + name.substring(j + 6, name.length);
                        break;
                    }
                } else {
                    nodename = name;
                }
                corpName.push(nodename)
            }
            for (var i = 0; i < corpName.length; i++) {
                lineinfo.push({
                    source: BranchPersonNameinfo[i],
                    target: corpName[i],
                    name: BranchPersonTypeinfo[i],
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#BF3EFF'

                        }
                    },
                });

            }
            return corpNameinfo, BranchPersonNameinfo, BranchPersonTypeinfo, lineinfo, allCorpName
        }
        arrTest2();

        //分公司名
        function arrTest3() {
            $.ajax({
                url: 'getCorpDist.do?corp_id3=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info("分公司名")
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            distNameinfo.push(result[i].distName);
                        }
                    }
                }
            })
            var nodename;//节点赋值
            var name;//接收节点
            //节点换行
            for (var i = 0; i < distNameinfo.length; i++) {
                var name = distNameinfo[i];
                if (name.length > 6) {
                    for (var j = 6; j < name.length; j++) {
                        nodename = name.substring(0, j) + "\n" + name.substring(j, j + 6) + "\n" + name.substring(j + 6, name.length);
                        break;
                    }
                } else {
                    nodename = name;
                }
                distName.push(nodename)
            }
            for (var i = 0; i < distName.length; i++) {
                nodeinfo.push({
                    name: distName[i],
                    des: distName[i],
                    itemStyle: {
                        normal: {
                            color: '#388E8E'
                        }
                    }
                });
            }
            for (var i = 0; i < distName.length; i++) {
                lineinfo.push({
                    source: rootName,
                    target: distName[i],
                    name: '投资',
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#f41122'

                        }
                    },
                });

            }
            return distName, nodeinfo, lineinfo, distNameinfo, allCorpName
        }
        arrTest3();

        //公司股东
        function arrTest4() {
            $.ajax({
                url: 'getCorpStock.do?corp_id2=' + id,
                type: 'get',
                async: false,
                dataType: "json",
                success: function (result) {
                    console.info("公司股东")
                    console.info(result)
                    if (result) {
                        for (var i = 0; i < result.length; i++) {
                            arrStockName.push(result[i].stockName);
                        }
                    }
                }
            })
            var sonDist = [];
            var nodename;//节点赋值
            var name;//接收节点
            //节点换行
            for (var i = 0; i < arrStockName.length; i++) {
                var name = arrStockName[i];
                if (name.length > 6) {
                    for (var j = 6; j < name.length; j++) {
                        nodename = name.substring(0, j) + "\n" + name.substring(j, j + 5) + "\n" + name.substring(j + 5, name.length);
                        break;
                    }
                } else {
                    nodename = name;
                }
                sonDist.push(nodename)
            }
            for (var i = 0; i < arrStockName.length; i++) {
                nodeinfo.push({
                    name: sonDist[i],
                    des: sonDist[i],
                    symbolSize: 50,
                    itemStyle: {
                        normal: {
                            color: 'red'
                        }
                    }
                });
            }
            for (var i = 0; i < arrStockName.length; i++) {
                lineinfo.push({
                    active: true,
                    source: sonDist[i],
                    target: rootName,
                    name: "股东",
                    lineStyle: {
                        normal: {
                            width: 2,
                            color: '#BF3EFF'

                        }
                    },
                });

            }
            return personNameinfo, nodeinfo, lineinfo, personTypeinfo, arrStockName
        }
        arrTest4();

        //根据分公司查看分公司名
        function arrTest5() {
            for (var m = 0; m < distNameinfo.length; m++) {
                var arrdistname = distNameinfo[m];
                var arrdistname1 = [];
                $.ajax({
                    url: 'getCorpDistByDistName.do?distName=' + distNameinfo[m],
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info("根据分公司查看分公司名")
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                arrdistname1.push(result[i].distName);
                                arrdistname2.push(result[i].distName);
                            }
                        }
                    }
                })
                var sonDist = [];
                var nodename;//节点赋值
                var name;//接收节点
                //节点换行
                for (var i = 0; i < arrdistname1.length; i++) {
                    var name = arrdistname1[i];
                    if (name.length > 6) {
                        for (var j = 6; j < name.length; j++) {
                            nodename = name.substring(0, j) + "\n" + name.substring(j, j + 6) + "\n" + name.substring(j + 6, name.length);
                            break;
                        }
                    } else {
                        nodename = name;
                    }
                    sonDist.push(nodename)
                }

                var sonDist1 = [];
                var nodename1;//节点赋值
                var name1;//接收节点
                //节点换行

                var name1 = arrdistname;
                if (name1.length > 6) {
                    for (var j = 6; j < name1.length; j++) {
                        nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                        break;
                    }
                } else {
                    nodename1 = name1;
                }
                sonDist1.push(nodename1)


                for (var i = 0; i < sonDist.length; i++) {
                    nodeinfo.push({
                        name: sonDist[i],
                        des: sonDist[i],
                        itemStyle: {
                            normal: {
                                color: '#388E8E'
                            }
                        }
                    });
                }

                for (var i = 0; i < sonDist.length; i++) {
                    lineinfo.push({
                        source: sonDist1,
                        target: sonDist[i],
                        name: '投资',
                        lineStyle: {
                            normal: {
                                width: 2,
                                color: '#f41122'

                            }
                        }
                    });
                }

            }
            return lineinfo, nodeinfo, arrdistname2, allCorpName;
        }
        arrTest5();

        //根据分公司查看分公司名1
        function arrTest6() {
            for (var m = 0; m < arrdistname2.length; m++) {
                var sonDist = [];
                var sonDist1 = [];
                var arrdistname = [];
                var arrdistnames = arrdistname2[m];
                $.ajax({
                    url: 'getCorpDistByDistName.do?distName=' + arrdistname2[m],
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info("根据分公司查看分公司名1")
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                arrdistname.push(result[i].distName);
                            }
                        }
                    }
                })

                var nodename1;//节点赋值
                var name1;//接收节点
                //节点换行

                var name1 = arrdistnames;
                if (name1.length > 6) {
                    for (var j = 6; j < name1.length; j++) {
                        nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                        break;
                    }
                } else {
                    nodename1 = name1;
                }
                sonDist1.push(nodename1)


                var nodename;//节点赋值
                var name;//接收节点
                //节点换行
                for (var i = 0; i < arrdistname.length; i++) {
                    var name = arrdistname[i];
                    if (name.length > 6) {
                        for (var j = 6; j < name.length; j++) {
                            nodename = name.substring(0, j) + "\n" + name.substring(j, j + 6) + "\n" + name.substring(j + 6, name.length);
                            break;
                        }
                    } else {
                        nodename = name;
                    }
                    sonDist.push(nodename)
                }

                for (var i = 0; i < sonDist.length; i++) {
                    nodeinfo.push({
                        name: sonDist[i],
                        des: sonDist[i],
                        itemStyle: {
                            normal: {
                                color: '#388E8E'
                            }
                        }
                    });
                }
                for (var i = 0; i < sonDist.length; i++) {
                    lineinfo.push({
                        source: sonDist1,
                        target: sonDist[i],
                        name: '投资',
                        lineStyle: {
                            normal: {
                                width: 2,
                                color: '#f41122'

                            }
                        },
                    });

                }

            }
            return lineinfo, nodeinfo;
        }
        arrTest6();

        //根据公司股东查看公司名
        function arrTest8() {
            for (var m = 0; m < arrStockName.length; m++) {
                var sonDist = [];
                var sonDist1 = [];
                var stockCorp=[];
                $.ajax({
                    url: 'getCorpNameByOnePersonName.do?PersonName=' + arrStockName[m],
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info("根据公司股东查看公司名")
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                stockCorp.push(result[i].corpName);
                                oldstockCorp.push(result[i].corpName);
                            }
                        }
                    }
                })

                var nodename;//节点赋值
                var name;//接收节点
                //节点换行
                for (var i = 0; i < stockCorp.length; i++) {
                    var name = stockCorp[i];
                    if (name.length > 6) {
                        for (var j = 6; j < name.length; j++) {
                            nodename = name.substring(0, j) + "\n" + name.substring(j, j + 5) + "\n" + name.substring(j + 5, name.length);
                            break;
                        }
                    } else {
                        nodename = name;
                    }
                    sonDist.push(nodename)
                }

                var nodename1;//节点赋值
                //节点换行
                var name1 = arrStockName[m];
                if (name1.length > 6) {
                    for (var j = 6; j < name1.length; j++) {
                        nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 5) + "\n" + name1.substring(j + 5, name1.length);
                        break;
                    }
                } else {
                    nodename1 = name1;
                }
                sonDist1.push(nodename1)


                for (var i = 0; i < sonDist.length; i++) {
                    if(sonDist[i] != rootName ) {
                        for (var j = 0; j < oldstockCorp.length; j++) {
                            if (sonDist[i] != oldstockCorp[j] ) {
                                nodeinfo.push({
                                    name: sonDist[i],
                                    des: sonDist[i],
                                    itemStyle: {
                                        normal: {
                                            color: '#388E8E'
                                        }
                                    }
                                });
                            }
                            break;
                        }
                    }
                }
                for (var i = 0; i < sonDist.length; i++) {

                    lineinfo.push({
                        source: sonDist1,
                        target: sonDist[i],
                        name: "股东",
                        lineStyle: {
                            normal: {
                                width: 2,
                                color: '#BF3EFF'

                            }
                        },
                    });

                }
            }
            return corpNameinfo, BranchPersonNameinfo, BranchPersonTypeinfo, lineinfo, allCorpName

        }
        arrTest8();


        var option = {
            //title: { text: '关系图谱' },
            tooltip: {
                formatter: function (x) {
                    return x.data.des;
                }
            },
            series: [
                {
                    type: 'graph',
                    top: 25,
                    width: "auto",
                    height: "auto",
                    layout: 'force',
                    symbolSize: 80,
                    roam: true,
                    focusNodeAdjacency: true,
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [4, 10],
                    edgeLabel: {
                        normal: {
                            textStyle: {
                                fontSize: 20
                            }
                        }
                    },
                    force: {
                        repulsion: 2500,
                        edgeLength: [10, 50],
                        layoutAnimation: false
                    },
                    draggable: true,
                    itemStyle: {
                        normal: {
                            color: '#4b565b'
                        }
                    },

                    edgeLabel: {
                        normal: {
                            show: true,
                            formatter: function (x) {
                                return x.data.name;
                            }
                        }
                    },
                    label: {
                        normal: {
                            show: true,
                            textStyle: {}
                        }
                    },
                    data: nodeinfo,
                    links: lineinfo
                }
            ],
            toolbox: [
                {
                    show: true,
                    orient: 'vertical',
                    itemSize: 28,
                    itemGap: 25,
                    showTitle: true,
                    feature: {
                        saveAsImage: {
                            show: true,
                            title: '保存为图片',
                        },
                        restore: {
                            show: true,
                            title: '刷新',
                        },
                        dataView: {
                            show: true,
                            title: '数据视图',
                        },
                        dataZoom: {
                            show: true,
                            title: {
                                zoom: '区域缩放',
                                back: '区域缩放还原',
                            },
                        },
                        magicType: {
                            show: true,
                            title: {
                                line: '切换为折线图',
                                bar: '切换为柱状图',
                                stack: '切换为堆叠',
                                tiled: '切换为平铺',
                            },
                        },
                    },
                    top: '18%',
                    right: 15,
                }
            ],
        };
        myChart2.setOption(option);
    });
});

//查关系、千企地图界面
$(document).ready(function(){
    $('#relaLeftDiv1').click(function () {
        $(this).css("background-color","#1db5ee");
        $("#relaLeftDiv2").css("background-color","#ffffff");
        $("#relaLeftFont1").css("color","#ffffff");
        $("#relaLeftFont2").css("color","#000000");
    });
    $('#relaLeftDiv2').click(function () {
        $(this).css("background-color","#1db5ee");
        $("#relaLeftDiv1").css("background-color","#ffffff");
        $("#relaLeftFont2").css("color","#ffffff");
        $("#relaLeftFont1").css("color","#000000");
    });
    $("#map_corpName").mouseenter(function () {
        $(this).css("color","#1db5ee");
    });
    $("#map_corpName").mouseleave(function () {
        $(this).css("color","#000000");
    });

    $('#map_right').click(function () {
        $(this).css("display","none");
        $("#map_left").css("display","block");
        $("#mapCorpList").css("display","none");
        $("#mapCorpTable").css("display","block");

        $("#mapinfo_div").width($("#mapinfo_div").width() + 400);
        $("#mapCorp_div").width($("#mapCorp_div").width() - 400);
        $("#mapCorp_div").css("margin-left",400);
    });
    $('#map_left').click(function () {
        $(this).css("display","none");
        $("#map_right").css("display","block");
        $("#mapCorpTable").css("display","none");
        $("#mapCorpList").css("display","block");

        $("#mapinfo_div").width($("#mapinfo_div").width() - 400);
        $("#mapCorp_div").width($("#mapCorp_div").width() + 400);
        $("#mapCorp_div").css("margin-left",0);
    });

    //关系路径数
    var elem = document.querySelector('input[type="range"]');
    //获取一个想显示值的标签，并且初始化默认值
    var target = document.querySelector('.rangeNum');
    target.innerHTML = elem.value;
    var rangeValue = function(){
        var newValue = elem.value;
        target.innerHTML = newValue;
    }
    //绑定input监听事件
    elem.addEventListener("input", rangeValue);

    //开始分析
    $('#startAnalyze').click(function () {
        var selectA = document.getElementById("selectA").value;
        var selectB = document.getElementById("selectB").value;
        console.log(selectA + ":"+ selectB);
        if(selectA == "" || selectB == ""){
            setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
            document.getElementById("showMessageFont3").innerText = "提示：请选择人员！";
            setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
            $("#relaBackground").css("display","block");
        }else {
            var myChart2 = echarts.init(document.getElementById('relaEcharts'));
            var oneCorpNameinfo = [];//第一个人公司信息
            var twoCorpNameinfo = [];//第二个人公司信息
            var nodeinfo = [];//节点信息
            var lineinfo = [];//连接线信息
            var distName = [];//更新后分公司节点
            var onearrdistname = [];//第一家公司再投资公司
            var twoarrdistname = [];//第二家公司再投资公司
            var tempArray = [];//临时数组
            var corpName=[];//根据相同公司查询上一级公司——第二种方法
            var corpName1=[];//根据相同公司查询上一级公司——第三种方法

            nodeinfo.push({
                name: selectA,
                des: selectA,
                itemStyle: {
                    normal: {
                        color: '#1db5ee'
                    }
                }
            },{
                name: selectB,
                des: selectB,
                itemStyle: {
                    normal: {
                        color: '#1db5ee'
                    }
                }
            });
            //第一个人所有的投资公司
            function arrTest1() {
                $.ajax({
                    url: 'http://localhost:8080/getCorpNameByOnePersonName.do?PersonName=' + selectA,
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                oneCorpNameinfo.push(result[i].corpName);
                            }
                        }
                    }
                })

                return oneCorpNameinfo;
            }
            arrTest1();

            //第二个人所有的投资公司
            function arrTest2() {
                $.ajax({
                    url: 'http://localhost:8080/getCorpNameByOnePersonName.do?PersonName=' + selectB,
                    type: 'get',
                    async: false,
                    dataType: "json",
                    success: function (result) {
                        console.info(result)
                        if (result) {
                            for (var i = 0; i < result.length; i++) {
                                twoCorpNameinfo.push(result[i].corpName);
                            }
                        }
                    }
                })
                return twoCorpNameinfo;
            }
            arrTest2();

            //第一个人所有的投资公司的再投资公司
            function arrTest3() {
                for (var m = 0; m < oneCorpNameinfo.length; m++) {
                    var sonDist = [];
                    var sonDist1 = [];
                    $.ajax({
                        url: 'http://localhost:8080/getCorpDistByDistName.do?distName=' + oneCorpNameinfo[m],
                        type: 'get',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            console.info(result)
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    onearrdistname.push(result[i].distName);
                                }
                            }
                        }
                    })
                }
                return onearrdistname;
            }
            arrTest3();

            //第二个人所有的投资公司的再投资公司
            function arrTest4() {
                for (var m = 0; m < twoCorpNameinfo.length; m++) {
                    var sonDist = [];
                    var sonDist1 = [];

                    $.ajax({
                        url: 'http://localhost:8080/getCorpDistByDistName.do?distName=' + twoCorpNameinfo[m],
                        type: 'get',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            console.info(result)
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    twoarrdistname.push(result[i].distName);
                                }
                            }
                        }
                    })
                }
                return twoarrdistname;
            }
            arrTest4();

            //判断第一种相同情况 1=>2<=3
            function arrTest5() {
                //临时数组存放
                var tempArray1 = [];//临时数组1
                var tempArray2 = [];//临时数组2
                var sonDist = [];
                var sonDist1 = [];
                for(var i=0;i<oneCorpNameinfo.length;i++){
                    tempArray1[oneCorpNameinfo[i]]=true;//将数oneCorpNameinfo中的元素值作为tempArray1 中的键，值为true；
                }
                for(var i=0;i<twoCorpNameinfo.length;i++){
                    if(tempArray1[twoCorpNameinfo[i]]){
                        tempArray2.push(twoCorpNameinfo[i]);//得到twoCorpNameinfo 中与oneCorpNameinfo相同的元素；
                    }

                }
                var nodename1;//节点赋值
                var name1;//接收节点
                //节点换行
                for (var i = 0; i < tempArray2.length; i++) {
                    var name1 = tempArray2[i];
                    if (name1.length > 6) {
                        for (var j = 6; j < name1.length; j++) {
                            nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                            break;
                        }
                    } else {
                        nodename1 = name1;
                    }
                    sonDist1.push(nodename1)
                }
                for (var i = 0; i < sonDist1.length; i++) {
                    nodeinfo.push({
                        name: sonDist1[i],
                        des: sonDist1[i],
                        itemStyle: {
                            normal: {
                                color: '#388E8E'
                            }
                        }
                    });
                }
                for (var i = 0; i < sonDist1.length; i++) {
                    lineinfo.push({
                        source: "马云",
                        target: sonDist[i],
                        name: '投资',
                        lineStyle: {
                            normal: {
                                width: 2,
                                color: '#f41122'
                            }
                        },
                    });

                }
                for (var i = 0; i < sonDist1.length; i++) {
                    lineinfo.push({
                        source: "马化腾",
                        target: sonDist[i],
                        name: '投资',
                        lineStyle: {
                            normal: {
                                width: 2,
                                color: '#f41122'
                            }
                        },
                    });

                }

                return lineinfo, nodeinfo;
            }
            arrTest5();

            //判断第二种相同情况 1=>2=>3<=4<=5
            function arrTest6() {
                //临时数组存放
                var tempArray4 = [];//临时数组1
                for(var i=0;i<onearrdistname.length;i++){
                    tempArray4[onearrdistname[i]]=true;//将数oneCorpNameinfo中的元素值作为tempArray1 中的键，值为true；
                }
                for(var i=0;i<twoarrdistname.length;i++){
                    if(tempArray4[twoarrdistname[i]]){
                        tempArray.push(twoarrdistname[i]);//得到twoCorpNameinfo 中与oneCorpNameinfo相同的元素；
                    }
                }
                for (var m = 0; m < tempArray.length; m++) {
                    var one=[];
                    var two=[];
                    var tempArray1=[];
                    var sonDist = [];
                    var sonDist1 = [];
                    var sonDist2 = [];
                    $.ajax({
                        url: 'http://localhost:8080/getCorpNameByDistName.do?distName=' + tempArray[m],
                        type: 'get',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    corpName.push(result[i].corpName);
                                }
                            }
                        }
                    })
                    for(var i=0;i<corpName.length;i++){
                        tempArray1[corpName[i]]=true;//将数corpName中的元素值作为tempArray1 中的键，值为true；
                    }
                    for(var i=0;i<oneCorpNameinfo.length;i++){
                        if(tempArray1[oneCorpNameinfo[i]]){
                            one.push(oneCorpNameinfo[i]);//得到oneCorpNameinfo 中与corpName相同的元素；
                        }
                    }
                    for(var i=0;i<twoCorpNameinfo.length;i++){
                        if(tempArray1[twoCorpNameinfo[i]]){
                            two.push(twoCorpNameinfo[i]);//得到twoCorpNameinfo 中与corpName相同的元素；
                        }
                    }
                    var nodename1;//节点赋值
                    var name1;//接收节点
                    //节点换行
                    for(var i=0;i<one.length;i++){
                        var name1 = one[i];
                        if (name1.length > 6) {
                            for (var j = 6; j < name1.length; j++) {
                                nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                                break;
                            }
                        } else {
                            nodename1 = name1;
                        }
                        sonDist1.push(nodename1)
                    }

                    var nodename;//节点赋值
                    var name;//接收节点
                    //节点换行
                    for(var i=0;i<two.length;i++) {
                        var name = two[i];
                        if (name.length > 6) {
                            for (var j = 6; j < name.length; j++) {
                                nodename = name.substring(0, j) + "\n" + name.substring(j, j + 6) + "\n" + name.substring(j + 6, name.length);
                                break;
                            }
                        } else {
                            nodename = name;
                        }
                        sonDist.push(nodename)
                    }
                    var nodename2;//节点赋值
                    var name2;//接收节点
                    //节点换行

                    var name2 = tempArray[m];
                    if (name2.length > 6) {
                        for (var j = 6; j < name2.length; j++) {
                            nodename2 = name2.substring(0, j) + "\n" + name2.substring(j, j + 6) + "\n" + name2.substring(j + 6, name2.length);
                            break;
                        }
                    } else {
                        nodename2 = name2;
                    }
                    sonDist2.push(nodename2)


                    for (var i = 0; i < sonDist.length; i++) {
                        nodeinfo.push({
                            name: sonDist[i],
                            des: sonDist[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        nodeinfo.push({
                            name: sonDist1[i],
                            des: sonDist1[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist2.length; i++) {
                        nodeinfo.push({
                            name: sonDist2[i],
                            des: sonDist2[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist.length; i++) {
                        lineinfo.push({
                            source: sonDist[i],
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        },{
                            source: selectB,
                            target: sonDist[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        lineinfo.push({
                            source: sonDist1[i],
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        lineinfo.push({
                            source: selectA,
                            target: sonDist1[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }


                }
                return lineinfo, nodeinfo,tempArray;
            }
            arrTest6();

            var tempArray2=[];
            //判断第三种相同情况 1=>2=>3<=4
            function arrTest7() {
                //临时数组存放
                var tempArray3 = [];//临时数组3
                var corp_name;
                for(var i=0;i<onearrdistname.length;i++){
                    tempArray3[onearrdistname[i]]=true;//将数oneCorpNameinfo中的元素值作为tempArray1 中的键，值为true；
                }
                for(var i=0;i<twoCorpNameinfo.length;i++){
                    if(tempArray3[twoCorpNameinfo[i]]){
                        tempArray2.push(twoCorpNameinfo[i]);//得到twoCorpNameinfo 中与oneCorpNameinfo相同的元素；
                    }
                }
                for (var m = 0; m < tempArray2.length; m++) {
                    var one;
                    var tempArray1=[];
                    var sonDist = [];
                    var sonDist1 = [];
                    var sonDist2 = [];
                    $.ajax({
                        url: 'http://localhost:8080/getCorpNameByDistName.do?distName=' + tempArray2[m],
                        type: 'get',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    corpName1.push(result[i].corpName);
                                }
                            }
                        }
                    })
                    for(var i=0;i<corpName1.length;i++){
                        tempArray1[corpName1[i]]=true;//将数corpName中的元素值作为tempArray1 中的键，值为true；
                    }
                    for(var i=0;i<oneCorpNameinfo.length;i++){
                        if(tempArray1[oneCorpNameinfo[i]]){
                            one=oneCorpNameinfo[i];//得到oneCorpNameinfo 中与corpName相同的元素；
                        }
                    }
                    var nodename1;//节点赋值
                    var name1;//接收节点
                    //节点换行
                    var name1 = one;
                    if (name1.length > 6) {
                        for (var j = 6; j < name1.length; j++) {
                            nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                            break;
                        }
                    } else {
                        nodename1 = name1;
                    }
                    sonDist1.push(nodename1)

                    var nodename2;//节点赋值
                    var name2;//接收节点
                    //节点换行
                    var name2 = tempArray2[m];
                    if (name2.length > 6) {
                        for (var j = 6; j < name2.length; j++) {
                            nodename2 = name2.substring(0, j) + "\n" + name2.substring(j, j + 6) + "\n" + name2.substring(j + 6, name2.length);
                            break;
                        }
                    } else {
                        nodename2 = name2;
                    }
                    sonDist2.push(nodename2)


                    for (var i = 0; i < sonDist.length; i++) {
                        nodeinfo.push({
                            name: sonDist[i],
                            des: sonDist[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        nodeinfo.push({
                            name: sonDist1[i],
                            des: sonDist1[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist2.length; i++) {
                        nodeinfo.push({
                            name: sonDist2[i],
                            des: sonDist2[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist.length; i++) {
                        lineinfo.push({
                            source: sonDist[i],
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        },{
                            source: selectB,
                            target: sonDist[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        lineinfo.push({
                            source: selectA,
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }


                }
                return lineinfo, nodeinfo,tempArray2;
            }
            arrTest7();

            var tempArray5=[];
            //判断第三种相同情况 1=>2<=3<=4
            function arrTest8() {
                //临时数组存放
                var tempArray3 = [];//临时数组3
                var corp_name;
                for(var i=0;i<onearrdistname.length;i++){
                    tempArray3[onearrdistname[i]]=true;//将数oneCorpNameinfo中的元素值作为tempArray1 中的键，值为true；
                }
                for(var i=0;i<twoCorpNameinfo.length;i++){
                    if(tempArray3[twoCorpNameinfo[i]]){
                        tempArray5.push(twoCorpNameinfo[i]);//得到twoCorpNameinfo 中与oneCorpNameinfo相同的元素；
                    }
                }
                for (var m = 0; m < tempArray5.length; m++) {
                    var one;
                    var tempArray1=[];
                    var sonDist = [];
                    var sonDist1 = [];
                    var sonDist2 = [];
                    $.ajax({
                        url: 'http://localhost:8080/getCorpNameByDistName.do?distName=' + tempArray5[m],
                        type: 'get',
                        async: false,
                        dataType: "json",
                        success: function (result) {
                            if (result) {
                                for (var i = 0; i < result.length; i++) {
                                    corpName1.push(result[i].corpName);
                                }
                            }
                        }
                    })
                    for(var i=0;i<corpName1.length;i++){
                        tempArray1[corpName1[i]]=true;//将数corpName中的元素值作为tempArray1 中的键，值为true；
                    }
                    for(var i=0;i<oneCorpNameinfo.length;i++){
                        if(tempArray1[oneCorpNameinfo[i]]){
                            one=oneCorpNameinfo[i];//得到oneCorpNameinfo 中与corpName相同的元素；
                        }
                    }
                    var nodename1;//节点赋值
                    var name1;//接收节点
                    //节点换行
                    var name1 = one;
                    if (name1.length > 6) {
                        for (var j = 6; j < name1.length; j++) {
                            nodename1 = name1.substring(0, j) + "\n" + name1.substring(j, j + 6) + "\n" + name1.substring(j + 6, name1.length);
                            break;
                        }
                    } else {
                        nodename1 = name1;
                    }
                    sonDist1.push(nodename1)

                    var nodename2;//节点赋值
                    var name2;//接收节点
                    //节点换行
                    var name2 = tempArray5[m];
                    if (name2.length > 6) {
                        for (var j = 6; j < name2.length; j++) {
                            nodename2 = name2.substring(0, j) + "\n" + name2.substring(j, j + 6) + "\n" + name2.substring(j + 6, name2.length);
                            break;
                        }
                    } else {
                        nodename2 = name2;
                    }
                    sonDist2.push(nodename2)


                    for (var i = 0; i < sonDist.length; i++) {
                        nodeinfo.push({
                            name: sonDist[i],
                            des: sonDist[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        nodeinfo.push({
                            name: sonDist1[i],
                            des: sonDist1[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist2.length; i++) {
                        nodeinfo.push({
                            name: sonDist2[i],
                            des: sonDist2[i],
                            itemStyle: {
                                normal: {
                                    color: '#388E8E'
                                }
                            }
                        });
                    }
                    for (var i = 0; i < sonDist.length; i++) {
                        lineinfo.push({
                            source: sonDist[i],
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        },{
                            source: selectB,
                            target: sonDist[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }
                    for (var i = 0; i < sonDist1.length; i++) {
                        lineinfo.push({
                            source: selectA,
                            target: sonDist2[i],
                            name: '投资',
                            lineStyle: {
                                normal: {
                                    width: 2,
                                    color: '#f41122'
                                }
                            },
                        });
                    }


                }
                return lineinfo, nodeinfo,tempArray2;
            }
            arrTest8();

            console.log(nodeinfo);
            console.log(lineinfo);
            console.log("nodeinfo长度"+nodeinfo.length);
            console.log("lineinfo长度"+lineinfo.length);

            if(nodeinfo.length == 2 && lineinfo.length == 0){
                setTimeout("document.getElementById('showMessage3').style.display='inline'", 1);
                document.getElementById("showMessageFont3").innerText = "提示：暂无路径信息！";
                setTimeout("document.getElementById('showMessage3').style.display='none'", 1500);
                $("#relaBackground").css("display","block");
            }else{
                $("#relaBackground").css("display","none");
                var option = {
                    //title: { text: '关系图谱' },
                    tooltip: {
                        formatter: function (x) {
                            return x.data.des;
                        }
                    },
                    series: [
                        {
                            type: 'graph',
                            top: 25,
                            width: "auto",
                            height: "auto",
                            layout: 'force',
                            symbolSize: 80,
                            roam: true,
                            focusNodeAdjacency: true,
                            edgeSymbol: ['circle', 'arrow'],
                            edgeSymbolSize: [4, 10],
                            edgeLabel: {
                                normal: {
                                    textStyle: {
                                        fontSize: 20
                                    }
                                }
                            },
                            force: {
                                repulsion: 2500,
                                edgeLength: [10, 50],
                                layoutAnimation: false
                            },
                            draggable: true,
                            itemStyle: {
                                normal: {
                                    color: '#4b565b'
                                }
                            },

                            edgeLabel: {
                                normal: {
                                    show: true,
                                    formatter: function (x) {
                                        return x.data.name;
                                    }
                                }
                            },
                            label: {
                                normal: {
                                    show: true,
                                    textStyle: {}
                                }
                            },
                            data: nodeinfo,
                            links: lineinfo
                        }
                    ],
                    toolbox: [
                        {
                            show: true,
                            orient: 'vertical',
                            itemSize: 28,
                            itemGap: 25,
                            showTitle: true,
                            feature: {
                                saveAsImage: {
                                    show: true,
                                    title: '保存为图片',
                                },
                                restore: {
                                    show: true,
                                    title: '刷新',
                                },
                                dataView: {
                                    show: true,
                                    title: '数据视图',
                                },
                                dataZoom: {
                                    show: true,
                                    title: {
                                        zoom: '区域缩放',
                                        back: '区域缩放还原',
                                    },
                                },
                                magicType: {
                                    show: true,
                                    title: {
                                        line: '切换为折线图',
                                        bar: '切换为柱状图',
                                        stack: '切换为堆叠',
                                        tiled: '切换为平铺',
                                    },
                                },
                            },
                            top: '18%',
                            right: 15,
                        }
                    ],
                };
                myChart2.setOption(option);
            }
        }
    });
});
