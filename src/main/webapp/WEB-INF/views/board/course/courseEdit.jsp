<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DANDI</title>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- ckeditor5 -->
<!-- 새로운 폴더생성->servlet-context.xml에 추가 -->
<link rel="stylesheet" href="/mini/ckeditor/ckeditor.css"/>
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/super-build/ckeditor.js"></script>
<script src="/mini/ckeditor/ckeditor.js"></script>

<style>
	form{
		text-align: center;
	}
	input, textarea{
		margin: 20px 0px;
	}
	.container{
		padding: 30px 0px;
	}
	.btn{
		
		margin: 20px 0px;
	}
	#imgBox1 {
      width: 100%;
      height: 500px;
      overflox: hidden;
      margin: 0 auto;
   }
   
   #imgContent1 {
      width: 100%;
      height: 100%;
      object-fit: cover;
   }
</style>

<script>
	//ckeditor
	window.onload = function(){
		CKEDITOR.ClassicEditor.create(document.getElementById("content"), option);
	}
	
	//글등록
	function courseFormCheck(){
		if(document.getElementById("subject").value==""){
			alert("제목을 입력하세요.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div id="imgBox1">
      <img src="/mini/images/main/카페1.jpg" id="imgContent1" />
   </div>
	<div class="container">
		<h2 style="text-align: center; padding: 20px 0px;">코스 수정</h2>
		
		<form method="post" action="/mini/course/courseEditOk" onsubmit="return courseFormCheck()">
			<select id="schedule" class="form-select" name="schedule" style="width: 150px;" required>
                    <option value="1" ${vo.schedule == '1' ? 'selected' : ''}>당일치기</option>
                    <option value="2" ${vo.schedule == '2' ? 'selected' : ''}>1박2일</option>
                    <option value="3" ${vo.schedule == '3' ? 'selected' : ''}>2박3일</option>
                    <option value="4" ${vo.schedule == '4' ? 'selected' : ''}>3박4일</option>
            </select>
			<input type="hidden" name="news_no" value="${vo.news_no}"/>
			<input type="text" name="subject" id="subject" value="${vo.subject}" class="form-control mt-3">
			<textarea name="content" id="content" value="${vo.content}"></textarea>
			<button class="btn btn-outline-success">수정하기</button>
		</form>
	</div>
</body>
</html>
