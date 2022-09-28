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

<style type="text/css">
	body *{
	font-family: 'Gowun Batang';
	}

</style>
   
</head>
<body>

<form action="update" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="${dto.num}">
	<input type="hidden" name="currentPage" value="${currentPage}">
	
	<table class="table table-bordered" style="width: 500px;">
		<tr>
			<th style="width: 100px;">제목</th>
			<td>
				<input type="text" name="subject" class="form-control" required="required"
					value="${dto.subject}">
			</td>
		</tr>
		<tr>
			<th style="width: 100px;">사진</th>
			<td>
				**사진 선택을 안하면 기존사진이 유지됩니다
				<input type="file" name="upload" class="form-control" multiple="multiple">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="content" class="form-control" required="required"
					style="width: 500px; height: 150px;">${dto.content}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-outline-primary">게시글 수정</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>