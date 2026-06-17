<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .loginFrm{
        width: 350px;  margin: 0 auto; overflow:auto;
    }
    .loginFrm h1{
        text-align: center; margin: 50px 0 30px;
    }
    .loginFrm input[type="text"]{
        width: 350px; padding: 10px; margin: 10px 0; border-radius: 10px;
        border: 2px solid #ddd;  font-size: 1.1em;
    }
    .loginFrm input[type="password"]{
        width: 350px; padding: 10px; margin: 10px 0; border-radius: 10px;
        border: 2px solid #ddd;  font-size: 1.1em;
    }
     .loginFrm input[type="password"]:focus {
        border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .loginFrm input[type="text"]:focus {
        border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .loginbtn{
        width: 350px; color: #fff; background: #87CEEB; font-size: 1.2em;
        border-style: none; 
        padding: 10px; margin: 10px 0; border-radius: 10px;
    }

    .find{
        text-align: center;
        padding: 10px; margin: 10px 0;
        color:#696969;
       
    }
     .find a:link, .find a:visited{
       color:#696969;
    } 
    .find a:hover{
    	color: #87CEEB; 
    	 font-weight: bold;
    }
    
	header,footer{display:none;}
	
</style>
<script>
function formCheck(){

    //id
    if(document.getElementById("userid").value==""){
        alert("아이디를 입력하세요.");
        return false;
    }
    //password
    if(document.querySelector("#userpwd").value==""){
        alert("비밀번호를 입력하세요.");
        return false;
    }
    return true;
 } 

//팝업창 닫기

</script>

<div class="loginFrm">
	<form method="post" action="/mini/mypage/loginOk" onsubmit="return formCheck()">
		<h1 class="loginTop"><img src="/mini/images/main/logo.png"></h1>
		<input type="text" name="userid" id="userid" placeholder="아이디 입력" />
		<input type="password" name="userpwd" id="userpwd" placeholder="비밀번호 입력"/>
		<input type="submit" class="loginbtn" value="로그인" onclick="loginclosed()"/>
		<!-- <button onclick="openLoginPopup()">로그인</button> -->
	</form>
	 <div class='find'>
      <a onclick="joinPopup()">회원가입</a>/<a onclick="findIdPopup()">아이디찾기</a>/<a onclick="findPwdPopup()">비밀번호찾기</a>
     </div>
</div>