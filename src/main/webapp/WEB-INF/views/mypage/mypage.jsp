<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>

.mypageFrm h2{
   width: auto;
    margin: 200px 0 10px 150px;
    font-size:2em;
}
.mypage_Main{
   height: auto;
    background-color: #f3f5f7;
    padding:30px 120px 120px 120px;
}
.mypage_Top{
   background-color : #87CEEB;
   padding:20px;
   margin:30px;
   height:380px;
    
}

.tit_cont button{
   background: none;  /* 배경 제거 */
    border: none;      /* 테두리 제거 */
    padding: 0;        /* 여백 제거 */
    margin: 0;         /* 외부 여백 제거 */
    cursor: pointer;
}
.tit_cont button img{
 
    width: 10px;       /* 이미지의 크기를 조절 */
    height: auto;      /* 이미지의 비율을 유지 */
   
}

.tit_cont{
 margin-bottom: 10px;
 position: absolute; /* 절대 위치 사용 */
  top: -10; /* 위쪽 끝 */
  right:-10; /* 오른쪽 끝 */
}
.btn_file img{
   width:8px;
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
    margin-bottom: 5px;                 /* li 요소의 기본 마진 제거 */
    padding: 0;                /* li 요소의 기본 패딩 제거 */
}
#profileUpdate{
outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;     /* 밑줄 제거 (필요한 경우) */
    color: #fff;   
    font-size:20px;
}

.profile .photo {
   width: 150px; /* 원형의 너비 */
    height: 150px; /* 원형의 높이 */
    
    border-radius: 50%; /* 원형으로 만들기 */
    background-position: center; /* 이미지 중앙에 위치 */
    background-repeat: no-repeat; /* 이미지 반복 안 함 */
    background-size: cover; /* 이미지가 요소를 가득 채우도록 설정 */
  }
.profile{
display: flex; /* Flexbox를 사용하여 가운데 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
    height:210px;
}
.profilename{
margin:10px 0 0 0;
text-align: center;
font-size:1.2em;
font-weight:500
}
.profileuserName{
font-size:1.8em;
 text-align: center;
 font-weight: bold;

}
.btn_file{
text-align: center;

}
.mypage_botton h2{
   width: auto;
    margin: 30px 0 10px 40px;
    font-size:1.6em;
}
.mypage_botton_inr{
   background-color : #fff;
   padding:20px;
   margin:0 30px;
   height:170px;
   
}
.mypage_botton_inr a {
    outline: none;             /* 포커스 아웃라인 제거 */
    text-decoration: none;     /* 밑줄 제거 (필요한 경우) */
    color: black;              /* 글자색을 항상 검정색으로 설정 */
}

.mypage_botton_inr ul {
    padding: 0;                /* 불필요한 패딩 제거 */
    margin: 0;                 /* 불필요한 마진 제거 */
    list-style: none;          /* 목록 스타일 제거 (기본 점, 숫자 등) */
}

.mypage_botton_inr li {
    margin: 0;                 /* li 요소의 기본 마진 제거 */
    padding: 0;                /* li 요소의 기본 패딩 제거 */
}

.mypage_botton_inr em{
display: inline-block;
    position: absolute;
    left: 80px;
    height: 26px;
    min-width: 26px;
    line-height: 26px;
    padding: 0 7px;
    border-radius: 50px;
    color: #fff;
    font-size: 16px;
    background: #4765cf;
    box-sizing: border-box;
}
.mypage_botton_inr ul{
  height: 130px;
   margin: 0 80px;
   padding: 10px 0 0;
    display: flex;
    flex-wrap: wrap;
    
    
  }
  .mypage_botton_inr ul li{
     height: 50px;
      width: 33.3%;
    text-align: center;
  
    }   
    .mypage_botton_inr p{
       margin:5px 0 0 0;
    } 
    
   .mypage_botton_inr ul li a{
    position: relative;
   
    }   
    .pop_subMenu {
            display: none; /* 처음에는 숨김 */
            width: 200px;
            height: 160px;
            background-color: #fff;
            padding: 20px;
            margin-top: 20px;
        }
  button {
        all: unset;
        cursor: pointer;
        color:#fff;
        background: transparent;
        border: none;
        padding: 0;
        font-size:1.2em;
        
    }
    #admin{
        	width:90px;
        	height:90px;
        	border-radius: 30px;
        }
    
</style>
<script>
window.onload = function() {
    var listItems = document.querySelectorAll('.mypage_botton_inr ul li');
    var listLength = listItems.length;
    var width;

    if (listLength === 3) {
        width = '33.3%';
    } else if (listLength === 4) {
        width = '24%';
    }

    listItems.forEach(function(item) {
        item.style.width = width;
    });
};
//점 세개 이미지 누르면 숨겨진 박스 나오게
function toggleDiv() {
            var hiddenBox = document.getElementById('hidden_Menu');
            
            if (hiddenBox.style.display === 'none' || hiddenBox.style.display === '') {
                hiddenBox.style.display = 'block'; // 박스를 보여줍니다.
            } else {
                hiddenBox.style.display = 'none'; // 박스를 숨깁니다.
            }
        }
        
function chk(){
    //회원 탈퇴 확인하기
    if(confirm("회원을 탈퇴하시겠습니까?")){
        location.href = "/mini/mypage/unjoins";
    }
}
</script>
<script>
function submitForm() {
    var form = document.getElementById('profileForm');
    var formData = new FormData(form);

    console.log('Sending request with form data:', formData);

    fetch('/mini/mypage/updateProfileImage', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        console.log('Received response:', response);

        if (!response.ok) {
            console.error('Network response was not ok.');
            return response.text(); // Error message를 문자열로 반환
        }
        return response.json();
    })
    .then(data => {
        console.log('Received data:', data);

        if (data.imgUrl) {
            // 이미지가 성공적으로 업데이트 되었을 때
            document.getElementById('profileImg').src = '/mini' + data.imgUrl;
            location.reload();
        } else {
            // 서버에서 오류를 반환했을 때
            console.error('Error:', data.error);
        }
    })
    .catch(error => {
        console.error('Fetch error:', error);
    });
}

</script>
<div class="mypageFrm">
   <h2>마이페이지</h2>
<div class="mypage_Main">
   <div class="mypage_Main1">
    <div class="mypage_Main_inr">
        <div class="mypage_Top"><!-- 여행가는 달 없을때 type1클래스 추가 -->
     <div class="mypage_Top_inr">
        
   <div class="mypage_Top_Box">
   <div class="tit_cont">
      <button type="button" title="열기" class="btn_titview"><img src="../images/mypage/btn_dot.png" onclick="toggleDiv()"/></button>
      <div id="hidden_Menu" class="pop_subMenu">
         <ul>
            <li class="btn_info"><a href="/mini/mypage/joinEdit"><img src="../images/mypage/member.png"> 개인정보 변경</a></li>
            <li class="btn_logout"><a href="/mini/mypage/logout"><img src="../images/mypage/logout.png"> 로그아웃</a></li>
            <li class="btn_out"><a href="javascript:chk()"><img src="../images/mypage/secession.png"> 회원탈퇴</a></li>
         </ul>
      </div>
   </div>
      <form  method="post" id="pform" name="pform">
           <div class="profile">
             <img class="photo" id="profileImg" src="/mini/resources/uploadfile/${userimg}" alt="Profile Image"/>
         </div>
        <div>
            <p class="profilename"> 반가워요!</p> 
            <p class="profileuserName">${greeting}</p>
        </div>
    </form>   

    <div class="btn_file">
       <form id="profileForm" method="post" action="${pageContext.request.contextPath}/mini/mypage/updateProfileImage" enctype="multipart/form-data">
    <input type="file" id="fileInput" name="userimgfile" accept="image/*" style="display:none;" onchange="submitForm()"/>
    <button type="button" onclick="document.getElementById('fileInput').click();">
        프로필 이미지 설정 <img src="../images/mypage/btn_profile.png" alt="프로필 이미지 설정">
    </button>
</form>
    </div> 
            </div>
         </div>
          </div>
       </div>
</div>
<div class="mypage_botton">
      <h2>나의활동</h2>
      <div class="mypage_botton_inr">
         <ul>
            <li>
               <a href="/mini/mypage/mypage_list_fav" ><img src="../images/mypage/mypagelike.png"/><em class="favoCnt"></em></a>
               <p>찜목록</p>
            </li>
               <li>
                  <a href="/mini/mypage/mypage_list_cs2" ><img src="../images/mypage/mypagecourse.png"/><em class="cosCnt"></em></a>
                  <p>코스</p>
               </li>
    		 <c:if test="${logId=='root'}">
					 <li>
						<a href="/mini/mypage/rootpage"><img id='admin' src="../images/mypage/root.png"/><em class="qnaCnt"></em></a>
						<p>관리자</p>
					</li>
					</c:if>
					 <li>
						<a href="/mini/mypage/qnaList"><img src="../images/mypage/mypageQ.png"/><em class="qnaCnt"></em></a>
						<p>Q&A</p>
					</li>

            </ul>
         </div>
      
   </div>
</div>
</div>