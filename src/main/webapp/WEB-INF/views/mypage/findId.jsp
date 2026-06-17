<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
header,footer{display:none;}
.findIdFrm{
        width: 350px;  margin: 0 auto; overflow:auto;
    }
.findIdFrm h1{
        text-align: center; margin: 150px 0 20px;
    }
.findIdFrm input[type="text"]{
        width: 350px; padding: 10px; margin: 10px 0; border-radius: 10px;
        border: 2px solid #ddd;  font-size: 1.1em;
    }
    .findIdFrm input[type="email"]{
        width: 350px; padding: 10px; margin: 10px 0; border-radius: 10px;
        border: 2px solid #ddd;  font-size: 1.1em;
    }
     .findIdFrm input[type="email"]:focus {
        border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .findIdFrm input[type="text"]:focus {
        border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
.findIdbtn{
        width: 350px; color: #fff; background: #87CEEB; font-size: 1.2em;
        border-style: none; 
        padding: 10px; margin: 10px 0; border-radius: 10px;
    }

.findIdresult{
	margin-top:10px;
	text-align: center;
	 color:red;
}



</style>
<script>
function formCheck(){

    //email
    if(document.getElementById("email").value==""){
        alert("이메일을 입력하세요.");
        return false;
    }
    //username
    if(document.getElementById("username").value==""){
        alert("이름을 입력하세요.");
        return false;
    }
    return true;
 } 

</script>
<div class="findIdFrm">
    <c:if test="${not empty logId}">
        <p>현재 로그인된 아이디: ${logId}</p>
        <p>현재 로그인된 사용자 이름: ${logName}</p>
    </c:if>
    <form method="post" action="/mini/mypage/findId" onsubmit="return formCheck()">
    	<h1>아이디 찾기</h1>
        <input type="email" name="email" id="email" placeholder="이메일 입력" />
        <input type="text" name="username" id="username" placeholder="이름 입력" />
        <input type="submit" class="findIdbtn" value="아이디찾기"/>
    </form>

    <c:if test="${not empty foundId}">
        <p class="findIdresult">찾은 아이디: ${foundId}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
</div>