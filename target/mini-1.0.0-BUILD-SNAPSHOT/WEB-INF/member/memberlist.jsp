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
<script type="text/javascript">
	$(function(){
		//카메라 아이콘 클릭 시 file 태그 클릭한 효과주기
		$(".btnnewphoto").click(function(){
			$("#newphoto").trigger("click"); // #photoupload를 누르지 않아도 강제클릭됨
		});
		
	
		//file태그 변경 시 이벤트
		$("#newphoto").change(function(e){
			
			var num=$(this).attr("num");
			console.log(num);
			var form=new FormData();
			form.append("photo",$("#newphoto")[0].files[0]);
			form.append("num",num);
			console.dir(form);
			
			$.ajax({
				type: "post",
				dataType:"text",
				url:"updatephoto",
				processData:false,
				contentType:false,
				data:form,
				success:function(res){
					location.reload();
					
				}
			});
		});
		
		//멤버삭제
		$(".btndelete").click(function(){
			var num=$(this).attr("num");
			//alert(num);
			var ans=confirm("정말 탈퇴하시겠습니까?");
			if(ans){
				$.ajax({
					type: "get",
					dataType:"text",
					url:"delete",
					data:{"num":num},
					success:function(res){
						alert("탈퇴하였습니다");
						location.reload();
						
					}
				});
			}
		});
		
		//수정버튼 클릭시 모달 다이얼로그에 데이터 넣기
		$(".btnupdate").click(function(){
			updatenum=$(this).attr("num");
			//alert(updatenum);
			$.ajax({
				type: "get",
				dataType:"json",
				url:"updateform",
				data:{"num":updatenum},
				success:function(res){
					$("#updatename").val(res.name);
					$("#updatehp").val(res.hp);
					$("#updateemail").val(res.email);
					$("#updateaddr").val(res.address);
					
				}
			});
		});
		
		
		//수정
		$("#btnupdateok").click(function(){
			
			var updatename= $("#updatename").val();
			var updatehp=$("#updatehp").val();
			var updateemail=$("#updateemail").val();
			var updateaddr=$("#updateaddr").val();
			
			$.ajax({
				type: "post",
				dataType:"text",
				url:"update",
				data:{"name":updatename,"hp":updatehp,"address":updateaddr,"email":updateemail,"num":updatenum},
				success:function(res){
					alert("수정되었습니다");
					location.reload(); //새로고침
				}
			});
		});
		
	});
</script>   
</head>
<body>

<h2 class="alert alert-warning">총 ${totalCount}명의 회원이 있습니다</h2>
<br>
<table class="table table-bordered">
	<c:forEach var="dto" items="${list }">
	<!-- 반복문의 경우 반드시 버튼 등에 id가 아닌 class로 줘야한다. id는 고유값으로 1개만 존재하는 것이므로 반복되며 여러번쓰이는 반복문에서는 오류발생가능  -->
		<tr>
			<td style="width: 250px;" align="center" rowspan="5">
				<img src="../upload/${dto.photo}" width="230" height="250" border="1" style="margin-bottom: 10px;">
				<br>
				
				<!-- 로그인한 사람것만 사진수정 버튼이 보이도록 한다 -->
				<c:if test="${sessionScope.loginok!=null and sessionScope.loginid==dto.loginid}">
					<input type="file" id="newphoto" style="display: none;" num="${dto.num}"><!-- 사진수정시 호출 -->
					<button type="button" class="btn btn-outline-warning btnnewphoto">사진수정</button>
				</c:if>
				
			</td>
			<td style="width: 300px">회원명: ${dto.name}</td>
			<td rowspan="5" align="center" valign="middle">
			
				<!-- 로그인한 사람것만 수정삭제 버튼이 보이도록 한다 -->
				<c:if test="${sessionScope.loginok!=null and sessionScope.loginid==dto.loginid}">
					<button type="button" class="btn btn-outline-secondary btnupdate" num="${dto.num}"
						data-bs-toggle="modal" data-bs-target="#myUpdateModal">수정</button>
					<br><br>
					<button type="button" class="btn btn-outline-secondary btndelete" num="${dto.num}">삭제</button>
				</c:if>
				
			</td>
		</tr>
		<tr>
			<td>아이디: ${dto.loginid}</td>
		</tr>
		<tr>
			<td>이메일: ${dto.email}</td>
		</tr>
		<tr>
			<td>핸드폰: ${dto.hp}</td>
		</tr>
		<tr>
			<td>주소: ${dto.address}</td>
		</tr>
	</c:forEach>
</table>


<!-- 회원정보수정 창- The Modal -->
<div class="modal" id="myUpdateModal">
  <div class="modal-dialog">
    <div class="modal-content">

     <!-- Modal Header -->
     <div class="modal-header">
       <h4 class="modal-title">회원정보 수정</h4>
       <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
     </div>

     <!-- Modal body -->
     <div class="modal-body">
       <div class="input-group mb-3 input-group">
		<span class="input-group-text">회원명</span>
		<input type="text" class="form-control" id="updatename">
       </div>
       <div class="input-group mb-3 input-group">
		<span class="input-group-text">핸드폰</span>
		<input type="text" class="form-control" id="updatehp">
       </div>
       <div class="input-group mb-3 input-group">
		<span class="input-group-text">이메일</span>
		<input type="email" class="form-control" id="updateemail">
       </div>
       <div class="input-group mb-3 input-group">
		<span class="input-group-text">주소</span>
		<input type="text" class="form-control" id="updateaddr">
       </div>	
     </div>

     <!-- Modal footer -->
     <div class="modal-footer">
     	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="btnupdateok">수정</button>
       <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
     </div>

    </div>
  </div>
</div>

</body>
</html>