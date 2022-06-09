<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath }"/>
<style>
	
</style>
<nav class="col-sm-2 col-4 g p-4 g " id="myScrollspy">
      <ul class="nav flex-column">
      
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath()%>/myPage.log"><font color="black">마이페이지</font></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath()%>/passCheck.log?mem=1"><font color="black">개인정보 변경</font></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath()%>/passCheck.log?mem=2"><font color="black">비밀번호 변경</font></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#"><font color="black">1:1 문의(준비중)</font></a>
    </li>
    <c:if test="${sGrade != '0'}">
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath()%>/passCheck.log?mem=3"><font color="red">회원탈퇴</font></a>
    </li>    
    </c:if>  
    <c:if test="${sGrade == '0'}">
    <li class="nav-item">
      <a class="nav-link" href="<%=request.getContextPath()%>/passCheck.log?mem=4"><font color="red">관리자 메뉴</font></a>
    </li>
    </c:if>
  </ul>
    </nav>