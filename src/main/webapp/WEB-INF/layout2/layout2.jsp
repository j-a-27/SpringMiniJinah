<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring5 Tiles</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Anton&family=Black+Han+Sans&family=Do+Hyeon&family=Gamja+Flower&family=Gowun+Batang:wght@400;700&family=Jua&family=Roboto:ital,wght@1,100&family=Song+Myung&display=swap"
       rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<style type="text/css">
	body *{
		font-family: 'Gowun Batang';
	}
	
	div.mainlayout1{
		position: relative;
	}
		
	div.mainlayout1 div.main{
		border: 1px solid gray;	
	}
	
	#header{
		width: 100%;
		height: 130px;
		text-align: center;
		line-height: 130px;
		background-color: #EEEEEE;
		padding-top: 60px; 
	}
	
	#menu{
		width: 100%;
		height: 140px;
		text-align: center;
	}
	
	#info{
		position: absolute;
		bottom: 0px;
		width: 100%;
		height: 200px;
		background-color: #444444;
		color: #EEEEEE;
	}
	
	#main{
		width: 100%;
		height: 800px;
		padding: 30px 30px;
	}
</style>
   
</head>
<body>
<div class="mainlayout1">
	<div class="main" id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div class="main" id="menu">
		<tiles:insertAttribute name="menu"/>
	</div>
	<div class="main" id="info">
		<tiles:insertAttribute name="info"/>
	</div>
	<div class="main" id="main">
		<tiles:insertAttribute name="main"/>
	</div>
</div>
</html>
</body>