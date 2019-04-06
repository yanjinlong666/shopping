<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/3/20
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改会员信息</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/md5.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/area/area.js"></script>

</head>
<body>
<fieldset>
    <legend>修改会员信息</legend>
    <form class="form-horizontal" >
        <input type="hidden" value="${member.id}" id="id">
        <input type="hidden"  id="areaIds">
        <%--<input type="text" value="${member.areaSheng.id}" id="areaShengHidden" name="areaSheng.id">
        <input type="text" value="${member.areaShi.id}" id="areaShiHidden" name="areaShi.id">
        <input type="text" value="${member.areaXian.id}" id="areaXianHidden" name="areaXian.id">--%>
        <div class="form-group">
            <label class="col-md-2 control-label">用户名:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="userName"  value="${member.userName}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">邮箱:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="email"  value="${member.email}">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-2 control-label">生日:</label>
            <div class="col-md-3">
                <input type="text" class="form-control" id="birthday"  value="${member.birthday}">
            </div>
        </div>
        <div class="form-group" id="areaDiv">
            <label class="col-md-2 control-label">地区:</label>
            <div class="col-md-2">
                <input type="text" class="form-control" id="areaNames" value="${member.areaNames}">
            </div>
            <div class="col-md-1">
                <button type="button" id="editAreaButton" onclick="editArea(1)" class="btn btn-info"><span class="glyphicon glyphicon-pencil"></span>编辑</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5" style="text-align: center">
                <button type="button" onclick="updateMember()" class="btn btn-info"><span class="glyphicon glyphicon-pencil"></span>修改</button>
            </div>
        </div>
    </form>
</fieldset>

    <script>
        $(function () {

           /* //初始化省下拉
            initAreaSheng();
            //初始化市下拉
            initAreaShi();
            //初始化市下拉
            initAreaXian();*/
        })
        //修改
        function updateMember() {
            var v_userName = $("#userName").val();
            var v_email = $("#email").val();
            var v_birthday = $("#birthday").val();
            var v_areaNames = $("#areaNames").val();
            var v_areaIds = $("#areaIds").val();
            var v_id = $("#id").val();
            if (v_userName.length == 0 || v_email.length ==0 || v_birthday.length == 0 || v_areaNames.length == 0){
                alert("不能有非空项");
                return;
            }
            $.ajax({
                url: "/member/updateMember.jhtml",
                type: "post",
                data: {
                    "id": v_id,
                    "userName": v_userName,
                    "email": v_email,
                    "birthday": v_birthday,
                    "areaNames": v_areaNames,
                    "areaIds": v_areaIds
                },
                success: function (result) {
                    if (result.code == 200){
                        alert(result.msg);
                        location.href = "/member/toMemberList.jhtml";
                    }else{
                        alert(result.msg);
                    }
                }
            })

        }
        //修改地区
        function editArea(id,obj){
            //禁用编辑地区按钮
            $("#editAreaButton").attr("disabled",true);
            $.ajax({
                url: "http://192.168.1.48:8092/api/area/queryAreaByPid.jhtml",
                dataType: "jsonp",
                data: {"id":id},
                success: function (result) {
                    if (result.code == 200){
                        //如果内容改变 先将后面的select清空
                        if (obj){
                            $(obj).parent().nextAll().remove();
                            //获取到选择的新地区
                            var v_areaIds = "";
                            var v_areaNames = "";
                            if (obj){
                                $("select[name='areaSel']").each(function () {
                                    if (this.options[this.selectedIndex].value != -1) {
                                        v_areaIds += this.options[this.selectedIndex].value+",";
                                        v_areaNames += this.options[this.selectedIndex].text;
                                    }
                                })
                                $("#areaNames").val(v_areaNames);
                                $("#areaIds").val(v_areaIds);
                            }
                        }

                        //如果后面没有数据 没有下一级下拉
                        var v_data = result.data;
                        if (v_data.length == 0){
                            return;
                        }
                        var v_areaSelStr = "<div class=\"col-md-1\">\n" +
                            "                <select name='areaSel' class=\'form-control'onchange=\"editArea(this.value,this)\">" +
                            "<option value='-1'>请选择</option>";
                        for (var i = 0; i < v_data.length; i++) {
                            v_areaSelStr += "<option value='"+v_data[i].id+"'>"+v_data[i].areaName+"</option>";
                        }
                        v_areaSelStr += "</select>\n" +
                            "            </div>";
                        $("#areaDiv").append(v_areaSelStr);

                    } else {
                        alert(result.msg);
                    }
                }
            })
        }
       /* var v_selShengId;
        var v_selShiId;
        var v_selXianId;
        function initAreaSheng(){
            v_selShengId = $("#areaShengHidden").val();
            if (v_selShengId) {
                initAreaSel("areaShengSel",1,v_selShengId);
            }
        }
        function initAreaShi(){
            v_selShiId = $("#areaShiHidden").val();
            if (v_selShiId) {
                initAreaSel("areaShiSel",v_selShengId,v_selShiId);
            }
        }
        function initAreaXian(){
            v_selXianId = $("#areaXianHidden").val();
            if (v_selXianId){
                initAreaSel("areaXianSel",v_selShiId,v_selXianId);
            }
        }*/

    </script>
</body>
</html>
