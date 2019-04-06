<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/17
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>
</head>
<body>
    <div style="width: 500px">
        <c:forEach items="${imageList}" var="image">
            <a class="thumbnail"  href="#">
                <img src="<%=request.getContextPath()%>${image.imagePath}" width="90px">
            </a>
        </c:forEach>
    </div>
    <div class="row">
        <div class="col-md-5">
            <div class="col-md-1"></div>
        </div>

    </div>
</body>
</html>
