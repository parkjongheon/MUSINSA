<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies !=null) {
		for(int i=0; i<cookies.length; i++){
			
			if(cookies[i].getName().equals("cMid")){
				pageContext.setAttribute("cMid", cookies[i].getValue());
				break;
			}
		}
	}
%>
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
		function loginOk(){
			let mid = $("#mid").val();
			let pwd = $("#pwd").val();
			let idSave = $("#idSave").val();
			
			
			
			if(mid.trim() == ""){
				$("#demo > p").remove();
		  	$("#demo").append("<p><font color='red'>아이디를 입력해주세요</font></p>");
			}
			else if(pwd.trim() == ""){
				$("#demo > p").remove();
			  $("#demo").append("<p><font color='red'>비밀번호를 입력해주세요</font></p>");
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/logOk",
					data : {
						mid : mid,
						pwd : pwd,
						idSave : idSave
					},
					success : function(data){
						if(data == '1'){
							$("#demo > p").remove();
							$("#demo").append("<p><font color='red'>존재하지않는 아이디입니다.</font></p>");
						}
						else{
							location.href="${ctp}/logSession.log?mid="+data;
						}
					},
					error : function(){
						alert("전송실패 관리자문의요망");
					}
				});
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
							<div class="mb-4">
								<a href="${ctp}/main.log"><img src="${ctp}/images/musinsa.jpg" style="width: 300px"></a>
							</div>
							<h4 class="mb-4">Login</h4>
						</div>
						<form class="user" name="myForm" method="post" action="${ctp}/loginOk.log">
        			<div class="form-group">
        				<input type="text" class="form-control" name="mid" id="mid"
        				<c:if test="${not empty param.checkMid}">value="${param.checkMid}"</c:if>
        				<c:if test="${empty cMid}">placeholder="아이디를 입력해주세요"</c:if>
        				<c:if test="${not empty cMid}">value="${cMid}"</c:if>/>
        			</div>
        			<div class="form-group">
            		<input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호"/>
        			</div>
        			<div id="demo"></div>
        			<div class="form-group">
            		<input type="checkbox" class="form-control-input" name="idSave" id="idSave" checked/>
            		<label class="form-control-label" for="idSave">아이디 저장</label>
        			</div>
        			<!-- <input type="submit" class="btn btn-secondary btn-block" value="login"/> -->
        			<input type="button" onclick="loginOk()" class="btn btn-secondary btn-block" value="login"/>
        			<hr>
    				</form>
    				<div class="text-center mb-2">
        			<a class="small" href="${ctp}/idSearch.log">아이디 찾기</a>   /   <a class="small" href="${ctp}/pwdSearch.log">비밀번호 찾기</a>
    				</div>
    				<div class="text-center">
    					<a class="small" href="${ctp}/join.log">회원가입</a>
      			</div>
    			</div>
  			</div>
			</div>
 		</div>
	</div>
</div>
</body>
</html>