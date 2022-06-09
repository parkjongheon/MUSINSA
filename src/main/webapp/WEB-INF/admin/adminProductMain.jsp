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
</head>
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
</style>
<script>
	'use strict';
	
	function myFunction(idx){
		let url = "${ctp}/prdOptionSearch.ad?idx="+idx;
		        var windowW = 1200;  // 창의 가로 길이
		        var windowH = 800;  // 창의 세로 길이
		        var left = Math.ceil((window.screen.width - windowW)/2);
		        var top = Math.ceil((window.screen.height - windowH)/2);
		window.open(url,"pop_01","l top="+top+", left="+left+", height="+windowH+", width="+windowW);
	}
	function productSearch(){
		let part = $("#selectSearch").val();
		let item= $("#itemSearch").val();
		
		location.href="${ctp}/adminProductMain.ad?pag=${pag}&pageSize=${pageSize}&part="+part+"&item="+item;
		
		
	}
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
  
  <a href="${ctp}/main.log" class="w3-bar-item w3-left w3-text-white" style="text-decoration: none;">MUSINSA</a>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white " style="z-index:3;width:300px;" id="mySidebar"><br>

  <div class="w3-container">
    <h4>관리자 메뉴</h4>
  </div>
  <hr/>
  <div class="w3-bar-block">
  	<a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="${ctp}/adminMain.ad" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bars fa-fw" style="text-decoration-line: none;"></i>  전체보기</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  회원 관리</a>
    <a href="${ctp}/adminProductMain.ad?pag=1&pageSize=15&part=0&item=0" class="w3-bar-item w3-button w3-padding w3-blue"><i class="fa fa-shopping-bag fa-fw"></i>  상품 관리</a>
    <a href="${ctp}/adOrderList.ad" class="w3-bar-item w3-button w3-padding"><i class="fa fa-shopping-cart fa-fw"></i>  주문관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-eye fa-fw"></i>  방문기록</a>
  </div>
</nav>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b> ProductPage</b></h5>
  </header>
  <div class="w3-row-padding w3-margin-bottom">
  </div>
  <div class="w3-container">
	  <p>
	  <b>상세검색</b>
	  </p>
	  <div class="w3-container w3-border p-4 mb-3 w3-round-large">
	  	<p>
				<select class="w3-select w3-border w3-round-large from-control mr-3 w3-third" name="selectSearch" id="selectSearch" style="width: 200px">
						
						<option value="0" <c:if test="${param.part == 0}">selected</c:if>  >전체보기</option>	
						<option value="1" <c:if test="${param.part == 1}">selected</c:if> >브랜드</option>	
						<option value="2" <c:if test="${param.part == 2}">selected</c:if> >카테고리</option>	
						<option value="3" <c:if test="${param.part == 3}">selected</c:if> >상품검색</option>	
						
				</select>
				<input type="text" class="w3-input w3-border w3-round-large w3-third mr-3" name="itemSearch" id="itemSearch" placeholder="입력" style="width: 200px"/>
	    	<input type="button" class="w3-button w3-green w3-round-large mb-3" onclick="productSearch()" value="검색" />
	    	<input type="button" class="w3-button w3-blue w3-round-large w3-right mb-3" onclick="location.href='${ctp}/adminProduct.ad?pag=${param.pag}&pageSize=${param.pageSize}&part=${param.part}&item=${param.item}';" value="상품 등록"/>
	    </p>
	    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
	      <tr>
	        <th style="width: 5%">번호</th>
	        <th style="width: 10%">브랜드</th>
	        <th style="width: 10%">카테고리</th>
	        <th style="width: 20%">상품이름</th>
	        <th style="width: 10%">상품가격(원)</th>
	        <th style="width: 10%">상품가격(판매)</th>
	        <th style="width: 10%">판매현황</th>
	        <th style="width: 10%">비고</th>
	      </tr>
	      <c:if test="${empty vos}">
	      	<tr>
	      		<td colspan="8" class="text-center">검색결과가 없습니다.</td>
	      	</tr>
	      </c:if>
	      <c:if test="${not empty vos}">
	      <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	      	<td>${vo.idx}</td>
	      	<td>${vo.brandName}</td>
	      	<td>${vo.category}</td>
	      	<td>
	      	<a href="javascript:myFunction('${vo.idx}')">${vo.name}</a>
	      	</td>
	      	<td>${vo.rPrice}</td>
	      	<td>${vo.sPrice}</td>
	      	<td>
	      		<c:if test="${vo.sellStop == 0}"><b>판매중</b></c:if>
	      		<c:if test="${vo.sellStop == 1}"><font color="red"><b>판매 중지</b></font></c:if>
	      	</td>
	      	<td></td>
	      </tr>
	      </c:forEach>
	      </c:if>	      
	    </table>
	    </div>
    <hr/>
	  <div class="w3-bar text-center">
	  <c:if test="${not empty vos}">
	  <c:if test="${pag != 1}">
	  <a href="adminProductMain.ad?pag=1&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button w3-xlarge">&laquo;</a>
	  </c:if>
	  <c:if test="${curBlock > 1 }">
	  <a href="adminProductMain.ad?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button">&laquo;</a>
	  </c:if>
	  <c:set var="no" value="${(curBlock*blockSize)+1}"/>
		<c:set var="size" value="${(curBlock*blockSize)+blockSize}"/>
		<c:forEach var="i" begin="${no}" end="${size}">
			<c:choose>
				<c:when test="${i > totPage}"></c:when>
				<c:when test="${i == pag}">
					<a href="adminProductMain.ad?pag=${i}&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button w3-green">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="adminProductMain.ad?pag=${i}&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	  <c:if test="${curBlock < lastBlock}">
			<a href="adminProductMain.ad?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button">&raquo;</a>	
		</c:if>
		<c:if test="${pag != totPage}">
			<a href="adminProductMain.ad?pag=${totPage}&pageSize=${pageSize}&part=${param.part}&item=${param.item}" class="w3-button w3-xlarge">&raquo;</a>
		</c:if>
	  </c:if>		
		</div>
  </div>
  </div>
  <hr>
  <br>
</body>
</html>