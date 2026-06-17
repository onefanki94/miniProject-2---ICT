<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/mypages.css" type="text/css"/>
    <link rel="stylesheet" href="/mini/css/write.css" type="text/css"/>
<script>
    function bbsFormCheck(){
		if (document.getElementById("subject").value==""){
			alert("제목을 입력하세요.");
			return false;
		}
	
		return true;
	}
</script>
    <div class="mypageFavFrm">
	
		<div class="mypageFavTop">
			<div class="mypageFavName">
				<a href="/mini/mypage/mypage"> 마이페이지</a>
			</div>
			<h2>Q&A 작성하기</h2>
		</div>
		<div class="mypageFavMain">
			<div class="container">
				
				<form method="post" action="/mini/mypage/write" onsubmit="return bbsFormCheck()">
					<input type="text" name="subject" id="subject" class="form-control" placeholder="제목입력하세요.">
					<textarea name="content" id="content"></textarea>
					<div class="d-grid">
			  			<button class="btn btn-outline-secondary" style="flex-shrink: 0;">등록하기</button>
					</div>
				</form>
			</div>
			
			
		</div>
		<ul class="pagination justify-content-center" >
  
		</ul>			
		
	</div>
	