<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>前台首页</title>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/static/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!--修改密码模态框-->
<div class="modal fade" id="passwdUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_update_passwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="password" class="form-control" id="emp_update_passwd">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_update_rpasswd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="rpassword" class="form-control" id="emp_update_rpasswd">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>


<div class="container">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <span class="navbar-brand">
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    </span>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active">
                            <a href="#">
                                <font color="white">
                                    <c:if test="${empType==1}">
                                         普通员工:${empName}
                                     </c:if>
                                    <c:if test="${empType==2}">
                                        管理员:${empName}
                                    </c:if>
                                </font>
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>
                        <li><a href="/views/person_dev_front.jsp">自己资产情况</a></li>
                        <li><a href="#" id="li_btn1">所有员工资产情况</a></li>
                        <li><a href="/views/map_front.jsp">资产定位</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/views/index.jsp">注销</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" id="updatePassWd">修改密码</a></li>
                    </ul>

                </div>
            </div>
        </nav>

        <div class="jumbotron">
            <h1>Hello, world!</h1>
            <p>欢迎来到资产管理系统</p>
            <p>
                轻便、快捷、更高效
            </p>
            <p>
                <a class="btn btn-primary btn-lg" href="#" role="button">
                    <span class="glyphicon glyphicon-home" aria-hidden="true">
                    </span>
                </a>
            </p>
        </div>
        <div class="jumbotron">
            <p>
               让你的资产管理不再是烦恼
            </p>
            <p>
                <a class="btn btn-primary btn-lg" href="#" role="button">
                    <span class="glyphicon glyphicon-folder-open" aria-hidden="true">
                    </span>
                </a>
            </p>

        </div>
    </div>




    <script type="text/javascript">

        //点击修改密码
        $("#updatePassWd").click(function () {
            //弹出模态框
            $("#passwdUpdateModal").modal({
                backdrop:"static"
            });
        });

        //点击修改,修改密码
        $("#emp_update_btn").click(function () {
            $.ajax({
                url:"/employee/updatePasswd",
                data:$("#passwdUpdateModal form").serialize(),
                type:"POST",
                success:function (result) {
                    if (result.code==100){
                        alert(result.msg);
                        //关闭模态框
                        $('#passwdUpdateModal').modal('hide');
                    }else{
                        $("#emp_update_rpasswd").next("span").text(result.extend.msg);
                        $("#emp_update_rpasswd").parent().addClass("has-error");
                    }
                }
            });
        });

        $("#li_btn1").click(function () {
            $.ajax({
                url:"/device/checkQualify",
                type:"GET",
                success:function (result) {
                    if (result.code==200){
                        alert(result.extend.msg);
                        window.location.href ="/views/main_front.jsp";
                    }else {
                        window.location.href ="/views/manager_dev_front.jsp";
                    }
                }
            });
        });


    </script>

</body>
</html>
