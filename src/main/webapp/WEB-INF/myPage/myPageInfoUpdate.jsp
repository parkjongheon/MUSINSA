<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<script>
  	'use strict';
  	
  	
  	
  	function resetCheck(){
  		$("#demo1 > p").remove();
  		$("#demo2 > p").remove();
  		myFormJoin.reset();
  		$("#email1").focus();
  		
  	}
  	
  	function fCheck(){
	  	
  		let regNickName = /^[a-zA-Z가-힣0-9]+$/;
	    let regName = /^[가-힣a-zA-Z]+$/;
	    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	    let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;  
	    
	    
	  	let nickName = $("#nickName").val();
	  	let name = $("#name").val();
	  	let email1 = $("#email1").val();
  		let email2 = $("#email2").val();
	    let tel1 = $("#tel1").val();
	    let tel2 = $("#tel2").val();
	    let tel3 = $("#tel3").val();
	    let tel = tel1 + "-" + tel2 + "-" + tel3;
	    let email= $("#emailOk").val();
	    let submitFlag = 0;
			let emailres = email1+"@"+email2;
			let midres = $("#midOk").val();
			let nickres = $("#nickNameOk").val();
			
	    
	    if(!regNickName.test(nickName)) {
        alert("닉네임은 특수문자를 사용할수 없습니다.");
        $("#nickName").focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        $("#name").focus();
        return false;
      }
      else if(!regEmail.test(emailres)) {
        alert("이메일 형식에 맞지않습니다.");
        $("#email1").focus();
        return false;
      }
      else {
  	    submitFlag = 1;
				let roadAddress = $("#sample6_address").val();
				let detailAddress = $("#sample6_detailAddress").val();
				let extraAddress = $("#sample6_extraAddress").val();
				let address = roadAddress + "/" + detailAddress + "/" + extraAddress;
				$('input[name=address]').attr('value',address);
  	  }
	    
	    if(submitFlag == 1) {
	  		if(emailres != email){
	  			alert("이메일 인증을 눌러주세요!");
	  			$("#demo1 > p").remove();
	  			$("#email1").focus();
	  		}
	  		else if(nickres != nickName){
	  			alert("닉네임 중복체크버튼을 눌러주세요!");
	  			$("#demo2 > p").remove();
	  			$("#nickName").focus();
	  		}
	  		else {
	  			$('input[name=tel]').attr('value',tel);
		  			myFormJoin.submit();
	  		}
	  	}
	  	else {
	  		alert("변경실패! 관리자에게 문의해주세요");
	  	}
	    
  	}
 // 이메일 체크 시작
  	function emailCheck() {
  		let email1 = $("#email1").val();
			let email2 = $("#email2").val();
  		let email = email1 + "@" + email2;
  		
  		if(email1.trim() == ""){
    		  $("#demo1 > p").remove();
    		  $("#demo1").append("<p><font color='red'>이메일을 입력해주세요</font></p>"); 
    		  return false;
    	}
  		else{
  			 $.ajax({
  	  			type : "post",
  	  			url : "${ctp}/joinEmailOk",
  	  			data : {
  	  				email1 : email1,
  	  				email2 : email2,		
  	  			},
  	  			success : function(data) {
  	  				if(data == '1'){
  	  				  $("#demo1 > p").remove();
  	  					$("#demo1").append("<p><font color='red'>사용할수 없는 이메일 입니다.</font></p>");
  	  					return false;
  	  				}
  	  				else{
  	  				  $("#demo1 > p").remove();
  	  					$("#demo1").append("<p><font color='green'>사용가능한 이메일입니다.</font></p>");
  	  					$('input[name=emailOk]').attr('value',email);
  	  					
  	  				}
  	  			},
  	  			error : function(){
  	  				alert("전송실패");
  	  			}
  	  		});  
  		}
  	}
  	// 이메일 체크 끝
  	
  	// 닉네임 체크 시작
  	function nickCheck() {
  		let nickName = $("#nickName").val();
  		
  		if(nickName.trim() == ""){
  		  $("#demo2 > p").remove();
  		  $("#demo2").append("<p><font color='red'>닉네임을 입력해주세요</font></p>"); 
  		  return false;
  		}
  		else{
 			 $.ajax({
 	  			type : "post",
 	  			url : "${ctp}/joinNickOk",
 	  			data : {nickName : nickName},
 	  			success : function(data) {
 	  				if(data == '1'){
 	  				  $("#demo2 > p").remove();
 	  					$("#demo2").append("<p><font color='red'>사용할수 없는 닉네임 입니다.</font></p>");
 	  					return false;
 	  				}
 	  				else{
 	  				  $("#demo2 > p").remove();
 	  					$("#demo2").append("<p><font color='green'>사용가능한 닉네임 입니다.</font></p>");
 	  					$('input[name=nickNameOk]').attr('value',nickName);
 	  					
 	  				}
 	  			},
 	  			error : function(){
 	  				alert("전송실패");
 	  			}
 	  		});  
  		}
  	}
  	
  	// 닉네임 체크 끝
  </script>
	<style>
	.g{
		font-family: 'icomoon';
	}
	.myPage{
		width: 850px;
		height : 1000px;
		border-style: solid;
	  border-width: 2px;
	  border-color: #edf0f5;
	  border-radius: 10px;
	}
	.myPageInfo{
		width: 900px;
		height: 700px;
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
    <div class="container-fluid pl-4" style="margin-top:30px;  height: 1150px; ">
		  <div class="row">
		     	<%@ include file="/include/sidebar.jsp" %>
		    <div class="col-sm-10 col-8">
		     	<div class="row">
		     		<div class="myPage p-3 ml-2" style="width:1000px">
			     			<h2>Update</h2>
			     			<hr/>
		     			<div class="container mt-3">
			     			<div class="myPageInfo p-2">
			     			<form name="myFormJoin" method="post" action="${ctp}/infoUpdateOk.log">
			     			<h2>개인정보 변경</h2>
			     			<br/>
			     				<label for="jmid">아이디</label>
			     			<div class="input-group">
			     				<input class="form-control mr-3" style="width:300px;"  type="text" name="jmid" id="jmid" value="${sMid}" disabled="disabled"/>	
			     			</div>
			     			
								<br/>
			     			<label for="email1">이메일</label>
			     			<div class="input-group">
			     				<input class="form-control" style="width:300px;" type="text" name="email1" id="email1" value="${email1}"/>
			     				<select name="email2" id="email2" class="form-control ml-3 mr-3" style="width:200px;" >
								    <option value="naver.com"<c:if test="${email2 == 'naver.com'}">selected</c:if>>naver.com</option>
								    <option value="hanmail.net"<c:if test="${email2 == 'hanmail.net'}">selected</c:if>>hanmail.net</option>
								    <option value="hotmail.com"<c:if test="${email2 == 'hotmail.com'}">selected</c:if>>hotmail.com</option>
								    <option value="gmail.com"<c:if test="${email2 == 'gmail.com'}">selected</c:if>>gmail.com</option>
								    <option value="nate.com"<c:if test="${email2 == 'nate.com'}">selected</c:if>>nate.com</option>
								    <option value="yahoo.com"<c:if test="${email2 == 'yahoo.com'}">selected</c:if>>yahoo.com</option>
					 			  </select>
					 			  <input type="button" class="btn btn-success" value="인증하기" onclick="emailCheck()"/>
			     				<input type="hidden" name="emailOk" id="emailOk" value="${vo.email}"/>
			     			</div>
			     			<div id="demo1"></div>
			     			<br/>
			     				<label for="name">이름</label>
			     			<div class="form-group">	
			     				<input class="form-control" style="width:300px;" type="text" name="name" id="name" value="${vo.name}"/>
			     			</div>
			     			<label for="nickName">닉네임</label>
			     			<div class="input-group ">
			     				<input type="text" value="${vo.nickName}" class="form-control mr-3" style="width:300px;" name="nickName" id="nickName"/>
			     				<input type="hidden" name="nickNameOk" id="nickNameOk" value="${vo.nickName}"/>
			     				<input type="button" class="btn btn-success" value="중복확인" onclick="nickCheck()"/>
			     			</div>	
			     				<div id="demo2"></div>
			     				<br/>
			     			
						    <br/>
						    <br/>
			     				<label for="tel1">전화번호</label>
			     			<div class="input-group ">
				     			<select class="form-control mr-4" style="width:100px;" name="tel1" id="tel1">
								    <option value="010"<c:if test="${tel1 == '010'}">selected</c:if>>010</option>
								    <option value="02"<c:if test="${tel1 == '02'}">selected</c:if>>서울</option>
								    <option value="031"<c:if test="${tel1 == '031'}">selected</c:if>>경기</option>
								    <option value="032"<c:if test="${tel1 == '032'}">selected</c:if>>인천</option>
								    <option value="041"<c:if test="${tel1 == '041'}">selected</c:if>>충남</option>
								    <option value="042"<c:if test="${tel1 == '042'}">selected</c:if>>대전</option>
								    <option value="043"<c:if test="${tel1 == '043'}">selected</c:if>>충북</option>
						        <option value="051"<c:if test="${tel1 == '051'}">selected</c:if>>부산</option>
						        <option value="052"<c:if test="${tel1 == '052'}">selected</c:if>>울산</option>
						        <option value="061"<c:if test="${tel1 == '061'}">selected</c:if>>전북</option>
						        <option value="062"<c:if test="${tel1 == '062'}">selected</c:if>>광주</option>
					  			</select>
				     			<input class="form-control mr-4" style="width:200px;" type="text" name="tel2" id="tel2"/ value="${tel2}">
				     			<input class="form-control" style="width:200px;" type="text" name="tel3" id="tel3" value="${tel3}"/>
				     			<input type="hidden" name="tel" id="tel"/>
			     			</div>
			     			<br/>
			     			<label for="address">주소</label>
			     			<div class="input-group mb-3">
									<input class="form-control mr-3" value="${vo.post}" style="width:200px;" type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
									<input class="btn btn-success" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
			     			</div>
								<div class="form-group mb-3">
									<input class="form-control" value="${roadAddress}" style="width:350px;" type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소">
								</div>
								<div class="input-group">
									<input class="form-control mr-3" value="${detailAddress}" style="width:150px;" type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
									<input class="form-control" value="${extraAddress}" style="width:200px;"t type="text" name="extraAddress" id="sample6_extraAddress" size="25" placeholder="참고항목">
									<input type="hidden" name="address" id="address" value="">
								</div>
								<br/><br/><br/><br/>
								<input type="hidden" name="jpwd" value="${vo.pwd}"/>
								<input type="hidden" name="gender" value="${vo.gender}"/>
								<input type="hidden" name="birthday" value="${vo.birthday}"/>
								<div class="input-group text-center mt-3">
				     			<input type="button" class="btn btn-secondary mr-3" value="마이페이지" onclick="${ctp}/myPage.log"/>
				     			<input type="button" class="btn btn-secondary mr-3" value="변경하기" onclick="fCheck()"/>
				     			<input type="button" class="btn btn-secondary" value="다시입력" onclick="resetCheck()"/>
								</div>
			     			</form>
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