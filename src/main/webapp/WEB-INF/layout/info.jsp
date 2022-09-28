<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Anton&family=Black+Han+Sans&family=Do+Hyeon&family=Gamja+Flower&family=Gowun+Batang:wght@400;700&family=Jua&family=Roboto:ital,wght@1,100&family=Song+Myung&display=swap"
       rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<style type="text/css">
	body *{
	font-family: 'Gowun Batang';
	}
	img{
		border-radius: 5px;
	}
	.context{
		margin-top: 20px;
		font-size: 12px;
	}
</style>
   
</head>
<body>
<h4>info</h4>

<!-- 로그인 안한 상태에서는 기본 사진이 나오도록 한다 -->
<c:if test="${sessionScope.loginok==null}">
	<img src="${root}/image/f1.jpg" width="100" height="150">
</c:if>
<!-- 로그인 한 상태에서는 로그인한 멤버의 사진이 나오도록 한다 -->
<c:if test="${sessionScope.loginok!=null}">
	<img src="${root}/upload/${sessionScope.loginphoto}" width="100" height="150">
</c:if>


<div class="context">
	전화번호<br>
	02-222-3456
	<br><br>
	이메일<br>
	bitcamp@gmail.com
	<br><br>
	SNS<br>
	bit_insta
	
</div>

</body>
</html>