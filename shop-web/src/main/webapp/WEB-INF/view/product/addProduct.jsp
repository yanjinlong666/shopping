<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-fileinput-master/css/fileinput.min.css">

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/shop.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-fileinput-master/js/fileinput.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-fileinput-master/js/locales/zh.js"></script>

</head>
<body>

<fieldset>
	<legend>商品添加</legend>

	<form class="form-horizontal" id="productForm" action="<%=request.getContextPath()%>/product/addProductByFileInput.jhtml"
		  method="post" enctype="multipart/form-data">
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
				<select name="brand.id" id="brandSel" class="form-control">
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
		<div class="row">
			<div class="col-md-5" style="text-align: center">
				<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>添加</button>
			</div>
		</div>
	</form>
</fieldset>

	<script type="text/javascript">
		//初始化加载品牌动态下拉
		$(function(){
			initBrandSel("brandSel");
		})
		//添加商品主图
        $('#uploadImage').fileinput({
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
            uploadUrl: "/product/uploadProductImage.jhtml",//这个是配置上传调取的后台地址
            maxFileSize : 9999,//文件大小限制
            enctype: 'multipart/form-data',
            allowedFileExtensions : ["jpg", "png","gif","docx","zip","xlsx","txt"],/*上传文件格式限制*/
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            showBrowse: true,
            browseOnZoneClick: true,
            slugCallback: function (filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        });
        $('#uploadImage').on("fileuploaded", function(event, data, previewId, index) {
            $("#productImagePath").val(data.response.data);
        });
        //添加商品子图
        $('#uploadImageChildren').fileinput({
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
            uploadUrl: "/product/uploadProductImage.jhtml",//这个是配置上传调取的后台地址
            maxFileSize : 9999,//文件大小限制
            maxFileCount: 9999,//允许最大上传数，可以多个，
            enctype: 'multipart/form-data',
            allowedFileExtensions : ["jpg", "png","gif","docx","zip","xlsx","txt"],/*上传文件格式限制*/
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            showBrowse: true,
            browseOnZoneClick: true,
            slugCallback: function (filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        });
        $('#uploadImageChildren').on("fileuploaded", function(event, data, previewId, index) {
            $("#productImagePathChildren").val( $("#productImagePathChildren").val()+data.response.data+",");
        });
        /*//添加子图片行
        function addRow() {
            $("div[data-name='childImageRow']").last().after("<div class=\"form-group\" data-name='childImageRow'>\n" +
                "\t\t\t<label for=\"productImages\" class=\"col-md-2 control-label\">商品子图：</label>\n" +
                "\t\t\t<div class=\"col-md-2\" data-name=\"childImageRow\">\n" +
                "\t\t\t\t<input type=\"file\" class=\"form-control\" name=\"productImages\" placeholder=\"\">\n" +
                "\t\t\t</div>\n" +
                "\t\t\t<div class=\"col-md-1\">\n" +
                "\t\t\t\t<button type=\"button\" onclick=\"addRow()\" class=\"btn btn-default\"><span\n" +
                "\t\t\t\t\t\tclass=\"glyphicon glyphicon-minus\"></span>删除子图\n" +
                "\t\t\t\t</button>\n" +
                "\t\t\t</div>\n" +
                "\t\t</div>");
        }
        //删除子图片行
        function deleteRow(obj) {
            $(obj).closest("div[class='form-group']").remove();
        }*/

		//动态添加文件域
        /*var file_count = 0;
		function insertFile(){
            file_count++;
		    var insert_row = $("#file-tab").get(0).insertRow();
			var cell_file = insert_row.insertCell();
            cell_file.innerHTML = "<input type='file' name='picture'/>";
            var cell_count = insert_row.insertCell();
            cell_count.innerHTML = file_count;
			var cell_del = insert_row.insertCell();
			cell_del.innerHTML = "<input type='button' value='删除' onclick='delFile(this)'/>";
		}*/
		//删除文件域
		/*function delFile(obj) {
            curRow = obj.parentNode.parentNode;
            $("#file-tab").get(0).deleteRow(curRow.rowIndex);
		}*/
	</script>
</body>
</html>