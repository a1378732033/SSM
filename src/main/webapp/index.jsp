<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工管理系统</title>
<%
pageContext.setAttribute("App_PATH", request.getContextPath());
%>
<script type="text/javascript" src="${App_PATH}/static/js/jquery-3.4.1.js" ></script>
<link href="${App_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="${App_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
 
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" ">员工修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
  <div class="form-group">
    <label class="col-sm-2 control-label">empName</label>
    <div class="col-sm-10">
      <p class="form-control-static" id="empName_update_static"></p>
      <span class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">email</label>
    <div class="col-sm-10">
      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigui.com">
      <span class="help-block"></span>
    </div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label">gender</label>
    <div class="col-sm-10">
     <label class="radio-inline">
  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
</label>
<label class="radio-inline">
  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
</label>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">deptName</label>
    <div class="col-sm-4">
    <!-- 提交部门Id -->
     <select class="form-control" name="dId" >
  

     </select>
    </div>
  </div>
</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
  <div class="form-group">
    <label class="col-sm-2 control-label">empName</label>
    <div class="col-sm-10">
      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
      <span class="help-block"></span>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">email</label>
    <div class="col-sm-10">
      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigui.com">
      <span class="help-block"></span>
    </div>
  </div>
   <div class="form-group">
    <label class="col-sm-2 control-label">gender</label>
    <div class="col-sm-10">
     <label class="radio-inline">
  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
</label>
<label class="radio-inline">
  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
</label>
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label">deptName</label>
    <div class="col-sm-4">
    <!-- 提交部门Id -->
     <select class="form-control" name="dId" >
  

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
<!-- 显示页面 -->
<div class="container">
<!-- 标题 -->
  <div class="row">
    <div class="col-md-12">
    <h1>员工管理系统</h1>
    </div>
  </div>
<!-- 按钮 -->
  <div class="row">
  <div class="col-md-4 col-md-offset-8">
  <button class="btn btn-primary btn-sm" id="emp_add_modal_btn">新增</button>
  <button class="btn btn-danger btn-sm" id="emp_delete_all_btn">删除</button>
  </div>
  </div>
<!-- 显示数据 -->
  <div class="row">
  <div class="col-md-12"> 
  <table class="table table-hover" id="emps_table">
  <thead>
 <tr>
 <th><input type="checkbox" id="check_all"/> </th>
 <th>#</th>
 <th>empName</th>
 <th>gender</th>
 <th>email</th>
 <th>deparName</th>
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
  <div class="col-md-6" id="page_info_area">
  </div>
  <!-- 分页条 -->
  <div class="col-md-6 " id="page_nva_area">
  
  </div>
  </div>
</div>
<script type="text/javascript">
//发送ajax请求，要到分页数据
var curremtPage;
var totalRecord;
$(function(){
	to_page(1);
});
function to_page(pn){
	$.ajax({
		url:"${App_PATH}/emps",
		data:"pn="+pn,
		type:"GET",
		success:function(result){
		//解析表格数据	
		build_emps_table(result);
	    //解析显示分页信息
	    build_page_info(result);
	    //解析显示分页条数据
	    buid_page_nav(result);
		}
	});	
}
function build_emps_table(result){
$("#emps_table tbody").empty();
	var emps=result.extend.pageInfo.list;
	$.each(emps,function(index,item){
		var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>");
		var empIdTd= $("<td></td>").append(item.empId);
		var empNameTd= $("<td></td>").append(item.empName);		
		var genderTd= $("<td></td>").append(item.gender=="M"?"男":"女");
		var emailTd= $("<td></td>").append(item.email);
		var departmentTd= $("<td></td>").append(item.department.deptName);
		var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
		//添加一个自定义按钮表示当前删除员工的ID
		   editBtn.attr("edit-id",item.empId);
		var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
		//添加一个自定义按钮表示当前删除员工的ID
		   delBtn.attr("del-id",item.empId);
		var btntd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
		//var delBtn
	$("<tr></tr>").append(checkBoxTd).append(empIdTd)
	.append(empNameTd)
	.append(genderTd)
	.append(emailTd)
	.append(departmentTd)
	.append(btntd)
	.appendTo("#emps_table tbody");
	});
}
function build_page_info(result){
	$("#page_info_area").empty();
	$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页 ,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
	//末页
	totalRecord=result.extend.pageInfo.pages;
	//当前页
	curremtPage=result.extend.pageInfo.pageNum;
}
function buid_page_nav(result){
	$("#page_nva_area").empty();
	var ul=$("<ul></ul>").addClass("pagination");
	var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	var perPageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
	if(result.extend.pageInfo.hasPreviousPage==false){
		firstPageLi.addClass("disabled");
		perPageLi.addClass("disabled");
	}else{
		firstPageLi.click(function(){
			to_page(1);
		});
		 perPageLi.click(function(){
			 to_page(result.extend.pageInfo.pageNum-1);
		 });
	}
		var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
	var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
	if(result.extend.pageInfo.hasNextPage==false){
		nextPageLi.addClass("disabled");
		lastPageLi.addClass("disabled");
	}else{
		nextPageLi.click(function(){
			to_page(result.extend.pageInfo.pageNum+1);
		});
		lastPageLi.click(function(){
			to_page(result.extend.pageInfo.pages);
		});
	}
	
	
	//添加首页和前一页
	ul.append(firstPageLi).append(perPageLi);
	$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
		var numli=$("<li></li>").append($("<a></a>").append(item));
		if(result.extend.pageInfo.pageNum==item){
			numli.addClass("active");
		}
		numli.click(function(){
			to_page(item);
		});
			
		ul.append(numli);
	});
	ul.append(nextPageLi).append(lastPageLi);
	var navEle=$("<nav></nav>").append(ul);
	navEle.appendTo("#page_nva_area");
}
//重置表单方法
function reset_form(ele){
	//清空数据
	$(ele)[0].reset()
	//清空表单样式
	$(ele).find("*").removeClass("has-success has-error");
	$(ele).find(".help-block").text("");
}
//点击新增按钮弹出模态框
$("#emp_add_modal_btn").click(function(){
	//发出ajax请求，查出部门信息，显示在下拉列表
	reset_form("#empAddModal form");
//	$("#empAddModal form")[0].reset();
	getDepts("#empAddModal select");
	//弹出模态框
  $("#empAddModal").modal({
	  backdrop:"static"
   }
  );
});
//查出所有部门信息显示在下拉列表中
	function getDepts(ele){
	//清理之前数据
	$(ele).empty();
	$.ajax({
		url:"${App_PATH}/depts",
		type:"GET",
		success:function(result){
		
			//console.log(result)
			//depts: [{deptId: 1, deptName: "开发部"}, {deptId: 2, deptName: "测试部"}
			//$("empAddModal select").append()
			$.each(result.extend.depts,function(){
				
				var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
				optionEle.appendTo(ele);
			});
		}
	});	
	}
	//校验表单数据
	function validate_add_from(){
		//1拿到要校验的内容
		var empName=$("#empName_add_input").val();
		var  regName=/^[a-zA-Z0-9_-]{3,16}$|(^[\u2E80-\u9FFF]{2,5})/;
		if(!regName.test(empName)){
		
			show_validate_msg("#empName_add_input","error","用户名必须是2-5个中文或者3-16个字母组成");
			
			/*$("#empName_add_input").parent().addClass("has-error");
			$("#empName_add_input").next("span").text("用户名必须是2-5个中文或者3-16个字母组成");*/
		//alert("用户名必须是2-5个中文或者3-16个字母组成");
		return false;
		}else{
			
			show_validate_msg("#empName_add_input","success","");
			/*$("#empName_add_input").parent().addClass("has-success");
			$("#empName_add_input").next("span").text("用户名正确");*/
		}
		var email=$("#email_add_input").val();
		var regEmail=/^w{3}\.\w+\@\w+\.com+$/
		if(!regEmail.test(email)){
			show_validate_msg("#email_add_input","error","邮箱必须是www.字母@.com");
			/*$("#email_add_input").parent().addClass("has-error");
			$("#email_add_input").next("span").text("邮箱必须是www.字母@.comzuc");*/
			//alert("邮箱必须是www.字母@.comzuc");
			return false;
		}else{
			show_validate_msg("#email_add_input","success","邮箱正确");
			/*$("#email_add_inpu").parent().addClass("has-success");
			$("#email_add_input").next("span").text("邮箱正确");*/
		}
		
		return true;
	}
	//校验方法 
	function show_validate_msg(ele,status,msg){
		//先清除当前元素
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if("success"==status){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		}else if("error"==status){
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}
	//给员工姓名绑定一个change事件
	$("#empName_add_input").change(function(){
		//发送ajax请求校验用户名是否可用
		var empName=this.value;
		$.ajax({
			url:"${App_PATH}/checkuse",
			type:"POST",
		    data:"empName="+empName,
		    success:function(result){
		    	if(result.code==100){
		    	show_validate_msg("#empName_add_input","success","用户名正确");
		    	$("#emp_save_btn").attr("ajax-va","success");
		    	
		    	}else{
		    		show_validate_msg("#empName_add_input","error",result.extend.va_msg);
		    		$("#emp_save_btn").attr("ajax-va","error");
		    	}
		    }
		});
	});
	
	//保存按钮
	 $("#emp_save_btn").click(function(){
		 //1将模态框中填写的表达信息发过服务器
		 //2先给要提交给服务器的数据进行校验
		
		if(!validate_add_from()){		 	
			 return false;
		 };
		
		 if($(this).attr("ajax-va")=="error"){
			 return false;
		 }
		// 4发送ajax请求
		//提前form表单中的内容$("#empAddModal form").serialize();
		$.ajax({
			url:"${App_PATH}/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(result){
				//关闭模态框
				if(result.code==100){
				$("#empAddModal").modal("hide");
				//发ajax请求送显示最后一页
				to_page(totalRecord);
				}else{
					//显示失败信息
					//console.log(result);
					if(undefined!=result.extend.errorFields.email){
					show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
					}
                    if(undefined!=result.extend.errorFields.empName){
                    show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
					}
				}
			}
		});
	 });
	$(document).on("click",".delete_btn",function(){
		//alert($(this).parents("tr").find("td:eq(1)").text());
		var empName=$(this).parents("tr").find("td:eq(2)").text();
		var empId=$(this).attr("del-id");
		if(confirm("确认要删除["+empName+"]吗?")){
			//发送ajax请求
			$.ajax({
				url:"${App_PATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
				}
			});
		}
	});
	$(document).on("click",".edit_btn",function(){
		//1查出员工信息显示在模态框中
		getEmp($(this).attr("edit-id"));
		//2查出部门信息，并显示在模态框中
		getDepts("#empUpdateModal select");
		//3把员工id传递给模态框的更新按钮
		$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
		 $("#empUpdateModal").modal({
			  backdrop:"static"
		   }
		  );
	});
	function getEmp(id){
		$.ajax({
		  url:"${App_PATH}/emp/"+id,
		  type:"GET",
		  success:function(result){
			  var empDate=result.extend.emp;
			  $("#empName_update_static").text(empDate.empName);
			  $("#email_update_input").val(empDate.email);
			  $("#empUpdateModal input[name=gender]").val([empDate.gender]);
			  $("#empUpdateModal select").val([empDate.dId]);
		  }
		});
	}
	$("#emp_update_btn").click(function(){
		//验证邮箱是否合法
		
		var email=$("#email_update_input").val();
		var regEmail=/^w{3}\.\w+\@\w+\.com+$/
		if(!regEmail.test(email)){	
			show_validate_msg("#email_update_input","error","邮箱必须是www.字母@.com");	
			return false;
		}else{
			show_validate_msg("#email_update_input","success","邮箱正确");	
	
		}
		
		//发送ajax
		$.ajax({
			url:"${App_PATH}/emp/"+$(this).attr("edit-id"),
			type:"PUT",
			data:$("#empUpdateModal form").serialize(),
			success:function(result){
				$("#empUpdateModal").modal("hide");
				to_page(curremtPage);
			}
		});	
	});
	//完成全选 
	$("#check_all").click(function(){
		//alert($(this).prop("checked"));
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	$(document).on("click",".check_item",function(){
		//alert($(".check_item:checked").length);
		if($(".check_item:checked").length==5){
			$("#check_all").prop("checked",$(this).prop("checked"));	
		}
	});
	$("#emp_delete_all_btn").click(function(){
		var empNames="";
		var del_idstr="";
		$.each($(".check_item:checked"),function(){
			empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
			del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		empNames=empNames.substring(0,empNames.length-1);
		del_idstr=del_idstr.substring(0,del_idstr.length-1);
		if(confirm("确认删除["+ empNames+"]吗?")){
			//发送ajax请求
			$.ajax({
				url:"${App_PATH}/emp/"+del_idstr,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(curremtPage);
				}
			});
		}
	});
</script>
</body>
</html>