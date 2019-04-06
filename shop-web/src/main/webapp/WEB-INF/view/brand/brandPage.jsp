<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${!empty list}">
<table border="1" cellspacing="0" width="700px" id="tabPage">
	<thead>
		<tr class="checkTr">
			<td>选择</td>
			<td>序号</td>
			<td>品牌名字</td>
			<td>录入时间<input type="button" value="↑" data-sort-filed="entryTime" data-sort="asc"/><input type="button" value="↓" data-sort-filed="entryTime" data-sort="desc"/></td>
			<td>修改时间<input type="button" value="↑" data-sort-filed="updateTime" data-sort="asc"/><input type="button" value="↓" data-sort-filed="updateTime" data-sort="desc"/></td>
			<td>操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="brand">
			<tr class="checkTr">
				<td><input type="checkbox" name="ids" value="${brand.id}"/></td>
				<td>${brand.id}</td>
				<td>
					<span id="listSpan" name="listSpan">${brand.brandName}</span>
					<span id="updateSpan" name="updateSpan">
						<input type="text" id="updateInput" size="5" onclick="window.event.cancelBubble=true;"/>
						<input type="button" value="修改" onclick="updateBlank(this)"/>
						<input type="button" value="取消" onclick="cancel(this)"/>
						<input type="hidden" id="brandId"/>
					</span>
				</td>
				<td><fmt:formatDate value="${brand.entryTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><fmt:formatDate value="${brand.updateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>
					<input type="button" value="删除" onclick="window.event.cancelBubble=true;deleteBlank(${brand.id})"/>
					<input type="button" value="修改" onclick="toUpdateBlank(this,${brand.id})"/>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	<!-- 包含分页 -->
	<jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>
</c:if>
<c:if test="${empty list}">
<h2><font color="red">没有符合的数据</font></h2>
</c:if>
