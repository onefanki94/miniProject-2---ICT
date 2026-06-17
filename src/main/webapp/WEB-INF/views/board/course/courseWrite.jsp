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
   /* window.onload = function(){
      CKEDITOR.ClassicEditor.create(document.getElementById("content"), option);
   } */
   //CKEditor 초기화
   window.onload = () => {
       CKEDITOR.ClassicEditor
           .create(document.getElementById('content'), option)
           .then(editor => {
               console.log('CKEditor 5 is ready.');
               window.editorInstance = editor; // 에디터 인스턴스를 전역 변수로 저장
           })
           .catch(error => {
               console.error('CKEditor 5 initialization error:', error);
           });
   };
   //글등록
   function courseFormCheck() {
      const subject = document.getElementById("subject").value.trim();
      const content = window.editorInstance.getData(); // Get the HTML content from CKEditor

      if (subject === "") {
         alert("제목을 입력하세요.");
         return false;
      }
      
      // Check if there's at least one image in the content
      const parser = new DOMParser();
      const doc = parser.parseFromString(content, 'text/html');
      const images = doc.querySelectorAll('img');
      
      if (images.length === 0) {
         alert("썸네일에 사용될 이미지를 최소 1장 업로드 해주세요.");
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
      <h2 style="text-align: center; padding: 20px 0px;">나만의 코스짜기</h2>
      
      <form method="post" action="/mini/course/courseWriteResult" onsubmit="return courseFormCheck()">
         <select class="form-select" name="schedule" style="width: 150px;">
               <option value="1">당일치기</option>
               <option value="2">1박2일</option>
               <option value="3">2박3일</option>
               <option value="4">3박4일</option>
            </select>
         <input type="text" name="subject" id="subject" class="form-control mt-3" placeholder="제목을 입력하세요.">
         <textarea name="content" id="content"></textarea>
         <button class="btn btn-outline-success">등록하기</button>
      </form>
   </div>
</body>
</html>
