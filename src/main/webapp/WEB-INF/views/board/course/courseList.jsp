<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
   * {
       font-family: "Gothic A1", sans-serif;
       scroll-behavior: smooth;
      }
   body {
      margin: 0;
   }
   
   header ul, div ul {
      list-style: none;
      padding: 0;
      margin: 0;
   }
   
   body a:link {
      color: black;
      text-decoration: none;
   }
   
   body a:visited {
      color: black;
      text-decoration: none;
   }
   
   body header a:hover {
      color: #c79288;
      text-decoration: none;
      transition: 0.2s linear;
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
   
   #courseName {
      margin-top: 60px;
      margin-bottom: 80px;
      text-align: center;
   }
   
   .courseContent {
      margin: 0 auto;
      width: 70%;
   }
   .content1 {
      max-width: 1200px;
      margin: 0 auto;
   }
   
   .flex1 {
      display: flex;
      flex-wrap: wrap;
      gap: 1em;
      margin: -50px 0 0 50px;
   }
   
   
   
   .item1>#itemImgBox {
      width: 260px;
      height: 200px;
      overflow: hidden;
      margin: 0 auto;
   }
   
   .item1 #imgThumbnail {
      width: 100%;
      height: 100%;
      object-fit: cover;
   }
    #searchWord{
      width: 300px;
      text-align: center;
       border-radius: 20px;
       border: 1px solid #bbb;
       margin: 10px 0;
       padding: 10px 12px;
       font-family: fontAwesome;
       flex: 1;
   }
   #subject1{
   	width: 195px;
   	text-overflow: ellipsis;
   	white-space: nowrap;
   	overflow: hidden;
   }
</style>
<script>
   var searchKey="${pvo.searchKey}";
   var searchWord="${pvo.searchWord}";
   var schedule = "${pvo.schedule}";
   
   function reloadPage(page){
      var url = "/mini/course/courseList?nowPage="+page;
      if(searchWord!=null && searchWord!=""){
         url += "&searchKey="+searchKey+"&searchWord="+searchWord;
      }
      if (schedule != null && schedule != "") {
          url += "&schedule=" + schedule;
      }
      location.href = url;
   }
</script>   
<script>
   function validateForm() {
       var searchKey = document.querySelector('select[name="searchKey"]').value;
       var searchWord = document.querySelector('#searchWord').value.trim();

       if (searchKey !== '' && searchWord === '') {
           alert('검색어를 입력하세요');
           return false; // Prevent form submission
       }
       return true; // Allow form submission
   }
</script>
</head>
<body>
    <!-- 상단이미지 -->
   <div id="imgBox1">
      <img src="/mini/images/main/카페1.jpg" id="imgContent1" />
   </div>
   <!-- 내용 -->
   <div class="courseContent">
      <h2 id="courseName">여행코스추천👣</h2>
      
      <!-- 검색어 -->
      <div style="margin-bottom:30px; display: flex; justify-content: center; align-items: center; gap: 10px; ">
         <form method="get" action="/mini/course/courseList" onsubmit="return validateForm()" style="height: 50px;">
            <select class="form-select" name="searchKey" style="width: 100px; flex-shrink: 0; margin-bottom: 5px;">
				<option value="">전체</option>
				<option value="subject" ${pvo.searchKey == 'subject' ? 'selected' : ''}>제목</option>
				<option value="content" ${pvo.searchKey == 'content' ? 'selected' : ''}>글내용</option>
				<option value="userid" ${pvo.searchKey == 'userid' ? 'selected' : ''}>작성자</option>
            </select>
            <select class="form-select" name="schedule" style="width: 150px; flex-shrink: 0;">
            	<option value="">전체</option>
               <option value="1" ${pvo.schedule == '1' ? 'selected' : ''}>당일치기</option>
               <option value="2" ${pvo.schedule == '2' ? 'selected' : ''}>1박2일</option>
               <option value="3" ${pvo.schedule == '3' ? 'selected' : ''}>2박3일</option>
               <option value="4" ${pvo.schedule == '4' ? 'selected' : ''}>3박4일</option>
            </select> 
            <input type="text" name="searchWord" id="searchWord" />
            <button type="submit" class="btn btn-outline-secondary" style="flex-shrink: 0;">Search</button>
         </form>
      </div>

      <!-- 코스작성 -->
      <div style="margin-top: 100px; width:97%;">
	      <c:if test="${logStatus == 'Y'}">
	         <div style="text-align: right; margin-right: 70px; margin-bottom: 30px;">
	            <a href="/mini/course/courseWrite">일정추천하기</a></br>
	         </div>
	      </c:if>
	      <div style="text-align: right; margin-right: 70px; margin-bottom: 100px;">
	         <a href="?searchKey=${pvo.searchKey}&searchWord=${pvo.searchWord}&schedule=${pvo.schedule}&sort=viewCount">조회순 | </a>
	         <a href="?searchKey=${pvo.searchKey}&searchWord=${pvo.searchWord}&schedule=${pvo.schedule}&sort=newest">최신순</a>
	      </div>
      </div>
      
      <!-- 게시판 -->
      <div id="container" style="margin: 0 auto;">
         <div class="content1">
            <div class="flex1">
               <c:forEach var="vo" items="${list}">
                  <div class="item1">
                     <div id="itemImgBox">
                        <a href="/mini/course/courseView?news_no=${vo.news_no}"><img
                           src="${vo.thumb}" id="imgThumbnail" /></a>
                     </div>
                     </br>
                     <div id="subject1">
                        <b>${vo.subject}</b></br>👀 ${vo.hit}&nbsp;💬${vo.reply_count}</br>📅 ${vo.writedate}
                     </div>
                  </div>
               </c:forEach>
            </div>
         </div>
      </div>
      <!-- 페이징 -->
      <ul class="pagination justify-content-center" style="margin:100px;">
         <!-- 이전페이지 -->
         <!-- 첫번째 페이지 -->
         <c:if test="${pvo.nowPage==1}">
            <li class="page-item"><a class="page-link"
               href="javascript:void(0);">Previous</a></li>
         </c:if>
         <!-- 첫번째 페이지가 아니면 -->
         <c:if test="${pvo.nowPage>1}">
            <li class="page-item"><a class="page-link"
               href="javascript:reloadPage(${pvo.nowPage-1});">Previous</a></li>
         </c:if>


         <c:forEach var="p" begin="${pvo.startPageNum}"
            end="${pvo.startPageNum+pvo.onePageNum-1}">
            <c:if test="${p<=pvo.totalPage}">
               <li class='page-item <c:if test="${p==pvo.nowPage}">active</c:if>'><a
                  class="page-link" href="javascript:reloadPage(${p});">${p}</a></li>
            </c:if>
         </c:forEach>

         <!-- 다음페이지 -->
         <!-- 다음페이지가 없을때 -->
         <c:if test="${pvo.nowPage==pvo.totalPage}">
            <li class="page-item"><a class="page-link"
               href="javascript:void(0);">Next</a></li>
         </c:if>
         <!-- 다음페이지가 있을때 -->
         <c:if test="${pvo.nowPage<pvo.totalPage}">
            <li class="page-item"><a class="page-link"
               href="javascript:reloadPage(${pvo.nowPage+1});">Next</a></li>
         </c:if>
      </ul>   
   </div>
