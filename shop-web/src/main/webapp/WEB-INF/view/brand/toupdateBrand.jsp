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
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

</head>
<body>
<fieldset>
	<legend>品牌修改</legend>

	<form class="form-horizontal" id="productForm" action="<%=request.getContextPath()%>/brand/updateBrand.jhtml"
		  method="post">
		<input type="hidden" value="${brand.id}" name="id"/>
		<div class="form-group">
			<label for="brandName" class="col-md-2 control-label">品牌名字:</label>
			<div class="col-md-3">
				<input type="text" class="form-control" name="brandName" value="${brand.brandName}" placeholder="品牌名字">
			</div>
		</div>
		<div class="row">
			<div class="col-md-5" style="text-align: center">
				<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>修改</button>
			</div>
		</div>
	</form>
</fieldset>
</body>
</html>