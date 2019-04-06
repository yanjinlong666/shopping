<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/3/16
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员展示</title>
    <jsp:include page="/WEB-INF/common/headcss.jsp"></jsp:include>
</head>
<body>
    <%--条件查询表单--%>
    <div class="panel panel-primary">
    <div class="panel-heading">条件查询</div>
    <form class="form-horizontal" id="productForm"  style="padding: 5px">
        <div class="form-group">
            <label class="col-md-2 control-label">按照用户名：</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="userName"  placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">按照生日:</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="birthdayBegin" id="blrz-entry-date-start"
                           class="form-control form_datetime" placeholder="开始时间" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <input type="text" id="birthdayEnd" class="form-control form_datetime" placeholder="结束时间" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="form-group" id="areaDiv">
            <label class="col-md-2 control-label">按照地区：</label>
            <%--<div class="col-md-1">
                <select name="areaSheng.id" id="areaShengSel" class="form-control" onchange="initAreaShiSel()">
                    <option value="-1">请选择</option>
                </select>
            </div>
            <div class="col-md-1">
                <select name="areaShi.id" id="areaShiSel" class="form-control" onchange="initAreaXianSel()">
                    <option value="-1">请选择市</option>
                </select>
            </div>
            <div class="col-md-1">
                <select name="areaXian.id" id="areaXianSel" class="form-control">
                    <option value="-1">请选择县</option>
                </select>
            </div>--%>
        </div>
        <div class="row">
            <div class="col-md-5" style="text-align: center">
                <button type="button" class="btn btn-primary" onclick="search();"><span class="glyphicon glyphicon-ok"></span>搜索</button>
                <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
            </div>
        </div>
    </form>
</div>
    <%--展示列表--%>
    <div class="panel panel-primary">
        <div class="panel-heading">展示列表</div>
        <table id="memberTab" class="table table-striped table-bordered" style="width:100%">
            <thead>
            <tr>
                <th>序号</th>
                <th>用户名</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>生日</th>
                <th>地区</th>
                <th>操作</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>序号</th>
                <th>用户名</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>生日</th>
                <th>地区</th>
                <th>操作</th>
            </tr>
            </tfoot>
        </table>
    </div>

    <jsp:include page="/WEB-INF/common/headerjs.jsp"></jsp:include>
    <script type="text/javascript" src="/js/myjs/area/area.js"></script>

    <script>
        $(function () {
            //初始化会员表
            initMemberTable();
            //初始化下拉（多级联动）
            initArea(1);
        })
        //初始化会员表
        var v_initMemberTable;
        function initMemberTable(){
            v_initMemberTable = $('#memberTab').DataTable({
                //去掉搜索框
                "searching" : false,
                //自定义每页条数
                "lengthMenu":[5,10,15,20],
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "url": "<%=request.getContextPath()%>/member/list.jhtml",
                    /*调接口方式*/
                    /*"url": "http://192.168.1.48:8090/api/member/list.jhtml",*/
                    "type": "post",
                    "dataSrc": function(result) {
                        result.draw = result.data.draw;
                        result.recordsFiltered = result.data.recordsFiltered;
                        result.recordsTotal = result.data.recordsTotal;
                        return result.data.data;
                    }
                },
                "columns": [
                    {"data": "id"},
                    {"data": "userName", "orderable": false},
                    {"data": "phone","orderable": false},
                    {"data": "email","orderable": false},
                    {"data": "birthday"},
                    {"data": "areaNames","orderable": false},
                    {
                        "data": "id","orderable": false,
                        render: function (data) {
                            return '<button type="button" onclick="window.event.cancelBubble=true;editMember('+data+')" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>修改</button>\n';
                        }
                    }
                ],
                //回调函数
                "fnDrawCallback":function(){},
                //汉化
                language: {
                    url:"/js/DataTables-1.10.15/chinese.json",
                }
            });
        }
        //条件查询
        function search(){
            var json = {};
            json.userName = $("#userName").val();
            json.birthdayBegin = $("#birthdayBegin").val();
            json.birthdayEnd = $("#birthdayEnd").val();
            var v_ids = "";
            $("select[name='areaSel']").each(function () {
                if (this.options[this.selectedIndex].value != -1){
                    v_ids += this.options[this.selectedIndex].value+ ",";
                }
            })
            json.areaIds = v_ids;
            v_initMemberTable.settings()[0].ajax.data = json;
            v_initMemberTable.ajax.reload();
        }
        //省市县动态下拉
        function initArea(id,obj) {
            $.ajax({
                url: "http://192.168.1.48:8092/api/area/queryAreaByPid.jhtml",
                data: {"id":id},
                dataType: "jsonp",
                success: function (result) {
                    if(result.code == 200){
                        if (obj){
                            $(obj).parent().nextAll().remove();
                        }
                        var v_data = result.data;
                        if (v_data.length == 0){
                            return;
                        }
                        var v_areaSelStr = "<div class=\"col-md-1\">\n" +
                            "                <select name=\"areaSel\"  class=\"form-control\" onchange=\"initArea(this.value,this)\">" +
                            "<option value='-1'>请选择</option>";
                        for (var i = 0; i < v_data.length; i++) {
                            v_areaSelStr += "<option value='"+v_data[i].id+"'>"+v_data[i].areaName+"</option>";
                        }
                        v_areaSelStr += "</select>\n" +
                            "            </div>";
                        $("#areaDiv").append(v_areaSelStr);
                    }else{
                        alert(result.msg);
                    }
                }
            })
        }
        //修改会员信息
        function editMember(id) {
            location.href = "/member/toUpdateMember.jhtml?id="+id;
        }
    </script>

</body>
</html>
