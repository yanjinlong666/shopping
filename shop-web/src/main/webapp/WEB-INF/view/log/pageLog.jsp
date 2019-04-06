<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/12
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${!empty logList}">
    <table border="1" cellspacing="0" width="1100px">
        <thead>
        <tr>
            <td>序号</td>
            <td>用户名</td>
            <td>操作</td>
            <td>状态</td>
            <td>创建时间</td>
            <td>花费时间</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${logList}" var="log">
            <tr>
                <td>${log.id}</td>
                <td>${log.userName}</td>
                <td>${log.info}</td>
                <td>${log.status eq 1?"成功":"失败"}</td>
                <td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${log.executeTime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>
</c:if>
<c:if test="${empty logList}">
    <h2><font color="red">没有符合条件的数据</font></h2>
</c:if>