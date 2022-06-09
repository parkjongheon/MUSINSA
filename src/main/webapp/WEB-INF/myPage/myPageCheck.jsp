<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<script>
		'use strict';
		function fCheck(){
			let mem = $("#mem").val();
			let pwd = $("#pwdCheck").val();
			
			// mem = 1 (개인정보 변경) 2 (비밀번호 변경)
			if(pwd.trim() == ""){
				$("#demo > p").remove();
				$("#demo").append("<p><font color='red'>비밀번호를 입력해주세요</font></p>");
			}
			else{
				$.ajax({
					type : "post",
					url : "${ctp}/pwdCheckOk",
					data : {pwd : pwd},
					success : function(data){
						if(data == '1'){
							if(mem == '1'){
								location.href="${ctp}/infoUpdate.log";
							}
							else if(mem == '2'){
								location.href="${ctp}/pwdUpdate.log";
							}
							else if(mem == '3'){
								location.href="${ctp}/dropMember.log";
							}
							else if(mem == '4'){
								location.href="${ctp}/adminMain.ad";
							}
						}
						else{
							$("#demo > p").remove();
							$("#demo").append("<p><font color='red'>비밀번호가 틀렸습니다. 다시입력해주세요</font></p>");
							$("#pwdCheck").val() = "";
							$("#pwdCheck").focus();
						}
					},
					error : function(){
						alert("전송오류 관리자요망");
					}
				});
			}
			
		}
	</script>
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
    <div class="container-fluid pl-4" style="margin-top:30px;  height: 1000px; ">
		  <div class="row">
		     	<%@ include file="/include/sidebar.jsp" %>
		    <div class="col-sm-10 col-8">
		     	<div class="row">
		     		<div class="myPage p-3 ml-2" style="width:1300px">
			     			<h2>MyPage</h2>
			     			<hr>
		     			<div class="container mt-3">
			     			<h2>비밀번호 확인</h2>
			     			<hr/>
			     			<div class="input-group mb-3">
			     			<input type="password" name="pwdCheck" id="pwdCheck" class="form-control mr-3" style="width:500px"/>
			     			<input type="button" class="btn btn-secondary" value="인증하기" onclick="fCheck()"/>
			     			<input type="hidden" name="mem" id="mem" value="${param.mem}"/>
			     			<br/>
			     			<div id="demo"></div>
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