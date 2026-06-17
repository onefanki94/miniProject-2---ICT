<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<style>
.mypageFavFrm{
display: flex;
   flex-direction: column;
    height: auto;
	width: 1200px;
    margin: 150px auto;
    padding: 100px 20px 200px 20px;
}

.mypageFavName a{
outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;     /* 밑줄 제거 (필요한 경우) */
    color: #999;  
    font-size:1.5em;
}
.mypageFavTop h2{
 font-weight: bold;
 font-size:2.5em;
}
.mypageFavTop{
position: relative;
    padding-right: 20px;
}
.mypageFavMain{
position: relative;
    width: 100%;
    margin-top: 24px;
}
.box_leftType1 {
    float: left;
    width: 900px;
    position: relative;
}
.box_rightType1 {
    float: right;
    
    }
 .snb_mypage {
 width: 248px;
 padding: 30px 20px 30px 0px;
 background: #f7f7f7;
 }
 .snb_mypage ul{
 	list-style: none;  
 	padding:0;
 }
 .snb_mypage > ul > li a {
    display: block;
    padding-left: 20px;
    }
 
 .snb_mypage a{
 	color: black;    
 	 outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;
 }
 .snb_mypage ul li {
    width: 100%;
    padding-top: 20px;
    font-size: 16px;
    font-weight: 700;
   }
   .snb_mypage ul li.on a {
    background: url(../images/mypage/redline.png) 0 0 no-repeat;
    background-size: 4px 100%;
    }
    .total_check {
    position: relative;
    width: 900px;
    padding: 15px 0 13px;
    font-weight: 700;
    border-top: 1px solid #999;
    }
    .total_check strong span {
    padding: 0 2px;
    color: #0a97cd;
	}
	.total_check strong {
    font-weight: 700;
    font-size: 18px;
    color: #000;
    }
	.list_thumType > li.bdr_nor {
    border-top: 1px solid #e6e6e6;
    width:900px;
     display: flex;  /* Flexbox를 사용하여 수평 배치 */
     align-items: center;
    gap: 20px; /* 이미지와 텍스트 간의 간격 조정 */
    margin-bottom: 30px;
	}
	.list_thumType > li.bdr_nor .date{
	  align-self: flex-start;
	}
	.list_thumType > li .photo .dim {
    position: absolute;
    top: 0;
    left: 0;
    width: 48px;
    height: 28px;
    background: #13294b;
    line-height: 2;
    text-align: center;
	}
	.list_thumType > li .photo .txt_mid {
    color: #fff;
    font-size: 14px;
	}
	.list_thumType > li .area_txt {
   padding-right: 20px;
	}
	.list_thumType > li .area_txt .tit {
    margin-top: -5px;
    padding-bottom: 5px;
	}
	
	.bdr_nor{
    list-style: none;  
	}
	.box_leftType1 ul{
	padding:0;
	}
	.pop_subMenu ul{
	list-style: none;  
	
	}
	.pop_subMenu ul li{
	color: black;    
 	 outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;
	}
   .dotbutton button{
    background: none;  /* 배경 제거 */
    border: none;      /* 테두리 제거 */
    padding: 0;        /* 여백 제거 */
    margin: 0;         /* 외부 여백 제거 */
    cursor: pointer;
      }
    .dotbutton button img{
      width: 25px;       /* 이미지의 크기를 조절 */
    height: auto;      /* 이미지의 비율을 유지 */
   
    }
    .pop_subMenu a {
    outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;     /* 밑줄 제거 (필요한 경우) */
    color: black;              /* 글자색을 항상 검정색으로 설정 */
}

.pop_subMenu ul {
    padding: 0;                /* 불필요한 패딩 제거 */
    margin: 0;                 /* 불필요한 마진 제거 */
    list-style: none;          /* 목록 스타일 제거 (기본 점, 숫자 등) */
}

.pop_subMenu li {
    padding: 0;                /* li 요소의 기본 패딩 제거 */
    margin-left:5px;
}
.pop_subMenu {
     display: none;
    border: 1px solid #BABABA;
    width: 100px;
    background-color:#F7F7F7;
    margin-top: 10px;
    position: absolute; /* 절대 위치 지정 */
    top: 80px; /* 초기 위치 (위쪽에서 50px) */
    left: 500px; /* 초기 위치 (왼쪽에서 50px) */
}
.dotbutton button{
 margin-bottom: 10px;
 position: absolute; /* 절대 위치 사용 */
  top: 10; /* 위쪽 끝 */
  right:0; /* 오른쪽 끝 */
}
.photo{
	width: 220px;
    height: 126px;
    overflow: hidden;
}

.image img{
	width: 100%;
    height:100%;
    object-fit: contain;
  
}
.image p{
  display: none; 
}
.area_txt {
    display: flex;  /* 텍스트 영역을 플렉스 컨테이너로 설정 */
    align-items: center; /* 수직 가운데 정렬 */
    flex-grow: 1;  /* 남은 공간을 차지하게 설정 */
}
.area_txt .tit a:hover {
        border-bottom: 2px solid black; /* 마우스를 갖대었을 때 검정색 밑줄 */
    }
</style>
<script>
function toggleDiv() {
    var hiddenBox = document.getElementById('hidden_Menu');
    
    if (hiddenBox.style.display === 'none' || hiddenBox.style.display === '') {
        hiddenBox.style.display = 'block'; // 박스를 보여줍니다.
    } else {
        hiddenBox.style.display = 'none'; // 박스를 숨깁니다.
    }
}


</script>
<div class="mypageFavFrm">
	
		<div class="mypageFavTop">
			<div class="mypageFavName">
				<a href="/mini/mypage/mypage"> 마이페이지</a>
			</div>
			<h2>코스</h2>
		</div>
	
		<div class="mypageFavMain">
			<!-- 썸네일 리스트 -->
			<div class="box_leftType1">
				<div class="total_check">
					
				</div> 
				<!-- 명소,추천,코스,축제 -->
<ul class="list_thumType flnon">
    <c:forEach var="course" items="${course}">
        <li class="bdr_nor">
            <div class="photo">
                <a href="/mini/course/courseView?news_no=${course.news_no}">
                    ${course.content}
                </a>
            </div>
            <div class="area_txt">
                <div class="tit">
                    <a href="/mini/course/courseView?news_no=${course.news_no}" style="color: black; text-decoration: none;
                     font-size:1.1em; font-weight: bold;">
                        ${course.subject}
                    </a>
                </div>
            </div>
            <div class="date">
                작성일: ${course.writedate}
            </div>
        </li>
    </c:forEach>
</ul>


				<!-- //명소,추천,코스,축제 -->
	
				<!-- paging -->
				<div class="page_box">
				</div>
				<!-- //paging -->
			</div>
			<!-- //썸네일 리스트 -->
			
			<div class="box_rightType1">
				<!-- snb -->
				<div class="snb_mypage">
					<ul>
						<li ><a href="/mini/mypage/mypage_list_fav">찜목록</a></li>
						<li class="on"><a href="/mini/mypage/mypage_list_cs2">코스</a></li>
						<li><a href="/mini/mypage/qnaList" id="qna">Q&A</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>