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
		function resetOk(){
			$("#email1").val("");
			$("#email1").focus();
			
			$("#name").val("");
			$("#tel1").val("010");
	    $("#tel2").val("");
	    $("#tel3").val("");
			$("#name").focus();
		}
		
		function idEmailSearchOk(){
			let email1 = $("#email1").val();
			let email2 = $("#email2").val();
			
			let email = email1 + "@" + email2;
			
			
			
			if(email1.trim() == ""){
				$("#demo > p").remove();
		  	$("#demo").append("<p><font color='red'>이메일을 입력해주세요</font></p>");
		  	$("#email1").focus();
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/idEmailSearchOk",
					data : {email : email},
					success : function(data){
						if(data == '1'){
							$("#demo > p").remove();
							$("#demo").append("<p><font color='red'>존재하지않는 이메일입니다.</font></p>");
						}
						else{
							location.href="${ctp}/idSearchOk.log?mid="+data;
						}
					},
					error : function(){
						alert("전송실패 관리자문의요망");
					}
				});
			}
		}
		
		function idTelSearchOk(){
			let name = $("#name").val();
			let tel1 = $("#tel1").val();
	    let tel2 = $("#tel2").val();
	    let tel3 = $("#tel3").val();
	    let tel = tel1 + "-" + tel2 + "-" + tel3;
	    let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g; 
			
			
			
			if(name.trim() == ""){
				$("#demo1 > p").remove();
		  	$("#demo1").append("<p><font color='red'>성명을 입력해주세요</font></p>");
		  	$("#name").focus();
			}
			else if(tel1.trim() == "" || tel2.trim() == "" || tel3.trim() == ""){
				$("#demo1 > p").remove();
		  	$("#demo1").append("<p><font color='red'>전화번호를 정확히 입력해주세요</font></p>");
		  	$("#tel2").focus();
			}
			else if(!regTel.test(tel)) {
				$("#demo1 > p").remove();
		  	$("#demo1").append("<p><font color='red'>전화번호를 정확히 입력해주세요</font></p>");
		  	$("#tel2").focus();
		    return false;
		  }
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/idTelSearchOk",
					data : {
						name : name,
						tel : tel
						},
					success : function(data){
						if(data == '1'){
							$("#demo1 > p").remove();
							$("#demo1").append("<p><font color='red'>입력하신 정보가 존재하지 않습니다.</font></p>");
						}
						else{
							location.href="${ctp}/idSearchOk.log?mid="+data;
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
								<a href="${ctp}/main.log"><img src="${ctp}/images/musinsa.jpg" style="width: 200px"></a>
							</div>
							<h4 class="mb-4">아이디 찾기</h4>
						</div>
						<c:if test="${empty param.res || param.res == '0'}">
						<div class="input-group mb-2 text-center">
						<input type="button" class="btn btn-success mr-2" style="width:200px;height: 100px;" onclick="location.href='${ctp}/idSearch.log?res=1';" value="이메일로 찾기"/>
						<input type="button" class="btn btn-info ml-2" style="width:200px;height: 100px;" onclick="location.href='${ctp}/idSearch.log?res=2';" value="연락처로 찾기"/>
						
						</div>
						</c:if>
						<c:if test="${param.res == '1'}">
						<form class="user" name="myForm" method="post" action="${ctp}/loginOk.log">
        			<div class="input-group mb-2 p-5">
			     				<input class="form-control" style="width:250px;" type="text" name="email1" id="email1" placeholder="이메일을 입력해주세요"/>
									
			     				<select name="email2" id="email2" class="form-control ml-3 mr-3" style="width:150px;" >
								    <option value="naver.com" selected>naver.com</option>
								    <option value="hanmail.net">hanmail.net</option>
								    <option value="hotmail.com">hotmail.com</option>
								    <option value="gmail.com">gmail.com</option>
								    <option value="nate.com">nate.com</option>
								    <option value="yahoo.com">yahoo.com</option>
					 			  </select>
			     			</div>
			     			<div class="text-center" id="demo"></div>
			     			<br/>
			     			<div class="text-center">
        			<input type="button" onclick="location.href='${ctp}/idSearch.log?res=0';" class="btn btn-secondary" value="돌아가기"/>
        			<input type="button" onclick="idEmailSearchOk()" class="btn btn-secondary" value="아이디 찾기"/>
        			<input type="button" onclick="resetOk()" class="btn btn-secondary" value="다시입력"/>
			     			</div>
    				</form>
    				</c:if>
    				<c:if test="${param.res == '2'}">
						<form class="user p-5" name="myForm" method="post" action="${ctp}/loginOk.log">
        			<div class="input-group p-3">
	        			<label for="name">이름</label>
			     			<div class="form-group">	
			     				<input class="form-control" style="width:400px;" type="text" name="name" id="name"/>
			     			</div>
			     		</div>
			     			<div class="input-group mb-2 p-3">
			     			<label for="tel1">전화번호</label>
			     			<div class="form-group">
				     			<select class="form-control mr-4" style="width:100px;" name="tel1" id="tel1">
								    <option value="010" selected>010</option>
								    <option value="02">서울</option>
								    <option value="031">경기</option>
								    <option value="032">인천</option>
								    <option value="041">충남</option>
								    <option value="042">대전</option>
								    <option value="043">충북</option>
						        <option value="051">부산</option>
						        <option value="052">울산</option>
						        <option value="061">전북</option>
						        <option value="062">광주</option>
					  			</select>
				     			<input class="form-control mr-4" style="width:130px;" type="text" name="tel2" id="tel2"/>
				     			<input class="form-control" style="width:130px;" type="text" name="tel3" id="tel3"/>
				     			<input type="hidden" name="tel" id="tel"/>
			     			</div>
			     			</div>
		     			
		     			<div class="text-center" id="demo1"></div>
		     			<br/>
		     			<div class="text-center">
	        			<input type="button" onclick="location.href='${ctp}/idSearch.log?res=0';" class="btn btn-secondary" value="돌아가기"/>
	        			<input type="button" onclick="idTelSearchOk()" class="btn btn-secondary" value="아이디 찾기"/>
	        			<input type="button" onclick="resetOk()" class="btn btn-secondary" value="다시입력"/>
		     			</div>
    				</form>
    				</c:if>
    				<hr/>
    				<div class="text-center mb-2">
        			<a class="small" href="${ctp}/pwdSearch.log">비밀번호를 잊으셨나요?</a>
    				</div>
    				<div class="text-center">
    					<a class="small" href="${ctp}/join.log">회원이 아니신가요?</a>
      			</div>
    			</div>
  			</div>
			</div>
 		</div>
	</div>
</div>
</body>
</html>