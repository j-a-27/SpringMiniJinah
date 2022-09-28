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
<link href="https://fonts.googleapis.com/css2?family=Anton&family=Black+Han+Sans&family=Do+Hyeon&family=Gamja+Flower&family=Gowun+Batang:wght@400;700&family=Jua&family=Roboto:ital,wght@1,100&family=Song+Myung&display=swap"
       rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<style type="text/css">
	body *{
	font-family: 'Gowun Batang';
	}

</style>
   
</head>
<body>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<a href="${root}/" style="color: black; text-decoration: none;">
	<b style="font-size: 50px;">BitCamp</b>
</a>
	
<span id="loginstate">
	<c:if test="${sessionScope.loginok==null}">
		<button type="button" class="btn btn-outline-secondary" id="btnlogin"
			data-bs-toggle="modal" data-bs-target="#myModal">로그인</button>
	</c:if>
	
	<c:if test="${sessionScope.loginok!=null}">
		<b>${sessionScope.loginname}님</b>
		&nbsp;&nbsp;
		<button type="button" class="btn btn-outline-danger" id="btnlogout">로그아웃</button>
	</c:if>
</span>

		
<!-- 로그인 창- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

     <!-- Modal Header -->
     <div class="modal-header">
       <h4 class="modal-title">회원 로그인</h4>
       <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
     </div>

     <!-- Modal body -->
     <div class="modal-body">
       <div class="input-group mb-3 input-group-sm">
		<span class="input-group-text">아이디</span>
		<input type="text" class="form-control" id="loginid">
       </div>
       <div class="input-group mb-3 input-group-sm">
		<span class="input-group-text">비밀번호</span>
		<input type="password" class="form-control" id="loginpass">
       </div>	
     </div>

     <!-- Modal footer -->
     <div class="modal-footer">
     	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnloginok">로그인</button>
       <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
     </div>

    </div>
  </div>
</div>

<!-- 스크립트 이벤트 -->
<script type="text/javascript">
	//팝업창에 있는 로그인버튼
	$("#btnloginok").click(function(){
		//아이디와 비번읽기
		var id=$("#loginid").val();
		var pass=$("#loginpass").val();
		var root='${root}';
		console.log("root: "+root)
		
		$.ajax({
			type:"get",
			url:root+"/member/login", 
			dataType:"json",
			data: {"id":id,"pass":pass}, 
			success:function(res){			
				if(res.result=='fail'){
					alert("아이디나 비번이 맞지 않습니다");
				}else{
					location.reload();
				}
			}
		});
		
	});
	
	//로그아웃
	$("#btnlogout").click(function(){
		var root='${root}';
		
		$.ajax({
			type:"get",
			url:root+"/member/logout", 
			dataType:"text",
			success:function(res){			
				location.reload();
			}
		});
	});

</script>


</body>
</html>