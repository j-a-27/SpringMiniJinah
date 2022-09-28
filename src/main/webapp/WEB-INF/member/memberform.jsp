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
	
	#showimg{
		border: 1px solid gray;
		width: 130px;
		height: 160px;
	}

</style>
<script type="text/javascript">

	$(function(){
		//버튼 클릭시 사진 불러오는 이벤트 주기
		$("#btnphoto").click(function(){
			$("#myphoto").trigger("click");
		});
		
		//사진 불러오면 미리보기하기
		$("#myphoto").change(function(){

			 //정규표현식
			var reg = /(.*?)\/(jpg|jpeg|png|bmp|gif)$/;
			var f=$(this)[0].files[0];//현재 선택한 파일
			if(!f.type.match(reg)){
			  alert("확장자가 이미지파일이 아닙니다");
			  return; //종료
			}
			 if($(this)[0].files[0]){
			  var reader=new FileReader();
			  reader.onload=function(e){
			   $("#showimg").attr("src",e.target.result);
			  }
			  reader.readAsDataURL($(this)[0].files[0]);
			 }
		});
		
		//아이디 입력 시 .idsuccess 값 지움
		$("#loginid2").keydown(function(){
			$("div.idsuccess").text("");
		});
		
		//중복체크 버튼 클릭 시 아이디 체크
		$("#btnidcheck").click(function(){
			alert($("#loginid2").val());
			$.ajax({
				type:"get",
				dataType:"json",
				url:"idcheck",
				data:{"id":$("#loginid2").val()},
				success:function(res){
					if(res.count==0){
						$("div.idsuccess").text("ok");
					}else{
						$("div.idsuccess").text("fail");
					}					
				}				
			});
		});
		
		// 2번째 비밀번호 입력시 체크
		$("#pass2").keyup(function(){
			var p1=$("#pass").val();
			var p2=$(this).val();
			if(p1==p2){
				$("div.passsuccess").text("ok");
			}else{
				$("div.passsuccess").text("");
			}
		});
			
	}); //function
	
	//submit 전에 호출
	function check(){
		//사진
		if($("#myphoto").val()==""){
			alert("사진을 넣어주세요");
			return false;
		}
		
		//중복체크
		if($("div.idsuccess").text()!='ok'){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		//비밀번호
		if($("div.passsuccess").text()!='ok'){
			alert("비밀번호가 서로 다릅니다");
			return false;
		}
	}

</script>   
</head>
<body>
<form action="insert" method="post" enctype="multipart/form-data" onsubmit="return check()">
	<table class="table table-bordered" style="width: 600px;">
		<caption align="top"><h4 class="alert alert-danger">회원가입</h4></caption>
		<tr>
			<td style="width: 250px;" rowspan="4" align="center">
				<input type="file" id="myphoto" name="myphoto" style="display: none;">
				<button type="button" id="btnphoto" class="btn btn-secondary">사진선택</button>
				<br>
				<img id="showimg">
			</td>
			<td>
				<div class="input-group">
					<input type="text" placeholder="아이디입력" id="loginid2" name="loginid"
						class="form-control" style="width: 120px;" required="required">
					<button type="button" class="btn btn-danger btn-sm" id="btnidcheck">중복체크</button>
					&nbsp;
					<div class="idsuccess" style="width: 80px;">id check</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="input-group">
					<input type="password" style="width: 120px;" class="form-control" required="required"
						name="pass" id="pass" placeholder="숫자 4자리" maxlength="4" pattern="[0-9]{4,}">
					<input type="password" style="width: 120px;" class="form-control" required="required"
						id="pass2" placeholder="숫자 4자리" maxlength="4" pattern="[0-9]{4,}">
					&nbsp;
					<div class="passsuccess" style="width: 80px;">pass check</div>	
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="name" class="form-control" style="width: 150px;"
					placeholder="이름입력" required="required">
			</td>
		</tr>
		<tr>
			<td>
				<input type="email" name="email" class="form-control" style="width: 250px;"
					placeholder="이메일입력" required="required">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="input-group">
					<input type="text" name="hp" class="form-control" required="required"
						placeholder="(-)없이 HP번호만 입력">
						
					<input type="text" name="address" class="form-control" style="width: 250px;"
						placeholder="주소 입력" required="required">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-secondary" style="width: 180px;">회원가입</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>