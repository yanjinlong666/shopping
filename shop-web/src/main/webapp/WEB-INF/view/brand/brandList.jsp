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
	<link rel="stylesheet" href="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/css/dataTables.bootstrap.css">

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery-3.3.1.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DataTables-1.10.15/media/js/dataTables.bootstrap.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/myjs/shop/shop.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>

</head>
<body>

<fieldset>
	<legend>品牌条件查询</legend>
	<form class="form-horizontal" id="productForm">
		<div class="form-group">
			<label for="brandName" class="col-md-2 control-label">按照品牌名：</label>
			<div class="col-md-3">
				<input type="text" class="form-control" id="brandName" name="brandName" placeholder="品牌名">
			</div>
		</div>
		<div class="form-group">
			<label for="entryTimeBegin" class="col-md-2 control-label">按照录入时间:</label>
			<div class="col-md-3">
				<div class="input-group">
					<input type="text" id="entryTimeBegin" onclick="WdatePicker()"
						   class="form-control" placeholder="开始时间" aria-describedby="basic-addon1">
					<span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
					<input type="text" id="entryTimeEnd" name="entryTimeEnd" onclick="WdatePicker()"
						   class="form-control" placeholder="结束时间" aria-describedby="basic-addon1">
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="updateTimeBegin" class="col-md-2 control-label">按照修改时间:</label>
			<div class="col-md-3">
				<div class="input-group">
					<input type="text" id="updateTimeBegin" name="updateTimeBegin" onclick="WdatePicker({skin:'YcloudRed'})"
						   class="form-control" placeholder="开始时间" aria-describedby="basic-addon1">
					<span class="input-group-addon" id="basic-addon1">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
					<input type="text" id="updateTimeEnd" name="updateTimeEnd" onclick="WdatePicker({skin:'YcloudRed'})"
						   class="form-control" placeholder="结束时间" aria-describedby="basic-addon1">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-5" style="text-align: center">
				<button type="button" class="btn btn-primary" onclick="search();"><span class="glyphicon glyphicon-ok"></span>搜索</button>
				<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
			</div>
		</div>

	</form>
</fieldset>

<div class="row" style="margin: 10px">
	<div class="col-md-5" style="text-align: left">
		<button type="button" class="btn btn-info" onclick="addBrand();"><span class="glyphicon glyphicon-plus"></span>添加</button>
		<button type="button" class="btn btn-danger" onclick="deleteBatchBrand();"><span class="glyphicon glyphicon-remove"></span>批量删除</button>
	</div>
</div>

<table id="brandTab" class="table table-striped table-bordered" style="width:100%">
	<thead>
	<tr>
		<th><input type="checkbox" onclick="checkAll(this)"/></th>
		<th>序号</th>
		<th>商品名</th>
		<th>录入时间</th>
		<th>修改时间</th>
		<th>操作</th>
	</tr>
	</thead>
	<tfoot>
	<tr>
		<th><input type="checkbox"/></th>
		<th>序号</th>
		<th>商品名</th>
		<th>录入时间</th>
		<th>修改时间</th>
		<th>操作</th>
	</tr>
	</tfoot>
</table>

<script type="text/javascript">
	//条件查询
	function search(){
	    var v_json = {};
        v_json.brandName = $("#brandName").val();
        v_json.entryTimeBegin = $("#entryTimeBegin").val();
        v_json.entryTimeEnd = $("#entryTimeEnd").val();
        v_json.updateTimeBegin = $("#updateTimeBegin").val();
        v_json.updateTimeEnd = $("#updateTimeEnd").val();
        v_brandTable.settings()[0].ajax.data = v_json;
        v_brandTable.ajax.reload();
	}
	//初始化
	$(function(){
	    initBrandTable();
        initClickRow();
	})
	//初始化品牌表
    var v_brandTable;
	function initBrandTable() {
		v_brandTable = $("#brandTab").DataTable({
            //去掉搜索框
            "searching" : false,
            //自定义每页条数
            "lengthMenu":[5,10,15,20],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url":"<%=request.getContextPath()%>/brand/queryBrand.jhtml",
                "type":"post"
            },
            "columns": [
                {"data":"id",
                    render:function(data,type,row,meta){
                        return "<input type='checkbox' value='"+data+"'>"
                    }
                },
                {"data": "id"},
                {"data": "brandName"},
                {"data": "entryTime"},
                {"data": "updateTime"},
                {
                    "data": "id",
                    render: function (data) {
                        return "<button type=\"button\" onclick=\"window.event.cancelBubble=true;updateBrand("+data+")\" class=\"btn btn-info btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            " <button type=\"button\" onclick=\"window.event.cancelBubble=true;deleteBrand("+data+")\" class=\"btn btn-danger btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-remove\"></span>删除</button>";
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
        for (var i=v_ids.length-1;i>=0;i--){
            if(v_ids[i]==id){
                return true;
            }
        }
    }
	//初始化点击行事件
	var v_ids = [];
	function initClickRow() {
		$("tbody").on("click","tr",function(){
		    var v_checkbox = $(this).find("input[type='checkbox']")[0];
		    var v_flag = $(this).attr("flag");
		    if(v_flag!=1){
		        //如果当前行复选框未选中，选中复选框，行变色，当前行的复选框值加进数据库
                $(v_checkbox).attr("checked",true);
                $(this).css("background","yellow");
                $(this).attr("flag",1);
                v_ids.push(v_checkbox.value);
			}else{
                v_checkbox.checked = false;
                $(this).css("background","");
                $(this).attr("flag",0);
                removeIds(v_checkbox.value);
			}
		})
    }
    //取消选中时删除数组中当前行的复选框的值
    function removeIds(id){
        for (var i=v_ids.length-1;i>=0;i--){
            if(v_ids[i]==id){
                v_ids.slice(i,1);
                break;
            }
        }
    }

</script>
 	<script type="text/javascript">
		//删除
		function deleteBrand(id){
			if(confirm("确定要删除吗?")){
				$.ajax({
					url:"<%=basePath%>brand/deleteBrand.jhtml",
					data:{"id":id},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code==200){
							alert(data.msg);
							//$("#checkIds").val("");
							v_rowIds = [];
							location.href="<%=request.getContextPath()%>/brand/toBrandList.jhtml";
						}else{
							alert(data.msg);
						}
					},
					error:function(){
						//location.href="<%=basePath%>brand/toErrorJsp.jhtml";
					}
				})
			}
		}

		//修改
		function updateBrand(id){
            location.href="<%=request.getContextPath()%>/brand/toUpdateBrand.jhtml?id="+id;
		}
		//批量删除
		function deleteBatchBrand(){
			if(v_ids.length>0){
				var v_idsArr = v_ids.join(",");
				if(confirm("确定要删除吗?")){
					$.ajax({
						url:"<%=basePath%>brand/deleteBatchBrand.jhtml",
						type:"post",
						data:{
							"ids":v_idsArr
						},
						dataType:"json",
						success:function(data){
							if(data.code==200){
								alert(data.msg);
								//$("#checkIds").val("");
								search(1);
								v_rowIds = [];
							}else{
								alert(data.msg);
							}
							
						}
					})
				}
			}else{
				alert("请选择要删除的信息");
			}
		}
		//初始化加载
		$(function(){
			//初始化点击行变色选中多选框
			initCheckBox();
			//$("#brandUpdate").hide();
			$("span[name='updateSpan']").hide();
			//初始化升降序
			initSort();
		})
		//点击行变色,选中多选框,翻页被选中
		var v_rowIds = [];
		function initCheckBox(){
			//获取行
			$("#tabPage tbody tr").each(function(){
				//获取当前行的复选框
				var v_checkBox = $(this).find("input[name='ids']")[0];
				//翻页保持选中
				for(var i=0;i<v_rowIds.length;i++){
					if(v_rowIds[i]==$(v_checkBox).val()){
						v_checkBox.checked = true;
						$(this).css("background","yellow");
						$(this).attr("flag",1);
						break;
					}
				}
				//循环绑定点击事件
				$(this).bind({
					//点击事件
					click:function(){
						//获取选中状态
						var v_flag = this.getAttribute("flag");
						//如果被选中
						if(v_flag==1){
							//清除行颜色
							$(this).css("background","");
							//取消选中多选框
							v_checkBox.checked = false;
							//删除数组中值
							removeRowIds($(v_checkBox).val());
							//增加标志位判断是否被选中
							this.setAttribute("flag",0);
							console.log(v_rowIds);
						}else{
							//如果未被选中改变行颜色
							$(this).css("background","yellow");
							//选中多选框
							$(v_checkBox).attr("checked",true);
							//将当前行多选框值放进数组
							v_rowIds.push($(v_checkBox).val());
							//增加标志位判断是否被选中
							this.setAttribute("flag",1);
							console.log(v_rowIds);
						}
					},
				//移上事件
				mouseover:function(){
					//获取选中状态
					var v_flag = this.getAttribute("flag");
					if(v_flag!=1){
						$(this).css("background","pink");
					}
				}, 
				//移出事件
				mouseout:function(){
					//获取选中状态
					var v_flag = this.getAttribute("flag");
					if(v_flag!=1){
						$(this).css("background","");
					}
				}
				})
			})
		}
		//删除数组中元素
		function removeRowIds(id){
			for(var i=v_rowIds.length;i>=0;i--){
				if(v_rowIds[i]==id){
					v_rowIds.splice(i,1);
					break;
				}
			}
		}
		//添加
		function addBrand(){
			location.href="<%=request.getContextPath()%>/brand/toAddBrand.jhtml";
		}
		//升降序
		var v_data_filed;
		var v_data_sort;
		var v_data_button_id;
		function initSort(){
			var i=0;
			//获取升降序按钮
			$("thead input[type='button']").each(function(){
				$(this).attr("data-id",i);
				i++;
				if($(this).attr("data-id")==v_data_button_id){
					$(this).css("background","pink");
				}
				//动态绑定点击事件
				$(this).bind({
					click:function(){
						v_data_filed = $(this).attr("data-sort-filed");
						v_data_sort = $(this).attr("data-sort");
						$(this).css("background","pink");
						v_data_button_id = $(this).attr("data-id");
						search(1);
					},
					mouseover:function(){
						if($(this).attr("data-id")==v_data_button_id){
							return;
						}
						$(this).css("background","yellow");
					},
					mouseout:function(){
						if($(this).attr("data-id")==v_data_button_id){
							return;
						}
						$(this).css("background","");
					}
				})
			})
		}
		
		/* //选中行变色,勾选复选框
		function lod(){
			var trArr = $(".checkTr");
			for (var i = 1; i < trArr.length; i++) {
				trArr[i].onclick = function(){
					var flag = this.getAttribute("flag");
					var ids  = $("#checkIds").val();
					if(flag!=1){
						$(this).children().children().prop("checked",true);
						this.style.background = "yellow";
						$(this).attr("flag",1);
						ids += ","+$(this).children().children().val();
						$("#checkIds").val(ids);
					}else{
						$(this).children().children().prop("checked",false);
						this.style.background = "white";
						$(this).attr("flag",0);
						ids = $("#checkIds").val().replace(","+$(this).children().children().val(),"");
						$("#checkIds").val(ids);
					}
					
				}
			}	
		}
		//翻页时选中被选中的
		function initCheckbox(){
			var ids = $("#checkIds").val();
			var idsArr = ids.split(",");
			for(var i=0;i<idsArr.length;i++){
				$("input[name='ids']").each(function(){
					if($(this).val()==idsArr[i]){
						$(this).prop("checked",true);
						$(this).parent().parent().attr("style","background:yellow");
						$(this).parent().parent().attr("flag",1);
					}
				})
			}
		} */
	</script>
</body>
</html>









