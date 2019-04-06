function initAreaSel(areaSel,areaId,selAreaId){
    $.ajax({
        url:"http://192.168.1.48:8090/api/area/queryAreaByPid.jhtml",
        dataType:"jsonp",
        data: {"id":areaId},
        success:function(result){
            if(result.code==200){
                var v_dataArr = result.data;
                for(var i=0;i<v_dataArr.length;i++){
                    $("#"+areaSel).append("<option value='"+v_dataArr[i].id+"'>"+v_dataArr[i].areaName+"</option>");
                }
               if(selAreaId){
                    console.log(selAreaId);
                    $("#"+areaSel).val(selAreaId);
                }
            }
        }
    })
}