<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工列表</title>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="/static/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!--员工修改 Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_update_name" class="col-sm-2 control-label">name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="emp_update_name" placeholder="name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_update_mobile" class="col-sm-2 control-label">mobile</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_mobile"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_update_age" class="col-sm-2 control-label">age</label>
                        <div class="col-sm-10">
                            <input type="text" name="age" class="form-control" id="emp_update_age" placeholder="age">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_update_input" value="1" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_update_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empType</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empType" id="empType1_update_input" value="1" checked> 普通员工
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empType" id="empType2_update_input" value="2"> 管理员
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="department.id" id="dept_update_select">

                            </select>
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



<!--员工添加 Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="emp_add_name" class="col-sm-2 control-label">name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="emp_add_name" placeholder="name">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_add_mobile" class="col-sm-2 control-label">mobile</label>
                        <div class="col-sm-10">
                            <input type="text" name="mobile" class="form-control" id="emp_add_mobile" placeholder="mobile">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_add_age" class="col-sm-2 control-label">age</label>
                        <div class="col-sm-10">
                            <input type="text" name="age" class="form-control" id="emp_add_age" placeholder="age">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_add_input" value="1" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empType</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empType" id="empType1_add_input" value="1" checked> 普通员工
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empType" id="empType2_add_input" value="2"> 管理员
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="department.id" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>




<div class="container">
    <!--标题-->
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
                    <li class="active"><a href="#">员工管理模块<span class="sr-only">(current)</span></a></li>
                    <li><a href="/views/device_list_after.jsp">资产管理模块</a></li>
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
        <div>
            <div class="col-md-2 col-md-offset-10">
                <button class="btn btn-default" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-default" id="emp_delete_all_btn">删除</button>
            </div>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>Id</th>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>手机号</th>
                        <th>员工类型</th>
                        <th>部门</th>
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

        var totalRecord,currentPage;
        //1.页面加载完以后,直接发送一个ajax请求,要到分页数据
        $(function(){
            //去首页
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url:"/employee/emps",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    //console.log(result);
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result){
            //清空table表格
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function(index,item){
                var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
                var IdTd=$("<td></td>").append(item.id);
                var nameTd=$("<td></td>").append(item.name);
                var ageTd=$("<td></td>").append(item.age);
                var sexTd=$("<td></td>").append(item.sex==1?"男":"女");
                var mobileTd=$("<td></td>").append(item.mobile);
                var empTypeTd=$("<td></td>").append(item.empType==1?"普通员工":"管理员");
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                /**
                 * <button class="btn btn-primary btn-sm">
                 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                 </button>
                 * */
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


                $("<tr></tr>").append(checkBoxTd).append(IdTd).append(nameTd).append(ageTd)
                        .append(sexTd).append(mobileTd).append(empTypeTd).append(deptNameTd)
                        .append(btnTd).appendTo("#emps_table tbody");
            });
        }
        //解决显示分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"记录数");
            totalRecord=result.extend.pageInfo.total;
            currentPage=result.extend.pageInfo.pageNum;
        }

        //解决显示分页条,点击分页要能去下一页
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

        function reset_form(ele) {
            //重置表单内容
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
            $("#dept_add_select").empty();
        }

        //点击新增按钮,弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //清除表单数据(表单完整重置:表单的数据,表单的样式)
            reset_form("#empAddModal form");
            //发送Ajax请求,查出部门信息,显示下拉列表
            getDepts("#dept_add_select");

            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });
        //查出所有的部门信息并显示下拉列表中
        function getDepts(ele) {
            $.ajax({
                url:"/dept/getDeptAll",
                type:"GET",
                success:function (result) {
                    $.each(result.extend.departments,function (index,item) {
                        var optionEle=$("<option></option>").append(item.deptName).attr("value",item.id);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        //校验表单数据
        function validate_add_form() {
            //1.拿到要校验的数据,使用正则表达式
            var empName=$("#emp_add_name").val();
            var regName=/(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)){
                //应该清空元素之前的样式
                show_validate_msg("#emp_add_name","error","用户名可以是2-5位中文或5-16位中英文数字的组合");
                return false;
            }else {
                show_validate_msg("#emp_add_name","success","");
            }
            var mobile=$("#emp_add_mobile").val();
            var regMobile = /^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8])|(19[7]))\d{8}$/;
            if (!regMobile.test(mobile)){
                //应该清空元素之前的样式
                show_validate_msg("#emp_add_mobile","error","手机号格式不正确");
                return false;
            }else {
                show_validate_msg("#emp_add_mobile","success","");
            }

            var age=$("#emp_add_age").val();
            var regAge = /^[0-9]{1,2}$/;
            if (!regAge.test(age)){
                //应该清空元素之前的样式
                show_validate_msg("#emp_add_age","error","年龄必须0-99岁");
                return false;
            }else {
                show_validate_msg("#emp_add_age","success","");
            }

            return true;
        }


        function show_validate_msg(ele,status,msg) {
            //清楚当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if ("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


        $("#emp_add_mobile").change(function () {
            //发送ajax请求校验用户名是否可用
            var mobile=this.value;
            $.ajax({
                url:"/employee/checkmobile",
                data:"mobile="+mobile,
                type:"POST",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg("#emp_add_mobile","success","手机号可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#emp_add_mobile","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });

        });

        //点击保存,保存员工
        $("#emp_save_btn").click(function () {
            //1.将模态框中填写的表单数据提交给服务器进行保存
            //1.先对要提交给服务器的数据进行校验
            if (!validate_add_form()){
                return false;
            }

            //判断之前的mobile校验是否成功,如果成功,往下继续,不成功,不可以点击保存
            if ($(this).attr("ajax-va")=="error"){
                return false;
            }

            //2.发送ajax请求保存员工
            $.ajax({
                url:"/employee/addEmployee",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                        //员工保存成功:
                        //1.关闭模态框
                        $('#empAddModal').modal('hide');
                        //2.来到最后一页,显示刚才保存的数据
                        //发送ajax请求显示最后一页数据
                        to_page(totalRecord);


                }
            });
        });

        //1。我们是按钮创建之前就绑定了click,所以绑定不上
        //1)可以在创建按钮的时候绑定 2)绑定点击.live(),新版本已经移除
        //使用on进行替代
        $(document).on("click",".edit_btn",function () {
            //1.查出部门信息,并显示部门列表
            getDepts("#dept_update_select");

            //2.查出员工信息,显示员工信息
            getEmp($(this).attr("edit-id"));

            //3.把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

            //4.弹出模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });


        function getEmp(id) {
            $.ajax({
                url:"/employee/getEmpById/"+id,
                type:"GET",
                success:function (result) {
                    var empData=result.extend.employee;

                    $("#emp_update_name").val(empData.name);
                    $("#emp_update_mobile").text(empData.mobile);
                    $("#emp_update_age").val(empData.age);
                    $("#empUpdateModal input[name=sex]").val([empData.sex]);
                    $("#empUpdateModal input[name=empType]").val([empData.empType]);
                    $("#dept_update_select").val([empData.department.id]);

                }
            });
        }


        //点击更新,更新员工信息
        $("#emp_update_btn").click(function () {
            //1.验证员工姓名是否合法
            var empName=$("#emp_update_name").val();
            var regName=/(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regName.test(empName)){
                //应该清空元素之前的样式
                show_validate_msg("#emp_update_name","error","用户名可以是2-5位中文或5-16位中英文数字的组合");
                return false;
            }else {
                show_validate_msg("#emp_update_name","success","");
            }
            //2.发送ajax请求保存员工数据
            $.ajax({
                url:"/employee/emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function () {
                    //1.关闭模态框
                    $("#empUpdateModal").modal('hide');
                    //2.回到本页面
                    to_page(currentPage);
                }
            });

        });



        //点击删除
        $(document).on("click",".delete_btn",function () {
            //1.弹出是否确认删除对话框
            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del-id");
            if (confirm("确认删除【"+empName+"】吗?")){
                //确认,发送ajax请求删除即可
                $.ajax({
                    url:"/employee/emp/"+empId,
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
        $("#emp_delete_all_btn").click(function () {
            var empNames="";
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id字符串
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除empName多余的,
            empNames=empNames.substring(0,empNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if (confirm("确认删除【"+empNames+"】")){
                //发送ajax请求
                $.ajax({
                    url:"/employee/emp/"+del_idstr,
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
