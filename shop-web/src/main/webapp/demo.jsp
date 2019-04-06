<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/2/23
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse" style="margin: 0px">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">商品管理系统</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">用户<span class="sr-only">(current)</span></a></li>
                <li><a href="#">产品</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">品牌<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">31</a></li>
                        <li><a href="#">32</a></li>
                        <li><a href="#">33</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">41</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">42</a></li>
                    </ul>
                </li>
            </ul>
        </div>
</nav>

    <div class="row" style="padding-left: 5px">
        <div class="col-md-2">
            <a href="#" class="list-group-item active">商品管理系统</a>
            <a href="#" class="list-group-item">用户管理</a>
            <a href="#" class="list-group-item">产品管理</a>
            <a href="#" class="list-group-item">品牌管理</a>
            <a href="#" class="list-group-item">日志管理</a>
        </div>
        <div class="col-md-10">
            <fieldset>
                <legend>配置数据源</legend>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-md-2 control-label">主机名</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="inputPassword" placeholder="shop">
                        </div>
                        <label for="inputPassword" class="col-md-2 control-label">数据库</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="inputPassword" placeholder="shop">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-md-2 control-label">用户名</label>
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="inputPassword" placeholder="用户名">
                        </div>
                        <label for="inputPassword" class="col-md-2 control-label">密码</label>
                        <div class="col-md-3">
                            <input type="password" class="form-control" id="inputPassword" placeholder="密码">
                        </div>
                    </div>
                    <div style="text-align: center">
                        <button type="button" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span>提交</button>
                        <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
                    </div>
                    <div style="text-align: right;background-color: #ccc;margin-top: 10px">
                        <div class="btn-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span>添加用户</button>
                            <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>批量删除</button>
                        </div>
                    </div>
                </form>
            </fieldset>

            <div class="panel panel-primary">
                <div class="panel-heading">用户列表</div>
                <!-- Table -->
                <table class="table table-bordered">
                    <tr style="font-weight: bolder;">
                        <td>选择</td>
                        <td>用户名</td>
                        <td>年龄</td>
                        <td>籍贯</td>
                        <td>职位</td>
                        <td>学历</td>
                        <td>公司</td>
                        <td>电话</td>
                        <td>邮箱</td>
                        <td>操作</td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"/></input></td>
                        <td>张三</td>
                        <td>20</td>
                        <td>郑州</td>
                        <td>java</td>
                        <td>大专</td>
                        <td>飞狐</td>
                        <td>1234</td>
                        <td>5678</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                                <button type="button" class="btn btn-danger btn btn-primary btn-xs"><span class="glyphicon glyphicon-remove"></span>删除</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"/></input></td>
                        <td>张三</td>
                        <td>20</td>
                        <td>郑州</td>
                        <td>java</td>
                        <td>大专</td>
                        <td>飞狐</td>
                        <td>1234</td>
                        <td>5678</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                                <button type="button" class="btn btn-danger btn btn-primary btn-xs"><span class="glyphicon glyphicon-remove"></span>删除</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"/></input></td>
                        <td>张三</td>
                        <td>20</td>
                        <td>郑州</td>
                        <td>java</td>
                        <td>大专</td>
                        <td>飞狐</td>
                        <td>1234</td>
                        <td>5678</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="...">
                                <button type="button" class="btn btn-info btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span>修改</button>
                                <button type="button" class="btn btn-danger btn btn-primary btn-xs"><span class="glyphicon glyphicon-remove"></span>删除</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="disabled">
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li>
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
        </div>
    </div>
</body>
</html>
