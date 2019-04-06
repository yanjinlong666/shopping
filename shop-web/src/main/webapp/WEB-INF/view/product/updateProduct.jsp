<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

</head>
<fieldset>
	<legend>商品修改</legend>

	<form class="form-horizontal" id="productForm" action="<%=request.getContextPath()%>/product/updateProductByFileInput.jhtml"
		  method="post" enctype="multipart/form-data">
		<input type="hidden" value="${product.id}" name="id"/>
		<%--商品主图的老路径隐藏域--%>
		<input type="text" value="${product.productImagePath}" name="productImagePath"/>
		<%--商品主图的新路径隐藏域--%>
		<input type="text" id="productImageNewPath" name="productImageNewPath"/>
		<%--商品子图的新路径隐藏域--%>
		<input type="text" name="productImagePathChildren" id="productImagePathChildren"/>

		<input type="text" id="imgIdHidden" name="delImgIds"/>
		<input type="text" id="imgPathHidden" name="delImgPaths"/>
		<div class="form-group">
			<label class="col-md-2 control-label">商品名字:</label>
			<div class="col-md-3">
				<input type="text" class="form-control" name="productName" value="${product.productName}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 control-label">商品价格:</label>
			<div class="col-md-3">
				<input type="text" class="form-control" name="productPrice" value="${product.productPrice}">
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
			<label  class="col-md-2 control-label">商品图片：</label>
			<div class="col-md-3">
				<img src="${product.productImagePath}" width="100px">
				<input type="file" name="productImage" id="uploadImage">
			</div>
		</div>
		<div class="form-group" data-name='childImageRow'>
			<label  class="col-md-2 control-label">商品子图：</label>
			<div style="width: 550px">
				<c:forEach items="${imageList}" var="image">
					<div style="display: inline-block" data-flag="imageRow">
						<div>
							<img src="<%=request.getContextPath()%>${image.imagePath}" width="100px">
						</div>
						<div>
							<input type="button"  value="删除" onclick="delImage(this,'${image.id}','${image.imagePath}')"/>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="form-group" data-name='childImageRow'>
		<label class="col-md-2 control-label">商品子图：</label>
		<div class="col-md-3">
			<input type="file" name="productImage" id="uploadImageChildren">
		</div>
		<%--<div class="col-md-2" data-name="childImageRow">
			<input type="file" class="form-control" name="productImages" placeholder="">
		</div>
		<div class="col-md-1">
			<button type="button" onclick="addRow()" class="btn btn-default"><span
					class="glyphicon glyphicon-plus"></span>添加子图
			</button>
		</div>--%>
	</div>

		<div class="row">
			<div class="col-md-5" style="text-align: center">
				<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>修改</button>
			</div>
		</div>
	</form>
</fieldset>

<body>
	<%--<form action="<%=request.getContextPath()%>/product/updateProduct.jhtml" method="post" enctype="multipart/form-data">
		<input type="hidden" value="${product.id}" name="id"/>
		<input type="hidden" value="${product.productImagePath}" name="productImagePath"/>
		<input type="hidden" id="imgIdHidden" name="delImgIds"/>
		<input type="hidden" id="imgPathHidden" name="delImgPaths"/>

		<table>
			<tr>
				<td>商品名字:</td>	
				<td><input type="text" name="productName" value="${product.productName}"/></td>
			</tr>
			<tr>
				<td>商品价格:</td>	
				<td><input type="text" name="productPrice" value="${product.productPrice}"/></td>
			</tr>
			<tr>
				<td>商品品牌:</td>	
				<td>
					<select name="brand.id" id="brandSel">
						<option value="-1">--请选择--</option>
						&lt;%&ndash; <c:forEach items="${listBrand}" var="brand">
							<option value="${brand.id}" ${product.brand.id==brand.id?"selected":""}>${brand.brandName}</option>
						</c:forEach> &ndash;%&gt;
						&lt;%&ndash; <c:if test="${product.brand.id==brand.id}">selected</c:if> &ndash;%&gt;
					</select>
				</td>
			</tr>
			<tr>
				<td>商品图片：</td>
				<td><img src="<%=request.getContextPath()%>${product.productImagePath}" width="100px">
					<input type="file" name="productImage"/>
				</td>
			</tr>
			<tr>
				<td>商品子图片：</td>
				<td>
					<div style="width: 550px">
						<c:forEach items="${imageList}" var="image">
							<div style="display: inline-block" data-flag="imageRow">
								<div>
									<img src="<%=request.getContextPath()%>${image.imagePath}" width="100px">
								</div>
								<div>
									<input type="button"  value="删除" onclick="delImage(this,'${image.id}','${image.imagePath}')"/>
								</div>
							</div>
						</c:forEach>
					</div>
				</td>
			</tr>
			<tr data-name="childImageRow">
				<td><input type="button" value="添加子图片" onclick="addRow()"/></td>
			</tr>
			<tr>
				<td><input type="submit" value="更新商品"/></td>
			</tr>
		</table>
	</form>--%>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/shop.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/shop.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-fileinput-master/js/fileinput.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-fileinput-master/js/locales/zh.js"></script>

	<script type="text/javascript">
		$(function(){
			initBrandSel("brandSel",'${product.brand.id}');
		})
        //修改商品主图
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
            $("#productImageNewPath").val(data.response.data);
        });
        //修改时添加商品子图
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
		//修改时移除老图片
		function delImage(obj,id,path) {
		    //删除图片
			$(obj).parents("div[data-flag='imageRow']").remove();
            //存储删除的图片id
			$("#imgIdHidden").val($("#imgIdHidden").val()+","+id);
            //存储删除的图片path
            $("#imgPathHidden").val($("#imgPathHidden").val()+","+path);
        }
       /* //增加行
		function addRow() {
			$("tr[data-name='childImageRow']").last().after("<tr data-name=\"childImageRow\">\n" +
                "\t\t\t\t<td></td><td><input type=\"file\" name=\"productImages\"/><input type=\"button\" value=\"—\" onclick=\"delRow(this)\"/></td>\n" +
                "\t\t\t</tr>");
        }
        //删除行
		function delRow(obj) {
			$(obj).parent().parent().remove();
        }*/
	</script>
</body>
</html>