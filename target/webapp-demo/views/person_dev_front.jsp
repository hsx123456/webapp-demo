<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人资产情况</title>
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
                        <li>
                            <a href="/views/main_front.jsp">
                                <font color="#4682b4">
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
                        <li class="active"><a href="#">自己资产情况</a></li>
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



        <!--按钮-->
        <div class="row">
            <div>
                <div class="col-md-2 col-md-offset-10">
                    <button class="btn btn-primary" id="dev_export_modal_btn">资产导出</button>
                </div>
            </div>
        </div>

        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="devs_table">
                    <thead>
                    <tr>
                        <th>Id</th>
                        <th>资产设备</th>
                        <th>资产类型</th>
                        <th>价格</th>
                        <th>所处状态</th>
                        <th>坐标</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>

        <!--分页信息-->
        <div class="row">
            <!--分页文字信息-->
            <div class="col-md-6" id="page_info_area">

            </div>
            <!--分页条-->
            <div class="col-md-6" id="page_nav_area">

            </div>
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

        //1.页面加载完以后,直接发送一个ajax请求,要到分页数据
        $(function(){
            //去首页
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url:"/device/getDevsByempId?pn="+pn,
                type:"GET",
                success:function (result) {
                    //1.解析并显示员工数据
                    build_devs_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条数据
                    build_page_nav(result);

                }
            });
        }

        function build_devs_table(result) {
            //清空table表格
            $("#devs_table tbody").empty();
            var devs=result.extend.pageInfo.list;
            $.each(devs,function (index,item) {
                var IdTd=$("<td></td>").append(item.id);
                var devNameTd=$("<td></td>").append(item.devName);
                var itemDevType=item.devType;
                var devTypeTd=$("<td></td>");
                switch (itemDevType){
                    case 1:devTypeTd.append("手机资产");break;
                    case 2:devTypeTd.append("电脑资产");break;
                    case 3:devTypeTd.append("插线板资产");break;
                    case 4:devTypeTd.append("显示屏资产");break;
                    case 5:devTypeTd.append("共用资产");break;
                    case 6:devTypeTd.append("其他资产");break;
                    default:devTypeTd.append("未知资产");break;
                }
                var priceTd=$("<td></td>").append(item.price);

                var itemStatus=item.status;
                var statusTd=$("<td></td>");
                switch (itemStatus){
                    case 1:statusTd.append("使用中");break;
                    case 2:statusTd.append("未使用且无损坏");break;
                    case 3:statusTd.append("维修中");break;
                    case 4:statusTd.append("废弃");break;
                    default:statusTd.append("未检测到..");break;

                }
                var coordinateTd=$("<td></td>").append("("+item.x+","+item.y+")");

                $("<tr></tr>").append(IdTd).append(devNameTd).append(devTypeTd)
                        .append(priceTd).append(statusTd).append(coordinateTd)
                        .appendTo("#devs_table tbody");

            });

        }

        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"记录数");
        }

        function build_page_nav(result){
            $("#page_nav_area").empty();
            var ul=$("<ul></ul>").addClass("pagination");
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                });
            }

            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

            if (result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //为元素添加翻页事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);

            //遍历给ul中添加页码
            $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
                var numLi=$("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfo.pageNum==item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });

            //添加下一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //导出资产订单
        $("#dev_export_modal_btn").click(function () {
            $.ajax({
                url:"/device/exportDev",
                type:"GET",
                success:function (result) {
                    alert("已导出到桌面");
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
                        window.location.href ="/views/person_dev_front.jsp";
                    }else {
                        window.location.href ="/views/manager_dev_front.jsp";
                    }
                }
            });
        });

    </script>
</body>
</html>
