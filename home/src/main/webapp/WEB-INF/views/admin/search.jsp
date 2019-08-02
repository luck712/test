<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h4>type = ${type}, keyword = ${keyword}</h4>

<h2>회원 검색(관리자)</h2>

<form action="search" method="get">
	<select name="type">
		<option value="email" ${type == 'email'?'selected':''}>이메일</option>
		<option value="name" ${type == 'name'?'selected':''}>이름</option>
		<option value="birth" ${type == 'birth'?'selected':''}>생년월일</option>
		<option value="phone" ${type == 'phone'?'selected':''}>전화번호</option>
		<option value="auth" ${type == 'auth'?'selected':''}>권한</option>
	</select>
	
	<input type="search" name="keyword" placeholder="검색어" 
		required value="${keyword}">
	
	<input type="submit" value="검색">
</form>

<hr>

<c:choose>
	<c:when test="${list.isEmpty()}">
		<h3>검색 결과가 존재하지 않습니다</h3>
	</c:when>
	<c:otherwise>
		<%-- 결과가 출력될 테이블 --%>
		<table border="1" width="800">
			<thead>
				<tr>
					<th>번호</th>
					<th>이메일</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>권한</th>
					<th>관리메뉴</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mdto" items="${list}">
				<tr>
					<td>${mdto.no}</td>
					<td>${mdto.email}</td>
					<td>${mdto.name}</td>
					<td>${mdto.birth}</td>
					<td>${mdto.phone}</td>
					<td>${mdto.regist}</td>
					<td>${mdto.auth}</td>
					<td>
						<!-- 상세보기 -->
						<a href="info?email=${mdto.email}">
							<img src="../image/view.png" width="20" height="20">
						</a>
						<!-- 수정 -->
						<a href="edit?email=${mdto.email}">
							<img src="../image/edit.png" width="20" height="20">
						</a>
						<!-- 탈퇴 -->
						<a href="delete?email=${mdto.email}&type=${param.type}&keyword=${param.keyword}">
							<img src="../image/delete.png" width="20" height="20">
						</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>





