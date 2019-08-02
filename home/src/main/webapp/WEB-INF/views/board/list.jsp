<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 자바스크립트를 이용하여 페이지 이동을 처리 -->
<script src = "https://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function(){
		//목표 : 페이지 번호를 누르면 해당하는 번호의 페이지로 이동처리
		// 		이동은 form을 전송하는 것으로 대체
		$(".navigator-page").click(function(){
			var p = $(this).text();
			move(p);
		});
		//이동 함수
		function move(no){
		//input[name=page]에 no를 설정한 뒤 form을 전송
		$("input[name=page]").val(no);
		$("form").submit();
		}
		
		//select[name=type]인 항목의 값을 선택
		var type ="${param.type}";
		if(type){
		$("select[name=type]").val(type);
		}
	});
</script>

<!-- 표 -->
<table class="table table-stripe" width="900">
	<!-- 제목 -->
	<thead>
		<tr>
			<th>번호</th>
			<th width="40%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<!-- 게시글 -->
	<tbody align="center">
		<c:forEach var="bdto" items="${list}">
		<tr>
			<td>${bdto.no}</td>
			<td class="text-left">
			
				<%-- 차수(depth)만큼 띄어쓰기 진행 --%>
				<c:forEach var="i" begin="1" end="${bdto.depth}">
					&nbsp;&nbsp;
				</c:forEach>
				
				<%-- 답변글만 아이콘 추가 --%>
				<c:if test="${bdto.depth > 0}">
				<img src="../image/reply.png" width="30" height="20">
				</c:if>
			
				<%-- 말머리는 있을 때에만 [] 를 붙여서 출력한다. --%>
				<c:if test="${not empty bdto.head}">
				[${bdto.head}] 
				</c:if>
				
				<%-- content로 가기 위해 no를 첨부한다 --%>
				<a href="content?no=${bdto.no}">
					${bdto.title}
				</a>
				
			</td>
			<td>${bdto.writer}</td>
			<td>${bdto.when}</td>
			<td>${bdto.read}</td>
		</tr>
		</c:forEach>
	</tbody>
	<!-- 글쓰기 버튼 -->
	<tfoot>
		<tr>
			<td colspan="8" align="right">
				<a href="write">글쓰기</a>
			</td>
		</tr>
	</tfoot>
</table>

<!-- 네비게이션 + 검색창 -->

<div class="empty"></div>

<form class="form" action="list" method="get">
<input type="hidden" name="page" value="1">
<select name="type">
	<option value="title+content">제목+내용</option>
	<option value="writer">작성자</option>
</select>

<input type="search" name="keyword" placeholder="검색어" required value="${param.keyword}">

<input type="submit" value="검색">
</form>

<div class="empty"></div>

<ul class="navigator">
	<%-- 이전 구간 링크 --%>
	<c:if test="${not p.isFirstBlock()}">
	<li><a href="list?${p.getPrevBlock()}">&lt;&lt;</a></li>
	</c:if>
	
	<%-- 이전 페이지 링크(pno - 1) --%>
	<c:if test="${not p.isFirstPage()}">
	<li><a href="list?${p.getPrevPage()}">&lt;</a></li>
	</c:if>
	
	<%-- 페이지 출력 --%>
	<c:forEach var="i" begin="${startBlock}" end="${endBlock}">
		<c:choose>
			<c:when test="${page==i}">
				<li class="active">${i}</li>
			</c:when>
			<c:otherwise>
				<li><a href="#" class="navigator-page">${i}</a></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<%-- 다음 페이지 링크(pno + 1) --%>
	<c:if test="${not p.isLastPage()}">
		<li><a href="list?${p.getNextPage()}">&gt;</a></li>
	</c:if>
	
	<%-- 다음 구간 --%>
	<c:if test="${not p.isLastBlock()}">
		<li><a href="list?${p.getNextBlock()}">&gt;&gt;</a></li>
	</c:if>
</ul>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






