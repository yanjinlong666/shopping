<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/3/12
  Time: 22:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地区展示</title>
    <jsp:include page="/WEB-INF/common/headcss.jsp"></jsp:include>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <%--地区树--%>
        <div class="col-md-3">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    地区管理
                    <button type="button" class="btn btn-info" onclick="showAddArea();"><span class="glyphicon glyphicon-plus"></span>新增</button>
                    <button type="button" class="btn btn-info" onclick="editArea();"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                    <button type="button" class="btn btn-danger" onclick="delArea();"><span class="glyphicon glyphicon-remove"></span>删除</button>
                </div>
            </div>
            <ul id="areaTree" class="ztree"></ul>
        </div>
        <div class="col-md-9">

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/headerjs.jsp"></jsp:include>

<script type="text/javascript">
    $(function () {
        //初始化地区树
        initAreaTree();
    })
    //初始化地区树
    function initAreaTree() {
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid",//对应实体类属性名
                },
                key: {
                    name: "areaName",//对应实体类属性名

                }
            },
            check: {
                enable: true,
                chkboxType: { "Y": "s", "N": "s" }
            },
            treeNode:{
                open: true
            }

        };
        $.ajax({
            url: "<%=request.getContextPath()%>/area/queryAreaList.jhtml",
            type: "post",
            success: function (result) {
                var zTreeObj = $.fn.zTree.init($("#areaTree"), setting, result.data);
            },
            error: function (result) {
                $("#error").html(result.responseText);
            }
        })
    }
    //添加地区
    function showAddArea() {
        //获取当前选中节点
        var zTreeObj = $.fn.zTree.getZTreeObj("areaTree");
        var selectedNodes = zTreeObj.getSelectedNodes();
        //只能选择一个部门
        if (selectedNodes.length != 1){
            bootbox.alert({
                message: "请选择一个部门",
            })
            return;
        }
        //当前选中节点的id
        var v_areaId = selectedNodes[0].id;
        $("#areaPid").attr("value",v_areaId);
        //弹出添加框
        var v_addDialog = bootbox.dialog({
            title: '添加地区',
            //弹框内容
            message: $("#addArea").html(),
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
                        var v_pid = $("#areaPid",v_addDialog).val();
                        var v_areaName = $("#areaName",v_addDialog).val();
                        //发送ajax添加进数据库
                        $.ajax({
                            url: "<%=request.getContextPath()%>/area/addArea.jhtml",
                            type: "post",
                            data: {
                                "pid": v_pid,
                                "areaName": v_areaName
                            },
                            success:function (result) {
                                //页面动态添加子节点
                                var newNode = {
                                    "id": result.data,
                                    "pid": v_pid,
                                    "areaName": v_areaName
                                };
                                zTreeObj.addNodes(zTreeObj.getSelectedNodes()[0],newNode);
                            }
                        })
                    }
                }
            }
        })
    }
    //删除地区
    function delArea() {
        //获取选中的节点
        var zTreeObj = $.fn.zTree.getZTreeObj("areaTree");
        var selectedNodes = zTreeObj.getSelectedNodes();
        //请选择部门
        if (selectedNodes.length == 0){
            bootbox.alert({
                message: "请至少选择一个部门",
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
                    //获取当前选中节点的所有子节点
                    var v_idsArr = [];
                    var transformToArray = zTreeObj.transformToArray(selectedNodes);
                    for (var i = 0; i < transformToArray.length; i++) {
                        v_idsArr.push(transformToArray[i].id);
                    }

                    $.ajax({
                        url:"<%=request.getContextPath()%>/area/delArea.jhtml",
                        type:"post",
                        data:{
                            "ids":v_idsArr
                        },
                        success:function (result) {
                            if (result.code==200){
                                bootbox.alert({
                                    message: "操作成功",
                                    callback: function(){
                                        //删除页面子节点
                                        for (var i = 0; i < selectedNodes.length; i++) {
                                            zTreeObj.removeNode(selectedNodes[i]);
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
    //修改地区
    function editArea() {
        //获取选中的节点
        var zTreeObj = $.fn.zTree.getZTreeObj("areaTree");
        var selectedNodes = zTreeObj.getSelectedNodes();
        //请选择部门
        if (selectedNodes.length != 1){
            bootbox.alert({
                message: "请选择一个部门",
            })
            return;
        }
        //查询获取回显数据
        var v_id = selectedNodes[0].id;
        $.ajax({
            url: "<%=request.getContextPath()%>/area/queryAreaById.jhtml",
            type: "post",
            data: {
                "id": v_id
            },
            success: function (result) {
                //回显赋值
                var v_area = result.data;
                $("#editAreaId").val(v_area.id);
                $("#editAreaName").val(v_area.areaName);
                //弹出修改框
                var v_editDialog = bootbox.dialog({
                    title: '修改地区',
                    //弹框内容
                    message: $("#editArea form").clone(),
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
                            //回调函数
                            callback: function(){
                                //获取添加页面表单信息
                                var v_id = $("#editAreaId",v_editDialog).val();
                                var v_areaName = $("#editAreaName",v_editDialog).val();
                                //发送ajax添加进数据库
                                $.ajax({
                                    url: "<%=request.getContextPath()%>/area/updateArea.jhtml",
                                    type: "post",
                                    data: {
                                        "id": v_id,
                                        "areaName": v_areaName
                                    },
                                    success:function (result) {
                                        if (result.code==200){
                                            //页面动态修改节点
                                            selectedNodes[0].areaName = v_areaName;
                                            zTreeObj.updateNode(selectedNodes[0]);
                                        }

                                    }
                                })
                            }
                        }
                    }
                })
            }
        })

    }
</script>
    <%--添加弹框--%>
    <div id="addArea" style="display: none">
    <form class="form-horizontal"  style="padding: 5px">
        <input id="areaPid" type="text">
        <div class="form-group">
            <label class="col-md-2 control-label">地区名字：</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="areaName" placeholder="地区名">
            </div>
        </div>

    </form>
</div>

    <%--修改弹框--%>
    <div id="editArea" style="display: none">
        <form class="form-horizontal"  style="padding: 5px">
            <input id="editAreaId" type="text">
            <div class="form-group">
                <label class="col-md-2 control-label">地区名字：</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" id="editAreaName" placeholder="地区名">
                </div>
            </div>

        </form>
    </div>
</body>
</html>
