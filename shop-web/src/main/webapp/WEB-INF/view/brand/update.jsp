<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<input type="hidden" value="${brand.id}" id="brandId"/>
<table>
	<tr>
		<td>品牌名字:</td>
		<td><input type="text" id="updateBrandName" value="${brand.brandName}"/></td>
	</tr>
	<tr>
		<td><input type="button" value="修改" onclick="updateBrand()"/></td>			
	</tr>
</table>