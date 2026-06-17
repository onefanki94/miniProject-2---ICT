<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   * {
       font-family: "Noto Sans KR", sans-serif;
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
   
   .flex1, .flex2, .flex3{
      display: flex;
      flex-wrap: wrap;
      gap: 1em;
      margin: -50px 0 0 50px;
   }
   
   
   
   .item1>#itemImgBox {
      width: 200px;
      height: 260px;
      overflow: hidden;
      margin: 0 auto;
      border-radius: 5px;
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
   #morebtn1, #morebtn2, #morebtn3{
   	margin: 60px;
   }
   
</style>
<script>
   var searchKey="${pvo.searchKey}";
   var searchWord="${pvo.searchWord}";

   
   function reloadPage(page){
      var url = "/mini/course/courseList?nowPage="+page;
      if(searchWord!=null && searchWord!=""){
         url += "&searchKey="+searchKey+"&searchWord="+searchWord;
      }
      location.href = url;
   }
</script>
<script>
	
</script>
</head>
<body>
    <!-- 상단이미지 -->
   <div id="imgBox1">
      <img src="/mini/images/main/카페1.jpg" id="imgContent1" />
   </div>
   <!-- 내용 -->
   <div class="courseContent">
      <h2 id="courseName"><b>검색결과</b></h2>
      
      <!-- 검색어 -->
      <div style="margin-bottom:30px; display: flex; justify-content: center; align-items: center; gap: 10px; ">
         <form method="get" action="/mini/searchResult" style="height: 50px;">
            <input type="text" name="searchWord" id="searchWord" required />
            <button type="submit" class="btn btn-outline-secondary" style="flex-shrink: 0;">Search</button>
         </form>
      </div>

      <!-- 게시판 -->
      
      <div id="container" style="margin: 0 auto; margin-top:100px; ">
         <div class="content1">
         <h2 style="text-align: center;margin-top: 50px;font-size:18pt;font-weight:bold;">축제에 관한 검색결과입니다.</h2>
         
            <div class="flex1" style="margin-top: 50px;">
               <c:forEach var="vo" items="${list}">
                  <div class="item1">
                     <div id="itemImgBox">
                        <a href="/mini/festival/festivalView/${vo.no}"><img
                           src="/mini/images/poster/${vo.poster}" id="imgThumbnail" /></a>
                     </div>
                     </br>
                     <div id="subject1">
                        <b>${vo.title}</b>
                     </div>
                  </div>
               </c:forEach>
            </div>
            <div style="text-align:center;">
         	<button id="morebtn1"  class="btn btn-outline-secondary">더보기</button>
         </div>
		<h2 style="text-align: center;margin-top: 50px;font-size:18pt;font-weight:bold;">맛집에 관한 검색결과입니다.</h2>
		
            <div class="flex2" style="margin-top: 50px;">
               <c:forEach var="rvo" items="${restlist}">
                  <div class="item1">
                     <div id="itemImgBox">
                        <a href="/mini/rest/restView/${rvo.rest_code}"><img
                           src="/mini/images/Food/${rvo.imageurl}" id="imgThumbnail" /></a>
                     </div>
                     </br>
                     <div id="subject1">
                        <b>${rvo.store_name}</b>
                     </div>
                  </div>
               </c:forEach>   
            </div>
            <div style="text-align:center;">
			<button id="morebtn2"  class="btn btn-outline-secondary">더보기</button>
		</div>
            <h2 style="text-align: center;margin-top: 50px;font-size:18pt;font-weight:bold;">코스에 관한 검색결과입니다.</h2>
            <div class="flex3" style="margin-top: 50px;">
               <c:forEach var="cvo" items="${courselist}">
                  <div class="item1">
                     <div id="itemImgBox">
                        <a href="/mini/course/courseView?news_no=${cvo.news_no}"><img
                           src="${cvo.thumb}" id="imgThumbnail" /></a>
                     </div>
                     </br>
                     <div id="subject1">
                        <b>${cvo.subject}</b>
                     </div>
                  </div>
               </c:forEach>   
            </div>
		<div style="text-align:center;">
			<button id="morebtn3"  class="btn btn-outline-secondary">더보기</button>
		</div>
         </div>
      </div>    
         </div>
    </div>      
   <script>
		let festivalPage =2;
		let restaurantPage =2;	
		let coursePage =2;	
		//const searchWord='${pvo.searchWord}';
		function loadFestivals(){
			fetch('/mini/searchFestivals?page='+ festivalPage +'&searchWord='+searchWord)
				.then(response=>response.json())
				.then(data=>{
					console.log(data);
					const container = document.querySelector('.flex1');
					data.forEach(vo => {
                       let item = '';
                       item +='<div class="item1">'
                    	   item +='      <div id="itemImgBox">'
                    		   item +='     <a href="/mini/festival/festivalView/'+vo.no+'"><img '
                    		   item +='      src="/mini/images/poster/'+vo.poster+'" id="imgThumbnail" /></a>'
                    		   item +='</div>'
                    			   item +='</br>'
                    				   item +='<div id="subject1">'
                    					   item +=' <b>'+vo.title+'</b>'
                    						   item +='  </div>'
                    							   item +=' </div>'
                        ;
                        document.querySelector('.flex1').innerHTML += item;
                    });
                    festivalPage++; 
				});
		}
		
		function loadRestaurants(){
			fetch('/mini/searchFoods?page='+ restaurantPage +'&searchWord='+searchWord)
				.then(response=>response.json())
				.then(data=>{
					console.log(data);
					const container = document.querySelector('.flex2');
					data.forEach(rvo => {
                       let item2 = '';
                       item2 +='<div class="item1">'
                    	   item2 +='      <div id="itemImgBox">'
                    		   item2 +='     <a href="/mini/rest/RestView/'+rvo.rest_code+'"><img '
                    		   item2 +='      src="/mini/images/Food/'+rvo.imageurl+'" id="imgThumbnail" /></a>'
                    		   item2 +='</div>'
                    			   item2 +='</br>'
                    				   item2 +='<div id="subject1">'
                    					   item2 +=' <b>'+rvo.store_name+'</b>'
                    						   item2 +='  </div>'
                    							   item2 +=' </div>'
                        ;
                        document.querySelector('.flex2').innerHTML += item2;
                    });
                    restaurantPage++; 
				});
		}
		
		function loadCourses(){
			fetch('/mini/searchCourses?page='+ coursePage +'&searchWord='+searchWord)
				.then(response=>response.json())
				.then(data=>{
					console.log(data);
					const container = document.querySelector('.flex3');
					data.forEach(cvo => {
                       let item3 = '';
                       item3 +='<div class="item1">'
                    	   item3 +='      <div id="itemImgBox">'
                    		   item3 +='     <a href="/mini/course/courseView/'+cvo.news_no+'"><img '
                    		   item3 +='      src="'+cvo.thumb+'" id="imgThumbnail" /></a>'
                    		   item3 +='</div>'
                    			   item3 +='</br>'
                    				   item3 +='<div id="subject1">'
                    					   item3 +=' <b>'+cvo.subject+'</b>'
                    						   item3 +='  </div>'
                    							   item3 +=' </div>'
                        ;
                        document.querySelector('.flex3').innerHTML += item3;
                    });
                    coursePage++; 
				});
		}

		document.getElementById('morebtn1').addEventListener('click', (event) => {
            event.preventDefault(); // 링크 기본 동작 방지
            loadFestivals();
        });

        document.getElementById('morebtn2').addEventListener('click', (event) => {
            event.preventDefault(); // 링크 기본 동작 방지
            loadRestaurants();
        });
        
        document.getElementById('morebtn3').addEventListener('click', (event) => {
            event.preventDefault(); // 링크 기본 동작 방지
            loadCourses();
        });

        // 초기 로드
        //loadFestivals();
        //loadRestaurants();
   </script>
   
   
   
   
   
   
   
   
   
   
   