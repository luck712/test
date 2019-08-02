<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
	(주의) 
	 - 템플릿 페이지는 다른 페이지에 불려가서 실행되므로 경로를 절대경로로 작성
	 - 프로젝트 명이 변경될 경우 모든 링크를 다 수정해야 하기 때문에
	 		context path(소속 경로)를 구하는 방법을 알아야 함
	 - request.getContextPath() 로 프로젝트의 루트 경로를 구할 수 있음
	 - 절대경로 작성시 직접 쓰지 말고 해당 명령을 사용하는 것이 바람직
 --%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}/"></c:set>

<%-- <c:url var="root" value="/"></c:url> --%>
    
<!-- <a href="/home">메인화면</a> -->

<%-- 로그인 여부에 따라 메뉴를 구분하여 출력 --%>
<c:set var="login" value="${not empty sessionScope.ok}"></c:set>
<c:set var="admin" value="${sessionScope.auth == '관리자'}"></c:set>
<ul class="menu"> 
	<c:choose>
		<c:when test="${login}">
			<li><a href="${root}">메인화면</a></li>
			<li><a href="${root}member/info">내정보</a></li>
			<li><a href="${root}member/logout">로그아웃</a></li>
			<li><a href="${root}board/list">게시판</a></li>
			<c:if test="${admin}">
		    <li>[<a href="${root}admin/search">회원 관리</a>]</li>
			</c:if>
		</c:when>
		<c:otherwise>
		    <li><a href="${root}">메인화면</a></li>
		    <li><a href="${root}member/regist">회원가입</a></li>
		    <li><a href="${root}member/login">로그인</a></li>
		    <li><a href="${root}board/list">게시판</a></li>
		</c:otherwise>
	</c:choose>
</ul>
		
		
		
		
		

