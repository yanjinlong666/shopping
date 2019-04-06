<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${!empty list}">
	<table border="1" cellspacing="0" id="tabPage">
		<thead>
		<tr>
			<td>选择</td>
			<td>序号</td>
			<td>商品名字</td>
			<td>商品价格<input type="button" value="↑" data-sort-filed="productPrice" data-sort="asc"/><input type="button" value="↓" data-sort-filed="productprice" data-sort="desc"/></td>
			<td>录入时间<input type="button" value="↑" data-sort-filed="entryTime" data-sort="asc"/><input type="button" value="↓" data-sort-filed="entryTime" data-sort="desc"/></td>
			<td>修改时间<input type="button" value="↑" data-sort-filed="updateTime" data-sort="asc"/><input type="button" value="↓" data-sort-filed="updateTime" data-sort="desc"/></td>
			<td>品牌名字</td>
			<td>主图片</td>
			<td>操作</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="product">
			<tr class="checkTr">
				<td><input type="checkbox" value="${product.id}" name="ids"/></td>
				<td>${product.id}</td>
				<td>${product.productName}</td>
				<td>${product.productPrice}</td>
				<td><fmt:formatDate value="${product.entryTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${product.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<%--<td>${product.entryTimeStr}</td>
				<td>${product.updateTimeStr}</td>--%>
				<td>${product.brand.brandName}</td>
				<td><img src="<%=request.getContextPath()%>${product.productImagePath}" width="100px" height="50px"></td>
				<td>
					<a href="javaScript:void(0)" onclick="window.event.cancelBubble=true;deleteProduct(${product.id})">删除</a>
					<a href="javaScript:void(0)" onclick="window.event.cancelBubble=true;updateProduct(${product.id})">修改</a>
					<input type="button" value="查看子图片" onclick="window.event.cancelBubble=true;showImages(${product.id})"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
</table>
	<!-- 分页 -->
	<%--<jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>--%>

</c:if>
<c:if test="${empty list}">
<h2><font color="red">没有符合条件的数据</font></h2>
</c:if>

