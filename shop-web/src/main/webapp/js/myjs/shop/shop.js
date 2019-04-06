/*
function initBrandSel(brandSel){
	$.ajax({
		url:path+"/brand/list.jhtml",
		type:"post",
		success:function(result){
			if(result.code==200){
				var v_dataArr = result.data;
				for(var i=0;i<v_dataArr.length;i++){
					$(".brandSel").append("<option value='"+v_dataArr[i].id+"'>"+v_dataArr[i].brandName+"</option>");
				}
			}
		}
	})
}*/
function initBrandSel(brandSel,brandId){
    $.ajax({
        url:path+"/brand/list.jhtml",
        type:"post",
        success:function(result){
            if(result.code==200){
                var v_dataArr = result.data;
                for(var i=0;i<v_dataArr.length;i++){
                    $("#"+brandSel).append("<option value='"+v_dataArr[i].id+"'>"+v_dataArr[i].brandName+"</option>");
                }
                if(brandId){
                    $("#"+brandSel).val(brandId);
                }
            }
        }
    })
}
