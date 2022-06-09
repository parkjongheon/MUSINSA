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
    <a href="${ctp}/adminMain.ad" class="w3-bar-item w3-button w3-padding w3-blue"><i class="fa fa-bars fa-fw" style="text-decoration-line: none;"></i>  전체보기</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  회원 관리</a>
    <a href="${ctp}/adminProductMain.ad?pag=1&pageSize=15&part=0&item=0" class="w3-bar-item w3-button w3-padding"><i class="fa fa-shopping-bag fa-fw"></i>  상품 관리</a>
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
    <h5><b> AdminPage</b></h5>
  </header>

  <div class="w3-row-padding w3-margin-bottom">
  <div class="w3-quarter">
      <div class="w3-container w3-orange w3-text-white w3-padding-16">
        <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
        <div class="w3-right">
          <h3>${delUserCount} / ${userCount}</h3>
        </div>
        <div class="w3-clear"></div>
        <h4>회원 관리</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-red w3-padding-16">
        <div class="w3-left"><i class="fa fa-shopping-bag w3-xxxlarge"></i></div>
        <div class="w3-right">
          <h3>${prdCount}</h3>
        </div>
        <div class="w3-clear"></div>
        <h4>상품 관리</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-blue w3-padding-16">
        <div class="w3-left"><i class="fa fa-eye w3-xxxlarge"></i></div>
        <div class="w3-right">
          <h3>0</h3>
        </div>
        <div class="w3-clear"></div>
        <h4>방문 기록</h4>
      </div>
    </div>
    <div class="w3-quarter">
      <div class="w3-container w3-teal w3-padding-16">
        <div class="w3-left"><i class="fa fa-truck w3-xxxlarge"></i></div>
        <div class="w3-right">
          <h3>${orderCount} / ${orderAllCount}</h3>
        </div>
        <div class="w3-clear"></div>
        <h4>주문 관리</h4>
      </div>
    </div>
    
  </div>
  <div class="w3-container">
		    <h4><a href="" >회원 목록</a></h4>
		    <table class="w3-table w3-striped w3-bordered w3-border w3-hoverable w3-white">
		      <tr>
		        <th style="width: 5%">번호</th>
		        <th style="width: 5%">회원번호</th>
		        <th style="width: 20%">아이디</th>
		        <th style="width: 20%">닉네임</th>
		        <th style="width: 10%">등급</th>
		        <th style="width: 10%">누적금액</th>
		        <th style="width: 10%">탈퇴여부</th>
		      </tr>
		      <c:forEach var="vo" items="${vos}" varStatus="st">
		      <tr>
		        <td>${st.count}</td>
		        <td>${vo.idx}</td>
		        <td>${vo.mid}</td>
		        <td>${vo.nickName}</td>
		        <td>
		        <c:if test="${vo.grade == 0}">⚔<font color="red">관리자</font></c:if>
			      <c:if test="${vo.grade == 1}">🥉<font color="brown">브론즈</font></c:if>
			      <c:if test="${vo.grade == 2}">🥈<font color="darkgray">실버</font></c:if>
			      <c:if test="${vo.grade == 3}">🥇<font color="gold">골드</font></c:if>
			      <c:if test="${vo.grade == 4}">🏆<font color="platinum">플래티넘</font></c:if>
		        </td>
		        <td>${vo.totPrice} &#8361;</td>
		        <td>${vo.userDel}</td>
		      </tr>      
		      </c:forEach>      
		    </table>
    		<ul class="pagination text-center w3-center">
    		<c:if test="${pag != 1}">
					<li class="page-item"><a class="page-link" href="adminMain.ad?pag=${pag-1}"><</a></li>
    		</c:if>
    		<c:if test="${curScrStartNo == 5}">
					<li class="page-item"><a class="page-link" href="adminMain.ad?pag=${pag+1}">></a></li>						
    		</c:if>
				</ul>
    <hr/>
  </div>
  <hr>

  <br>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>MUSINSA</h4>
  </footer>

  <!-- End page content -->

</script>
</div>
</body>
</html>