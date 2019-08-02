<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	이 페이지는 "로그인 된 사용자" 전용 페이지이므로 반드시 세션의 ok값이 필요
 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>${mdto.name}님의 정보</h1>

<table border="1" width="400">
	<tbody>
		<tr>
			<th width="30%">회원번호</th>
			<td>${mdto.no}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${mdto.email}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${mdto.name}</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${mdto.birth}</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${mdto.phone}</td>
		</tr>
		<tr>
			<th>가입일</th>
			<td>${mdto.regist}</td>
		</tr>
		<tr>
			<th>권한</th>
			<td>${mdto.auth}</td>
		</tr>
		<tr>
			<th>최종 접속일</th>
			<td>${mdto.recent}</td>
		</tr>
	</tbody>
</table>
<%-- 회원이 이용할 수 있는 기능들을 링크로 제공 --%>
<h3><a href="change_pw?email=${mdto.email}">비밀번호 변경</a></h3>
<h3><a href="edit?email=${mdto.email}">회원정보 변경</a></h3>
<h3><a href="delete?email=${mdto.email}">회원 탈퇴</a></h3>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>











