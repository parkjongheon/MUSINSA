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


</style>
<script>
	'use strict';
	
	//전역변수 선택박스 (cnt)
	let cnt = 0;
	
	// 검색기능
	function tagCheck(){
		let tagSearch = $("#tagSearch").val();
		
		location.href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=5&item="+tagSearch;
	}
	// 사이즈선택후 선택박스 불러오는 js (이미같은상품이있는지검사와 동시에 선택상품가격과 total값 계산)
	$(function() {
	    $("#selectSize").on('change', function(){
	    	selectBox();
	    });
	});
	function selectBox(){
		let price = ${vo.sPrice};
		let size = $("#selectSize").val();
		let color = $("#selectColor").val();
		let getSize = size.split("_");
		let prdIdx = getSize[0]
		let prdSize = getSize[1];
		let prd = color+"_"+prdSize+"_"+prdIdx;
		let prdcnt = 0 ;
		
		for(let i = 1; i<=cnt; i++){
			if(prd == $("#colorSize"+i).val()){
				alert("이미등록된 상품입니다");
				return false;
			}
		}
		
		cnt++;
		
		
		$('#demo').append("<div id='itembox"+cnt+"'>"
		+"<div class='input-group w3-light-gray p-3'>"
		+"<div class='w3-left'>"
		+"<h5><b><span id ='item"+cnt+"'>"+color+" / "+prdSize+"</span></b></h5>"
		+"</div>"
		+"<div class='w3-right'>"
		+"<h5><a href='javascript:delCount("+cnt+")' id='delCount"+cnt+"'style='width: 50px'>X</a></h5>"
		+"</div>"
		+"<div class='w3-right mr-4'>"
		+"<h5><span id='price"+cnt+"'>${vo.sPrice}</span></h5>"
		+"</div>"
		+"<div class='w3-right'>"
		+"<input type='number' onchange='prdCount("+cnt+")' class='w3-input mr-5' id='prdCount"+cnt+"' value='1' min='1' max='10' style='width: 50px'/>"
		+"</div>"
		+"</div>"
		+"</div>"
		+"<input type='hidden' id='colorSize"+cnt+"' value='"+prd+"'/>"
		+"<input type='hidden' id='productCount"+cnt+"' value='1'/>");
		
		
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
	    			let size = items[i].split("_");
	    			$('#selectSize').append("<option value='"+items[i]+"'>"+size[1]+"</option>");
	    		} 
	    	}
	    });
	}
	
	// 전체 구매 
	function sellProduct(){
		let info = "";
		let trash = "";
		for(let i = 1; i<=cnt; i++){
			let a = $("#colorSize"+i).val();
			let b = $("#productCount"+i).val();
			if(a == "" || b == ""){
				trash += $("#productCount"+i).val()+"_"+$("#colorSize"+i).val()+"/";				
				
			}
			else{
				info += $("#productCount"+i).val()+"_"+$("#colorSize"+i).val()+"/";				
			}
		}
		if(info == ""){
			alert("상품을 선택해주세요");
			return false;
		}
		
		$("#tot").val(info);
		
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
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white " style="z-index:3;width:300px;" id="mySidebar"><br>

  <div class="w3-container">

  <h4>SHOP</h4>
  </div>
  <hr/>
  <div class="w3-bar-block">
  	<a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=0" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 0}">w3-light-blue</c:if>"><i class="fa fa-bars fa-fw" style="text-decoration-line: none;"></i>  전체상품</a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=1" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 1}">w3-light-blue</c:if>">  상의 <small>Top</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=2" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 2}">w3-light-blue</c:if>">  아우터 <small>Outer</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=3" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 3}">w3-light-blue</c:if>">  하의 <small>Pants</small></a>
    <a href="${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=4" class="w3-bar-item w3-button w3-padding <c:if test="${param.part == 4}">w3-light-blue</c:if>">  스커트 <small>Skirt</small></a>
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
	  <div class="w3-container p-5">
		  <div class="w3-half pl-5">
			  <div class="w3-container">
			  	<div class="mb-5">
					  <h4><b>${vo.name}</b></h4>
			  	</div>
			  	<div class="card w3-card" style="width:500px">
			    	<img class="card-img-top p-4" src="${ctp}/data/product/${vo.fSName}" alt="Card image" style="width:100%">
	  			</div>
			  </div>
		  </div>
		  <div class="w3-half">
		  	<div class="w3-container mt-5" style="width: 480px">
		  		<p><b>한정 판매</b></p>
		  		<p><font color="gray">무신사 스토어를 포함한 제한된 판매처에서만 구매 가능한 상품입니다.</font></p>
		  		<hr/>
		  		<p><b>Product Info</b> <font color="gray"><small>제품정보</small></font></p><br/>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	브랜드  / 품번 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5> <b>${vo.brandName} / ${vo.idx}</b></h5>
		  			</div>
		  		</div>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	상품명 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5><b> ${vo.name}</b></h5>
		  			</div>
		  		</div>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	누적판매 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5><b> ${vo.sell} 건 </b></h5>
		  			</div>
		  		</div>
		  		<div class="w3-container">
		  			<c:forEach var="i" begin="1" end="${fn:length(tagContent)-1}">
			  			<input class="w3-button w3-gary w3-border w3-small mb-2" onclick="location.href='${ctp}/prdProductMain.prd?pag=1&pageSize=18&part=5&item=${tagContent[i]}';" type="button" value="#${tagContent[i]}"/>
		  			</c:forEach>
		  			
		  		</div>
		  		<hr/>
		  		<p><b>Delivery Info</b> <font color="gray"><small>배송정보</small></font></p><br/>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	출고 정보 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5><b> 결제 3일 이내 출고</b></h5>
		  			</div>
		  		</div>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	배송 방법 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5><b> 국내 배송 / 입점사 배송</b></h5>
		  			</div>
		  		</div>
		  		
		  		
		  		<hr/>
		  		<p><b>Price Info</b> <font color="gray"><small>가격정보</small></font></p><br/>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	무신사 판매가 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<h5><b> ${vo.sPrice } 원</b></h5>
		  			</div>
		  		</div>
		  		<div class="w3-container">
		  			<div class="w3-half" style="width: 140px">
		  			<h5>	무신사 적립금 </h5>
		  			</div>
		  			<div class="w3-half">
		  			<fmt:parseNumber var="point" value="${vo.sPrice /100}" integerOnly="true"/>
		  			<h5><b>${point} POINT</b></h5>
		  			</div>
		  		</div>
		  		
		  		<hr/>
		  		<c:if test="${not empty cvos}">
		  		<input type="hidden" id="selectColor" value="${cvo.color}"/>
		  		<div class="mb-5">
		  			<p><b>Color Info</b> <small> 
		  			<c:if test="${cvo.color == 'black'}">${cvo.color} ⬛</c:if>
	  				<c:if test="${cvo.color == 'white'}">${cvo.color} ⬜</c:if>
	  				<c:if test="${cvo.color == 'red'}">${cvo.color} 🟥</c:if>
	  				<c:if test="${cvo.color == 'orange'}">${cvo.color} 🟧</c:if>
	  				<c:if test="${cvo.color == 'yellow'}">${cvo.color} 🟨</c:if>
	  				<c:if test="${cvo.color == 'green'}">${cvo.color} 🟩</c:if>
	  				<c:if test="${cvo.color == 'blue'}">${cvo.color} 🟦</c:if>
	  				<c:if test="${cvo.color == 'purple'}">${cvo.color} 🟪</c:if>
	  				<c:if test="${cvo.color == 'brown'}">${cvo.color} 🟫</c:if>
	  				<c:if test="${cvo.color == 'navy'}">${cvo.color} ◼</c:if>
	  				<c:if test="${cvo.color == 'gray'}">${cvo.color} ◽</c:if>
		  			</small></p>
		  		</div>
		  		</c:if>
		  		<c:if test="${not empty vos}">
		  		<div class="form-group w3-light-gray p-3">
		  			<select class="w3-input" id="selectColor" name="selectColor">
		  				<option value="" disabled selected="selected">컬러 선택</option>
		  				<c:forEach var="vo" items="${vos}" varStatus="st">
		  				<option value="${vo.color}">
		  				<c:if test="${vo.color == 'black'}">${vo.color} ⬛</c:if>
		  				<c:if test="${vo.color == 'white'}">${vo.color} ⬜</c:if>
		  				<c:if test="${vo.color == 'red'}">${vo.color} 🟥</c:if>
		  				<c:if test="${vo.color == 'orange'}">${vo.color} 🟧</c:if>
		  				<c:if test="${vo.color == 'yellow'}">${vo.color} 🟨</c:if>
		  				<c:if test="${vo.color == 'green'}">${vo.color} 🟩</c:if>
		  				<c:if test="${vo.color == 'blue'}">${vo.color} 🟦</c:if>
		  				<c:if test="${vo.color == 'purple'}">${vo.color} 🟪</c:if>
		  				<c:if test="${vo.color == 'brown'}">${vo.color} 🟫</c:if>
		  				<c:if test="${vo.color == 'navy'}">${vo.color} ◼</c:if>
		  				<c:if test="${vo.color == 'gray'}">${vo.color} ◽</c:if>
		  				</option>
		  				</c:forEach>
		  			</select>
		  		</div>
		  			</c:if>
		  		<div class="form-group w3-light-gray p-3">
		  			<select class="w3-input" id="selectSize" name="selectSize">
		  				<option>사이즈 선택</option>
		  				<c:forEach var="cvo" items="${cvos}" varStatus="st">
		  				<option value='${cvo.idx}_${cvo.size}'>${cvo.size}</option>
		  				</c:forEach>
		  			</select>
		  		</div>
		  		
		  		<div id="demo">
			  		
		  		</div>
		  		
		  		<div class="input-group w3-light-gray p-3">
			  		<div class="w3-left">
			  			<h5><b>총 상품 금액</b></h5>
			  			<input type="hidden" id="totPrice" value=""/>
			  		</div>
				  	<div class="w3-right">
			  			<h5><b>원</b></h5>
				  	</div>		
			  		<div class="w3-right">
			  			<div><h5 id="demo1"></h5></div>
			  		</div>
		  		</div>
		  		<div class="input-group w3-white mt-5">
		  		<input type="button" class="w3-button w3-blue mr-2" value="바로 구매" onclick="sellProduct()" style="width: 250px;height: 60px"/>
		  		<input type="button" class="w3-button w3-border mr-2" value="장바구니" style="width: 90px;height: 60px"/>
		  		<input type="button" class="w3-button w3-border" value="❤" style="width: 90px;height: 60px"/>
		  		</div>
		  	</div>
		  </div>
	  	<br>
		</div>
		<hr/>
		<form name="myForm" method="post" action="${ctp}/productSell.prd">
			<input type="hidden" name="tot" id="tot" value="">
		  <input type="hidden" value="${param.idx}" id="prdIdx" name="prdIdx"/>
		</form>
  	<div class="w3-container mt-5 text-center">
  		<img src="${ctp}/data/product/${vo.fSContent}" class="w3-border w3-padding" alt="Alps">
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