<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
  <title>title</title>
  <script>
  	'use strict';
  	
  	function optionUpdate(idx){
  		let op = 'op'+idx;
  		let opValue = $("#"+op+"").val();
  		let opId = idx;
  		let ans = confirm("수정하시겠습니까?");
  		if(ans){
  			$.ajax({
  				type : "post",
  				url : "${ctp}/optionUpdate",
  				data : {
  					opValue : opValue,
  					opId : opId
  				},
  				success : function(data){
  					if(data == '1'){
  						alert("수정완료");
  					}
  					else{
  						alert("수정실패");  						
  					}
  				}
  			});
  		}
  	}
  	
  	function optionDelete(idx){
  		let opIdx = idx;
  		let ans = confirm("삭제하시겠습니까?");
  		
  		if(ans){
  			$.ajax({
  				type : "post",
  				url : "${ctp}/optionDelete",
  				data : {opIdx : opIdx},
  				success : function(data){
  					if(data == '1'){
  						alert("삭제완료");
  						location.reload();
  					}
  					else{
  						alert("삭제실패");  						
  					}
  				}
  			});
  		}
  	}
  	
  	function optionAllDelete(idx){
  		let opIdx = idx;
			let ans = confirm("정말 전체삭제하시겠습니까?");
  		
  		if(ans){
  			$.ajax({
  				type : "post",
  				url : "${ctp}/optionAllDelete",
  				data : {opIdx : opIdx},
  				success : function(data){
  					if(data == '1'){
  						alert("전체삭제완료");
  						location.href="{ctp}/prdOptionSearch.ad?idx="+opIdx+"&sw=0";
  					}
  					else{
  						alert("삭제실패");  						
  					}
  				}
  			});
  		}
  		
  	}
  </script>
</head>
<body>
  <div class="w3-container">
	  <div class="w3-left w3-half p-5 " style="width: 400px;">
	  	<div class="w3-card-4" style="width: 300px;height: 300px;">  	
			  <img src="${ctp}/data/product/${vo.fSName}" class="p-5" style="width: 300px;height: 300px;" id="brandView" name="brandView"  alt="미리보기"/>
			</div>
			
	  </div>
  	<div class="w3-rigth w3-half p-5">
  		<table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white text-center">
  			<tr>
  				<th style="width: 20%">색상</th>
	  			<th style="width: 20%">사이즈</th>
	  			<th style="width: 20%">수량</th>
  				<th style="width: 20%"></th>
  			</tr>
  				<c:forEach var="vos" items="${vos}" varStatus="st">
  			<tr>
  				<c:if test="${vos.color == 'black'}"><td>${vos.color}⬛</td></c:if>
  				<c:if test="${vos.color == 'white'}"><td>${vos.color}⬜</td></c:if>
  				<c:if test="${vos.color == 'red'}"><td>${vos.color}🟥</td></c:if>
  				<c:if test="${vos.color == 'orange'}"><td>${vos.color}🟧</td></c:if>
  				<c:if test="${vos.color == 'yellow'}"><td>${vos.color}🟨</td></c:if>
  				<c:if test="${vos.color == 'green'}"><td>${vos.color}🟩</td></c:if>
  				<c:if test="${vos.color == 'blue'}"><td>${vos.color}🟦</td></c:if>
  				<c:if test="${vos.color == 'purple'}"><td>${vos.color}🟪</td></c:if>
  				<c:if test="${vos.color == 'brown'}"><td>${vos.color}🟫</td></c:if>
  				<c:if test="${vos.color == 'navy'}"><td>${vos.color}◼</td></c:if>
  				<c:if test="${vos.color == 'gray'}"><td>${vos.color}◽</td></c:if>
  				<td>${vos.size}</td>
  				<c:if test="${sw == 1}">
  				<td><input type="number" value="${vos.count}" id="op${vos.opIdx}" style="width: 100px"></td>
  				</c:if>
  				<c:if test="${sw == 0}">
  				<td>${vos.count}</td>
  				</c:if>
  				<td>
  				<c:if test="${sw == 1}">
  					<input type="button" class="btn btn-info btn-sm" value="수정" onclick="optionUpdate('${vos.opIdx}')" style="height: 30px;">
  					<input type="button" class="btn btn-danger btn-sm " value="삭제" onclick="optionDelete('${vos.opIdx}')" style="height: 30px;">
  				</c:if>
  				</td>
  			</tr>
  				</c:forEach>
  		</table>
    </div>
    <div class="w3-container text-center mr-5">
    <c:if test="${sw == 1}">
    	<input type="button" class="btn btn-danger" onclick="optionAllDelete(${param.idx})" value="전체삭제">
    	<input type="button" class="btn btn-secondary" value="돌아가기" onclick="location.href='${ctp}/prdOptionSearch.ad?idx=${idx}&sw=0';" >
    </c:if>
    <c:if test="${sw == 0}">
	    <c:if test="${not empty vos}">
	    	<input type="button" class="btn w3-blue" value="수정/삭제" onclick="location.href='${ctp}/prdOptionSearch.ad?idx=${idx}&sw=1';">
  	  </c:if>	
	    	<input type="button" class="btn w3-gray" value="닫기" onclick="window.close()">
    </c:if>
    </div>
  </div> 
</body>
</html>