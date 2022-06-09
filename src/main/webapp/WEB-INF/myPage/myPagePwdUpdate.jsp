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
	<script>
		'use strict';
		
		function pwdCheck(){
			let upwd = $("#upwd").val();
			let upwd1 = $("#upwd1").val();
			 
			
			let regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*]){8,16}/;
			
			if(upwd.trim() == ""){
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호를 입력해주세요.</font></p>");
				$("#upwd").focus();
			}
			else if(upwd1.trim() == ""){
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호를 한번더 입력해주세요.</font></p>");		
				$("#upwd1").focus();
			}
			else if(upwd != upwd1){
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호가 서로다릅니다. 다시입력해주세요</font></p>");
				$("#upwd1").focus();
			}
			else if(!regPwd.test(upwd)) {
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호는 1개이상의 문자와 특수문자 조합의 8~16 자리로 작성해주세요.</font></p>");
      }
			else{
				myForm.submit();
			}
		}
	</script>
  <meta charset="UTF-8">
  <%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
  <title>title</title>
</head>
<body>
<%@ include file="/include/nav.jsp"%>     <!-- 네이바 -->
    <div class="container-fluid pl-4" style="margin-top:30px;  height: 1000px; ">
		  <div class="row">
		     	<%@ include file="/include/sidebar.jsp" %>
		    <div class="col-sm-10 col-8">
		     	<div class="row">
		     		<div class="myPage p-3 ml-2" style="width:1300px">
			     			<h2>MyPage</h2>
			     			<hr>
		     			<div class="container mt-3">
			     			<h2>비밀번호 변경</h2>
			     			<hr/>
								<br/>
								<form name="myForm" method="post" action="${ctp}/pwdUpdateOk.log">
			     				<label for="jpwd">비밀번호</label>
			     			<div class="form-group">			     			
			     				<input class="form-control" style="width:300px;" type="password" name="upwd" id="upwd"/>
			     			</div>
				     			<label for="jpwd">비밀번호 재확인</label>
			     			<div class="form-group">
				     			<input class="form-control" style="width:300px;" type="password" name="upwd1" id="upwd1"/>
			     			</div>
			     			<br/>
			     			<div id="demo"></div>				     			
			     			<div class="text-left">
			     				<input type="button" class="btn btn-secondary" value="변경하기" onclick="pwdCheck()">
			     			</div>
							</form>
			     	</div>
					</div>
				</div>
	    </div>
	  </div>
	</div>
	<%@ include file="/include/footer.jsp"%>
</body>
</html>