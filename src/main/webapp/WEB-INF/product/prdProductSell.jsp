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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/js/woo.js"></script>
<script>
	'use strict';

	// 검색기능
	function tagCheck(){
		let tagSearch = $("#tagSearch").val();
		
		location.href="${ctp}/prdProductMain.prd?pag=1&pageSize=16&part=5&item="+tagSearch;
	}
	
	function sellproduct(){
		let address = $("#sample6_address").val();
		let detailAddress = $("#sample6_detailAddress").val();
		let extraAddress = $("#sample6_extraAddress").val();
		let post = $("#sample6_postcode").val();
		
		let totAddress = address + "/" + detailAddress + "/" + extraAddress;
		
		$("#ordPost").val(post);
		$("#ordAddress").val(totAddress);
		
		
		let count = $("#count").val();
		let optionCount = "";
		let order ="";
		for(let i = 0; i<count;i++){
			order += $("#orderOption"+i).val() +'/';
			optionCount += $("#optionCount"+i).val() +'/';
		}
		let totPrice = $("#totPrice").val();
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
	    <h3><b>Order / Payment</b></h3>
	  </header>
	  <form name="myForm" method="post" action="${ctp}/orderOk.ord">
	  <div class="w3-container w3-border p-5 ">
	  	<h4><b>Recipient Info</b> <font color="gary"><small>수령자 정보</small></font></h4>
	  	<div class="w3-container w3-border">
	  		<div class="w3-half" style="width: 20%"><h5><b>아이디</b></h5></div>
	  		<div class="w3-half"><h5>${memvo.mid}</h5></div>
	  		<input type="hidden" id="ordMid" name="ordMid" value="${memvo.mid}"/>
	  	</div>
	  	<div class="w3-container w3-border">
	  		<div class="w3-half" style="width: 20%"><h5><b>주문자</b></h5></div>
	  		<div class="w3-half"><h5>${memvo.name}</h5></div>
	  		<input type="hidden" id="ordName" name="ordName" value="${memvo.name}"/>
	  	</div>
	  	<div class="w3-container w3-border">
	  		<div class="w3-half" style="width: 20%"><h5><b>전화번호</b></h5></div>
	  		<div class="w3-half"><h5>${memvo.tel}</h5></div>
	  		<input type="hidden" id="ordTel" name="ordTel" value="${memvo.tel}"/>
	  	</div>
	  	
	  	
	  	<div class="w3-container w3-border mt-3 p-3">
	  		<div class="w3-half" style="width: 20%"><h5><b>수령자</b></h5></div>
	  		<div class="w3-half">
	  			<div class="container">
		  				<input class="w3-input w3-border" style="width:200px;" type="text" name="pickName" value="${memvo.name}" id="pickName" placeholder="수령자">	  		
	  			</div>
	  		</div>
	  	</div>
	  	<div class="w3-container w3-border p-3">
	  		<div class="w3-half" style="width: 20%"><h5><b>배송지 주소</b></h5></div>
	  		<div class="w3-half">
	  			<div class="container mb-2">
		  			<div class="w3-half" style="width:220px;">
		  				<input class="w3-input w3-border" style="width:200px;" type="text" name="postcode" id="sample6_postcode" value="${memvo.post}" placeholder="우편번호">
		  			</div>
		  			<div class="w3-half">
							<input class="w3-button w3-border" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">	  			
		  			</div>	  			
	  			</div>
	  			<div class="container mb-2">
	  				<c:set var="address" value="${fn:split(memvo.address,'/')}"/>
	  				<input class="w3-input w3-border" style="width:350px;" value="${address[0]}" type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소">	  			
	  			</div>
	  			<div class="container mb-2">
		  			<div class="w3-half" style="width:170px">
			  			<input class="w3-input w3-border mr-3" style="width:150px;" value="${address[1]}" type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">	  			
		  			</div>
		  			<div class="w3-half" >
							<input class="w3-input w3-border" style="width:200px; "value="${address[2]}" type="text" name="extraAddress" id="sample6_extraAddress" size="25" placeholder="참고항목">	  			
		  			</div>  			
	  			</div>
				</div>
	  		<input type="hidden" id="ordAddress" name="ordAddress" value=""/>
	  		<input type="hidden" id="ordPost" name="ordPost" value=""/>
	  	</div>
	  	<div class="w3-container w3-border mb-4 p-3">
	  		<div class="w3-half" style="width: 20%;height: 30px"><h5><b>배송 메모</b></h5></div>
	  		<div class="w3-half">
	  			<select class="w3-input w3-border p-3" id="ordMemo" name="ordMemo" style="width: 400px;height: 40px">
	  				<option value="" disabled="disabled" selected>배송 시 요청사항을선택해주세요.</option>
	  				<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
	  				<option value="부재 시 택배함에 넣어주세요.">부재 시 택배함에 넣어주세요.</option>
	  				<option value="부재 시 집 앞에 놔주세요.">부재 시 집 앞에 놔주세요.</option>
	  				<option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
	  				<option value="파손의 위험이 있는 상품입니다. 배송 시 주의해주세요.">파손의 위험이 있는 상품입니다. 배송 시 주의해주세요.</option>
	  			</select>
	  		</div>
	  	</div>
	  	
	  </div>
		<div class="w3-container w3-border p-5">
	  	<h4><b>Product Info</b> <font color="gary"><small>상품 정보</small></font></h4>
	  	<div class="w3-container w3-border">
	  		<div class="w3-third text-center" style="width: 60%"><h5><b>상품 정보</b></h5></div>
	  		<div class="w3-third text-center" style="width: 20%"><h5><b>수량</b></h5></div>
	  		<div class="w3-third text-center" style="width: 20%"><h5><b>주문금액</b></h5></div>
	  	</div>
	  	<input type="hidden" id="ordBrandName" name="ordBrandName" value="${prdvo.brandName}">
	  	<input type="hidden" id="ordPrdName" name="ordPrdName" value="${prdvo.name}">
	  	<c:forEach begin="0" end="${fn:length(totprd)-1}" var="i">
	  		<c:set var="tot" value="${fn:split(totprd[i],'_')}" />
	  	<div class="w3-container w3-border">
	  		<div class="w3-third text-center  w3-border-right" style="width: 60%">
					<div class="w3-half p-4 " style="width: 20%">
						<img src="${ctp}/data/product/${prdvo.fSName}" style="width:100px;height: 100px">
					</div>
					<div class="w3-half text-left" >
						<div class="w3-container mb-3"><h5><b>[${prdvo.brandName}] ${prdvo.name}</b></h5></div>
						<div class="w3-container w3-border w3-round-large">
							<div class="w3-container"><h5><b>옵션 : 색상 / 사이즈</b></h5></div>
							<div class="w3-container"><h5><b>${tot[1]} /  ${tot[2]}</b></h5></div>
							<input type="hidden" id="optionCount${i}" name="optionCount${i}" value="${tot[3]}_${tot[0]}"/>
							<input type="hidden" id="orderOption${i}" name="orderOption${i}" value="${tot[1]}_${tot[2]}_${tot[0]}"/>
						</div>
					</div>
				</div>
	  		<div class="w3-third text-center w3-border-right" style="width: 20%;padding: 50px"><h5><b>${tot[0]}</b></h5></div>
	  		<div class="w3-third text-center" style="width: 20%;padding: 50px"><h5><b>${prdvo.sPrice * tot[0]}</b></h5></div>
	  	</div>
	  	<c:set var="count" value="${count = i+1}"/>
	  	<c:set var="cnt" value="${cnt = cnt + tot[0]}"/>
	  	</c:forEach>
	  	<input type="hidden" value="${cnt}" id="cnt" name="cnt"/>
	  	<input type="hidden" value="${count}" id="count" name="count"/>
	  </div>
	  <div class="w3-container w3-border p-5 ">
	  	<h4><b>Payment info / Agreement</b> <font color="gary"><small>결제 정보 / 주문자 동의</small></font></h4>
	  	<div class="w3-container w3-border p-2">
	  		<div class="w3-half" style="width: 20%"><h5><b>상품금액</b></h5></div>
	  		<div class="w3-half"><h5>${prdvo.sPrice * cnt} 원</h5></div>
	  		<input type="hidden" id="totPrice" name="totPrice" value="${prdvo.sPrice * cnt}"/>
	  	</div>
	  	<div class="w3-container w3-border p-2">
	  		<div class="w3-half" style="width: 20%"><h5><b>적립금</b></h5></div>
	  		<fmt:parseNumber var="point" value="${(prdvo.sPrice * cnt)/100}" integerOnly="true"/>
	  		<div class="w3-half"><h5>${point} POINT</h5></div>
	  		<input type="hidden" id="point" name="point" value="${point}"/>
	  		<input type="hidden" id="prdOption" name="prdOption" value=""/>
	  		<input type="hidden" id="prdIdxCount" name="prdIdxCount" value=""/>
	  	</div>
	  	<div class="w3-container w3-border p-2">
	  		<div class="w3-half" style="width: 20%"><h5><b>품절 시 환불 안내</b></h5></div>
	  		<div class="w3-half w3-left">
	  			<ul>
	  				<li><b>결제하신 수단으로 취소됩니다.</b></li>
	  				<li>·입점업체 배송은 낮은 확률로 상품이 품절일 가능성이 있습니다. 이에 품절 시 빠르게 환불 처리해드립니다.</li>
	  				<li>·현금 환불의 경우, 예금정보가 일치해야 환불 처리가 가능합니다. 은행명, 계좌번호, 예금주명을 정확히 기재 부탁드립니다.</li>
	  				<li>·환불 받으신 날짜 기준으로 3~5일(주말 제외) 후 결제대행사에서 직접 고객님의 계좌로 환불 처리됩니다</li>
	  			</ul>
	  		</div>
	  	</div>
	  	<div class="w3-container w3-border p-2 mb-4">
	  		<div class="w3-half" style="width: 20%"><h5><b>주문자 동의</b></h5></div>
	  		<div class="w3-half w3-left">
	  			<ul>
	  				<li><b>회원 본인은 구매 조건, 주문 내용 확인 및 결제에 동의합니다</b></li>
	  				<li>·개인정보 수집 및 이용 동의</li>
	  				<li>·개인정보 제 3자 제공 동의</li>
	  				<li>·전자결제대행 이용 동의</li>
	  			</ul>
	  		</div>
	  	</div>
	  	<div class="w3-container text-center">
	  		<input type="button" class="w3-button w3-blue w3-round" onclick="sellproduct()" value="결제하기"/>
	  	</div>
	  </div>
	  </form>
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