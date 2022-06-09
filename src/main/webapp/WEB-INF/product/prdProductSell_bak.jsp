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
	
	//전역변수 선택박스 (cnt)
	let cnt = 0;
	
	// 검색기능
	function tagCheck(){
		let tagSearch = $("#tagSearch").val();
		
		location.href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=5&item="+tagSearch;
	}
	// 사이즈선택후 선택박스 불러오는 js (이미같은상품이있는지검사와 동시에 선택상품가격과 total값 계산)
	$(function() {
	    $("#selectSize").on('change', function(){
	    	selectBox();
	    });
	});
	function selectBox(){
		let check = $("#selectColor").val()+"_"+ $("#selectSize").val();
		
		for(let i = 1; i<=cnt; i++){
			if(check == $("#colorSize"+i).val()){
				alert("이미등록된 상품입니다");
				return false;
			}
		}
		
		cnt++;
		let price = ${vo.sPrice};
		let size = $("#selectSize").val();
		
		let color = $("#selectColor").val();
		
		
		let prdcnt = 0 ;
		
		$('#demo').append("<div id='itembox"+cnt+"'><div class='input-group w3-light-gray p-3'><div class='w3-left'><h5><b><span id ='item"+cnt+"'>"+color+" / "+size+"</span></b></h5></div><div class='w3-right'><h5><a href='javascript:delCount("+cnt+")' id='delCount"+cnt+"'style='width: 50px'>X</a></h5></div><div class='w3-right mr-4'><h5><span id='price"+cnt+"'>${vo.sPrice}</span></h5></div><div class='w3-right'><input type='number' onchange='prdCount("+cnt+")' class='w3-input mr-5' id='prdCount"+cnt+"' value='1' style='width: 50px'/></div></div></div><input type='hidden' id='colorSize"+cnt+"' value='"+color+"_"+size+"'/><input type='hidden' id='productCount"+cnt+"' value='1'/>");
		
		
		for(let i = 1; i<=cnt; i++){
			prdcnt += Number($('#productCount'+i).val());
		}
		let totPrice = price * prdcnt;
		
		$('#demo1').text(totPrice);
	}
	
	// 컬러 선택후 사이즈불러오는 js
	$(function() {
	    $("#selectColor").on('change', function(){
	    	$('#selectSize > option').remove();
	    	selectColor();
	    });
	});
	function selectColor() {
	    let selectColor = $("#selectColor").val();
	    let prdIdx = $("#prdIdx").val();
	    $('#selectSize').append("<option value='' selected>사이즈 선택</option>");
	    
	    
	    $.ajax({
	    	type : "post",
	    	url : "${ctp}/sizeSearch",
	    	data : {
	    		color : selectColor,
	    		idx : prdIdx
	    	},
	    	success : function(data){
	    		let items = data.split("/");
	    		
	    		for(var i = 0; i < items.length-1; i++){
	    			$('#selectSize').append("<option value='"+items[i]+"'>"+items[i]+"</option>");
	    		} 
	    	}
	    });
	}
	
	// 전체 구매 
	function sellProduct(){
		let info = "";
		
		for(let i = 1; i<=cnt; i++){
			info += $("#colorSize"+i).val() + "_" + $("#prdCount"+i).val()+"/"
		}
		$("#totPrd").val(info);
		
		myForm.submit();
	}
	
	//선택 박스 수량클릭시 선택값 total값계산
	function prdCount(idx){
		let cidx = idx;
		let price = ${vo.sPrice};
		let num = $("#prdCount"+cidx).val();
		let prdcnt = 0 ;
		
		let prdPrice = price * num;
		$('#price'+idx).text(prdPrice);
		
		$('#productCount'+idx).val(num);
		
		for(let i = 1; i<=cnt; i++){
			prdcnt += Number($('#productCount'+i).val());
		}
		let totPrice = price * prdcnt;
		
		$('#demo1').text(totPrice);
		
	}
	
	// 선택 박스삭제 (동시에 total값계산)
	function delCount(idx){
		let didx = idx;
		let prdcnt = 0 ;
		let price = ${vo.sPrice};
		$("#colorSize"+didx).val("");
		$("#productCount"+didx).val("");
		$("#itembox"+didx).remove();
		
		for(let i = 1; i<=cnt; i++){
			prdcnt += Number($('#productCount'+i).val());
		}
		let totPrice = price * prdcnt;
		
		$('#demo1').text(totPrice);
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
      	<a href="#" class="w3-bar-item w3-button" style="text-decoration: none;">Link 2</a>
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
	  <header class="w3-container mb-4 w3-black" style="padding-top:22px">
	    <h4><b>${vo.brandName}</b></h4>
	  </header>
	  <c:forEach begin="0" end="${fn:length(totprd)-1}" var="i">
	  <c:set var="tot" value="${fn:split(totprd[i],'_')}" />
	  <div>
	  <p>옵션번호 : ${tot[3]}  색상 : ${tot[1]}  사이즈 : ${tot[2]}  수량 :${tot[0]}  </p>
	  </div>
	  </c:forEach>	  
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