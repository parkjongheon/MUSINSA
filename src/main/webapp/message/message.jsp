<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = (String) request.getAttribute("msg");
	String url = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
	<script>
		'use srict';
		
		let msg = '<%=msg%>';
		let url = '<%=url%>';
		
		
		if(msg == "loginNo") msg = "로그인 실패";
		else if(msg == "loginOk") msg = "로그인 성공";
		else if(msg == "logout") msg = "로그아웃되었습니다.";
		else if(msg == "joinOk") msg = "회원가입이 완료되었습니다.";
		else if(msg == "joinNo") msg = "회원가입이 실패하였습니다 \n 관리자에게 문의해주세요";
		else if(msg == "pwdSearchOk") msg = "비밀번호가 변경되었습니다. 로그인창으로 이동합니다";
		else if(msg == "pwdSearchNo") msg = "비밀번호 변경실패";
		else if(msg == "infoUpdateOk") msg = "회원 정보가 변경되었습니다.";
		else if(msg == "infoUpdateNo") msg = "변경 실패 관리자에게 문의해주세요";
		else if(msg == "dropMemberOk") msg = "탈퇴가 완료되었습니다.";
		else if(msg == "orderOk") msg = "주문이 정상적으로 완료하였습니다.";
		else if(msg == "orderNo") msg = "주문 실패 관리자에게 연락주세요";
		else if(msg == "getOut") msg = "로그인이 필요한 서비스입니다.";
		else if(msg == "adgetOut") msg = "비정상 접근입니다 메인홈으로 돌아갑니다.";
		
		
		alert(msg);
		if(url !="") location.href = url;
	</script>
</head>
<body>
	
</body>
</html>