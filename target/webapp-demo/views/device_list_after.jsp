<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>资产列表</title>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/static/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工修改 Modal -->
<div class="modal fade" id="devUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改资产</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="dev_update_name" class="col-sm-2 control-label">资产设备</label>
                        <div class="col-sm-10">
                            <input type="text" name="devName" class="form-control" id="dev_update_name" placeholder="devName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">资产类型</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="devType" id="dev_update_select">

                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">资产状态</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="status" id="dev_update_status">
                                <option value="1">使用中</option>
                                <option value="2">未使用且无损坏</option>
                                <option value="3">维修中</option>
                                <option value="4">废弃</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_update_price" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="text" name="price" class="form-control" id="dev_update_price" placeholder="价格">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_update_x" class="col-sm-2 control-label">X:</label>
                        <div class="col-sm-10">
                            <input type="text" name="x" class="form-control" id="dev_update_x" placeholder="横坐标">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_update_y" class="col-sm-2 control-label">Y:</label>
                        <div class="col-sm-10">
                            <input type="text" name="y" class="form-control" id="dev_update_y" placeholder="纵坐标">
                            <span class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="dev_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工添加 Modal -->
<div class="modal fade" id="devAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加资产</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="dev_add_name" class="col-sm-2 control-label">资产设备</label>
                        <div class="col-sm-10">
                            <input type="text" name="devName" class="form-control" id="dev_add_name" placeholder="devName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">设备类型</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="devType" id="dev_type_select">

                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_add_price" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="text" name="price" class="form-control" id="dev_add_price" placeholder="价格">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_add_x" class="col-sm-2 control-label">X:</label>
                        <div class="col-sm-10">
                            <input type="text" name="x" class="form-control" id="dev_add_x" placeholder="横坐标">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dev_add_y" class="col-sm-2 control-label">Y:</label>
                        <div class="col-sm-10">
                            <input type="text" name="y" class="form-control" id="dev_add_y" placeholder="纵坐标">
                            <span class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="dev_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



    <div class="container">
        <h2 style="text-align: center">后台首页</h2>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <span class="navbar-brand">管理员</span>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="/views/list_json_after.jsp">员工管理模块<span class="sr-only">(current)</span></a></li>
                        <li class="active"><a href="#">资产管理模块</a></li>
                        <li><a href="/views/distribute_after.jsp">分配资产模块</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/views/index.jsp">注销</a></li>
                    </ul>
                    <p class="navbar-text navbar-right">
                        <font color="white">欢迎:${sessionScope.empName}</font>
                    </p>
                </div>
            </div>
        </nav>



        <!--按钮-->
        <div class="row">
                <div class="col-md-2 col-md-offset-10">
                    <button class="btn btn-default" id="dev_add_modal_btn">新增</button>
                    <button class="btn btn-default" id="dev_delete_all_btn">删除</button>
                </div>
        </div>
        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="device_table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>Id</th>
                        <th>资产设备</th>
                        <th>资产类型</th>
                        <th>价格</th>
                        <th>所处状态</th>
                        <th>坐标</th>
                        <th>所配员工</th>
                        <th>员工部门</th>
                        <th>操作</th>
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
        var totalRecord1,currentPage;

        $(function () {
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url:"/device/devByPage",
                data:"pn="+pn,
                type:"GET",
                success:function(result) {
                    //1.解析并显示资产数据
                    build_devs_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        //3.解析显示分页条数据
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul=$("<ul></ul>").addClass("pagination");
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));

            if (result.extend.pageInfoDev.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfoDev.pageNum-1);
                });
            }

            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

            if (result.extend.pageInfoDev.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //为元素添加翻页事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfoDev.pageNum+1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.pageInfoDev.pages);
                });
            }

            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);
            //遍历给ul中添加页码
            $.each(result.extend.pageInfoDev.navigatepageNums,function(index,item){
                var numLi=$("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfoDev.pageNum==item){
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

        //2.解析并显示分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfoDev.pageNum+"页,总"+result.extend.pageInfoDev.pages+"页,总"+result.extend.pageInfoDev.total+"记录数");
            totalRecord1=result.extend.pageInfoDev.total;
            currentPage=result.extend.pageInfoDev.pageNum;
        }

        //1.解析并显示资产数据
        function build_devs_table(result) {
            //清空table表格
            $("#device_table tbody").empty();
            var devs=result.extend.pageInfoDev.list;
            $.each(devs,function (index,item) {
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                var IdTd=$("<td></td>").append(item.id);
                var devNameTd=$("<td></td>").append(item.devName);
                //var devTypeTd=$("<td></td>").append(item.devType);
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
                //--------------------------------
                var itemStatus=item.status;
                var statusTd=$("<td></td>");
                switch (itemStatus){
                    case 1:statusTd.append("使用中");break;
                    case 2:statusTd.append("未使用且无损坏");break;
                    case 3:statusTd.append("维修中");break;
                    case 4:statusTd.append("废弃");break;
                    default:statusTd.append("未检测到..");break;

                }
                //-------------------------------------
                var coordinateTd=$("<td></td>").append("("+item.x+","+item.y+")");
                var empNameTd;
                var deptNameTd;
                if (item.emp==null){
                    empNameTd=$("<td></td>").append("");
                    deptNameTd=$("<td></td>").append("");
                }else{
                    empNameTd=$("<td></td>").append(item.emp.name);
                    deptNameTd=$("<td></td>").append(item.emp.department.deptName);
                }
                var editBtn=$("<button></button>").addClass("btn btn-default btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("编辑");
                //为编辑按钮添加一个自定义的属性,来表示当前员工id
                editBtn.attr("edit-id",item.id);
                var delBtn=$("<button></button>").addClass("btn btn-default btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                        .append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的员工id
                delBtn.attr("del-id",item.id);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);


                $("<tr></tr>").append(checkBoxTd).append(IdTd).append(devNameTd).append(devTypeTd)
                        .append(priceTd).append(statusTd).append(coordinateTd)
                        .append(empNameTd).append(deptNameTd).append(btnTd).appendTo("#device_table tbody");
            });

        }


        function reset_form(ele){
            //重置表单内容
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
            $("#dev_type_select").empty();
        }

        //点击新增按钮,弹出模态框
        $("#dev_add_modal_btn").click(function () {
            //清除表单数据(表单完整重置:表单的数据,表单的样式)
            reset_form("#devAddModal form");

            //发送Ajax请求,设备类型,显示出下拉列表
            getDevType("#dev_type_select");

            //弹出模态框
            $("#devAddModal").modal({
                backdrop:"static"
            });
        });

        function getDevType(ele) {
            $.ajax({
                url:"/device/getDevType",
                type:"GET",
                success:function (result) {
                    $.each(result.extend.devTypeValues,function (index,item) {
                        var optionEle=$("<option></option>").append(item).attr("value",(index+1));
                        optionEle.appendTo(ele);
                    });
                }
            });
        }


        //点击保存,保存资产
        $("#dev_save_btn").click(function () {
            //1.将模态框中填写的表单数据提交给服务器进行保存
            $.ajax({
                url:"/device/addDevice",
                type:"POST",
                data:$("#devAddModal form").serialize(),
                success:function (result) {
                    //员工保存成功:
                    //1.关闭模态框
                    $('#devAddModal').modal('hide');
                    //2.来到最后一页,显示刚才保存的数据
                    //发送ajax请求显示最后一页数据
                    to_page(totalRecord1);
                }
            });
        });


        //1。我们是按钮创建之前就绑定了click,所以绑定不上
        //1)可以在创建按钮的时候绑定 2)绑定点击.live(),新版本已经移除
        //使用on进行替代
        $(document).on("click",".edit_btn",function () {
            //1.查出资产类型,并显示资产列表
            getDevType("#dev_update_select");

            //2.查出资产信息,并显示
            getDev($(this).attr("edit-id"));

            //3.把员工的id传递给模态框的更新按钮
            $("#dev_update_btn").attr("edit-id",$(this).attr("edit-id"));

            //4.弹出模态框
            $("#devUpdateModal").modal({
                backdrop:"static"
            });

        });

        //查出资产信息
        function getDev(id) {
            $.ajax({
                url:"/device/getDevById/"+id,
                type:"GET",
                success:function (result) {
                    var devData=result.extend.device;

                    $("#dev_update_name").val(devData.devName);
                    $("#dev_update_select").val([devData.devType]);
                    $("#dev_update_status").val([devData.status]);
                    $("#dev_update_price").val(devData.price);
                    $("#dev_update_x").val(devData.x);
                    $("#dev_update_y").val(devData.y);

                }
            });
        }

        //点击更新
        $("#dev_update_btn").click(function () {
            $.ajax({
                url:"/device/dev/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#devUpdateModal form").serialize(),
                success:function (result) {
                    //1.关闭模态框
                    $("#devUpdateModal").modal('hide');
                    //2.回到本页面
                    to_page(currentPage);
                }
            });
        });


        //点击删除
        $(document).on("click",".delete_btn",function () {
            var devName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del-id");
            if (confirm("确认删除【"+devName+"】吗?")){
                //确认,发送ajax请求删除即可
                $.ajax({
                    url:"/device/dev/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }

        });


        //完成批量删除  ,全选、全不选
        $("#check_all").click(function () {

            $(".check_item").prop("checked",$(this).prop("checked"));

        });

        $(document).on("click",".check_item",function () {
            //判断当前选择中的元素是否5个
            var flag=$(".check_item:checked").length==$(".check_item").length;

            $("#check_all").prop("checked",flag);
        });

        //点击全部删除,就批量删除
        $("#dev_delete_all_btn").click(function () {
            var devNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                devNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id字符串
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除empName多余的,
            devNames=devNames.substring(0,devNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);

            if (confirm("确认删除【"+devNames+"】")){
                //发送ajax请求
                $.ajax({
                    url:"/device/dev/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                });
            }

        });

    </script>

</body>
</html>
