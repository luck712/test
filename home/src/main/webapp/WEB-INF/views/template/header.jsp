<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="root" value="/"></c:url>
<!Doctype HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>홈페이지</title>
    <link rel="stylesheet" type="text/css" href="${root}css/common.css">
    <style>
        main{
            width:1000px;
            margin: 30px auto;
        }
        header, nav, section, footer, article{
            padding:20px;
            text-align: center;
        }
        
        .menu a{
            color: white;
            text-decoration: none;
        }
        .menu a:hover{
            color:yellow;
        }
    </style>
</head>
<body test>
    <!-- 시맨틱 태그 : 태그에 이름을 통해 용도와 의미를 부여한 태그 -->
    <main>
        <header>
            <h1>홈페이지 제목을 작성하는 공간</h1>           
        </header>
        <nav class="text-left">
            <jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>
        </nav>
        <section>