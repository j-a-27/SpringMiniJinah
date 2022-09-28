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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
	body *{
	font-family: 'Gowun Batang';
	}
	
	span.likes{
		cursor: pointer;
	}
	
	span.day{
		color: #333;
		float: right;
	}
	
	span.writer{
		color: red;
		border: 1px solid red;
		border-radius: 40px;
		margin-left: 5px;
		font-size: 0.8em;
		padding: 3px;
	}
	
	.adel{
		color: red;
		cursor: pointer;
		margin-left: 5px;
	}
	
	div.alist pre{
		text-indent: 10px;
		color: gray;
	}
	div.alist img{
		width: 40px;
		height: 40px;
		cursor: pointer;
		border: 1px solid gray;
		border-radius: 10px;
	}

</style>
<script type="text/javascript">
	var num=${dto.num};
	$(function(){
		console.log("num="+num);
		
		list(); //처음 시작 시 댓글 출력
		
		
		$(document).on("click","i.adel",function(){
			
			var deleteok=confirm("정말 삭제하시겠습니까?");
			
			if(deleteok){
				//ajax 이용해서 삭제
				var idx=$(this).attr("idx");
				$.ajax({
					type: "get",
					dataType:"text",
					url:"../answer/delete",
					data:{"idx":idx},
					success:function(res){
						list();						
					}
				});
			}
			
		});
	});
	
	//댓글 출력 함수
	function list()
	{
		var loginok='${sessionScope.loginok}';
		var loginid='${sessionScope.loginid}'; //로그인한 사람의 아이디
		var writerid='${dto.id}'; //글쓴 사람의 아이디
		//alert(loginok+","+loginid);
		
		var s="";
		$.ajax({
			type:"get",
			dataType:"json",
			url:"../answer/list",
			data:{"num":num},
			success:function(res){
				$("b.banswer").text(res.length); // 댓글 아이콘 옆 댓글 개수 출력
				$.each(res,function(i,elt){					
					s+="<div>"+elt.name;
					//댓글 사진 나오기
					if(elt.photo!='no'){
						s+="<a href='../upload/"+elt.photo+"' target='_new'>"; //사진 누르면 새창으로 사진 크게보기
						s+="<img src='../upload/"+elt.photo+"'>";
						s+="</a>";
					}	
					//원글 작성자가 남긴 댓글일 경우 옆에 작성자뜸	
					if(writerid==elt.id){
						s+="<span class='writer'>작성자</span>";
					}					
					s+="<br>";
					s+="<pre>"+elt.message;
					s+="<span class='day'>"+elt.writeday+"&nbsp;";
					//로그인한 본인이 남긴 댓글일 경우 삭제 버튼(X아이콘) 나옴
					if(loginok=='yes' && loginid==elt.id){
						s+='<i class="fa fa-close adel" style="font-size:24px" idx='+elt.idx+'></i>';
					}					
					s+="</span></pre></div>";
				});
				$("div.alist").html(s);
			}
		});
		
	}
	
</script>
   
</head>
<body>
<table class="table table-bordered" style="width: 600px;">
	<tr>
		<td>
			<h2><b>${dto.subject}</b></h2>
			<c:if test="${memphoto!='no'}"> <!-- 탈퇴한 회원은 사진 안나옴 -->
			<img src="../upload/${memphoto}" width="50" height="50" class="rounded-circle"
				align="left" onerror="this.src='../image/noimage.png'" hspace="20">
			</c:if>
			<b>${dto.name}(${dto.id})</b><br>
			<span style="color: #ccc; font-size: 13px;">
				<fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd HH:mm"/>
				&nbsp;&nbsp;
				조회&nbsp;${dto.readcount}
			</span>
		</td>
	</tr>
	<tr height="300" valign="top">
		<td>
			<pre>${dto.content}</pre>
			<br><br>
			<c:if test="${dto.photo!='no' }">
				<c:forTokens var="photo" items="${dto.photo }" delims=",">
					<img src="../upload/${photo}" width="250" class="img-thumbnail"
						onerror="this.style.display='none'"> <!-- 해당폴더에 없는사진은 안보이게 처리 -->
				</c:forTokens>
			</c:if>
			<br><br>
			<span class="likes" num="${dto.num}">
				<!-- <i class="fas fa-heart"> -->
				<i class="far fa-heart"></i>&nbsp;
				좋아요 <b class="cntl">${dto.likes}</b>
			</span>
			&nbsp;&nbsp;
			<i class="far fa-comment-dots"></i>
			&nbsp;<b class="banswer">0</b>
			
			<br>
			<div class="alist">
				댓글목록
			</div>
			
			<c:if test="${sessionScope.loginok!=null}">	<!-- 로그인 했을때만 댓글창 보이게 하기 -->		
				<div class="afrom">
					<form id="afrom">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="id" value="${sessionScope.loginid}">
						<input type="hidden" name="name" value="${sessionScope.loginname}">
						
						<input type="file" id="upload" style="display: none;">
						<button type="button" class="btn btn-info btn-sm" id="btnphoto">사진</button>
						<img src="" id="aphoto" width="50" height="50" onerror="this.style.display='none'">
						<br>
						<div>
							<textarea name="message" id="message" style="width: 400px; height: 60px;"
								class="form-control"></textarea>
							<button type="button" class="btn btn-secondary btn-sm" id="btnasave">등록</button>					
						</div>
					</form>
				</div>
			</c:if>
			
		</td>
	</tr>
	<tr>
		<td>
			<button type="button" class="btn btn-outline-info"
			onclick="location.href='form'">새글</button>
			
			<button type="button" class="btn btn-outline-info"
			onclick="location.href='form?num=${dto.num}&regroup=${dto.regroup}&restep=${dto.restep}&relevel=${dto.relevel}&currentPage=${currentPage}'">답글</button>
			
			<button type="button" class="btn btn-outline-info"
			onclick="location.href='list?currentPage=${currentPage}'">목록</button>
			
			<!-- 로그인 중이면서 세션의 아이디와 글의 아이디가 같을 경우에만 수정,삭제가능 -->
			<c:if test="${sessionScope.loginok!=null && sessionScope.loginid==dto.id}">
				<button type="button" class="btn btn-outline-info"
				onclick="location.href='updateform?num=${dto.num}&currentPage=${currentPage}'">수정</button>
				
				<button type="button" class="btn btn-outline-info"
				onclick="location.href='delete?num=${dto.num}&currentPage=${currentPage}'">삭제</button>
			</c:if>
		</td>
	</tr>
</table>

<script type="text/javascript">
	//하트 클릭 시 채운빨강하트/빈검은하트 번갈아 나오게 하기
	$("span.likes").click(function(){
		//alert($(this).find("i").attr("class"));
		var heart=$(this).find("i").attr("class");
		if(heart=='far fa-heart'){
			$(this).find("i").attr("class",'fas fa-heart').css("color","red");
		}else{
			$(this).find("i").attr("class",'far fa-heart').css("color","black");
		}
		
		//ajax 이용해서 좋아요 수 증가후 출력
		var num=$(this).attr("num");
		$.ajax({
			type: "get",
			dataType:"json",
			url:"likes", //url: 현재 페이지에서 boardcontroller의 getMapping으로 가는 상대주소. 현재 페이지가 board/detail이므로 likes만 써도 되는것.
			data:{"num":num},
			success:function(res){
				//alert(res.likes);
				$("b.cntl").text(res.likes);
				
			}
		});
	});
	
	//사진버튼
	$("#btnphoto").click(function(){
		$("#upload").trigger("click");
	});
	
	$("#upload").change(function(){
		var form=new FormData();
		form.append("photo",$("#upload")[0].files[0]);
		
		$.ajax({
			type: "post",
			dataType:"json",
			url:"../answer/updatephoto",
			processData:false,
			contentType:false,
			data:form,
			success:function(res){
				$("#aphoto").attr("src","../upload/"+res.aphoto);
				$("#aphoto").css("display","inline-block");
			}
		});
	});
	
	//댓글 저장
	$("#btnasave").click(function(){
		var fdata=$("#afrom").serialize(); //form태그 안의 name을 쿼리 스트링 형태로 읽어온다
		//alert(fdata);
		$.ajax({
			type:"post",
			dataType:"text",
			url:"../answer/insert",
			data:fdata,
			success:function(res){
				list(); //새로고침(reload) 없이 댓글목록을 다시 DB에서 가져와서 출력하는 용도
				
				//입력값이랑 사진 안보이게 처리
				$("#message").val("");
				$("#aphoto").attr("src","").css("display","none");
			}
		});
		
	});
	
</script>
</body>
</html>











