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
<script type="text/javascript">
	'use strict';

	$(function() {
	    $("#brandFName").on('change', function(){
	    readURL(this);
	    });
	});
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	        $('#brandView').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	$(function() {
	    $("#fName").on('change', function(){
	    readURL1(this);
	    });
	});
	function readURL1(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	        $('#view').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	// 브랜드 버튼으로 카테고리 검색
	$(function() {
	    $("#brandSearch").on('change', function(){
	    $('#cSearch > option').remove();
	    brandSearch();
	    });
	});
	function brandSearch() {
	    let brandSearch = $("#brandSearch").val();
	    $('#cSearch').append("<option value='' selected>카테고리</option>");
	    
	    $.ajax({
	    	type : "post",
	    	url : "${ctp}/brandSearch",
	    	data : {brandSearch : brandSearch},
	    	success : function(data){
	    		let category = data.split("/");
	    		for(var i = 0; i < category.length-1; i++){
	    			$('#cSearch').append("<option value="+category[i]+">"+category[i]+"</option>");
	    		} 
	    	}
	    });
	}
	// 카테고리버튼으로 상품 검색
	$(function() {
	    $("#cSearch").on('change', function(){
	    	cSearch();
	    });
	});
	function cSearch() {
	    let brandSearch = $("#brandSearch").val();
	    let categorySearch = $("#cSearch").val();
	    $('#list1 > option').remove();
	    $.ajax({
	    	type : "post",
	    	url : "${ctp}/categorySearch",
	    	data : {
	    		brandSearch : brandSearch,
	    		categorySearch : categorySearch
	    		},
	    	success : function(datas){
	    		let items = datas.split("/");
	    		
	    		for(var i = 0; i < items.length-1; i++){
	    			$('#list1').append("<option value='"+items[i]+"'>"+items[i]+"</option>");
	    		} 
	    	}
	    });
	}
	
	
	
	function prdBrandInput(){
		let brand = $("#brandName").val();
		let brandFName = $("#brandFName").val();		
		let blank_pattern = /[\s]/g;
		
		if(brand.trim() == ""){
			$('#demo > p').remove();
			$('#demo').append("<p><font color='red'>브랜드명을 입력하세요.</font></p>");		
			$("#brandName").focus();
			return;
		}
		if(blank_pattern.test(brand) == true){
			$('#demo > p').remove();
			$('#demo').append("<p><font color='red'>공백은 허용하지않습니다.</font></p>");
			return;
		}
		if(brandFName.trim() == ""){
			$('#demo > p').remove();
			$('#demo').append("<p><font color='red'>사진을등록해주세요.</font></p>");
			return;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/brandCheck",
			data : {brand : brand},
			success : function(data){
				if(data == '1'){
					$('#demo > p').remove();
					myBrandForm.submit();
				}
				else{
					$('#demo > p').remove();
					$('#demo').append("<p><font color='red'>중복되는 브랜드입니다.</font></p>");
				}
			}
		});
		
	}
	
	function prdInput(){
		let fName = $("#fName").val();
		let brand = $("#brand").val();
		let category = $("#category").val();
		let product = $("#product").val();
		let rPrice = $("#rPrice").val();
		let sPrice = $("#sPrice").val();
		let content = $("#content").val();
		
		if(fName.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>상품 사진을 등록해주세요</font></p>");
			return;
		}
		else if(brand.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>브랜드명을 입력해주세요</font></p>");
			return;
		}
		else if(category == '1'){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>카테고리를 선택해주세요</font></p>");
			return;
		}
		else if(product.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>상품명을 입력해주세요.</font></p>");
			return;
		}
		else if(rPrice.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>원가를 입력해주세요.</font></p>");
			return;
		}
		else if(sPrice.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>판매가를 입력해주세요.</font></p>");
			return;
		}
		else if(content.trim() == ""){
			$('#demo1 > p').remove();
			$('#demo1').append("<p><font color='red'>상품(상세설명)사진을 등록해주세요</font></p>");
			return;
		}
		else{
			myPrdForm.submit();			
		}
	}
	// 옵션등록
	function prdOptionInput(){
		let name = $("#item").val(); 
		let color = $("#optionColor").val(); 
		let size = $("#optionSize").val(); 
		let count = $("#optionCount").val(); 
		
		if(name.trim() == ""){
			$('#demo2 > p').remove();
			$('#demo2').append("<p><font color='red'>상품명을 입력해주세요.</font></p>");
			return;
		}
		else if(color.trim() == ""){
			$('#demo2 > p').remove();
			$('#demo2').append("<p><font color='red'>색상을 선택해주세요.</font></p>");
			return;
		}
		else if(size.trim() == ""){
			$('#demo2 > p').remove();
			$('#demo2').append("<p><font color='red'>사이즈를 선택해주세요.</font></p>");
			return;
		}
		else if(count.trim() == ""){
			$('#demo2 > p').remove();
			$('#demo2').append("<p><font color='red'>수량을 입력해주세요.</font></p>");
			return;
		}
		else{
			$.ajax({
				type : "post",
				url : "${ctp}/optionInput",
				data : {
					name : name,
					color : color,
					size : size,
					count : count
				},
				success : function(data){
					if(data == "1"){
						$('#demo2 > p').remove();
						$('#demo2').append("<p>✔<font color='green'>등록되었습니다.</font></p>");
					}
					else{
						$('#demo2 > p').remove();
						$('#demo2').append("<p><font color='red'>실패</font></p>");
					}
				}
			});
		}
	}
	function prdOptionReset(){
		location.reload();
	}
	function tagSelect(){
		let tag = $("#tagitem").val();
		let tag1 = $("#tagContent").val();
		let tagItem = "#"+tag;
		let tagContent = tag1 + tagItem;
		$("#tagContent").val(tagContent);
		$("#tagitem").val("");
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
    <a href="${ctp}/adminMain.ad" class="w3-bar-item w3-button w3-padding w3-padding "><i class="fa fa-bars fa-fw" style="text-decoration-line: none;"></i>  전체보기</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  회원 관리</a>
    <a href="${ctp}/adminProductMain.ad?pag=1&pageSize=15&part=0&item=0" class="w3-bar-item w3-button w3-blue"><i class="fa fa-shopping-bag fa-fw"></i>  상품 관리</a>
    <a href="${ctp}/adOrderList.ad" class="w3-bar-item w3-button w3-padding"><i class="fa fa-shopping-cart fa-fw"></i>  주문관리</a>
    <a href="#" class="w3-bar-item w3-button w3-padding"><i class="fa fa-eye fa-fw"></i>  방문기록</a>
  </div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">
  <!-- 브랜드 등록 -->
  <div class=" p-2">
	  <input type="button" class="w3-button w3-gray w3-round-large btn-sm" value="돌아가기" onclick="location.href='${ctp}/adminProductMain.ad?pag=${param.pag}&pageSize=${param.pageSize}&part=${param.part}&item=${param.item}';">
  </div>
  <div class="w3-container" style="padding-top:22px">
  <form name="myBrandForm" method="post" action="${ctp}/adPrdBrandInput.ad?pag=${param.pag}&pageSize=${param.pageSize}&part=${param.part}&item=${param.item}" enctype="multipart/form-data">
    <h5><b> 브랜드 등록 </b></h5>
    <div class="w3-container w3-half w3-center" style="padding-left:150px;width: 600px;height: 500px;">
    	<div class="w3-card-4" style="width: 300px;height: 300px;">
			  <img src="./images/default1.png" class="p-5" style="width: 300px;height: 300px;" id="brandView" name="brandView"  alt="미리보기"/>
			</div>
			<div class="form-group ml-4 mt-4">
	    	<input type="file" class="w3-input w3-border w3-round-large" name="brandFName" id="brandFName" style="width: 250px"/>
    	</div>
    	<div class="w3-container">
	    	<div class="form-group">
		    	<input type="text" style="width: 250px"  class="w3-input w3-border w3-round-large" placeholder="브랜드명을 입력해주세요." id="brandName" name="brandName"/>
	    	</div>
	    		<div id="demo" class="w3-left" style="margin-left: 60px"></div>
	    	<div class="w3-container ">
	 		   	<input type="button" onclick="prdBrandInput()" class="w3-button w3-blue w3-round-large w3-left " style="margin-left: 70px" value="등록하기"/>
	 		   	<input type="hidden" value="${param.item}" name="sitem" id="sitem">
	    	</div>
    	</div>
    	<br/>
    </div>
    </form>
  </div>
  <!-- 상품 등록 -->
  <div class="w3-container" style="padding-top:22px">
  <form name="myPrdForm" method="post" action="${ctp}/adProductInput.ad?pag=${param.pag}&pageSize=${param.pageSize}&part=${param.part}" enctype="multipart/form-data">
    <h5><b> 상품 등록 </b></h5>
    <div class="w3-container w3-half w3-center" style="padding-left:150px;width: 600px;height: 400px;">
    	<div class="w3-card-4" style="width: 300px;height: 300px;">
			  <img src="./images/default.png" class="p-5" style="width: 300px;height: 300px;" id="view" name="view"  alt="미리보기"/>
			</div>
			<div class="form-group ml-4 mt-4">
	    	<input type="file" class="w3-input w3-border w3-round-large" name="fName" id="fName" style="width: 250px"/>
    	</div>
    </div>
    <div class="w3-container w3-half p-2  w3-round-xlarge" style="width: 850px">
    	<div class="w3-container">
	    	<div class="form-group w3-third ">
	    	<label for="brand">브랜드</label>
	    	<input type="text" style="width: 250px"  class="w3-input w3-border w3-round-large" list="list" id="brand" name="brand"/>
				  <datalist id ="list" >
				  <c:forEach var="vo" items="${vos}">
				    <option value="${vo.brandName}" />
				  </c:forEach>					    
				  </datalist>
	    	</div>
	    	<div class="form-group w3-third">
	    	<label for="category">카테고리</label>
		    	<select class="w3-select w3-border w3-round-large" name="category" id="category" style="width: 250px">
				    <option value="1" selected>카테고리</option>
				    <option value="상의">상의</option>
				    <option value="하의">하의</option>
				    <option value="아우터">아우터</option>
				    <option value="스커트">스커트</option>
				  </select>
	    	</div>
	    	<div class="form-group w3-third">
	    	<label for="product">상품명</label>
		    	<input type="text" class="w3-input w3-border w3-round-large" name="product" id="product" placeholder="상품명" style="width: 250px"/>
	    	</div>
			  <div class="form-group w3-third">
			  	<label for="price">(원)가격</label>
		    	<input type="text" class="w3-input w3-border w3-round-large" name="rPrice" id="rPrice" placeholder="가격" style="width: 250px"/>
	    	</div>
			  <div class="form-group w3-third">
			  	<label for="price">(판매)가격</label>
		    	<input type="text" class="w3-input w3-border w3-round-large" name="sPrice" id="sPrice" placeholder="가격" style="width: 250px"/>
	    	</div>
			  <div class="form-group w3-third">
			  <label for="content">상품설명(사진)</label>
		    	<input type="file" class="w3-input w3-border w3-round-large" name="content" id="content" style="width: 250px"/>
	    	</div>
	    	<div class="form-group w3-third">
	    		<input type="text" class="w3-input w3-border w3-round-large" name="tagitem" id="tagitem" style="width: 250px" placeholder="#태그"/>
	    	</div>
	    	<div class="form-group w3-third">
	    		<input type="button" onclick="tagSelect()" class="w3-button w3-green w3-round-large" value="추가" />
	    	</div>
	    	<div class="form-group">
	    		<input type="text" class="w3-input w3-border w3-round-large" value="" name="tagContent" id="tagContent"/>
	    	</div>
	    	<div id="demo1" class="w3-container text-center"></div>
	    	<div class="w3-container text-center">
	 		   	<input type="button" onclick="prdInput()" class="w3-button w3-blue w3-round-large" value="등록하기"/>
	    	</div>
	    	<input type="hidden" value="${param.item}" name="sitem" id="sitem">
    	</div>
    	<br/>
    </div>
    </form>
  </div>
  <!-- 상품 옵션 등록 -->
	<div class="w3-container" style="padding-top:22px;">
  	<form name="myPrd111Form" method="post" action="${ctp}/adProductInput111.ad" enctype="multipart/form-data">
    	<h5><b> 상품 옵션 등록 </b></h5>
	    <div class="w3-container w3-half p-2  w3-round-xlarge" style="width: 850px;margin-left: 300px;">
	    	<div class="w3-container">
		    	<div class="form-group w3-third ">
		    	<label for="brand">브랜드</label>
			    	<input type="text" style="width: 250px"  class="w3-input w3-border w3-round-large" list="list" id="brandSearch" name="brandSearch" placeholder="브랜드명" />
					  <datalist id ="list" >
					  <c:forEach var="vo" items="${vos}">
				    	<option value="${vo.brandName}" />
				  	</c:forEach>						    
					  </datalist>
		    	</div>
		    	<div class="form-group w3-third">
		    	<label for="category">카테고리</label>
			    	<select class="w3-select w3-border w3-round-large" name="cSearch" id="cSearch" style="width: 250px">
						    <option value="" disabled selected>카테고리</option>	
					  </select>
		    	</div>
				  <div class="form-group w3-third">
		    	<label for="item">상품명</label>
			    	<input type="text" style="width: 250px"  class="w3-input w3-border w3-round-large" list="list1" id="item" name="item" placeholder="상품명"/>
					  <datalist id ="list1" >
					  </datalist>
		    	</div>
				  <div class="form-group w3-third">
				  	<label for="optionColor">색상</label>
			    	<select class="w3-select w3-border w3-round-large" name="optionColor" id="optionColor" style="width: 250px">
						    <option value="" disabled selected>색상 선택</option>	
						    <option value="black">BLACK ⬛</option>
						    <option value="white">WHITE ⬜</option>	
						    <option value="red">RED 🟥</option>	
						    <option value="orange">ORANGE 🟧</option>	
						    <option value="yellow">YELLOW 🟨 </option>	
						    <option value="green">GREEN 🟩</option>	
						    <option value="blue">BLUE 🟦</option>	
						    <option value="purple">PURPLE🟪</option>	
						    <option value="brown">BROWN🟫</option>	
						    <option value="navy">NAVY◾</option>	
						    <option value="gray">gray◽</option>	
					  </select>
		    	</div>
				  <div class="form-group w3-third">
				  	<label for="optionSize">사이즈</label>
			    	<select class="w3-select w3-border w3-round-large" name="optionSize" id="optionSize" style="width: 250px">
						    <option value="" disabled selected>사이즈 선택</option>	
						    <option value="XXL">XXL</option>	
						    <option value="XL">XL</option>	
						    <option value="L">L</option>	
						    <option value="M">M</option>	
						    <option value="S">S</option>	
						    <option value="F">F</option>	
					  </select>
		    	</div>
				  <div class="form-group w3-third">
				  	<label for="optionCount">수량</label>
			    	<input type="number" class="w3-input w3-border w3-round-large" name="optionCount" id="optionCount" placeholder="수량" style="width: 250px"/>
		    	</div>
		    	<div id="demo2" class="w3-container text-center"></div>
		    	<div class="w3-container text-center">
		 		   	<input type="button" onclick="prdOptionInput()" class="w3-button w3-blue w3-round-large" value="등록하기"/>
		 		   	<input type="button" onclick="prdOptionReset()" class="w3-button w3-grey w3-round-large" value="다시입력"/>
		    	</div>
	    	</div>
	    	<br/>
	    </div>
    </form>
  </div>
	  <div class=" p-2">
	  <input type="button" class="w3-button w3-gray w3-round-large btn-sm" value="돌아가기" onclick="location.href='${ctp}/adminProductMain.ad?pag=${param.pag}&pageSize=${param.pageSize}&part=${param.part}&item=${param.item}';">
  </div>
  <br>
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>MUSINSA</h4>
    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
  </footer>

  <!-- End page content -->


</div>

</body>
</html>