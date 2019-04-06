<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">

</head>
<body onkeydown="keyLogin()">

<form class="form-horizontal" id="productForm" style="padding: 5px">
	<div class="form-group">
		<label for="userName" class="col-md-5 control-label">用户名：</label>
		<div class="col-md-3">
			<input type="text" class="form-control" id="userName" placeholder="用户名">
		</div>
	</div>
	<div class="form-group">
		<label for="userPwd" class="col-md-5 control-label">用户密码：</label>
		<div class="col-md-3">
			<input type="text" class="form-control" id="userPwd" placeholder="用户密码">
		</div>
	</div>
	<div class="form-group">
		<label for="imgCode" class="col-md-5 control-label">验证码：</label>
		<div class="col-md-4">
			<div class="row">
				<div class="col-md-4">
					<input type="text" class="form-control" id="imgCode" placeholder="验证码">
				</div>
				<div class="col-md-7">
					<img src="<%=request.getContextPath()%>/imgCode" onclick="refushImgCode(this)">点击图片刷新
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="" class="col-md-5 control-label"></label>
		<div class="col-md-3">
			<button type="button" class="btn btn-primary" onclick="login();"><span class="glyphicon glyphicon-ok"></span>登陆</button>
			<button type="reset" class="btn btn-primary" ><span class="glyphicon glyphicon-refresh"></span>取消</button>
			<button type="button" class="btn btn-primary" onclick="addUser();"><span class="glyphicon glyphicon-plus"></span>新用户注册</button>
		</div>
	</div>
</form>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/md5.js"></script>

		<script type="text/javascript">
			//刷新验证码
			function refushImgCode(obj){
			    var t = new Date();
			   obj.src = "<%=request.getContextPath()%>/imgCode?"+t;
                /*document.getElementById("imgCode").src = "<%=request.getContextPath()%>/user/getImgCode.jhtml?"+t;*/
			}
			//登陆
			function login(){
                var v_userName = $("#userName").val();
                var v_userPwd = hex_md5($("#userPwd").val());
                var v_imgCode = $("#imgCode").val();
                //非空验证
				if (v_userName.length==0){
				    alert("用户名不能为空");
				    return;
				}
                if (v_userPwd.length==0){
                    alert("密码不能为空");
                    return;
                }
                if (v_imgCode.length==0){
                    alert("验证码不能为空");
                    return;
                }
                $.ajax({
					url:"<%=basePath%>user/login.jhtml",
					type:"post",
					data:{
						"userName":v_userName,
						"userPwd":v_userPwd,
						"imgCode":v_imgCode
					},
					success:function(data){
						if(data.code==200){
							location.href="<%=basePath%>user/toMain.jhtml";
						}else{
							alert(data.msg);
						}
					}
				})
			}
			//回车键登陆
			function keyLogin(){
				if(event.keyCode==13){
					login();
				}
			}
			//注册
			function addUser() {
				location.href = "<%=request.getContextPath()%>/user/toAddUser.jhtml";
            }
		</script>
</body>
</html>