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
		
		function pwdSearchOk(){
			let upwd = $("#upwd").val();
			let upwd1 = $("#upwd1").val();
			let mid = $("#mid").val();
			let regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*]){8,16}/;
			
			
			if(!regPwd.test(upwd)) {
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호는 1개이상의 문자와 특수문자 조합의 8~20 자리로 작성해주세요.</font></p>");
        $("#upwd").focus();
        return false;
      }
      else if(upwd != upwd1) {
    	  $("#demo > p").remove();
				$("#demo").append("<p><font color='red'>두개의 비밀번호가 서로다릅니다 다시입력해주세요.</font></p>");
        $("#upwd1").focus();
        $("#upwd1").val("");
        return false;
      }
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/pwdSearchUpdate",
					data : {
						mid : mid,
						pwd : upwd
						},
					success : function(data){
						if(data == '1'){
							alert("전송실패 관리자문의요망");
						}
						else{
							alert("비밀번호가 변경되었습니다 로그인창으로 이동합니다.");
							location.href="${ctp}/login.log?checkMid="+data;
							
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
							<div class="mb-5">
								<h1>MUSINSA</h1>
							</div>
							<h4 class="mb-4">비밀번호 변경</h4>
						</div>
						<div class="p-5 ml-5">
						<form class="user" name="myForm" method="post" action="${ctp}/loginOk.log">
        			<div class="input-group mb-4">
			     			<label for="upwd">비밀번호</label>
		     				<div class="form-group">			     			
		     					<input class="form-control" style="width:370px;" type="password" name="upwd" id="upwd"/>
		     				</div>
			     		</div>
			     		<div class="input-group mb-2">
				     		<label for="upwd1">비밀번호 재확인</label>
			     			<div class="form-group">
				     			<input class="form-control" style="width:370px;" type="password" name="upwd1" id="upwd1"/>
			     			</div>
    					</div>
    					<input type="hidden" name="mid" id="mid" value="${param.mid}"/>
    				</form>
	     			<div class="text-center" id="demo"></div>
	     			</div>
	     			<br/>
	     			<div class="text-center">
        			<input type="button" onclick="location.href='${ctp}/idSearch.log?res=0';" class="btn btn-secondary" value="돌아가기"/>
        			<input type="button" onclick="pwdSearchOk()" class="btn btn-secondary" value="비밀번호 변경"/>
        			<input type="button" onclick="resetOk()" class="btn btn-secondary" value="다시입력"/>
			     	</div>
		     		<br/>
    				<hr/>
			    </div>
  			</div>
			</div>
 		</div>
</div>
</div>
</body>
</html>