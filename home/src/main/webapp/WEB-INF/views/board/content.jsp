<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	$(function(){
		//댓글 수정을 누르면 .reply-content와 .reply-edit를 교대로 보여줌
		$(".reply-edit").hide();
		
		//수정 버튼
		$(".reply-edit-btn").click(function(e){
			e.preventDefault();
			$(this).parent().prevAll(".reply-content").toggle();
			$(this).parent().prevAll(".reply-edit").toggle();
			if($(this).text() == "수정")
				$(this).text("취소");
			else
				$(this).text("수정");
		});
		
		//댓글 삭제 버튼 : 정말 삭제할 것인지 확인창 출력 후 처리
		$(".reply-delete-btn").click(function(e) {
			e.preventDefault();
			
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(choice){
				//원래 목적지(href 속성에 적혀있는 주소)로 이동을 시켜준다
				//이동 명령 : location.href = "주소";
				//이동 명령 : $(location).attr("href", "주소");
				var url = $(this).attr("href");
				$(location).attr("href", url);
			}
		});
	});
</script>

<h1>글 상세보기</h1>

<table class="table" width="700">
	<tbody class="text-left">
		<tr>
			<td>${bdto.writer}</td>
		</tr>
		<tr>
			<td>
				<c:if test="${not empty bdto.head}">
				[${bdto.head}] 
				</c:if>
				${bdto.title}
			</td>
		</tr>
		<tr>
			<td>${bdto.when}</td>
		</tr>
		<tr height="200">
			<td valign="top">
				${bdto.content}
			</td>
		</tr>
		<tr>
			<td>
				조회수 ${bdto.read}
				댓글 ${list.size()}
			</td>
		</tr>
		<%-- 댓글 목록 표시영역 --%>
		<tr>
			<td>
				<table border="1" width="100%">
					<tbody>
						<%-- 댓글 1개 표시 영역 시작 --%>
						<c:forEach var="cdto" items="${list}">
						<tr>
							<%-- 댓글 내용이 표시되는 칸 --%>
							<td class="reply-content" width="90%">
								<font color="blue" size="5">
								${cdto.writer}
								</font>
								
								<%-- 댓글 작성자가 게시글 작성자라면 추가적으로 표시 --%>
								<c:if test="${cdto.writer == bdto.writer}">
								<font color="red">(작성자)</font>
								</c:if>
								
								<font color="gray">
								${cdto.when}
								</font>
								
								<br>
								${cdto.content}
							</td>
							<%-- 댓글 수정이 가능한 폼 : 자신 것만 나오도록 처리 --%>
							<c:if test="${cdto.writer == ok}">
							<td class="reply-edit" width="90%">
								<%-- 댓글 작성란을 복사한 뒤 내용 출력 및 목적지 수정 --%>
								<form class="form form-vertical-line" action="c_edit" method="post">
									<input type="hidden" name="origin" value="${bdto.no}">
									<input type="hidden" name="no" value="${cdto.no}">
									<textarea name="content" rows="4" cols="100" required
											 placeholder="댓글 입력">${cdto.content}</textarea>
									<input type="submit" value="수정">
								</form>
							</td>
							</c:if>
							<%-- 수정, 삭제 버튼이 존재하는 칸 --%>
							<td>
								<%-- 본인 글 일때만 삭제를 표시 --%>
								<c:if test="${cdto.writer == ok}">
								<a href="#" class="reply-edit-btn">수정</a>
								<a href="c_delete?no=${cdto.no}" class="reply-delete-btn">삭제</a>
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<%-- 댓글 1개 표시 영역 종료 --%>
					</tbody>
				</table>
			</td>
		</tr>
		<%-- 댓글 입력 영역 --%>
		<tr>
			<td align="right">
				<form class="form form-vertical-line" action="comments" method="post">
					<input type="hidden" name="origin" value="${bdto.no}">
					<textarea name="content" rows="4" cols="100" required placeholder="댓글 입력"></textarea>
					<input type="submit" value="등록">
				</form>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td align="right">
				<a href="write">글쓰기</a>
				<a href="write?parent=${bdto.no}">답글쓰기</a>
				<%-- if(내글일 때){ --%>
				<c:if test="${bdto.writer == ok}">
				<a href="edit?no=${bdto.no}">수정</a>
				<a href="delete?no=${bdto.no}">삭제</a>
				</c:if>
				<a href="list">목록</a>
			</td>
		</tr>
	</tfoot>
</table>

<br><br>

<!-- 리스트를 표시 -->

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






