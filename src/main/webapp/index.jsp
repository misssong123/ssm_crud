<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
	<meta charset="utf-8">
	<title>员工列表</title>
	<!-- 获取当前项目路径 -->
	<%
		pageContext.setAttribute("APP_PATH", request.getContextPath());
	%>

	<!--
    ---web路径;
    不以/开始的相对路径，找资源。以当前路径为基准，经常容易出现问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306);需要加上项目名
    http://localhost:3306/crud
     -->
	<!-- 引入jQuery -->
	<script type="text/javascript"
			src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
	<!-- 引入样式 -->
	<link
			href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
			rel="stylesheet">
	<script
			src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工编辑的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
	 aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">员工修改</h4>
			</div>
			<div class="modal-body">
				<!-- 表单信息 -->
				<form class="form-horizontal">
					<div class="form-group">
						<label  class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<p class="form-controller-static" id="empName_update"></p>
						</div>
					</div>
					<div class="form-group">
						<label for="email_update_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control"
								   id="email_update_input" placeholder="email@qust.com"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
																name="gender" id="gender1_update" value="M" checked="checked">
								男
							</label> <label class="radio-inline"> <input type="radio"
																		 name="gender" id="gender2_update" value="F"> 女
						</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">deptName</label>
						<div class="col-sm-4">
							<!-- 部门提交id即可 -->
							<select class="form-control" name="dId" id="depts_select_update">

							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="emp_update">更新</button>
			</div>
		</div>
	</div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
	 aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">员工新增</h4>
			</div>
			<div class="modal-body">
				<!-- 表单信息 -->
				<form class="form-horizontal">
					<div class="form-group">
						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<input type="text" name="empName" class="form-control"
								   id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="email_add_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control"
								   id="email_add_input" placeholder="email@qust.com">
                            <span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
																name="gender" id="gender1_add" value="M" checked="checked">
								男
							</label> <label class="radio-inline"> <input type="radio"
																		 name="gender" id="gender2_add" value="F"> 女
						</label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">deptName</label>
						<div class="col-sm-4">
							<!-- 部门提交id即可 -->
							<select class="form-control" name="dId" id="depts_select_add">

							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="emp_save">保存</button>
			</div>
		</div>
	</div>
</div>
<!-- 搭建显示页面 -->
<div class="container">
	<!-- 标题 -->
	<div class="row">
		<div class="col-md-12">
			<h1>SSM-CRUD</h1>
		</div>
	</div>
	<!--按钮  -->
	<div class="row">
		<div class="col-md-4 col-md-offset-10">
			<button class="btn btn-primary" id="emp_add">新增</button>
			<button class="btn btn-danger" id="btn_delete_all">删除</button>
		</div>
	</div>
	<!-- 显示数据 -->
	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover" id="emps_table">
				<thead>
				<tr>
					<th><input type="checkbox" id="check_all"></th>
					<th>#</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>

				</tbody>



			</table>
		</div>
	</div>
	<!-- 显示分页信息 -->
	<div class="row">
		<!-- 分页文字信息 -->
		<div class="col-md-6" id="page_info"></div>
		<!-- 分页条信息 -->
		<div class="col-md-6" id="page_nav"></div>
	</div>
</div>
<script type="text/javascript">
    //保存总记录数
    var totalRecord, currnRecord;
    //1.页面加载完成以后,直接去发送ajax请求,要到分页信息
    $(function() {
        //去首页
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url : "${APP_PATH}/emps",
            data : "pn=" + pn,
            type : "GET",
            dataType : "json",
            success : function(result) {

                //1.解析并显示员工数据

                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        });
    }
    //1.解析并显示员工数据
    function build_emps_table(result) {
        //提前清空
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        //便利函数
        $
            .each(
                emps,
                function(index, item) {
                    var checkTd = $("<td><input type='checkbox' class='check_item'/></td>");
                    var empIdTd = $("<td></td>").append(item.empId);
                    var genderTd = $("<td></td>").append(
                        item.gender == 'M' ? "男" : "女");
                    var empNameTd = $("<td></td>").append(
                        item.empName);
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(
                        item.dept.deptName);

                    var editBtn = $("<button></button>")
                        .addClass(
                            "btn btn-primary btn-sm btn-update")
                        .append(
                            $("<span></span>")
                                .addClass(
                                    "glyphicon glyphicon-pencil"))
                        .append("编辑");
                    //为编辑按钮添加id属性
                    editBtn.attr("update_id", item.empId);
                    var deleteBtn = $("<button></button>")
                        .addClass(
                            "btn btn-danger btn-sm btn-delete")
                        .append(
                            $("<span></span>")
                                .addClass(
                                    "glyphicon glyphicon-trash"))
                        .append("删除");
                    //为删除按钮添加id属性
                    deleteBtn.attr("update_id", item.empId);
                    var btnTd = $("<td></td>").append(editBtn)
                        .append(" ").append(deleteBtn);
                    $("<tr></tr>").append(checkTd).append(empIdTd)
                        .append(empNameTd).append(genderTd)
                        .append(emailTd).append(deptNameTd)
                        .append(btnTd).appendTo(
                        "#emps_table tbody");
                });
    }
    //2.解析并显示分页信息
    function build_page_info(result) {
        //提前清空
        $("#page_info").empty();
        $("#page_info").append(
            "当前第" + result.extend.pageInfo.pageNum + "页,总共"
            + result.extend.pageInfo.pages + "页,共有"
            + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currnRecord = result.extend.pageInfo.pageNum;
    }
    //3.解析并显示分页条
    function build_page_nav(result) {
        //提前清空
        $("#page_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var fristPage = $("<li></li>").append(
            $("<a></a>").append("首页").attr("href", "#"));
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            fristPage.addClass("disabled");
            prePage.addClass("disabled");
        } else {
            fristPage.click(function() {
                to_page(1);
            });
            prePage.click(function() {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPage = $("<li></li>")
            .append($("<a></a>").append("&raquo;"));
        var lastPage = $("<li></li>").append(
            $("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        } else {
            nextPage.click(function() {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPage.click(function() {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(fristPage).append(prePage);
        $.each(result.extend.pageInfo.navigatepageNums, function(index,
                                                                 item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function() {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPage).append(lastPage);
        var navEle = $("<nav></nav>").append(ul);

        $("#page_nav").append(navEle);

    }
    //清空样式
    function reset_from(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has_error has_success");
        $(ele).find(".help-block").text("");

    }
    //显示模态框
    $("#emp_add").click(function() {
        //清空样式
        reset_from("#empAddModal form");
        //提前清空部门信息
        $("#depts_select_add").empty();
        //获取部门信息
        get_depts("#depts_select_add");
        //显示状态框
        $("#empAddModal").modal({
            backdrop : "static"
        });
    });
    //返回部门信息,显示在下拉菜单中
    function get_depts(ele) {

        $.ajax({
            url : "${APP_PATH}/depts",
            type : "GET",
            dataType : "json",
            success : function(result) {
                $.each(result.extend.depts, function() {
                    var optionEle = $("<option></option>").append(
                        this.deptName).attr("value", this.deptId);
                    $(ele).append(optionEle);
                });
            }
        });
    }
    //判断用户名是否合法
    $("#empName_add_input").change(
        function() {
            var empName = this.value;
            $.ajax({
                url : "${APP_PATH}/checkUser",
                data : "empName=" + empName,
                type : "POST",
                success : function(result) {
                    if (result.code == 100) {
                        validate_add_form_msg("#empName_add_input",
                            "success", result.extend.msg);
                        $("#emp_save").attr("ajax-vl", "success");
                    } else {
                        validate_add_form_msg("#empName_add_input",
                            "error", result.extend.va_msg);
                        $("#emp_save").attr("ajax-vl", "error");
                    }
                }
            });
        });
    //校验表单数据
    function validate_add_form() {
        //使用正则表达式校验数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,9}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {

            validate_add_form_msg("#empName_add_input", "error",
                "用户名可以是2-5位中文或者3-9位英文或数字的组合");

            return false;
        } else {
            validate_add_form_msg("#empName_add_input", "success", "");

        }
        //校验邮箱信息
        var email = $("#email_add_input").val();
        var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regemail.test(email)) {
            validate_add_form_msg("#email_add_input", "error", "邮箱格式不正确");

            return false;
        } else {
            validate_add_form_msg("#email_add_input", "success", "");

        }
        return true;
    }
    //添加样式
    function validate_add_form_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //保存员工数据
    $("#emp_save")
        .click(
            function() {
                //将信息保存在数据库中
                //判断信息是否符合规范
                if(!validate_add_form()){
                    return false;
                };
                if ($(this).attr("ajax-vl") == "error") {
                    return false;
                }
                //将表单信息序列化
                //alert($("#empAddModal form").serialize());
                //发送ajax请求

                $.ajax({
                        url : "${APP_PATH}/emp",
                        type : "POST",
                        data : $("#empAddModal form")
                            .serialize(),
                        dataType : "json",
                        success : function(result) {
                            if (result.code == 100) {
                                alert(result.msg);
                                //保存成功后,关闭模态框
                                $("#empAddModal").modal('hide');
                                //来到末页,显示刚才保存的数据
                                to_page(totalRecord);
                            } else {
                                if (undefined != result.extend.error.email) {
                                    validate_add_form_msg(
                                        "#email_add_input",
                                        "error",
                                        undefined == result.extend.error.email);
                                }
                                if (undefined != result.extend.error.empName) {
                                    validate_add_form_msg(
                                        "#empName_add_input",
                                        "error",
                                        undefined == result.extend.error.empName);
                                }
                            }

                        }
                    });

            });
    //点击修改按钮
    $(document).on("click", ".btn-update", function() {
        var id = $(this).attr("update_id");
        reset_from("#empUpdateModal form");
        //提前清空部门信息
        $("#depts_select_update").empty();
        //获取员工信息,回显到表单中
        getEmp(id);
        //获取部门信息
        get_depts("#depts_select_update");
        //给更新按钮赋值
        $("#emp_update").attr("update_id", id);
        //显示状态框
        $("#empUpdateModal").modal({
            backdrop : "static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url : "${APP_PATH}/emp/" + id,
            type : "GET",
            success : function(result) {
                var empData = result.extend.emp;
                var empName = empData.empName;
                var email = empData.email;
                $("#empName_update").text(empName);
                $("#email_update_input").val(email);
                $("#empUpdateModal input[name=gender]").val(
                    [ empData.gender ]);
                $("#empUpdateModal select").val([ empData.dId ]);
            }
        });
    }
    //更新员工信息
    $("#emp_update")
        .click(
            function() {
                //校验邮箱信息
                var email = $("#email_update_input").val();

                var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regemail.test(email)) {
                    validate_add_form_msg("#email_update_input",
                        "error", "邮箱格式不正确");
                    return false;
                } else {
                    validate_add_form_msg("#email_update_input",
                        "success", "");
                }

                //发送更新员工的信息
                $.ajax({
                    url : "${APP_PATH}/emp/"
                        + $(this).attr("update_id"),
                    type : "PUT",
                    data : $("#empUpdateModal form").serialize(),
                    success : function(result) {
                        //关闭模态框

                        $("#empUpdateModal").modal('hide');
                        //回到本页面
                        to_page(currnRecord);
                    }
                });
            });
    //删除员工信息
    $(document).on("click", ".btn-delete", function() {
        //弹出是否删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("update_id");

        if (confirm("确认删除" + empName + "吗?")) {
            $.ajax({
                url : "${APP_PATH}/emp/" + empId,
                type : "DELETE",
                success : function(result) {
                    alert(result.msg);
                    to_page(currnRecord);
                }
            });
        }
    });
    //全选/全不选功能
    $("#check_all").click(function() {

        $(".check_item").prop("checked", $(this).prop("checked"))
    });
    //单选按钮全选后,全选按钮选中
    $(document)
        .on(
            "click",
            ".check_item",
            function() {

                var flag = $(".check_item:checked").length == $(".check_item").length;
                $("#check_all").prop("checked", flag);
            });
    $("#btn_delete_all").click(
        function() {
            var empNames = "";
            var empIds = "";
            $.each($(".check_item:checked"), function() {
                empNames += $(this).parents("tr").find("td:eq(2)")
                        .text()
                    + ",";
                empIds += $(this).parents("tr").find("td:eq(1)").text()
                    + "-";
            });
            empNames = empNames.substring(0, empNames.length - 1);
            empIds = empIds.substring(0, empIds.length - 1);

            if (confirm("确认删除【" + empNames + "】吗?")) {
                //发送ajax请求
                $.ajax({
                    url : "${APP_PATH}/emp/" + empIds,
                    type : "DELETE",
                    success : function(result) {
                        alert(result.msg);
                        to_page(currnRecord);
                        $("#check_all").prop("checked", false);
                    }

                });
            }
        });
</script>
</body>
</html>