<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        #allmap {width: 100%;height: 600px;overflow: hidden;margin:0;font-family:"微软雅黑";}
        #l-map{height:100%;width:78%;float:left;border-right:2px solid #bcbcbc;}
        #r-result{height:100%;width:20%;float:left;}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=VEeh0cK7CshgDnuG3otsHLGjywGaMUEo"></script>
    <title>地图</title>
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
                        <li><a href="/views/person_dev_front.jsp">自己资产情况</a></li>
                        <li><a href="#" id="li_btn1">所有员工资产情况</a></li>
                        <li class="active"><a href="#">资产定位</a></li>
                        <!--新增根据类型查看资产-->
                        <form class="navbar-form navbar-left" id="form_map_submit">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <select class="form-control" name="status" id="dev_status_select">
                                        <option value="1">个人资产定位</option>
                                        <option value="2">所有资产定位</option>
                                    </select>
                                </div>
                            </div>

                            <button type="button" class="btn btn-default" id="btn_map_submit">Search</button>
                        </form>
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

        <div id="allmap"></div>
    </div>

</body>
</html>
    <script type="text/javascript">

        var global_points=new Array();

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


        function Points(x,y) {
            this.X=x;
            this.Y=y;

        }

        $(function () {
            $.ajax({
                url:"/device/getDevsListByEmpId",
                type:"GET",
                async:false,
                success:function (result) {
                    var coordinates=result.extend.coordinates;
                    $.each(coordinates,function (index,item) {
                      // alert(index+" , "+item.x+" ,"+item.y);
                        var p=new Points(item.x,item.y);
                        global_points[index]=p;
                    })
                }
            });


            // 百度地图API功能
            var map = new BMap.Map("allmap");
            var point = new BMap.Point(116.404, 39.915);
            map.centerAndZoom(point, 15);
            // 编写自定义函数,创建标注
            function addMarker(point){
                var marker = new BMap.Marker(point);
                map.addOverlay(marker);
            }
            // 随机向地图添加25个标注
            var bounds = map.getBounds();
            var sw = bounds.getSouthWest();
            var ne = bounds.getNorthEast();
            var lngSpan = Math.abs(sw.lng - ne.lng);
            var latSpan = Math.abs(ne.lat - sw.lat);


            var opts = {
                position : point,    // 指定文本标注所在的地理位置
                offset   : new BMap.Size(0, -0.5)    //设置文本偏移量
            }
            var label = new BMap.Label("个人资产位置信息", opts);  // 创建文本标注对象
            label.setStyle({
                color : "#FF00FF",
                fontSize : "20px",
                height : "20px",
                lineHeight : "20px",
                fontFamily:"微软雅黑"
            });
            map.addOverlay(label);

            for (var i = 0; i < global_points.length; i ++) {

                var point = new BMap.Point(sw.lng + lngSpan * (Math.random() * 0.7), ne.lat - latSpan * (Math.random() * 0.7));
               //alert(global_points[i].X+" , "+global_points[i].Y);
                //var point = new BMap.Point(global_points[i].X,global_points[i].Y);
                addMarker(point);
            }


        });


        $("#li_btn1").click(function () {
            $.ajax({
                url:"/device/checkQualify",
                type:"GET",
                success:function (result) {
                    if (result.code==200){
                        alert(result.extend.msg);
                        window.location.href ="/views/map_front.jsp";
                    }else {
                        window.location.href ="/views/manager_dev_front.jsp";
                    }
                }
            });
        });


        $("#btn_map_submit").click(function () {
            $.ajax({
                url:"/device/checkQualify",
                type:"GET",
                success:function (result) {
                    if (result.code==200){
                        alert(result.extend.msg);
                        window.location.href ="/views/map_front.jsp";
                    }else {
                        window.location.href ="/views/map_all_front.jsp";
                    }
                }
            });
        });
    </script>
