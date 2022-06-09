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
	
	function setOrder(idx){
		let info = $("#setOrderInfo"+idx).val();
		let oIdx = idx;
		let ans = confirm("상태를 변경하시겠습니까?");
		
		if(ans){
			$.ajax({
				type : "post",
				url : "${ctp}/orderUpdate.ord",
				data : {
					info : info,
					idx : oIdx
				},
				success : function(data){
					if(data == '1'){
						location.reload();
					}
				}
			});
		}
	}
	

	$(function() {
	    $("#selectSearch").on('change', function(){
	    	orderSearch();
	    });
	});
	function orderSearch(){
		let part = $("#selectSearch").val();
		
		location.href="${ctp}/adOrderList.ad?pag=${pag}&pageSize=${pageSize}&part="+part;
		
		
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
    <a href="${ctp}/adminProductMain.ad?pag=1&pageSize=15&part=0&item=0" class="w3-bar-item w3-button w3-padding "><i class="fa fa-shopping-bag fa-fw"></i>  상품 관리</a>
    <a href="${ctp}/adOrderList.ad" class="w3-bar-item w3-button w3-padding w3-blue"><i class="fa fa-shopping-cart fa-fw"></i> 주문관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-eye fa-fw"></i>  방문기록</a>
  </div>
</nav>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

  <!-- Header -->
  <header class="w3-container" style="padding-top:22px">
    <h5><b> OrderPage</b></h5>
  </header>
  <div class="w3-row-padding w3-margin-bottom">
  </div>
  <div class="w3-container">
	  <p>
	  <b>상세검색</b>
	  </p>
	  <div class="w3-container w3-border p-4 mb-3 w3-round-large">
	  	<p>
				<select class="w3-select w3-border w3-round-large from-control mr-3 w3-third mb-4" name="selectSearch" id="selectSearch" style="width: 200px">
						
						<option value="0" <c:if test="${param.part == 0}">selected</c:if> >전체보기</option>	
						<option value="1" <c:if test="${param.part == 1}">selected</c:if> >주문접수</option>	
						<option value="2" <c:if test="${param.part == 2}">selected</c:if> >배송중</option>	
						<option value="3" <c:if test="${param.part == 3}">selected</c:if> >배송완료</option>	
						
				</select>
	    </p>
	    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
	      <tr>
	        <th style="width: 5%">번호</th>
	        <th style="width: 5%">주문자</th>
	        <th style="width: 20%">주소</th>
	        <th style="width: 5%">받는사람</th>
	        <th style="width: 20%">주문상세</th>
	        <th style="width: 10%">총 가격</th>
	        <th style="width: 10%">주문상태</th>
	        <th style="width: 5%">비고</th>
	      </tr>
	      <c:if test="${empty vos}">
	      	<tr>
	      		<td colspan="8" class="text-center">주문내역이 없습니다.</td>
	      	</tr>
	      </c:if>
	      <c:if test="${not empty vos}">
	      <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	      	<td>${vo.idx}</td>
	      	<td>${vo.sellName}</td>
	      	<td>${vo.pickAddress}(${vo.pickPost})</td>
	      	<td>${vo.pickName}</td>
	      	
	      	<td>
	      	<c:set var="options" value="${fn:split(vo.prdOption,'/')}"/>
						<c:forEach var="i" begin="0" end="${fn:length(options)-1}">
							<c:set var="option" value="${fn:split(options[i],'_')}"/>
									${vo.prdName} : ${option[0]}  ${option[1]} - ${option[2]} 장<br/>	
						</c:forEach>
	      	</td>
	      	
	      	<td>${vo.totPrice}</td>
	      	<td>
	      		<c:if test="${vo.orderSw == 0}"><b>상품준비중</b></c:if>
	      		<c:if test="${vo.orderSw == 1}"><b>주문 접수</b></c:if>
	      		<c:if test="${vo.orderSw == 2}"><b>배송 접수</b></c:if>
	      		<c:if test="${vo.orderSw == 3}"><font color="blue"><b>배송 완료</b></font></c:if>
	      	</td>
	      	<td>
	      		<c:if test="${vo.orderSw == 0 || vo.orderSw == 1 || vo.orderSw == 2 }">
	      		<select class="w3-select w3-border w3-round-large" name="setOrderInfo" id="setOrderInfo${vo.idx}" style="width: 100px" onchange="setOrder('${vo.idx}')">
	      		<c:if test="${vo.orderSw == 0}">
							<option value="0" disabled="disabled" <c:if test="${vo.orderSw == 0}">selected</c:if> >상품준비중</option>	
							<option value="1">주문 접수</option>	
							<option value="2">배송 접수</option>	
							<option value="3">배송완료</option>
	      		</c:if>
	      		<c:if test="${vo.orderSw == 1}">
							<option value="1" disabled="disabled" <c:if test="${vo.orderSw == 1}">selected</c:if> >주문 접수</option>	
							<option value="2">배송 접수</option>	
							<option value="3">배송완료</option>
						</c:if>
	      		<c:if test="${vo.orderSw == 2}">
							<option value="2" disabled="disabled" <c:if test="${vo.orderSw == 2}">selected</c:if> >배송 접수</option>	
							<option value="3" <c:if test="${vo.orderSw == 3}">selected</c:if> >배송완료</option>	
						</c:if>
						</select>
						</c:if>
						<c:if test="${vo.orderSw == 3 }">
							<font color="blue">배송 완료</font>
						</c:if>
	      	</td>
	      </tr>
	      </c:forEach>
	      </c:if>	      
	    </table>
	    </div>
    <hr/>
	  <div class="w3-bar text-center">
	  <c:if test="${not empty vos}">
	  <c:if test="${pag != 1}">
	  <a href="adOrderList.ad?pag=1&pageSize=${pageSize}" class="w3-button w3-xlarge">&laquo;</a>
	  </c:if>
	  <c:if test="${curBlock > 1 }">
	  <a href="adOrderList.ad?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&laquo;</a>
	  </c:if>
	  <c:set var="no" value="${(curBlock*blockSize)+1}"/>
		<c:set var="size" value="${(curBlock*blockSize)+blockSize}"/>
		<c:forEach var="i" begin="${no}" end="${size}">
			<c:choose>
				<c:when test="${i > totPage}"></c:when>
				<c:when test="${i == pag}">
					<a href="adOrderList.ad?pag=${i}&pageSize=${pageSize}" class="w3-button w3-green">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="adOrderList.ad?pag=${i}&pageSize=${pageSize}" class="w3-button">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	  <c:if test="${curBlock < lastBlock}">
			<a href="adOrderList.ad?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
		</c:if>
		<c:if test="${pag != totPage}">
			<a href="adOrderList.ad?pag=${totPage}&pageSize=${pageSize}" class="w3-button w3-xlarge">&raquo;</a>
		</c:if>
	  </c:if>		
		</div>
  </div>
  </div>
  <hr>
  <br>
</body>
</html>