<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="iview/iview.css">
    <script src="iview/vue.js"></script>
    <script src="iview/iview.min.js"></script>
    <script src="iview/jquery-3.4.1.min.js"></script>
    <style>
        #app { /*页面滑动*/
            overflow: auto;
            height: calc(100% - 100px);
        }

        .ivu-table { /*table自适应*/
            height: auto;
        }

        .ivu-icon { /*图标不对齐的情况*/
            line-height: unset;
        }

        /*上述可用于公共属性*/
        body {
            opacity: 0;
            animation: page-fade-in 1s forwards;
        }

        @keyframes page-fade-in {
            0% {
                opacity: 0
            }

            100% {
                opacity: 1
            }
        }

    </style>

</head>