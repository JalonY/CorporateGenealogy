<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="0;URL=search_corp.do">
<link rel="shortcut icon" type="image/x-icon" href="icon/logo.iso" media="screen" />
<title>千企查-企业信息查询_工商信息查询</title>
<style>
    body {
        background: #eef0f2;
        width: 100%;
        height: 100%;
    }

    .loading {
        text-transform: uppercase;
        font-family: 'Cabin Condensed', sans-serif;
        font-weight: bold;
        font-size: 100pt;
        text-align: center;
        height: 120px;
        line-height: 110px;
        vertical-align: bottom;
        position: absolute;
        left: 0;
        right: 0;
        top: 40%;
        bottom: 0;
        display: block;
    }


    @keyframes wave-animation {
        0% {
            background-position: 0 bottom;
        }

        100% {
            background-position: 200px bottom;
        }
    }
    @keyframes loading-animation {
        0% {
            background-size: 200px 0px;
        }

        100% {
            background-size: 200px 200px;
        }
    }
    .wave {
        background-image: url("icon/uFpLbYt.png");
        -moz-background-clip: text;
        -o-background-clip: text;
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        text-shadow: 0px 0px rgba(255, 255, 255, 0.06);
        animation: wave-animation 1s infinite linear, loading-animation 10s infinite linear alternate;
        background-size: 200px 100px;
        background-repeat: repeat-x;
        opacity: 1;
    }
</style>
<script src="js/prefixfree.min.js"></script>
</head>
<body>
    <div class="loading wave">
        Loading
    </div>
    <div style="position: absolute;top: 60%;width: 100%;text-align: center;border: none">
        <font size="5" color="#1db5ee">请稍等，千企查正在努力加载……</font>
    </div>
</body>
</html>