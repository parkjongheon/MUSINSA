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
							<h4 class="mb-4">아이디 찾기</h4>
							</div>
							<div class="input-group mb-2 p-5 text-center">
			     				<p>회원님의 아이디는 [ <b>${param.mid}</b> ] 입니다</p>
			     		</div>
		     			<div class="text-center" id="demo"></div>
		     			<br/>
		     			<div class="text-center">
	        			<input type="button" onclick="location.href='${ctp}/login.log?checkMid=${param.mid}';" class="btn btn-secondary" value="돌아가기"/>
			     		</div>
    					<hr/>
    				<div class="text-center mb-2">
        			<a class="small" href="${ctp}/pwdSearch.log?mid=${param.mid}">비밀번호를 잊으셨나요?</a>
    				</div>
    			</div>
  			</div>
			</div>
 		</div>
	</div>
</div>
</body>
</html>