<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>分配资产</title>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/static/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>



<!-- 资产分配 Modal -->
<div class="modal fade" id="devDistributeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">分配资产</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="dev_distribute_name" class="col-sm-2 control-label">资产设备</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="dev_distribute_name"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">分配部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dev_dept_select">

                            </select>
                        </div>
                    </div>
                    <!--动态形成员工姓名下拉表-->
                    <div class="form-group" id="form_emp_name">
                        <label class="col-sm-2 control-label">部门人员</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="empId" id="dev_empName_select">

                            </select>
                        </div>
                     </div>
                    
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="dev_distribute_btn">确定</button>
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
                        <li><a href="/views/device_list_after.jsp">资产管理模块</a></li>
                        <li class="active"><a href="#">分配资产模块</a></li>
                    </ul>
                    <!--新增根据类型查看资产-->
                    <form class="navbar-form navbar-left" id="form_submit">
                        <div class="form-group">
                            <div class="col-sm-4">
                                <select class="form-control" name="devType" id="dev_type_select">

                                </select>
                            </div>
                            <div class="col-sm-4">
                                <select class="form-control" name="status" id="dev_type_select1">
                                    <option value="0">所有</option>
                                    <option value="1">已分配</option>
                                    <option value="2">未分配</option>
                                </select>
                            </div>
                        </div>

                        <button type="button" class="btn btn-default" id="btn_submit">Search</button>
                    </form>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/views/index.jsp">注销</a></li>
                    </ul>
                    <p class="navbar-text navbar-right">
                        <font color="white">欢迎:${sessionScope.empName}</font>
                    </p>
                </div>
            </div>
        </nav>




        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="device_table">
                    <thead>
                    <tr>
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
        var devType_global,status_global;

        $(function () {
            //1.先查询出资产设备类型
            getDevType();

            to_page(1,0,1);

        });

        function getDevType() {
            $.ajax({
                url:"/device/getDevType",
                type:"GET",
                success:function (result) {
                    $.each(result.extend.devTypeValues,function (index,item) {
                        var optionEle=$("<option></option>").append(item).attr("value",(index+1));
                        optionEle.appendTo("#dev_type_select");
                    });
                }
            });
        }

        function to_page(devType,status,pn){
            devType_global=devType;
            status_global=status;
            $.ajax({
                url:"/device/devByTypeAndStatus",
                data:"devType="+devType+"&status="+status+"&pn="+pn,
                type:"POST",
                success:function (result) {
                    //1.解析并显示对应资产数据
                    build_devs_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条数据
                    build_page_nav(result);
                }

            });
        }

        function build_page_nav(result){
            $("#page_nav_area").empty();
            var ul=$("<ul></ul>").addClass("pagination");
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            var devs=result.extend.pageInfoDev.list;
            //alert(devs[0].devType);
            var options=$("#dev_type_select1 option:selected");
            //alert(options.val());
            if (result.extend.pageInfoDev.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    to_page(devs[0].devType,options.val(),1);
                });
                prePageLi.click(function () {
                    to_page(devs[0].devType,options.val(),result.extend.pageInfoDev.pageNum-1);
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
                    to_page(devs[0].devType,options.val(),result.extend.pageInfoDev.pageNum+1);
                });
                lastPageLi.click(function(){
                    to_page(devs[0].devType,options.val(),result.extend.pageInfoDev.pages);
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
                    to_page(devs[0].devType,options.val(),item);
                });
                ul.append(numLi);
            });

            //添加下一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");

        }

        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfoDev.pageNum+"页,总"+result.extend.pageInfoDev.pages+"页,总"+result.extend.pageInfoDev.total+"记录数");
            totalRecord1=result.extend.pageInfoDev.total;
            currentPage=result.extend.pageInfoDev.pageNum;
        }

        function build_devs_table(result){
            //清空table表格
            $("#device_table tbody").empty();
            var devs=result.extend.pageInfoDev.list;
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
                var statusTd=$("<td></td>")
                switch (itemStatus){
                    case 1:statusTd.append("使用中");break;
                    case 2:statusTd.append("未使用且无损坏");break;
                    case 3:statusTd.append("维修中");break;
                    case 4:statusTd.append("废弃");break;
                    default:statusTd.append("未检测到..");break;

                }

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
                var editBtn=$("<button></button>").addClass("btn btn-default btn-sm distribute_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("分配");

                editBtn.attr("edit-id",item.id);
                //根据员工是否为null,为部门id赋值
                if (item.emp==null){
                    editBtn.attr("dept-id",0);
                }else {
                    editBtn.attr("dept-id",item.emp.department.id);
                }


                var btnTd=$("<td></td>").append(editBtn)

                $("<tr></tr>").append(IdTd).append(devNameTd).append(devTypeTd)
                        .append(priceTd).append(statusTd).append(coordinateTd)
                        .append(empNameTd).append(deptNameTd).append(btnTd).appendTo("#device_table tbody");

            });
        }

        
        $("#btn_submit").click(function () {
            $.ajax({
                url:"/device/devByTypeAndStatus",
                type:"POST",
                data:$("#form_submit").serialize(),
                success:function (result) {
                    var devs=result.extend.pageInfoDev.list;
                    var options=$("#dev_type_select1 option:selected");
                    to_page(devs[0].devType,options.val(),1);
                }
            });
        });

        $(document).on("click",".distribute_btn",function () {
            //把分配按钮的deviceid赋值给确定按钮
            $("#dev_distribute_btn").attr("edit-id",$(this).attr("edit-id"));
            //1.得到所有部门
            getDeptAll("#dev_dept_select",$(this).attr("dept-id"));

            //通过资产id得到部门和员工名
            getDeptAndempName($(this).attr("edit-id"));

            //2.弹出模态框
            $("#devDistributeModal").modal({
                backdrop:"static"
            });
        });
        
        
        function getDeptAll(ele,deptId) {
            $(ele).empty();
            $.ajax({
                url:"/dept/getDeptAll",
                type:"GET",
                success:function (result) {
                    $(ele).append($("<option></option>").append("请选择").attr("value",0));
                    $.each(result.extend.departments,function (index,item) {
                        var optionEle=$("<option></option>").append(item.deptName).attr("value",item.id);
                        optionEle.appendTo(ele);
                    });

                    $("#dev_empName_select").empty();
                    $.ajax({
                        url:"/employee/getEmpsBydeptId/"+deptId,
                        type:"GET",
                        success:function (result) {
                            $.each(result.extend.employees,function (index,item) {
                                var optionEle=$("<option></option>").append(item.name).attr("value",item.id);
                                optionEle.appendTo("#dev_empName_select");
                            });
                        }
                    });

                }
            });
        }


        //根据部门下拉框的事件,动态构建员工姓名下拉框
        $(document).on("change","#dev_dept_select",function () {
            //根据部门动态的显示该部门的员工
            $("#dev_empName_select").empty();
            var deptId=$(this).val();
            $.ajax({
                url:"/employee/getEmpsBydeptId/"+deptId,
                type:"GET",
                success:function (result) {
                    $.each(result.extend.employees,function (index,item) {
                        var optionEle=$("<option></option>").append(item.name).attr("value",item.id);
                        optionEle.appendTo("#dev_empName_select");
                    });
                }
            });
        });


        function getDeptAndempName(id) {
            $.ajax({
                url:"/device/getDevById/"+id,
                type:"GET",
                success:function (result) {
                    var devData=result.extend.device;
                    $("#dev_distribute_name").text(devData.devName);
                    $("#dev_dept_select").val([devData.emp.department.id]);
                    $("#dev_empName_select").val([devData.emp.id]);
                }
            });
        }

        //点击确定,把资产分配给员工
        $("#dev_distribute_btn").click(function () {

            if ($("#dev_dept_select").val()==0){
                return false;
            }

            //只把员工id和资产id传过去,部门id不需要,因为员工对象自带
            $.ajax({
                url:"/device/deviceToEmp",
                data:"deviceId="+$(this).attr("edit-id")+"&empId="+$("#dev_empName_select").val(),
                type:"GET",
                success:function (result) {
                    alert(result.extend.msg);
                    //1.关闭模态框
                    $('#devDistributeModal').modal('hide');
                    to_page(devType_global,status_global,currentPage);
                }
            });
        });

    </script>

</body>
</html>
