<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="ctp" value="${pageContext.request.contextPath }"/>

<script>
'use strict';

function logout(){
	let ans = confirm("로그아웃 하시겠습니까?");
	if(ans){
		location.href="${ctp}/logOut.log"
	}
}

</script>
<script>
	'use strict';
	function tagCheck(){
		let tagSearch = $("#tagSearch").val();
		
		location.href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=5&item="+tagSearch;
	}
</script>
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
body{
	height: 1500px;
}

html,body,h1,h2,h3,h4,nav {
text-decoration-line : none;
text-decoration : none;
}
nav{
font-family:system-ui;
font-size:20px;
}
.mySlides {display:none}
.w3-tag, .fa {cursor:pointer}
.w3-tag {height:15px;width:15px;padding:0;margin-top:6px}
</style>
<div class="w3-bar w3-black w3-xlarge">
  <a href="${ctp}/main.log" class="w3-btn w3-black" style="text-decoration: none;">MUSINSA</a>
	<a href="javascript:tagCheck()" class="w3-bar-item w3-button w3-right"><i class="fa fa-search"></i></a>
	<input type="text" id="tagSearch" name="tagSearch" class="w3-bar-item w3-input w3-round w3-right mr-2 mt-2" style="width: 300px;height:40px;color:black;font-size: 18px;"/>
</div>
<div class="w3-large">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
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
      	<a href="#" class="w3-bar-item w3-button" style="text-decoration: none;">1:1문의(준비중)</a>
      	<a href="javascript:logout()" class="w3-bar-item w3-button" style="text-decoration: none;"><font color="red">로그아웃</font></a>
    	</div>
		</div>
	  </c:if>
  	</div>
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <a href="<%=request.getContextPath()%>/prdProductMain.prd?pag=1&pageSize=18&part=0" class="w3-bar-item w3-button">shop</a>
      <a href="#about" class="w3-bar-item w3-button">About</a>

      <a href="#contact" class="w3-bar-item w3-button">Contact</a>
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
