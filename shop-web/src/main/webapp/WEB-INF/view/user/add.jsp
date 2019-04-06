<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/21
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册用户</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/ztree/css/zTreeStyle/zTreeStyle.css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/md5.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="/js/ztree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="/js/ztree/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="/js/ztree/js/jquery.ztree.exedit.js"></script>
</head>
<body>
<fieldset>
    <legend>注册用户</legend>

    <form class="form-horizontal" id="productForm" action="<%=request.getContextPath()%>/product/addProduct.jhtml"
          method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label class="col-md-2 control-label">用户名字:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="userName" placeholder="用户名字">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">用户密码:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="userPwd" placeholder="用户密码">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">真实名字:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="realName" placeholder="真实名字">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">生日:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="birthday" placeholder="生日">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">性别:</label>
            <div class="col-md-3">
                <label class="radio-inline">
                    <input type="radio" name="sex" value="1">男
                </label>
                <label class="radio-inline">
                    <input type="radio" name="sex" value="0">女
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">薪资:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="salary" placeholder="薪资">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">部门:</label>
            <div class="col-md-3">
                <ul id="deptTree" class="ztree"></ul>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">验证码:</label>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-5">
                        <input type="text" class="form-control" id="imgCode" placeholder="验证码">
                    </div>
                    <div class="col-md-7">
                        <img src="<%=request.getContextPath()%>/imgCode" onclick="refushImgCode(this)">点击图片刷新
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5" style="text-align: center">
                <button type="button" onclick="addUser()" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>添加</button>
            </div>
        </div>
    </form>
</fieldset>

<script type="text/javascript">
    $(function () {
        //初始化部门Tree
        initDeptTree();
    })
    function addUser() {
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
            url:"<%=request.getContextPath()%>/user/addUser.jhtml",
            type:"post",
            data:{
                "userName":v_userName,
                "userPwd":v_userPwd,
                "imgCode":v_imgCode
            },
            success:function (result) {
                if (result.code==200){
                    alert(result.msg);
                    location.href = "<%=request.getContextPath()%>/user/toMain.jhtml";
                }else{
                    alert(result.msg);
                }
            }
        })
    }
    //刷新验证码
    function refushImgCode(obj){
        var t = new Date();
        obj.src = "<%=request.getContextPath()%>/imgCode?t="+t;
    }
    //加载部门tree
    function initDeptTree() {
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid",
                },
                key: {
                    name: "deptName",
                }
            },
            check: {
                enable: true,
                chkboxType: { "Y": "ps", "N": "ps" }
            },

        };
        $.ajax({
            url: "<%=request.getContextPath()%>/dept/queryDeptList.jhtml",
            type: "post",
            success: function (result) {
                var zTree = $.fn.zTree.init($("#deptTree"), setting, result.data);
            },
            error: function (result) {
                $("#error").html(result.responseText);
            }
        })
    }

</script>

</body>
</html>
