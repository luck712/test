<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		<c:forEach var="bdto" items="${p.list}">
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
			<td>${bdto.auto}</td>
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
<select name="type">
	<option value="title+content">제목+내용</option>
	<option value="writer">작성자</option>
</select>

<input type="search" name="keyword" placeholder="검색어" required>

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
	<c:forEach var="i" begin="${p.startBlock}" end="${p.endBlock}">
		<c:choose>
			<c:when test="${p.isCurrentPage(i)}">
				<li class="active">${i}</li>
			</c:when>
			<c:otherwise>
				<li><a href="list?${p.getPage(i)}">${i}</a></li>
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



