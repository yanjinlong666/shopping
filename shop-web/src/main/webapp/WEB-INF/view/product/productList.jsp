
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>

    <jsp:include page="/WEB-INF/common/headcss.jsp"></jsp:include>

</head>
<body>

<%--条件查询表单--%>
<div class="panel panel-primary">
    <div class="panel-heading">条件查询</div>
    <form class="form-horizontal" id="productForm"  style="padding: 5px">
        <div class="form-group">
            <label for="productName" class="col-md-2 control-label">按照商品名：</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="productName" name="productName" placeholder="品牌名">
            </div>
        </div>
        <div class="form-group">
            <label for="productName" class="col-md-2 control-label">按照价格：</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="productPriceMin" name="productPriceMin" class="form-control" placeholder="最小价格" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-yen"></span>
                    </span>
                    <input type="text" id="productPriceMax" name="productPriceMax" class="form-control" placeholder="最大价格" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="productName" class="col-md-2 control-label">按照录入时间:</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="entryTimeBegin" name="entryTimeBegin" id="blrz-entry-date-start"
                           class="form-control form_datetime" placeholder="开始时间" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <input type="text" id="entryTimeEnd" name="entryTimeEnd"
                           class="form-control form_datetime" placeholder="结束时间" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="productName" class="col-md-2 control-label">按照修改时间:</label>
            <div class="col-md-3">
                <div class="input-group">
                    <input type="text" id="updateTimeBegin" name="updateTimeBegin"
                           class="form-control form_datetime" placeholder="开始时间" aria-describedby="basic-addon1">
                    <span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <input type="text" id="updateTimeEnd" name="updateTimeEnd" onclick="WdatePicker({skin:'YcloudRed'})"
                           class="form-control form_datetime" placeholder="结束时间" aria-describedby="basic-addon1">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="productName" class="col-md-2 control-label">按照品牌：</label>
            <div class="col-md-3">
                <select name="brand.id" id="brandSel" class="form-control">
                    <option value="-1">--请选择--</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5" style="text-align: center">
                <button type="button" class="btn btn-primary" onclick="search();"><span class="glyphicon glyphicon-ok"></span>搜索</button>
                <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
            </div>
        </div>

    </form>
</div>


<%--操作按钮--%>
<div class="row" style="margin: 10px">
    <div class="col-md-5" style="text-align: left">
        <button type="button" class="btn btn-info" onclick="addProduct();"><span class="glyphicon glyphicon-plus"></span>添加</button>
        <button type="button" class="btn btn-danger" onclick="deleteBatchProduct();"><span class="glyphicon glyphicon-remove"></span>批量删除</button>
        <button type="button" class="btn btn-info" onclick="exportByWhere();"><span class="glyphicon glyphicon-save"></span>按条件导出excel</button>
        <button type="button" class="btn btn-info" onclick="exportExcelByBrand();"><span class="glyphicon glyphicon-save"></span>按品牌导出excel</button>
    </div>
</div>

<%--展示列表--%>
<div class="panel panel-primary">
    <div class="panel-heading">展示列表</div>
    <table id="productTab" class="table table-striped table-bordered" style="width:100%">
        <thead>
        <tr>
            <th><input type="checkbox" onclick="checkAll(this)"/></th>
            <th>序号</th>
            <th>产品名</th>
            <th>产品价格</th>
            <th>录入时间</th>
            <th>修改时间</th>
            <th>品牌名</th>
            <th>商品主图</th>
            <th>操作</th>
        </tr>
        </thead>
        <tfoot>
        <tr>
            <th><input type="checkbox"/></th>
            <th>序号</th>
            <th>产品名</th>
            <th>产品价格</th>
            <th>录入时间</th>
            <th>修改时间</th>
            <th>品牌名</th>
            <th>商品主图</th>
            <th>操作</th>
        </tr>
        </tfoot>
    </table>
</div>


<div id="error"></div>

<jsp:include page="/WEB-INF/common/headerjs.jsp"></jsp:include>

<script>
$(function () {
        //初始化产品表
       initProductTable();
       //初始化点击行事件
        initClickRow();
        //初始化动态下拉
        initBrandSel("brandSel");
        //初始化日期组件
        initDateTimePicker();
    })
    //初始化时间插件bootstrap-datetimepicker
    function initDateTimePicker() {
        $(".form_datetime").datetimepicker({
            format: "yyyy-mm-dd hh:00",
            autoclose: true,
            "language": 'zh-CN',
            "todayBtn": 1,
            "todayHighlight": true,
            "minView": 1,
            "endDate": new Date()
        })
    }
    //初始化产品表
    var v_initProductTable;
    function initProductTable(){
        v_initProductTable = $('#productTab').DataTable({
            //去掉搜索框
            "searching" : false,
            //自定义每页条数
            "lengthMenu":[5,10,15,20],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "<%=request.getContextPath()%>/product/queryProduct.jhtml",
                "type": "post",
                "dataSrc": function(result) {
                    result.draw = result.data.draw;
                    result.recordsFiltered = result.data.recordsFiltered;
                    result.recordsTotal = result.data.recordsTotal;
                    return result.data.data;
                }
            },
            "columns": [
                {
                    "data": "id",
                    "orderable": false,
                    render:function(data,type,row,meta){
                        return "<input type='checkbox' value='"+data+"'>"
                    }
                },
                {"data": "id"},
                {"data": "productName", "orderable": false},
                {"data": "productPrice"},
                {
                    "data": "entryTimeStr"
                   /* 或日期格式处理
                   render:function(data, type, row, meta){
                        return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
                    }*/
                },
                {
                    "data": "updateTimeStr",
                },
                {"data": "brandName","orderable": false},
                {
                    "data": "productImagePath","orderable": false,
                    render:function (data) {
                        return "<img src='"+data+"' width='70px'>";
                    }
                },
                {
                    "data": "id","orderable": false,
                    render: function (data) {
                        return '<button type="button" onclick="window.event.cancelBubble=true;updateProduct('+data+')" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>修改</button>\n' +
                            '<button type="button" onclick="window.event.cancelBubble=true;deleteProduct(\''+data+'\')" class="btn btn-danger btn btn-primary btn-xs"><span class="glyphicon glyphicon-remove"></span>删除</button>'+
                            '<button type="button" onclick="window.event.cancelBubble=true;showImages('+data+')" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>查看子图</button>';
                    }

                }
            ],
            //回调函数
            "fnDrawCallback":function(){
                //保持翻页点击行选中
                $("tbody tr input[type='checkbox']").each(function () {
                    //拿到当前页面所有行的复选框的值和数组中ids值进行比较
                    var v_checkboxId = $(this).val();
                    if(isExist(v_checkboxId)){
                        $(this).closest("tr").css("background","yellow");
                        $(this).attr("checked",true);
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
    //循环当前行的值和数组中值比较是否存在
    function isExist(id){
        for (var i=v_rowIds.length-1;i>=0;i--){
            if(v_rowIds[i]==id){
                return true;
            }
        }
    }
    //条件查询
    function search(){
        var json = {};
        json.productName = $("#productName").val();
        json.productPriceMin = $("#productPriceMin").val();
        json.productPriceMax = $("#productPriceMax").val();
        json.entryTimeBegin = $("#entryTimeBegin").val();
        json.entryTimeEnd = $("#entryTimeEnd").val();
        json.updateTimeBegin = $("#updateTimeBegin").val();
        json.updateTimeEnd = $("#updateTimeEnd").val();
        json.orderByPriceAsc = $("#orderStr").val();
        json["brand.id"] = $("#brandSel").val();
        v_initProductTable.settings()[0].ajax.data = json;
        v_initProductTable.ajax.reload();
    }
    //点击行事件
    var v_rowIds = [];
    function initClickRow(){
        $("tbody").on("click","tr",function () {
            var v_checkbox = $(this).find("input[type='checkbox']")[0];
            var v_flag = $(this).attr("flag");
            //未点击
            if(v_flag!=1){
                $(this).css("background","yellow");
                $(v_checkbox).attr("checked",true);
                $(this).attr("flag",1);
                v_rowIds.push($(v_checkbox).val());
            }else{
                $(this).css("background","");
                $(v_checkbox).attr("checked",false);
                $(this).attr("flag",0);
                removeIds($(v_checkbox).val());
            }
        })
    }
    //取消选中时删除数组中当前行的复选框的值
    function removeIds(id){
        for (var i=v_rowIds.length-1;i>=0;i--){
            if(v_rowIds[i]==id){
                v_rowIds.splice(i,1);
                break;
            }
        }
    }
    //添加商品（弹框）
    function addProduct() {
        alert(11);
        //获取弹框内容
        var v_addProductDia = $("#addProductDia").html();
        //弹出添加框
        var v_addDialog = bootbox.dialog({
            title: '添加商品',
            //弹框内容
            message: $("#addProductDia"),
            size: 'larger',
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
                        var v_productName = $("#productName",v_addDialog).val();
                        var v_productPrice = $("#productPrice",v_addDialog).val();
                        var v_brandId = $("#addBrandSel",v_addDialog).val();
                        var v_productImagePath = $("#productImagePath",v_addDialog).val();
                        var v_productImagePathChildren = $("#productImagePathChildren",v_addDialog).val();
                        //发送ajax添加进数据库
                        $.ajax({
                            url: "<%=request.getContextPath()%>/product/addProduct.jhtml",
                            type: "post",
                            data: {
                                "productName": v_productName,
                                "productPrice": v_productPrice,
                                "brandId": v_brandId,
                                "productImagePath": v_productImagePath,
                                "productImagePathChildren": v_productImagePathChildren
                            },
                            success:function (result) {
                                if (result.code == 200) {
                                    alert(result.msg);
                                    search();
                                } else {
                                    alert(result.msg);
                                }
                            }
                        })
                    }
                }
            }
        })
        //弹框内容回填
        $("#addProductDia").html(v_addProductDia);
    }
    //去添加
    /*function toAddProduct(){
        location.href = "<%=request.getContextPath()%>/product/toAddProduct.jhtml";
    }*/
    //删除
    function deleteProduct(id){
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
                        url:"<%=request.getContextPath()%>/product/deleteProduct.jhtml",
                        type:"post",
                        //dataType:"json",
                        data:{"id":id},
                        success:function(data){
                            //$("#checkTr").val("");
                            if(data.code==200){
                                bootbox.alert({
                                    message: data.msg,
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
    //批量删除
    function deleteBatchProduct(){
        var v_ids = v_rowIds.join(",");
        if (v_ids.length==0){
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
                        url:"<%=basePath%>product/deleteBatchProduct.jhtml",
                        type:"post",
                        data:{"ids":v_ids},
                        dataType:"json",
                        success:function(data){
                            if(data.code==200){
                                v_rowIds = [];
                                bootbox.alert({
                                    message: data.msg,
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
    //修改
    function updateProduct(id){
        location.href="<%=basePath%>product/toUpdateProduct.jhtml?id="+id;
    }
    //分页
    /*function turnPage(pageIndex){
        search(pageIndex);
    }*/
    //onready初始化加载
   /* $(function(){
        //初始化点击行事件
        initCheckbox();

        //初始化升降序
        initSort();
    })*/
    //点击行变色,选中多选框,翻页保持 老的
    var v_idsArr = [];
    function initCheckbox(){
        //获取到tr
        $("#tabPage tbody tr").each(function(){
            //获取到复选框
            var v_checkbox = $(this).find("input[name='ids']:checkbox")[0];
            //翻页保持被选中
            for(var i = 0;i<v_idsArr.length;i++){
                if(v_idsArr[i]==$(v_checkbox).val()){
                    $(this).css("background","pink");
                    v_checkbox.checked = true;
                    $(this).attr("flag",1);
                    break;
                }
            }
            //tr循环绑定点击事件
            $(this).bind({
                //点击事件
                click:function(){
                    //获取被选中状态
                    var v_flag = this.getAttribute("flag");
                    //如果被选中
                    if(v_flag==1){
                        //点击行取消背景色
                        $(this).css("background","");
                        //取消复选框选中
                        $(v_checkbox).attr("checked",false);
                        //删除掉数组中当前行的复选框的值
                        deleteRowIds($(v_checkbox).val());
                        //增加标志位判断是否选中
                        this.setAttribute("flag",0);
                        console.log(v_idsArr);
                    }else{
                        //点击行改变背景色
                        $(this).css("background","pink");
                        //选中复选框
                        $(v_checkbox).prop("checked","true");
                        //获取到复选框的值给数组
                        v_idsArr.push(v_checkbox.value);
                        //增加标志位判断是否选中
                        this.setAttribute("flag",1);
                        console.log(v_idsArr);
                    }
                },
                //移上事件
                mouseover:function(){
                    //获取被选中状态
                    var v_flag = this.getAttribute("flag");
                    //如果未点击
                    if(v_flag!=1){
                        $(this).css("background","yellow");
                    }
                },
                //移开事件
                mouseout:function(){
                    //获取被选中状态
                    var v_flag = this.getAttribute("flag");
                    //如果未点击
                    if(v_flag!=1){
                        $(this).css("background","");
                    }
                }
            })
        })
    }
    function deleteRowIds(id){
        for(var i = v_idsArr.length;i>=0;i--){
            if(v_idsArr[i]==id){
                v_idsArr.splice(i,1);
                break;
            }
        }
    }
    //升降序
    var v_sortFiled;
    var v_sort;
    var v_select_button_id;
    function initSort(){
        var i=0;
        //获取升降序按钮
        $("#tabPage thead input").each(function(){
            $(this).attr("data-button-id",i);
            i++;
            if($(this).attr("data-button-id")==v_select_button_id){
                $(this).css("background","yellow");
            }
            //动态绑定事件
            $(this).bind("click",function(){
                $(this).css("background","yellow");
                v_sortFiled = $(this).attr("data-sort-filed");
                v_sort = $(this).attr("data-sort");
                v_select_button_id = $(this).attr("data-button-id");
                search(1);
            })
            $(this).bind("mouseover",function(){
                if($(this).attr("data-button-id")==v_select_button_id){
                    return;
                }
                $(this).css("background","pink");
            })
            $(this).bind("mouseout",function(){
                if($(this).attr("data-button-id")==v_select_button_id){
                    return;
                }
                $(this).css("background","");
            })
        })
    }
    //按条件导出excel
    function exportByWhere(){
        $("#productForm").get(0).action="<%=request.getContextPath()%>/product/exportExcel.jhtml";
        $("#productForm").get(0).method="post";
        $("#productForm").get(0).submit();
    }
    //按品牌导出excel
    function exportExcelByBrand(){
        $("#productForm").get(0).action="<%=request.getContextPath()%>/product/exportExcelByBrand.jhtml";
        $("#productForm").get(0).method="post";
        $("#productForm").get(0).submit();
    }
    //查看子图片
    function showImages(id){
        location.href = "<%=request.getContextPath()%>/product/findImages.jhtml?productId="+id;
    }

    /* //点击行变色,选中多选框
    function lod(){
        var v_trArr = $(".checkTr");
        for (var i = 1; i < v_trArr.length; i++) {
            v_trArr[i].onclick = function(){
                var v_ids = $("#checkTr").val();
                var v_flag = this.getAttribute("flag");
                if(v_flag!=1){
                    $(this).children().children().attr("checked",true);
                    $(this).attr("style","background:yellow");
                    v_ids += ","+$(this).children().children().val();
                    $("#checkTr").val(v_ids);
                    $(this).attr("flag",1);
                }else{
                    $(this).children().children().attr("checked",false);
                    $(this).attr("style","background:white");
                    $(this).attr("flag",0);
                    v_ids = $("#checkTr").val().replace(","+$(this).children().children().val(),"");
                    $("#checkTr").val(v_ids);
                }
            }
        }
    }
    //翻页时选中多选框
    function initCheckbox(){
        var v_ids = $("#checkTr").val();
        var v_idsArr = v_ids.split(",");
        for (var i = 0; i < v_idsArr.length; i++) {
            $("input[name='ids']").each(function(){
                if(v_idsArr[i]==$(this).val()){
                    $(this).attr("checked",true);
                    $(this).parent().parent().attr("style","background:yellow");
                    $(this).parent().parent().attr("flag",1);
                }
            })
        }
    } */
    /* //改变每页展示条数
    function changePageSize(pageSize){
        search(pageSize);
    } */

</script>
1234567
<%--添加商品弹框--%>
<div id="addProductDia">
    <fieldset>
        <legend>商品添加</legend>
        <form class="form-horizontal">
            <%--商品主图路径隐藏域--%>
            <input type="text" name="productImagePath" id="productImagePath"/>
            <%--商品子图路径隐藏域--%>
            <input type="text" name="productImagePathChildren" id="productImagePathChildren"/>
            <div class="form-group">
                <label class="col-md-2 control-label">商品名字:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="productName" placeholder="商品名字">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-md-2 control-label">商品价格:</label>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="productPrice" placeholder="商品价格">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-md-2 control-label">商品品牌:</label>
                <div class="col-md-3">
                    <select name="brandSel" id="addBrandSel" class="form-control">
                        <option value="-1">--请选择--</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">商品主图：</label>
                <div class="col-md-3">
                    <input type="file" id="uploadImage" class="form-control" name="productImage">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-md-2 control-label">商品子图：</label>
                <div class="col-md-3">
                    <input type="file" id="uploadImageChildren" class="form-control" name="productImage">
                </div>
            </div>
        </form>
    </fieldset>
</div>
</body>
</html>