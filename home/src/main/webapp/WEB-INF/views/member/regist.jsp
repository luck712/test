<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	$(function(){
		//email 입력창에 blur 이벤트가 발생하면 ajax 통신으로 중복검사 수행
		//요청 url : /member/id_check.do
		$("input[name=email]").blur(function(){
			$.ajax({
				url:"id_check.do",
				data:{
					email:$("input[name=email]").val()
				},
				dataType:"text",
				success:function(resp){
					//console.log(resp);
					if(resp == "N"){ 
						window.alert("이미 사용중인 아이디입니다");
					}
				}
			});
		});
	});
</script>


<%-- 회원 가입 페이지의 내용을 구현 --%>
<form class="form form-vertical-line" action="regist" method="post">
	<fieldset class="w50">
		<legend>가입 정보 입력</legend>
		<input type="text" name="email" placeholder="이메일" required>
		<input type="password" name="pw" placeholder="비밀번호" required>
		<input type="text" name="name" placeholder="이름" required>
		<input type="date" name="birth" required>
		<input type="text" name="phone" placeholder="전화번호(- 제외)">
		<input type="text" name="question" placeholder="비밀번호 확인용 질문" required>
		<input type="text" name="answer" placeholder="비밀번호 확인용 답변" required>
		<input type="submit" value="가입하기">
	</fieldset>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>





