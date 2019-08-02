<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<%-- 
	(주의) 테이블과 폼을 같이 사용할 때는 th 안쪽이나 테이블 바깥에 폼구현 
	--%>
	
	<form class="form form-vertical" action="login" method="post">
	<fieldset>
		<legend>
			<font color="red">L</font> 
			<font color="orange">o</font>
			<font color="yellow">g</font>
			<font color="green">i</font>
			<font color="blue">n</font>
		</legend>
		<input type="text" name="email" placeholder="Email" value="${cookie.saveId.value}" required>
		<input type="password" name="pw" placeholder="Password" required>
		<div>
		<input type="checkbox" name="remember" ${not empty cookie.saveId?"checked":""}>
		<label for="remember">아이디 저장하기</label>
		</div>
		<hr>
		<input type="submit" value="로그인">
	</fieldset>
	<h4><a href="find_id">아이디를 찾고싶어요</a></h4>
	<h4><a href="find_pw">비밀번호를 찾고싶어요</a></h4>
	</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






