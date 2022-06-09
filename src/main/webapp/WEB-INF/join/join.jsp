<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>	
	<%@ include file="/include/bs4.jsp"%> <!-- bs4 주석 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>

  <script>
  	'use strict';
  	let idOk = 0;
  	let emailOk = 0;
  	let nickOk = 0;
  	
  	
  	function resetCheck(){
  		$("#demo > p").remove();
  		$("#demo1 > p").remove();
  		$("#demo2 > p").remove();
  		myFormJoin.reset();
  		$("#jmid").focus();
  		
  	}
  	
  	function fCheck(){
	  	let regMid = /^[a-z0-9_]{6,20}$/;
	    let regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*]){8,16}/;
	    let regNickName = /^[a-zA-Z가-힣0-9]+$/;
	    let regName = /^[가-힣a-zA-Z]+$/;
	    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	    let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;  
	    
	    let mid = $("#jmid").val();
	  	let pwd = $("#jpwd").val();
	  	let pwd1 = $("#jpwd1").val();
	  	let pwd2 = $("#jpwd2").val();
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
			
	    
	    if(!regMid.test(mid)) {
	      alert("아이디는 영문 소문자와 숫자, 언더바(_)만 사용가능합니다.(길이는 6~20자리까지 허용)");
	      $("#jmid").focus();
	      return false;
      }
      else if(!regPwd.test(pwd1)) {
      	alert("비밀번호는 1개이상의 문자와 특수문자 조합의 8~20 자리로 작성해주세요.");
        $("#jpwd1").focus();
        return false;
      }
      else if(pwd1 != pwd2) {
      	alert("두개의 비밀번호가 서로다릅니다 다시입력해주세요.");
        $("#jpwd2").focus();
        $("#jpwd2").val("");
        return false;
      }
      else if(!regNickName.test(nickName)) {
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
	  		if(idOk == 0) {
	  			alert("아이디 중복체크버튼을 눌러주세요!");
	  			$("#jmid").focus();
	  		}
	  		else if(midres != mid){
	  			alert("아이디 중복체크버튼을 눌러주세요!");
	  			$("#demo > p").remove();
	  			$("#jmid").focus();
	  		}
	  		else if(emailres != email){
	  			alert("이메일 인증을 눌러주세요!");
	  			$("#demo1 > p").remove();
	  			$("#email1").focus();
	  		}
	  		else if(emailOk == 0){
	  			alert("이메일 인증을 눌러주세요!");
	  			$("#email1").focus();
	  		}
	  		else if(nickres != nickName){
	  			alert("닉네임 중복체크버튼을 눌러주세요!");
	  			$("#demo2 > p").remove();
	  			$("#nickName").focus();
	  		}
	  		else if(nickOk == 0){
	  			alert("닉네임 중복체크버튼을 눌러주세요!");
	  			$("#nickName").focus();
	  		}
	  		else {
	  			$('input[name=tel]').attr('value',tel);
	  			$('input[name=jpwd]').attr('value',pwd1);
		  			myFormJoin.submit();
	  		}
	  	}
	  	else {
	  		alert("회원가입 실패~~");
	  	}
	    
  	}
  	
  	
  	//아이디 체크 시작
  	function idCheck(){
  		let jmid = $("#jmid").val();
  		
  		if(jmid.trim() == ""){
  		  $("#demo > p").remove();
  		  $("#demo").append("<p><font color='red'>아이디를 입력해주세요</font></p>"); 
  		  return false;
  		}
  		else{
  		 $.ajax({
  			type : "post",
  			url : "${ctp}/joinIdOk",
  			data : {mid : jmid},
  			success : function(data) {
  				if(data == '1'){
  				  $("#demo > p").remove();
  					$("#demo").append("<p><font color='red'>중복되는 아이디입니다. 다시입력해주세요</font></p>");
  					return false;
  				}
  				else{
  				  $("#demo > p").remove();
  					$("#demo").append("<p><font color='green'>사용가능한 아이디입니다.</font></p>");
  					$('input[name=midOk]').attr('value',jmid);
  					idOk = 1;
  				}
  			},
  			error : function(){
  				alert("전송실패");
  			}
  		 }); 
  		}
  	}
  	// 아이디 체크 끝
  	
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
  	  					
  	  					emailOk = 1;
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
 	  					nickOk = 1;
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
		width: 950px;
		height : 1200px;
		border-style: solid;
	  border-width: 2px;
	  border-color: #edf0f5;
	  border-radius: 10px;
	}
	.myPageInfo{
		width: 810px;
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
  <title>title</title>
</head>
<body>

<%@ include file="/include/nav.jsp"%>     <!-- 네이바 -->
    
    <div class="container" style="margin-top:30px;  height: 1500px;">
		  <div class="row">
		    <div class="col-sm-10 col-8">
		     	<div class="row">
		     		<div class="myPage p-3 ml-2">
			     			<h2>Join</h2>
			     			<hr/>
		     			<div class="container mt-3">
			     			<div class="myPageInfo p-2">
			     			<form name="myFormJoin" method="post" action="${ctp}/joinOk.log">
			     			<h2>회원 가입</h2>
			     			<br/>
			     				<label for="jmid">아이디</label>
			     			<div class="input-group">
			     				<input class="form-control mr-3" style="width:300px;"  type="text" name="jmid" id="jmid"/>
			     				<input type="hidden" name="midOk" id="midOk"/>
			     				<input class="btn btn-success" type="button" value="중복 확인" onclick="idCheck()" />
			     			</div>
			     			<div id="demo"></div>
								<br/>
			     				<label for="jpwd">비밀번호</label>
			     			<div class="form-group">			     			
			     				<input class="form-control" style="width:300px;" type="password" name="jpwd1" id="jpwd1"/>
			     			</div>
				     			<label for="jpwd">비밀번호 재확인</label>
			     			<div class="form-group">
				     			<input class="form-control" style="width:300px;" type="password" name="jpwd2" id="jpwd2"/>
				     			<input type="hidden" name="jpwd" id="jpwd"/>
			     			</div>
			     			<label for="email1">이메일</label>
			     			<div class="input-group">
			     				<input class="form-control" style="width:300px;" type="text" name="email1" id="email1"/>
									
			     				<select name="email2" id="email2" class="form-control ml-3 mr-3" style="width:200px;" >
								    <option value="naver.com" selected>naver.com</option>
								    <option value="hanmail.net">hanmail.net</option>
								    <option value="hotmail.com">hotmail.com</option>
								    <option value="gmail.com">gmail.com</option>
								    <option value="nate.com">nate.com</option>
								    <option value="yahoo.com">yahoo.com</option>
					 			  </select>
					 			  <input type="button" class="btn btn-success" value="인증하기" onclick="emailCheck()"/>
			     				<input type="hidden" name="emailOk" id="emailOk"/>
			     			</div>
			     			<div id="demo1"></div>
			     			<br/>
			     				<label for="name">이름</label>
			     			<div class="form-group">	
			     				<input class="form-control" style="width:300px;" type="text" name="name" id="name"/>
			     			</div>
			     			<label for="nickName">닉네임</label>
			     			<div class="input-group ">
			     				<input type="text" class="form-control mr-3" style="width:300px;" name="nickName" id="nickName"/>
			     				<input type="hidden" name="nickNameOk" id="nickNameOk"/>
			     				<input type="button" class="btn btn-success" value="중복확인" onclick="nickCheck()"/>
			     			</div>	
			     				<div id="demo2"></div>
			     				<br/>
			     				<label for="birthday">생일</label>
			     			<div class="form-group">
			     				<c:set var="now" value="<%=new java.util.Date()%>"/>
			     				<fmt:formatDate var="birthday" value ="${now}" pattern="yyyy-MM-dd" />
									<input type="date" class="form-control" style="width:300px;" name="birthday" size="20" value="${birthday}"/>
			     			</div>
			     			<br/>
			     			<label for="gender">성별</label>
			     			<br/>
			     			<div class="form-check-inline">
						      <label class="form-check-label" for="radio1">
						        <input type="radio" class="form-check-input" id="radio1" name="gender" value="남자" checked>남자
						      </label>
						    </div>
						    <div class="form-check-inline mb-3">
						      <label class="form-check-label" for="radio2">
						        <input type="radio" class="form-check-input" id="radio2" name="gender" value="여자">여자
						      </label>
						    </div>
						    <br/>
						    <br/>
			     				<label for="tel1">전화번호</label>
			     			<div class="input-group ">
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
				     			<input class="form-control mr-4" style="width:200px;" type="text" name="tel2" id="tel2"/>
				     			<input class="form-control" style="width:200px;" type="text" name="tel3" id="tel3"/>
				     			<input type="hidden" name="tel" id="tel"/>
			     			</div>
			     			<br/>
			     			<label for="address">주소</label>
			     			<div class="input-group mb-3">
									<input class="form-control mr-3" style="width:200px;" type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
									<input class="btn btn-success" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
			     			</div>
								<div class="form-group mb-3">
									<input class="form-control" style="width:350px;" type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소">
								</div>
								<div class="input-group">
									<input class="form-control mr-3" style="width:150px;" type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
									<input class="form-control" style="width:200px;"t type="text" name="extraAddress" id="sample6_extraAddress" size="25" placeholder="참고항목">
									<input type="hidden" name="address" id="address" value="">
								</div>
								<br/>
								<div class="input-group text-center mt-3">
				     			<input type="button" class="btn btn-secondary mr-3" value="홈으로" onclick="location.href='${ctp}/main.log';"/>
				     			<input type="button" class="btn btn-secondary mr-3" value="가입하기" onclick="fCheck()"/>
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