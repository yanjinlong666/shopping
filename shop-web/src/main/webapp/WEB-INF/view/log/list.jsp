<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/12
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志记录展示</title>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/css/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.css">

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery.dataTables.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/dataTables.bootstrap.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<body>

<fieldset>
    <legend>日志条件查询</legend>
    <form class="form-horizontal" id="productForm">
        <div class="form-group">
            <label for="userName" class="col-md-2 control-label">按照用户名：</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <label for="status" class="col-md-2 control-label">按照状态：</label>
            <div class="col-md-3">
                <label class="radio-inline">
                    <input type="radio" name="status" id="status" value="1">成功
                </label>
                <label class="radio-inline">
                    <input type="radio" name="status" id="status" value="0">失败
                </label>
            </div>
        </div>
        <div class="form-group">
            <label for="createTimeMin" class="col-md-2 control-label">按照创建时间:</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="createTimeMin" name="createTimeMin"
                           class="form-control form-date" placeholder="开始时间" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <input type="text" id="createTimeMax" name="createTimeMax"
                           class="form-control form-date" placeholder="结束时间" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="executeTimeMin" class="col-md-2 control-label">按照花费时间：</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="executeTimeMin" name="executeTimeMin" class="form-control" placeholder="最小" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <input type="text" id="executeTimeMax" name="executeTimeMax" class="form-control" placeholder="最大" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5" style="text-align: center">
                <button type="button" class="btn btn-primary" onclick="search();"><span class="glyphicon glyphicon-ok"></span>搜索</button>
                <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
            </div>
        </div>

    </form>
</fieldset>

<div id="error"></div>
<table id="logTab" class="table table-striped table-bordered" style="width:100%">
    <thead>
    <tr>
        <th><input type="checkbox" onclick="checkAll(this)"/></th>
        <th>序号</th>
        <th>用户名</th>
        <th>开始时间</th>
        <th>操作</th>
        <th>状态</th>
        <th>花费时间</th>
        <th>详情</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th><input type="checkbox"/></th>
        <th>序号</th>
        <th>用户名</th>
        <th>开始时间</th>
        <th>操作</th>
        <th>状态</th>
        <th>花费时间</th>
        <th>详情</th>
    </tr>
    </tfoot>
</table>


<script type="text/javascript">
    //初始化
    $(function () {
        //初始化表格
        initLogTable();
        //初始化日期组件
        initDateTimePicker();
    })
        //条件查询
        function search(){
            var v_json = {};
            v_json.userName = $("#userName").val();
            v_json.status = $("input[name='status']:checked").val();
            v_json.createTimeMin = $("#createTimeMin").val();
            v_json.createTimeMax = $("#createTimeMax").val();
            v_json.executeTimeMin = $("#executeTimeMin").val();
            v_json.executeTimeMax = $("#executeTimeMax").val();
            v_logTable.settings()[0].ajax.data = v_json;
            v_logTable.ajax.reload();
        }
    //初始化日志表
    var v_logTable;
    //初始化表格
    function initLogTable() {
        v_logTable = $("#logTab").DataTable({
            /*"paging": true,
            "ordering": true,
            "retrieve": true,
            "destroy": true,*/
            //去掉搜索框
            "searching" : false,
            //自定义每页条数
            "lengthMenu":[5,10,15,20],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url":"<%=request.getContextPath()%>/log/queryLog.jhtml",
                "type":"post"
            },
            "columns": [
                {"data":"id",
                    render:function(data,type,row,meta){
                        return "<input type='checkbox' value='"+data+"'>"
                    }
                },
                {"data": "id"},
                {"data": "userName"},
                {
                    "data": "createTime",
                    render:function (data) {
                        return  getDateStr(data);
                    }
                },
                {"data": "info"},
                {
                    "data": "status",
                    render:function (data,type,row,meta) {
                        if(data==1){
                            return "成功";
                        }else{
                            return "失败";
                        }

                    }
                    
                },
                {"data": "executeTime"},
                {"data": "content"}
            ],

            //汉化
            language: {
                url:"/js/DataTables-1.10.15/chinese.json",
            }
        });
    }
    //初始化日期组件
    function initDateTimePicker() {
        $(".form-date").datetimepicker({
            //日期格式
            format: "yyyy-mm-dd hh:mm",
            //选完时间自动关闭
            autoclose: true,
            //语言
            "language": 'zh-CN',
            //显示今天按钮
            "todayBtn": 1,
            //今日时间高亮
            "todayHighlight": true,
            //最精确的时间
            // 0从小时视图开始，选分
            /*1	从天视图开始，选小时
            2	从月视图开始，选天
            3	从年视图开始，选月
            4	从十年视图开始，选年*/
            "minView": 0,
            //最大日期今天
            "endDate": new Date(),
            //步进值
            "minuteStep":1
        })
    }
    //前台js方式来转换日期毫秒数
    function getDateStr(myDate){
        var date=new Date(myDate);
        var str = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
        return str;
    }

</script>

</body>
</html>
