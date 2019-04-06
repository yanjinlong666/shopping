<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/26
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/common/headcss.jsp"></jsp:include>
</head>
<body>
    <%--按部门导出excel时动态提交参数的form--%>
    <form id="deptForm">
        <input type="hidden" name="idsStr"/>
    </form>
<%--条件查询--%>
<div class="container-fluid">
    <div class="row">
        <%--部门ztree展示--%>
        <div class="col-md-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    部门管理
                    <button type="button" class="btn btn-info" onclick="showAddDept();"><span class="glyphicon glyphicon-plus"></span>新增</button>
                    <button type="button" class="btn btn-info" onclick="editDept();"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                    <button type="button" class="btn btn-danger" onclick="delDept();"><span class="glyphicon glyphicon-remove"></span>删除</button>
                </div>
            </div>
            <ul id="deptTree" class="ztree"></ul>
        </div>
        <%--条件查询表单--%>
        <div class="col-md-9">
            <div class="panel panel-primary">
                <div class="panel-heading">条件查询</div>
                <form class="form-horizontal" id="productForm"  style="padding: 5px">
                    <div class="form-group">
                        <label for="userName" class="col-md-2 control-label">按照用户名：</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userName" class="col-md-2 control-label">按照薪资：</label>
                        <div class="col-md-3">
                            <div class="input-group">
                                <input type="text" id="salaryMin" class="form-control" placeholder="最小价格" aria-describedby="basic-addon1">
                                <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-yen"></span>
                    </span>
                                <input type="text" id="salaryMax" class="form-control" placeholder="最大价格" aria-describedby="basic-addon1">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-md-2 control-label">按照生日:</label>
                        <div class="col-md-3">
                            <div class="input-group">
                                <input type="text" id="birthdayMin" id="blrz-entry-date-start"
                                       class="form-control form_datetime" placeholder="开始时间" aria-describedby="basic-addon1">
                                <span class="input-group-addon" >
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                                <input type="text" id="birthdayMax"
                                       class="form-control form_datetime" placeholder="结束时间" aria-describedby="basic-addon1">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">按照状态：</label>
                        <div class="col-md-3">
                            <label class="radio-inline">
                                <input type="radio" name="status" value="1">正常
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="0">锁定
                            </label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-5" style="text-align: center">
                            <button type="button" class="btn btn-primary" onclick="search();"><span
                                    class="glyphicon glyphicon-ok"></span>搜索
                            </button>
                            <button type="reset" class="btn btn-default"><span
                                    class="glyphicon glyphicon-refresh"></span>重置
                            </button>
                        </div>
                    </div>
                    <input id="queryDeptIds" type="text"></input>
                </form>
            </div>
            <%--操作按钮--%>
            <div class="row" style="margin: 10px">
                <div class="col-md-5" style="text-align: left">
                    <button type="button" class="btn btn-info" onclick="addUser();"><span
                            class="glyphicon glyphicon-plus"></span>添加
                    </button>
                    <button type="button" class="btn btn-primary" onclick="updateUser();"><span
                            class="glyphicon glyphicon-pencil"></span>修改
                    </button>
                    <button type="button" class="btn btn-danger" onclick="deleteBatchUser();"><span
                            class="glyphicon glyphicon-remove"></span>批量删除
                    </button>
                    <button type="button" class="btn btn-primary" onclick="changeBatchDept();"><span
                            class="glyphicon glyphicon-refresh"></span>批量换部门
                    </button>
                    <button type="button" class="btn btn-primary" onclick="exportExcelByDept();"><span
                            class="glyphicon glyphicon-alt"></span>按部门导出excel
                    </button>
                </div>
            </div>

            <%--展示列表--%>
            <div class="panel panel-primary">
                <div class="panel-heading">展示列表</div>
                <table id="userTab" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th><input type="checkbox" onclick="checkAll(this)"/></th>
                        <th>序号</th>
                        <th>用户名</th>
                        <th>用户头像</th>
                        <th>用户真实名</th>
                        <th>生日</th>
                        <th>性别</th>
                        <th>薪资</th>
                        <th>部门</th>
                        <th>用户状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th><input type="checkbox"/></th>
                        <th>序号</th>
                        <th>用户名</th>
                        <th>用户头像</th>
                        <th>用户真实名</th>
                        <th>生日</th>
                        <th>性别</th>
                        <th>薪资</th>
                        <th>部门</th>
                        <th>用户状态</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <div id="error"></div>
        </div>
    </div>
</div>

    <jsp:include page="/WEB-INF/common/headerjs.jsp"></jsp:include>


    <script type="text/javascript">
        $(function () {
            //初始化用户表
            initUserTable();
            //初始化点击行事件
            initClickRow();
            //初始化部门ztree
            initDeptTree();
            //初始化日期组件
            initDateTimePicker();
            //初始化fileInput
            //initImage();
        })

        /**
         * 初始化添加用户图片文件域
         */
        function initAddHeaderImg (){
            var info = {
                //初始化上传文件框
                language: "zh",//配置语言
                showUpload : true,//显示整体上传的按钮
                showRemove : true,//显示整体删除的按钮
                uploadUrl: "/upload/uploadFile.jhtml",//这个是配置上传调取的后台地址，本项目是SSM搭建的
                allowedPreviewTypes : ['image'],
                allowedFileExtensions : ["jpg", "png","gif"],/*上传文件格式限制*/
            };
            $("#addHeaderImage").fileinput(info).on("fileuploaded", function (event, data, previewId, index) {
                if (data.response.code == 200){
                    $("#addHeaderImagePath",v_addUserDialog).val(data.response.data);
                }
            })
        }
        /**
         * 初始化修改用户图片文件域
         */
        function initEditHeaderImg (preview){
            var info = {
                //初始化上传文件框
                language: "zh",//配置语言
                showUpload : true,//显示整体上传的按钮
                showRemove : true,//显示整体删除的按钮
                uploadUrl: "/upload/uploadFile.jhtml",//这个是配置上传调取的后台地址，本项目是SSM搭建的
                allowedPreviewTypes : ['image'],
                allowedFileExtensions : ["jpg", "png","gif"],/*上传文件格式限制*/
                initialPreview: [preview],
                initialPreviewAsData: true,
            };
            $("#editHeaderImage").fileinput(info).on("fileuploaded", function (event, data, previewId, index) {
                if (data.response.code == 200){
                    $("#editHeaderImagePath",v_editUserDialog).val(data.response.data);
                }
            })
        }
        //按部门导出excel
        function exportExcelByDept() {
            //获取部门树
            var treeObj = $.fn.zTree.getZTreeObj("deptTree");
            //获取当前选中的节点
            var v_nodes = treeObj.getSelectedNodes();
            if (v_nodes.length != 1){
                bootbox.alert({
                    title: "",
                    message: "请选择一个部门",
                })
                return;
            }
            //后台处理  获取当前选中的节点的id
            var v_deptId = v_nodes[0].id;
            location.href = "<%=request.getContextPath()%>/user/exportExcelByDept.jhtml?id="+v_deptId;

            /*//前台处理 获取当前选中节点的下一级节点
            var childrenIdArr = [];
            var children = v_nodes[0].children;
            for (var i = 0; i < children.length; i++) {
                var childrenArr = treeObj.transformToArray(children[i]);
                var childIdArr = [];
                for (var j = 0; j < childrenArr.length; j++) {
                    childIdArr.push(childrenArr[j].id);
                }
                childrenIdArr.push(childIdArr);
            }
            //子节点的子子孙孙id转为字符串
            var v_ids = childrenIdArr.join(";");
            $("#deptForm input[type='hidden']").val(v_ids);
            //form表单动态提交
            $("#deptForm").get(0).action = "<%=request.getContextPath()%>/user/exportExcelByDept.jhtml";
            $("#deptForm").get(0).method = "post";
            $("#deptForm").get(0).submit();*/
        }

        //初始化用户表
        var v_initUserTable;
        function initUserTable(){
            v_initUserTable = $("#userTab").DataTable({
                //去掉搜索框
                "searching" : false,
                //自定义每页条数
                "lengthMenu":[5,10,15,20],
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "url":"<%=request.getContextPath()%>/user/queryUser.jhtml",
                    "type":"post"
                },
                "columns": [
                    {
                        "data":"id",
                        "orderable": "false",
                        "order": [],
                        render:function(data,type,row,meta){
                            return "<input type='checkbox' value='"+data+"'>"
                        }
                    },
                    {"data": "id"},
                    {"data": "userName"},
                    {
                        "data": "headerImage",
                        render: function (data) {
                            return '<img src="'+data+'" width="100px">';
                        }
                    },
                    {"data": "realName"},
                    {"data": "birthdayStr"},
                    {
                        "data": "sex",
                        render: function(data){
                            if(data==1){
                                return "男"
                            }else{
                                return "女"
                            }
                         }
                    },
                    {"data": "salary"},
                    {"data": "dept.deptName"},
                    {
                        "data": "status",
                        render: function (data) {
                            if (data==1){
                                return "正常"
                            } else{
                                return "锁定"
                            }
                        }
                    },
                    {
                        "data": "id",
                        render: function (data) {
                            return '<button type="button" onclick="window.event.cancelBubble=true;unLockUser(\'' + data + '\')" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-ok"></span>解锁账户</button>';
                        }
                    }
                ],
                //回调函数
                "fnDrawCallback":function () {
                    //保持翻页点击行选中
                    //获取当前页面所有行的复选框
                    $("tbody tr input[type='checkbox']").each(function () {
                        if(isExist($(this).val())){
                            //如果值存在于数组中
                            $(this).attr("checked",true);
                            $(this).closest("tr").css("background","yellow");
                            $(this).closest("tr").attr("flag",1);
                        }
                    })
                },
                //汉化
                language: {
                    url:"/js/DataTables-1.10.15/chinese.json",
                }
            });
        }
        //条件查询
        function search() {
            var json = {};
            json.userName = $("#userName").val();
            json.status = $("input[name='status']:checked").val();
            json.salaryMin = $("#salaryMin").val();
            json.salaryMax = $("#salaryMax").val();
            json.birthdayMin = $("#birthdayMin").val();
            json.birthdayMax = $("#birthdayMax").val();
            json.ids = $("#queryDeptIds").val();
            v_initUserTable.settings()[0].ajax.data = json;
            v_initUserTable.ajax.reload();
        }


        //回显判断
        function isExist(id) {
            for(var i=v_ids.length-1;i>=0;i--){
                if(v_ids[i]==id){
                    return true;
                }
            }
        }
        //初始化点击行
        var v_ids = [];
        //选中行的数据
        var v_rowData;
        function initClickRow(){
            $("tbody").on("click","tr",function () {
                //获取当前行选中状态
                var v_flag = $(this).attr("flag");
                //获取复选框
                var v_checkBox = $(this).find("input[type='checkbox']")[0];
                if(v_flag!=1){
                    //如果未选中，选中复选框，改变颜色，当前行复选框值加入数组
                    $(v_checkBox).attr("checked",true);
                    $(this).css("background","yellow");
                    v_ids.push(v_checkBox.value);
                    $(this).attr("flag",1);
                    //获取选中行的数据
                    v_rowData = v_initUserTable.row(this).data();
                }else{
                    //如果选中，取消选中复选框，取消颜色，当前行复选框值从数组删除
                    $(v_checkBox).attr("checked",false);
                    $(this).css("background","");
                    delIds(v_checkBox.value);
                    $(this).attr("flag",0);
                }
            })
        }
        //删除数组值的取消选中行的复选框值
        function delIds(id){
            for(var i=v_ids.length-1;i>=0;i--){
                if(v_ids[i]==id){
                    v_ids.splice(i,1);
                }
            }
        }

        //部门ztree展示
        function initDeptTree() {
            var setting = {
                data: {
                    simpleData: {
                        enable: true,
                        pIdKey: "pid",//对应实体类属性名
                    },
                    key: {
                        name: "deptName",//对应实体类属性名

                    }
                },
                check: {
                    enable: true,
                    chkboxType: { "Y": "s", "N": "s" }
                },
                treeNode:{
                    open: true
                },
                callback: {
                    onClick: zTreeOnClick
                }
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

        //添加部门
        function showAddDept() {
            var treeObj = $.fn.zTree.getZTreeObj("deptTree");
            //获取当前选中的节点
            var v_nodes = treeObj.getSelectedNodes();
            //只能选择一个部门添加子节点
            if(v_nodes.length!=1){
                bootbox.alert({
                    message: "请选择一个要添加的部门",
                })
                return;
            }
            //当前选中节点的id赋值给隐藏域pid
            var v_pid = v_nodes[0].id;
            $("#deptPid").attr("value",v_pid);
            //弹出添加框
            var v_addDialog = bootbox.dialog({
                title: '添加部门',
                //弹框内容
                message: $("#addDept").html(),
                size: 'middle',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger',
                        callback: function(){
                        }
                    },
                    ok: {
                        label: "添加",
                        className: 'btn-info',
                        //回调函数
                        callback: function(){
                            //获取添加页面表单信息
                            var v_pid = $("#deptPid",v_addDialog).val();
                            var v_deptName = $("#deptName",v_addDialog).val();
                            var v_remark = $("#remark",v_addDialog).val();
                            //发送ajax添加进数据库
                            $.ajax({
                                url: "<%=request.getContextPath()%>/dept/addDept.jhtml",
                                type: "post",
                                data: {
                                    "pid": v_pid,
                                    "deptName": v_deptName,
                                    "remark": v_remark
                                },
                                success:function (result) {
                                    //页面动态添加子节点
                                    var newNode = { id: result.data,
                                                    deptName: v_deptName,
                                                    pid: v_pid,
                                                    remark: v_remark};
                                    treeObj.addNodes(v_nodes[0],newNode);
                                }
                            })
                        }
                    }
                }
            })
        }
        //删除部门
        function delDept() {
            var treeObj = $.fn.zTree.getZTreeObj("deptTree");
            //获取选中的节点
            var v_nodes = treeObj.getSelectedNodes();
            if (v_nodes.length==0){
                bootbox.alert({
                    message: "请选择要删除的部门",
                })
                return;
            }
            bootbox.confirm({
                message: "确定要删除吗?",
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if(result){
                        //获取选中的节点下的所有子节点集合
                        var nodesArray = treeObj.transformToArray(v_nodes);
                        //遍历所有子节点拿到id存进数组
                        var idsArray = [];
                        for(var i = 0;i < nodesArray.length;i++){
                            idsArray.push(nodesArray[i].id);
                        }

                        $.ajax({
                            url:"<%=request.getContextPath()%>/dept/delDept.jhtml",
                            type:"post",
                            data:{
                                "ids":idsArray
                            },
                            success:function (result) {
                                if (result.code==200){
                                    bootbox.alert({
                                        message: "操作成功",
                                        callback: function(){
                                            for (var i = 0;i<v_nodes.length;i++){
                                                //删除选中节点的子节点
                                                treeObj.removeChildNodes(v_nodes[i]);
                                                //删除选中节点
                                                treeObj.removeNode(v_nodes[i]);
                                            }
                                        }
                                    })
                                }else{
                                    bootbox.alert({
                                        message: "操作失败",
                                    })
                                }
                            }
                        })
                    }
                }
            });
        }
        //修改部门
        function editDept() {
            var treeObj = $.fn.zTree.getZTreeObj("deptTree");
            var v_nodes = treeObj.getSelectedNodes();
            if (v_nodes.length != 1){
                bootbox.alert({
                    message: "请选择一个部门",
                })
                return;
            }
            //获取当前节点信息回显
            var v_id = v_nodes[0].id;
            var v_name = v_nodes[0].deptName;
            var v_remark = v_nodes[0].remark;
            $("#deptId").attr("value",v_id);
            $("#editDeptName").attr("value",v_name);
            $("#editRemark").text(v_remark);
            //弹出修改框
            var editDialog = bootbox.dialog({
                title: '修改部门',
                message: $("#editDept").html(),
                size: 'middle',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger',
                        callback: function(){

                        }
                    },
                    ok: {
                        label: "修改",
                        className: 'btn-info',
                        callback: function(){
                            var v_id = $("#deptId",editDialog).val();
                            var v_name = $("#editDeptName",editDialog).val();
                            var v_remark = $("#editRemark",editDialog).val();
                            var json = {};
                                json.id = v_id;
                                json.deptName = v_name;
                                json.remark = v_remark;
                            $.ajax({
                                url: "<%=request.getContextPath()%>/dept/updateDept.jhtml",
                                type: "post",
                                data: json,
                                success:function (result) {
                                    if (result.code==200){
                                        bootbox.alert({
                                            message: "操作成功",
                                            callback: function(){
                                                //在页面修改节点名
                                                v_nodes[0].deptName = v_name;
                                                v_nodes[0].remark = v_remark;
                                                treeObj.updateNode(v_nodes[0]);
                                            }
                                        })
                                    }else{
                                        bootbox.alert({
                                            message: "操作失败",
                                        })
                                    }
                                }
                            })
                        }
                    }
                }
            });
        }
        //添加用户
        var v_addUserDialog;
        function addUser() {
            //获取添加用户的弹出框
            var v_addDialogSource = $("#addUser").html();
            //弹出框的文件域初始化fileInput
            initAddHeaderImg();
            //初始化日期
            initDateTimePicker();
            //弹出添加框
            v_addUserDialog = bootbox.dialog({
                title: '添加用户',
                message: $("#addUser form"),
                size: 'large',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger',
                        callback: function(){
                        }
                    },
                    ok: {
                        label: "添加",
                        className: 'btn-info',
                        //回调函数
                        callback: function(){
                            //获取表单值
                            var v_deptId = $("#addDeptId",v_addUserDialog).val();//部门id
                            var v_addUserName = $("#addUserName",v_addUserDialog).val();
                            var v_addUserPwd = hex_md5($("#addUserPwd",v_addUserDialog).val());
                            var v_addRealName = $("#addRealName",v_addUserDialog).val();
                            var v_addBirthday = $("#addBirthday",v_addUserDialog).val();
                            var v_addSex = $("input[name='addSex']:checked",v_addUserDialog).val();
                            var v_addSalary = $("#addSalary",v_addUserDialog).val();
                            var v_headerImage = $("#addHeaderImagePath",v_addUserDialog).val();
                            $.ajax({
                                url: "<%=request.getContextPath()%>/user/addUserInfo.jhtml",
                                type: "post",
                                data: {
                                    "dept.id": v_deptId,
                                    "userName": v_addUserName,
                                    "userPwd": v_addUserPwd,
                                    "realName": v_addRealName,
                                    "birthday": v_addBirthday,
                                    "sex": v_addSex,
                                    "salary": v_addSalary,
                                    "headerImage": v_headerImage
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        bootbox.alert({
                                            message: "添加成功",
                                        })
                                        //重新加载
                                        v_initUserTable.ajax.reload();
                                    }
                                }
                            })
                        }
                    }
                }
            });
            //添加用户的弹出框重新赋值 不挪对象不需要
            $("#addUser").html(v_addDialogSource);
        }

        //添加用户时选择部门
        function showDept() {
            //获取tree所在的div
            var v_source = $("#deptTreeDiv").html();
            //初始化部门tree
            var setting = {
                data: {
                    simpleData: {
                        enable: true,
                        pIdKey: "pid",//对应实体类属性名
                    },
                    key: {
                        name: "deptName",//对应实体类属性名

                    }
                },
                check: {
                    enable: true,
                    chkboxType: { "Y": "s", "N": "s" }
                },
                treeNode:{
                    open: true
                },
            };
            $.ajax({
                url: "<%=request.getContextPath()%>/dept/queryDeptList.jhtml",
                type: "post",
                success: function (result) {
                    //初始化加载部门tree
                    var zTreeObj = $.fn.zTree.init($("#addUserDeptTree"), setting, result.data);
                    //弹出部门tree
                    var dia = bootbox.dialog({
                        title: '选择部门',
                        message: $("#addUserDeptTree"),
                        size: 'middle',
                        buttons: {
                            cancel: {
                                label: "取消",
                                className: 'btn-danger',
                                callback: function(){
                                }
                            },
                            ok: {
                                label: "确定",
                                className: 'btn-info',
                                //回调函数
                                callback: function(){
                                    //获取选中的部门
                                    var selectedNodes = zTreeObj.getSelectedNodes();
                                    if(selectedNodes.length!=1){
                                        bootbox.alert("请选择一个部门!");
                                        return;
                                    }
                                    //回填值给添加用户页面
                                    $("#addDeptName",v_addUserDialog).val(selectedNodes[0].deptName);
                                    $("#addDeptId",v_addUserDialog).val(selectedNodes[0].id);
                                }
                            }
                        }
                    })
                    //回填tree
                    $("#deptTreeDiv").html(v_source);
                },
                error: function (result) {
                    $("#error").html(result.responseText);
                }
            })
        }

        /**
         * 批量删除用户
         */
        function deleteBatchUser(){
            var v_idsArr = v_ids.join(",");
            if (v_idsArr.length==0){
                bootbox.alert("请选择要删除的信息!");
                return;
            }
            bootbox.confirm({
                message: "确定要删除吗?",
                title: "提示信息",
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: '取消',
                        className: 'btn-success'
                    }
                },
                callback: function (result) {
                    if(result){
                        $.ajax({
                            url:"<%=request.getContextPath()%>/user/deleteBatchUser.jhtml",
                            type:"post",
                            data:{"ids":v_idsArr},
                            dataType:"json",
                            success:function(data){
                                if(data.code==200){
                                    v_ids = [];
                                    bootbox.alert({
                                        message: "删除成功",
                                        callback: function () {
                                            search();
                                        }
                                    })
                                }else{
                                    bootbox.alert({
                                        message: data.msg,
                                        callback: function () {
                                        }
                                    })
                                }
                            },
                            error:function(data){
                                $("#error").html(data.responseText);
                            }
                        })
                    }
                }
            });
        }
        //解锁用户
        function unLockUser(id) {
            $.ajax({
                url:"<%=request.getContextPath()%>/user/unLockUser.jhtml",
                type:"post",
                data:{
                    "id":id
                },
                success:function (result) {
                    if(result.code==200){
                        alert(result.msg);
                        search();
                    }else{
                        alert(result.msg);
                    }
                },
                error:function (data) {
                    $("#error").html(data.responseText);
                }
            })
        }

        /**
         * 修改用户
         */
        function updateUser(){
            //获取修改用户弹框的div
            var v_source = $("#editUser").html();
            //初始化日期
            initDateTimePicker();
            //获取当前选中的用户id
            var v_checkbox = $("tbody tr input[type='checkbox']:checked");
            if (v_checkbox.length != 1){
                bootbox.alert("请选择一项修改的信息!");
                return;
            }
            //当前选中的用户id
            var v_id = v_checkbox[0].value;
            //可以从前台点击行时获取的用户信息
            console.log(v_rowData);
            //或者后台查询用户信息更严谨
            $.ajax({
                url: "<%=request.getContextPath()%>/user/queryUserById.jhtml",
                type: "post",
                data: {
                    "id": v_id
                },
                success: function (result) {
                    var v_user = result.data;
                    //用户编辑弹框回显赋值
                    $("#editUserId").val(v_user.id);//用户id
                    $("#editUserName").val(v_user.userName);
                    $("#editRealName").val( v_user.realName);
                    $("#editBirthday").val( v_user.birthdayStr);
                    if (v_user.sex == 1) {
                        $("#editSex1").attr("checked", true);
                    } else {
                        $("#editSex0").attr("checked", true);
                    }
                    $("#editSalary").val(v_user.salary);
                    $("#editUserDeptName").val(v_user.dept.deptName);
                    $("#editUserDeptId").val(v_user.dept.id);
                    //弹出框的文件域初始化fileInput
                    initEditHeaderImg(v_user.headerImage);
                    //老图片路径隐藏域赋值
                    $("#editOldHeaderImagePath").val(v_user.headerImage);
                    //弹出编辑修改框
                    v_editUserDialog = bootbox.dialog({
                        title: '修改用户',
                        message: $("#editUser form"),
                        size: 'large',
                        buttons: {
                            cancel: {
                                label: "取消",
                                className: 'btn-danger',
                                callback: function () {
                                }
                            },
                            ok: {
                                label: "修改",
                                className: 'btn-info',
                                //回调函数
                                callback: function () {
                                    //获取表单值
                                    var v_deptId = $("#editUserDeptId",v_editUserDialog).val();//部门id
                                    var v_userId = $("#editUserId",v_editUserDialog).val();//用户id
                                    var v_editUserName = $("#editUserName",v_editUserDialog).val();
                                    var v_editRealName = $("#editRealName",v_editUserDialog).val();
                                    var v_editBirthday = $("#editBirthday",v_editUserDialog).val();
                                    var v_editSalary = $("#editSalary",v_editUserDialog).val();
                                    var v_editSex = $("input[name='editSex']:checked",v_editUserDialog).val();
                                    //新老图片隐藏域路径
                                    var v_headImgPath = $("#editHeaderImagePath",v_editUserDialog).val();
                                    var v_headOldImgPath = $("#editOldHeaderImagePath",v_editUserDialog).val();
                                    $.ajax({
                                        url: "<%=request.getContextPath()%>/user/updateUserInfo.jhtml",
                                        type: "post",
                                        data: {
                                            "id": v_userId,
                                            "dept.id": v_deptId,
                                            "userName": v_editUserName,
                                            "realName": v_editRealName,
                                            "birthday": v_editBirthday,
                                            "sex": v_editSex,
                                            "salary": v_editSalary,
                                            "headerImage": v_headImgPath,
                                            "oldHeadImgPath": v_headOldImgPath
                                        },
                                        success:function (result) {
                                            if (result.code==200){
                                                bootbox.alert({
                                                    message: "修改成功",
                                                })
                                                //清空选中的数组中值
                                                v_ids = [];
                                                //重新加载
                                                search();
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    })
                    //弹框内容回填
                    $("#editUser").html(v_source);
                }
            })

        }
        /**
         * 修改用户时选择部门
         */
        function showDeptOnEdit() {
            //清空tree
            $("#deptTreeDiv").html('<ul id=\'addUserDeptTree\' class=\'ztree\'></ul>');
            //初始化部门tree
            var setting = {
                data: {
                    simpleData: {
                        enable: true,
                        pIdKey: "pid",//对应实体类属性名
                    },
                    key: {
                        name: "deptName",//对应实体类属性名

                    }
                },
                check: {
                    enable: true,
                    chkboxType: { "Y": "s", "N": "s" }
                },
                treeNode:{
                    open: true
                },
            };
            $.ajax({
                url: "<%=request.getContextPath()%>/dept/queryDeptList.jhtml",
                type: "post",
                success: function (result) {
                    //初始化加载tree
                    var zTreeObj = $.fn.zTree.init($("#addUserDeptTree"), setting, result.data);
                    //弹出部门tree框
                    var dia = bootbox.dialog({
                        title: '选择部门',
                        message: $("#addUserDeptTree"),
                        size: 'middle',
                        buttons: {
                            cancel: {
                                label: "取消",
                                className: 'btn-danger',
                                callback: function(){
                                }
                            },
                            ok: {
                                label: "确定",
                                className: 'btn-info',
                                //回调函数
                                callback: function(){
                                    //获取选中的部门
                                    var selectedNodes = zTreeObj.getSelectedNodes();
                                    if(selectedNodes.length!=1){
                                        bootbox.alert("请选择一个部门!");
                                        return;
                                    }
                                    //回填值给修改用户页面
                                    $("#editUserDeptName",v_editUserDialog).val(selectedNodes[0].deptName);
                                    $("#editUserDeptId",v_editUserDialog).val(selectedNodes[0].id);
                                }
                            }
                        }
                    })
                },
                error: function (result) {
                    $("#error").html(result.responseText);
                }
            })

        }

        /**
         * 初始化日期组件DateTimePicker
         */
        function initDateTimePicker() {
            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd",
                autoclose: true,
                "language": 'zh-CN',
                "todayBtn": 1,
                "todayHighlight": true,
                "minView": 2,
                "endDate": new Date()
            })
        }
        function initDateTimePickerEditUser() {
            $(".editBirthday").datetimepicker({
                format: "yyyy-mm-dd",
                autoclose: true,
                "language": 'zh-CN',
                "todayBtn": 1,
                "todayHighlight": true,
                "minView": 2,
                "endDate": new Date()
            })
        }

        /**
         * ztree点击条件查询
         * @type {string}
         */
        var v_deptIdsArr = [];
        function zTreeOnClick(event, treeId, treeNode) {
            v_deptIdsArr = [];
            //获取所有选中的节点
            var zTreeObj = $.fn.zTree.getZTreeObj("deptTree");
            var selectedNodes = zTreeObj.getSelectedNodes();
            //转为数组
            var v_deptArr = zTreeObj.transformToArray(selectedNodes);
            //遍历拿到选中节点的id
            for(var i=0;i<v_deptArr.length;i++){
                //如果有重复就不再添加进数组
                if(!isExistDept(v_deptArr[i].id)){
                    v_deptIdsArr.push(v_deptArr[i].id);
                }
            }
            //ids隐藏域赋值
            $("#queryDeptIds").val(v_deptIdsArr.join());
            //调用条件查询
            search();
        };
        //判断选中的部门数组中是否已经存在
        function isExistDept(id) {
            for (var i= 0;i<v_deptIdsArr.length;i++) {
                if (id == v_deptIdsArr[i]){
                    return true;
                }
            }
        }

        //批量换部门
        function changeBatchDept() {
            //是否有选中用户
            if (v_ids.length==0){
                bootbox.alert("请选择要修改的用户!");
                return;
            }
            //清空tree
            $("#deptTreeDiv").html('<ul id=\'userDeptTree\' class=\'ztree\'></ul>');
            //初始化部门tree
            var setting = {
                data: {
                    simpleData: {
                        enable: true,
                        pIdKey: "pid",//对应实体类属性名
                    },
                    key: {
                        name: "deptName",//对应实体类属性名

                    }
                },
                check: {
                    enable: true,
                    chkboxType: { "Y": "s", "N": "s" }
                },
                treeNode:{
                    open: true
                },
            };
            var zTreeObj;
            $.ajax({
                url: "<%=request.getContextPath()%>/dept/queryDeptList.jhtml",
                type: "post",
                success: function (result) {
                    //初始化加载tree
                    zTreeObj = $.fn.zTree.init($("#userDeptTree"), setting, result.data);
                },
                error: function (result) {
                    $("#error").html(result.responseText);
                }
            })
            //弹出部门tree框
            var dia = bootbox.dialog({
                title: '选择部门',
                message: $("#userDeptTree"),
                size: 'middle',
                buttons: {
                    cancel: {
                        label: "取消",
                        className: 'btn-danger',
                        callback: function(){
                        }
                    },
                    ok: {
                        label: "确定",
                        className: 'btn-info',
                        //回调函数
                        callback: function(){
                            //获取选中的部门
                            var selectedNodes = zTreeObj.getSelectedNodes();
                            if(selectedNodes.length!=1){
                                bootbox.alert("请选择一个部门!");
                                return;
                            }
                            //获取选中的部门的id
                            var v_deptId = selectedNodes[0].id;
                            //修改用户所在的部门
                            $.ajax({
                                url: "<%=request.getContextPath()%>/user/updateBatchUserDept.jhtml",
                                type: "post",
                                data: {
                                   "dept.id": v_deptId,//部门id
                                   "ids": v_ids.join()//用户id
                                },
                                success:function (result) {
                                    if (result.code == 200){
                                        bootbox.alert({
                                            message: "修改成功"
                                        })
                                        //重新加载
                                        search();
                                        //清除选中状态
                                        v_ids = [];
                                    }
                                }
                            })
                        }
                    }
                }
            })

        }
        //添加用户头像
       /* function initImage(){
            $('#headerImage').fileinput({
                //初始化上传文件框
                language: "zh",//配置语言
                showUpload : true, //显示整体上传的按钮
                showRemove : true,//显示整体删除的按钮
                uploadAsync: true,//默认异步上传
                uploadLabel: "上传",//设置整体上传按钮的汉字
                removeLabel: "移除",//设置整体删除按钮的汉字
                uploadClass: "btn btn-primary",//设置上传按钮样式
                showCaption: true,//是否显示标题
                dropZoneEnabled: false,//是否显示拖拽区域
                uploadUrl: "/upload/uploadFile.jhtml",//这个是配置上传调取的后台地址
                maxFileSize : 9999,//文件大小限制
                enctype: 'multipart/form-data',
                allowedFileExtensions : ["jpg", "png","gif","docx","zip","xlsx","txt"],/!*上传文件格式限制*!/
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                showBrowse: true,
                browseOnZoneClick: true,
                slugCallback: function (filename) {
                    return filename.replace('(', '_').replace(']', '_');
                }
            });
            $('#headerImage').on("fileuploaded", function(event, data, previewId, index) {
                if (data.response.code == 200){
                    $("#headerImagePath",v_addUserDialog).val(data.response.data);
                }
            });
            $('#editHeaderImage').fileinput({
                //初始化上传文件框
                language: "zh",//配置语言
                showUpload : true, //显示整体上传的按钮
                showRemove : true,//显示整体删除的按钮
                uploadAsync: true,//默认异步上传
                uploadLabel: "上传",//设置整体上传按钮的汉字
                removeLabel: "移除",//设置整体删除按钮的汉字
                uploadClass: "btn btn-primary",//设置上传按钮样式
                showCaption: true,//是否显示标题
                dropZoneEnabled: false,//是否显示拖拽区域
                uploadUrl: "/upload/uploadFile.jhtml",//这个是配置上传调取的后台地址
                maxFileSize : 9999,//文件大小限制
                enctype: 'multipart/form-data',
                allowedFileExtensions : ["jpg", "png","gif","docx","zip","xlsx","txt"],/!*上传文件格式限制*!/
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                showBrowse: true,
                browseOnZoneClick: true,
                slugCallback: function (filename) {
                    return filename.replace('(', '_').replace(']', '_');
                }
            });
            $('#editHeaderImage').on("fileuploaded", function(event, data, previewId, index) {
                if (data.response.code == 200){
                    $("#editHeaderImagePath",v_editUserDialog).val(data.response.data);
                }
            });
        }*/

    </script>

    <%--添加部门的弹框--%>
    <div id="addDept" style="display: none">
        <form class="form-horizontal"  style="padding: 5px">
            <input id="deptPid" type="text">
            <div class="form-group">
                <label for="userName" class="col-md-2 control-label">部门名字：</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="deptName" name="deptName" placeholder="部门名">
                </div>
            </div>
            <div class="form-group">
                <label for="userName" class="col-md-2 control-label">部门描述：</label>
                <div class="col-md-3">
                    <textarea id="remark"></textarea>
                </div>
            </div>
        </form>
    </div>

    <%--修改部门的弹框--%>
    <div id="editDept" style="display: none">
        <form class="form-horizontal"  style="padding: 5px">
            <input id="deptId" type="text">
            <div class="form-group">
                <label for="userName" class="col-md-2 control-label">部门名字：</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editDeptName" placeholder="部门名">
                </div>
            </div>
            <div class="form-group">
                <label for="userName" class="col-md-2 control-label">部门描述：</label>
                <div class="col-md-3">
                    <textarea id="editRemark"></textarea>
                </div>
            </div>
        </form>
    </div>

    <%--添加用户的弹框--%>
    <div id="addUser" >
        <form class="form-horizontal" method="post">
            <input type="text" id="addHeaderImagePath"/>
            <div class="form-group">
                <label class="col-md-2 control-label">用户名字:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="addUserName" placeholder="用户名字">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">用户头像:</label>
                <div class="col-md-5">
                    <input type="file" id="addHeaderImage" class="form-control" name="uploadFile">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">用户密码:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="addUserPwd" placeholder="用户密码">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">真实名字:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="addRealName" placeholder="真实名字">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">生日:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control form_datetime" id="addBirthday" placeholder="YYYY-MM-DD">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">性别:</label>
                <div class="col-md-3">
                    <label class="radio-inline">
                        <input type="radio" name="addSex" value="1">男
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="addSex" value="0">女
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">薪资:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="addSalary" placeholder="薪资">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">部门:</label>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="addDeptName">
                    <input type="hidden" class="form-control" id="addDeptId">
                </div>
                <div class="col-md-1">
                    <button type="button" class="btn btn-info" onclick="showDept();">选择</button>
                </div>
            </div>

        </form>
    </div>

    <%--添加或修改用户时选择部门tree的弹框--%>
    <div style="display: none" id="deptTreeDiv">
        <ul id="addUserDeptTree" class="ztree"></ul>
    </div>

    <%--修改用户的弹框--%>
    <div id="editUser" style="display: none;">
        <form class="form-horizontal" method="post">
            <input type="text" id="editHeaderImagePath"/>
            <input type="text" id="editOldHeaderImagePath"/>
            <input type="text" id="editUserId"/>
            <div class="form-group">
                <label class="col-md-2 control-label">用户名字:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editUserName" placeholder="用户名字">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">用户头像:</label>
                <div class="col-md-5">
                    <img width="100px" id="editShowImage">
                    <input type="file" id="editHeaderImage" class="form-control" name="uploadFile">
                </div>
            </div>
            <%--<div class="form-group">
                <label class="col-md-2 control-label">用户密码:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editUserPwd" placeholder="用户密码">
                </div>
            </div>--%>
            <div class="form-group">
                <label class="col-md-2 control-label">真实名字:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editRealName" placeholder="真实名字">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">生日:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control editBirthday" id="editBirthday" placeholder="YYYY-MM-DD">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">性别:</label>
                <div class="col-md-3">
                    <label class="radio-inline">
                        <input type="radio" name="editSex" id="editSex1" value="1">男
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="editSex" id="editSex0" value="0">女
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">薪资:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editSalary" placeholder="薪资">
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">部门:</label>
                <div class="col-md-2">
                    <input type="text" class="form-control" id="editUserDeptName">
                    <input type="text" class="form-control" id="editUserDeptId">
                </div>
                <div class="col-md-1">
                    <button type="button" class="btn btn-info" onclick="showDeptOnEdit();">选择</button>
                </div>
            </div>

        </form>
    </div>
</body>
</html>
