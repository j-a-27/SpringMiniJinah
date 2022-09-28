<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <!DOCTYPE html>
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
<h5>menu</h5>
<c:set var="root" value="<%=request.getContextPath() %>"/>

<a href="${root}/">Home</a>
&nbsp;&nbsp;
<a href="${root}/board/list">게시판</a>
&nbsp;&nbsp;
<a href="${root}/member/list">회원목록</a>
&nbsp;&nbsp;
<a href="${root}/help/map">지도</a>

</body>
</html> --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link
        href="https://fonts.googleapis.com/css2?family=Anton&family=Black+Han+Sans&family=Do+Hyeon&family=Gamja+Flower&family=Gowun+Batang:wght@400;700&family=Jua&family=Roboto:ital,wght@1,100&family=Song+Myung&display=swap"
        rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <style>
        a{text-decoration: none;}
        
        .menubox{
        	width: 600px;
        	margin:auto;
        }
        
        ul li{list-style: none;}
        li.main{float: left;}
        li.main>a{
            display: block;
            width: 180px;
            font-weight: bold;
        }
        li.main>a:hover{
            cursor: pointer;
        }
        ul.submenu{
            margin-left: 0px;
            font-size: 14px;
            padding-left: 1px;
            margin-top: 10px;
        }
        ul.submenu {
            display: block;
            width: 180px;
            height: 20px;
            color: rgb(87, 87, 87);
        }
        ul.submenu :hover{
            color: orange;
            cursor:pointer;
        }
        
        ul.submenu a{
        	text-decoration: none;
        	color: rgb(87, 87, 87);
        }
    </style>
    <script>
        $(function(){

            //일단 서브메뉴 모두 숨기기
            $("ul.submenu").hide();

            //li.main 바로 밑의 a태그에 마우스 올리면 오랜지색 되고 벗어나면 다시 검은색
            $("li.main>a").hover(function(){
                $(this).css("color","orange");
            },function(){
                $(this).css("color","black");
            });

            //li.main 바로 밑의 a태그에 마우스 올리면 .submenu나오고 벗어나면 다시 submenu 숨기기
            $("li.main>a").mouseover(function(){
                // $(this).next().slideDown(); //방법1
                $(this).siblings().slideDown(); //방법2
                $(this).parent().siblings().find(".submenu").slideUp();
            });

            //메인 제목 클릭 시 서브메뉴가 나타났다 사라졌다 하기
            $("li.main>a").click(function(){
                $(this).siblings().slideToggle();
            });

            //서브메뉴 벗어나면 사라지기
            $("ul.submenu").hover(function(){
                $(this).slideDown();
            },function(){
                $(this).slideUp();
            });
            
        });
    </script>
</head>
<body>
<c:set var="root" value="<%=request.getContextPath() %>"/>
    <div class="menubox">
        <ul>
            <!-- 1번째 메뉴 -->
            <li class="main">
                <a>비트캠프 안내</a>
                <ul class="submenu">
                    <li><a href="${root}/">메인페이지</a></li>
                    <li><a href="${root}/help/map">찾아 오시는 길</a></li>
                </ul>
            </li>

            <!-- 2번째 메뉴 -->
            <li class="main">
                <a>회원전용</a>
                <ul class="submenu">
                    <li><a href="${root}/member/list">회원목록</a></li>
                    <li><a href="${root}/member/form">회원가입</a></li>
                </ul>
            </li>

            <!-- 3번째 메뉴 -->
            <li class="main">
                <a>게시판</a>
                <ul class="submenu">
                    <li><a href="${root}/board/list">게시판목록</a></li>
                    <li><a href="${root}/board/form">글쓰기</a></li>
                    <li>방명록</li>
                </ul>
            </li>

        </ul>
    </div>
</body>
</html>