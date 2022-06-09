<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	
	<style>
	.g{
		font-family: 'icomoon';
	}
	.myPage{
		width: 850px;
		height : 800px;
		border-style: solid;
	  border-width: 2px;
	  border-color: #edf0f5;
	  border-radius: 10px;
	}
	.myPageInfo{
		width: 900px;
		height: 200px;
	}
	#myScrollspy{
		border-radius: 10px;
		border-style: solid;
	  border-width: 2px;
	  border-color: #edf0f5;
	  height : 920px;
	  width: 500px;
	}	

	</style>
  <meta charset="UTF-8">
  <%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
  <title>title</title>
</head>
<body>
<%@ include file="/include/nav.jsp"%>     <!-- 네이바 -->
    <div class="container-fluid pl-4" style="margin-top:30px;margin-bottom:150px;  height: 100%; ">
		  <div class="row">
		     	<%@ include file="/include/sidebar.jsp" %>
		    <div class="col-sm-10 col-8">
		     	<div class="row">
		     		<div class="myPage p-3 ml-2" style="width:1300px;height: 100%;">
			     			<h2>MyPage</h2>
			     			<hr>
		     			<div class="container mt-3">
			     			<h2>회원 정보</h2>
			     			<div class="myPageInfo p-2">
			     			<p><font size="5px">${sMid}</font> [ <small>${vo.nickName}</small> ] 님 환영합니다.</p>
			     			<div class="w3-row-padding w3-margin-bottom">
								  <div class="w3-third">
								      <div class="w3-container
								      <c:if test="${grade == 'ADMIN'}">w3-teal</c:if>
								      <c:if test="${grade == 'Bronze'}">w3-brown</c:if>
								      <c:if test="${grade == 'silver'}">w3-gray</c:if>
								      <c:if test="${grade == 'Gold'}">w3-amber</c:if>
								      <c:if test="${grade == 'Platinum'}">w3-cyan</c:if>
								        w3-text-white w3-padding-16">
								        <div class="w3-left"><i class="fa fa-address-card-o w3-xxxlarge"></i></div>
								        <div class="w3-right">
								          <h3>${grade }</h3>
								        </div>
								        <div class="w3-clear"></div>
								        <h4>등급</h4>
								      </div>
								    </div>
								    <div class="w3-third">
								      <div class="w3-container w3-red w3-padding-16">
								        <div class="w3-left"><i class="fa fa-shopping-bag w3-xxxlarge"></i></div>
								        <div class="w3-right">
								          <h3>${vo.point }.PT</h3>
								        </div>
								        <div class="w3-clear"></div>
								        <h4>POINT</h4>
								      </div>
								    </div>
								    <div class="w3-third">
								      <div class="w3-container w3-blue w3-padding-16">
								        <div class="w3-left"><i class="fa fa-plus w3-xxxlarge"></i></div>
								        <div class="w3-right">
								          <h3>${vo.totPrice} &#8361;</h3>
								        </div>
								        <div class="w3-clear"></div>
								        <h4>누적 금액</h4>
								      </div>
								    </div>
							  	</div>
			     			</div>
		     			</div>
				     	<div class="container mt-3">
						  <h2>주문 내역</h2>
						  <br>
						  <!-- Nav tabs -->
						  <ul class="nav nav-tabs" style="width:1120px">
						    <li class="nav-item">
						      <a class="nav-link active" data-toggle="tab" href="#home">전체</a>
						    </li>
						    
						  </ul>
						
						  <!-- Tab panes -->
						  <div class="tab-content">
						    <div id="home" class="container tab-pane active"><br>
						    	<c:if test="${empty ordvos}">
						     	 <h3>주문내역이 없습니다.</h3>
						    	</c:if>
						      <c:if test="${not empty ordvos}">
						      <c:forEach var="orvo" items="${ordvos}">
						      <div class="w3-container w3-border mb-4" style="max-height: 500px">
						      	<div class=" w3-container w3-quarter text-center" style="width: 10%;padding: 10px;height: 100%;"><h5><b>${orvo.sellDate}</b></h5></div>
							  		<div class="w3-quarter text-center  w3-border-right w3-border-left" style="width: 50%;height: 100%;">
											<div class="w3-half p-4 mr-4" style="width: 30%">
												<img src="${ctp}/data/product/${orvo.prdfSName}" style="width:110px;height: 120px">
											</div>
											<div class="w3-half text-left" style="width: 320px;height: 100%">
												<div class="w3-container mb-3"><h5><b>[${orvo.prdBrand}] ${orvo.prdName}</b></h5></div>
												<div class="w3-container w3-border w3-round-large">
												<c:set var="options" value="${fn:split(orvo.prdOption,'/')}"/>
													<c:forEach var="i" begin="0" end="${fn:length(options)-1}">
														<c:set var="option" value="${fn:split(options[i],'_')}"/>
																<div class="w3-container"><h5><b>옵션 : 색상 ${option[0]} / 사이즈 ${option[1]}/ 수량${option[2]}</b></h5></div>	
													</c:forEach>
												</div>
											</div>
										</div>
										<div class="w3-quarter text-center w3-border-right" style="width: 20%;padding: 60px;height: 100%"><h5><b> 가격 : ${orvo.totPrice }</b></h5></div>
	  								<div class="w3-quarter text-center" style="width: 20%;padding: 60px;height: 100%">
	  								<c:if test="${orvo.orderSw == 0}"><h5><b>상품준비중</b></h5></c:if>
	  								<c:if test="${orvo.orderSw == 1}"><h5><b>주문 접수</b></h5></c:if>
	  								<c:if test="${orvo.orderSw == 2}"><h5><b>배송중</b></h5></c:if>
	  								<c:if test="${orvo.orderSw == 3}"><h5><b>배송완료</b></h5></c:if>
	  								</div>
									</div>
						      </c:forEach>
						      <br>
  								<div class="w3-bar text-center mt-5">
						      <c:if test="${pag != 1}">
									  <a href="${ctp}/myPage.log?pag=1&pageSize=${pageSize}" class="w3-button w3-xlarge">&laquo;</a>
									  </c:if>
									  <c:if test="${curBlock > 1 }">
									  <a href="${ctp}/myPage.log?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&laquo;</a>
									  </c:if>
									  <c:set var="no" value="${(curBlock*blockSize)+1}"/>
										<c:set var="size" value="${(curBlock*blockSize)+blockSize}"/>
										<c:forEach var="i" begin="${no}" end="${size}">
											<c:choose>
												<c:when test="${i > totPage}"></c:when>
												<c:when test="${i == pag}">
													<a href="${ctp}/myPage.log?pag=${i}&pageSize=${pageSize}" class="w3-button w3-blue">${i}</a>
												</c:when>
												<c:otherwise>
													<a href="${ctp}/myPage.log?pag=${i}&pageSize=${pageSize}" class="w3-button">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									  <c:if test="${curBlock < lastBlock}">
											<a href="${ctp}/myPage.log?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="w3-button">&raquo;</a>	
										</c:if>
										<c:if test="${pag != totPage}">
											<a href="${ctp}/myPage.log?pag=${totPage}&pageSize=${pageSize}" class="w3-button w3-xlarge">&raquo;</a>
										</c:if>
						      </div>
								</c:if>
						    </div>
						    <div id="menu1" class="container tab-pane fade"><br>
						      <h3>배송중인 상품이 없습니다.</h3>
						      
						    </div>
						    <div id="menu2" class="container tab-pane fade"><br>
						      <h3>배송완료된 상품이 없습니다.</h3>
						    </div>
						  </div>
						</div>
					</div>
				</div>
	    </div>
	  </div>
	</div>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>