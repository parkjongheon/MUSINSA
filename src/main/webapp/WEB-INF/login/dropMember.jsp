<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>	
<%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
	<style>
		.content{
            width: 600px;
            height: 800px;
			border-style: solid;
	 	 	border-width: 2px;
	 		border-color: #edf0f5;
	  	    border-radius: 10px;
	  	
		}
        .flex-container{
            width: 100%;
            height: 100vh;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            justify-content: center;
        }
	</style>
	<script>
	'use strict';
	
	function deleteOk(){
		let checked = $('#agree').is(':checked');
		
		if(checked == false){
			alert("탈퇴하시려면 동의버튼을 눌러주세요");
			return false;
		}
		else{
			let ans = confirm("탈퇴하시겠습니까?");
			  if(ans){
				  location.href = "${ctp}/dropMemberOk.log";
			  }
		}
	}
	</script>
  <meta charset="UTF-8">
  <title>login</title>
</head>
<body>
<div class="flex-container">
	<div class="row ">
		<div class="col">
			<div class="content ">
				<div class="col-xl">
					<div class="p-5">
						<div class="text-center">
							<div class="mb-5">
								<h1>MUSINSA</h1>
							</div>
							<h4 class="mb-4">회원 탈퇴</h4>
							</div>
							<div class="input-group mb-2 p-5 text-center">
			     				<p>[ <b>${sMid}</b> ] 님</p>
			     				<p>탈퇴하시면 지금까지의 구매기록이 삭제됩니다. </p>
			     				<p>재가입시 멤버쉽 기록이 사라지며 복구가 불가합니다.</p>
			     				<p>또한 탈퇴후 10일동안 재가입이 불가능합니다</p>
			     				<p>탈퇴하시겠습니까?</p>
			     				<br/>
			     				<div class="form-group">
	            		<input type="checkbox" class="form-control-input" name="agree" id="agree"/>
	            		<label class="form-control-label" for="agree">네 동의합니다.</label>
        			</div>
			     		</div>
		     			<div class="text-center" id="demo"></div>
		     			<br/>
		     			<div class="text-center">
	        			<input type="button" onclick="location.href='${ctp}/myPage.log';" class="btn btn-secondary" value="돌아가기"/>
	        			<input type="button" onclick="deleteOk()" class="btn btn-danger" value="탈퇴하기"/>
			     		</div>
    					<hr/>
    			</div>
  			</div>
			</div>
 		</div>
	</div>
</div>
</body>
</html>