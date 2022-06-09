<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
ul li {list-style:none; }
.fl {float:left; }
.tc {text-align:center; }

</style>
<script>
	'use strict';

	// 검색기능
	function tagCheck(){
		let tagSearch = $("#tagSearch").val();
		
		location.href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=5&item="+tagSearch;
	}
	
	function sellproduct(){
		let count = $("#count").val();
		let optionCount = "";
		let order ="";
		for(let i = 0; i<count;i++){
			order += $("#orderOption"+i).val() +'/';
			optionCount += $("#optionCount"+i).val() +'/';
		}
		let totPrice = $("#totPrice").val();
		alert(totPrice);
		$("#prdOption").val(order);
		$("#prdIdxCount").val(optionCount);
		myForm.submit();
	}
</script>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4; overflow: inherit;">
<div class="w3-bar w3-black w3-xlarge">
  <a href="${ctp}/main.log" class="w3-btn w3-black" style="text-decoration: none;">MUSINSA</a>
	<a href="javascript:tagCheck()" class="w3-bar-item w3-button w3-right"><i class="fa fa-search"></i></a>
	<input type="text" id="tagSearch" name="tagSearch" class="w3-bar-item w3-input w3-round w3-right mr-2 mt-2" style="width: 300px;height:40px;color:black;font-size: 18px;"/>
</div>
<div class="w3-large">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card w3-overflow">
	  <div class="w3-left w3-hide-small">
	  <c:if test="${empty sMid}">
	  	<a class="w3-bar-item w3-button" href="<%=request.getContextPath()%>/login.log">Login</a>
	  	<a href="<%=request.getContextPath()%>/join.log" class="w3-bar-item w3-button">Join</a>
	  </c:if>
	  <c:if test="${not empty sMid}">
	  <div class="w3-dropdown-click w3-white">
      <button onclick="myFunction()" class="w3-button">
	      <c:if test="${sGrade == 0}">⚔<font color="red">관리자</font>&nbsp;[<b>${sNickName}님</b>]</c:if>
	      <c:if test="${sGrade == 1}">🥉<font color="brown">브론즈</font>&nbsp;[<b>${sNickName}님</b>]</c:if>
	      <c:if test="${sGrade == 2}">🥈<font color="darkgray">실버</font>&nbsp;[<b>${sNickName}님</b>]</c:if>
	      <c:if test="${sGrade == 3}">🥇<font color="gold">골드</font>&nbsp;[<b>${sNickName}님</b>]</c:if>
	      <c:if test="${sGrade == 4}">🏆<font color="platinum">플래티넘</font>&nbsp;[<b>${sNickName}님</b>]</c:if>
      </button>
      
    	<div id="Demo" class="w3-dropdown-content w3-bar-block w3-border">
      	<a href="<%=request.getContextPath()%>/myPage.log" class="w3-bar-item w3-button" style="text-decoration: none;">마이페이지</a>
      	<a href="#" class="w3-bar-item w3-button" style="text-decoration: none;">1:1 문의(준비중)</a>
      	<a href="javascript:logout()" class="w3-bar-item w3-button" style="text-decoration: none;"><font color="red">로그아웃</font></a>
    	</div>
		</div>
	  </c:if>
  	</div>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <a href="<%=request.getContextPath()%>/prdProductMain.prd?pag=1&pageSize=16&part=0" class="w3-bar-item w3-button">shop</a>
      <a href="#about" class="w3-bar-item w3-button">About</a>
      <a href="#contact" class="w3-bar-item w3-button">Contact</a>
    </div>
    </div>
  </div>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white " style="z-index:3;width:300px;" id="mySidebar"><br>

  <div class="w3-container">

  <h4>SHOP</h4>
  </div>
  <hr/>
  <div class="w3-bar-block">
  	<a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=0" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 0}">w3-light-blue</c:if>"><i class="fa fa-bars fa-fw" style="text-decoration-line: none;"></i>  전체상품</a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=1" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 1}">w3-light-blue</c:if>">  상의 <small>Top</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=2" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 2}">w3-light-blue</c:if>">  아우터 <small>Outer</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=3" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 3}">w3-light-blue</c:if>">  하의 <small>Pants</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=4" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 4}">w3-light-blue</c:if>">  스커트 <small>Skirt</small></a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main " style="margin-left:300px;margin-top:120px;">
	<div class="ml-3 mr-3 w3-white" style="max-height: 100%">
	  <!-- Header -->
	  <header class="w3-container w3-border " style="padding-top:5px;height: 80px">
	    <h3><b>Order / Success</b></h3>
	  </header>
	  <div class="w3-container w3-border p-5" >
	  	<h4><b>Thanks</b></h4>
	  	<div class="w3-container w3-border text-center" style="height: 400px">
	  		<div class="w3-container mb-4">
	  			<img src="${ctp}/images/musinsa.jpg" style="height: 150px">
	  			<h4><b>주문이 완료되었습니다.</b></h4>
	  			<p>감사합니다 보다 더 나은 <b>MUSINSA</b> 로 자리잡겠습니다.</p>
	  			<p>자세한 주문현황은 마이페이지에서 확인해주세요</p>
	  		</div>
	  		<div class="w3-container">
	  			<input type="button" class="w3-button w3-gary w3-border" onclick="location.href='${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=0';" value="쇼핑하기"/>
	  			<input type="button" class="w3-button w3-gary w3-border" onclick="location.href='${ctp}/myPage.log';" value="마이페이지"/>
	  		</div>
	  	</div>
	  </div>
	</div>
</div>
<script>
function myFunction() {
  var x = document.getElementById("Demo");
  if (x.className.indexOf("w3-show") == -1) { 
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
<script>
'use strict';

function logout(){
	let ans = confirm("로그아웃 하시겠습니까?");
	if(ans){
		location.href="${ctp}/logOut.log"
	}
}

</script>
</body>
</html>