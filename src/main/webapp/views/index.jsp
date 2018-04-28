<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>测试</title>
        <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="/static/jquery-3.2.1/jquery-3.2.1.min.js"></script>
        <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <style>
            body{
                width:100%;
                height:auto;
                background-color: #c4e3f3;
            }
            .container{
                margin-top: 100px;
            }
        </style>

    </head>
    <body>
        <h2 style="text-align: center">单位资产管理系统</h2>
        <div class="container">
            <c:if test="${!empty requestScope.msg}">
                <font color="red">${requestScope.msg}</font>
            </c:if>
            <form class="form-horizontal" action="/employee/doLogin" method="post">

                <div class="form-group">
                    <label for="inputEmail3" class="col-md-2 control-label">mobile</label>
                    <div class="col-md-10">
                        <input type="text" name="mobile" class="form-control" id="inputEmail3" placeholder="用户名">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-md-2 control-label">Password</label>
                    <div class="col-md-10">
                        <input type="password"  name="password" class="form-control" id="inputPassword3" placeholder="密码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputValidaeCode3" class="col-md-2 control-label">ValidateCode</label>
                    <div class="col-md-5">
                        <input type="text" name="validateCode" class="form-control" id="inputValidaeCode3" placeholder="验证码">
                    </div>
                    <div class="col-md-5">
                        <img src="/validateCode" id="validateCodeBtn" class="img-thumbnail" width="30%" height="50%">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-offset-2 col-md-2">
                        <select class="form-control" name="mark">
                            <option value="1">前台</option>
                            <option value="0">后台</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-default">登录</button>
                    </div>
                </div>
            </form>

        </div>



        <script type="text/javascript">
            $("#validateCodeBtn").click(function () {
                $("#validateCodeBtn").attr("src","/validateCode?"+"date="+new Date().getTime());
            });


        </script>



    </body>
</html>
