<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.ck-editor > *{
		text-align:left;
	}
	.ck-editor button{
		width:auto !important; 
	}
</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="js/ckeditor.js"></script>
<script>
	$(function(){
	    ClassicEditor
	            .create( document.querySelector( 'textarea[name=content]' ) )
	            .catch( error => {
	                console.error( error );
	            } );
	});
</script>

<h1>글 작성하기</h1>

<form action="write" method="post" class="form form-label">

<c:if test="${not empty param.parent}">
	<input type="hidden" name="parent" value="${param.parent}">
</c:if>

<div class="form-group">
	<label>분류</label>
	<select name="head">
		<option value="">선택하세요</option>
		<option>정보</option>
		<option>유머</option>
		<option>자유</option>
	</select>
</div>
<div class="form-group">
	<label>제목</label>
	<input type="text" name="title" placeholder="제목" required>
</div>
<div class="form-group">
	<label>내용</label>
	<textarea name="content" placeholder="내용" required></textarea>
</div>
<input type="submit" value="글 등록">
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>