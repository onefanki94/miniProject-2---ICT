<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
header,footer{display:none;}
.error-message {
	margin-top:5px;
        color: red;
        text-align: center;
    }
    .findP{
    text-align: center;
    margin-bottom:10px;
    }
    .error-message p{
    margin:0;
    
    }
 .findPwdFrm{
        width: 350px;  margin: 0 auto; overflow:auto;
    } 
 .findPwdFrm h1{
        text-align: center; margin: 170px 0 20px;
   }  
  .findPwdMain{
    margin:0;
    padding:0;
   }
 .findPwdMain input[type="text"]{
      width: 350px;
    padding: 10px;
    border-radius: 10px;
    border: 2px solid #ddd;
    font-size: 1.1em;
  }
  .findPwdMain input[type="text"]:focus {
      border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
      outline: none; /* 기본 포커스 윤곽선 제거 */
  }
  .findPwdMain input[type="password"]{
      width: 350px;
    padding: 10px;
    border-radius: 10px;
    border: 2px solid #ddd;
    font-size: 1.1em;
  }
   .findPwdMain input[type="password"]:focus {
      border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
      outline: none; /* 기본 포커스 윤곽선 제거 */
  }
  .findPwdBtn{
        width: 350px; color: #fff; background: #87CEEB; font-size: 1.2em;
        border-style: none; 
        padding: 10px; margin: 20px 0; border-radius: 10px;
    }
  
 
</style>
<script>
function validateStep1(form) {
    if (form.userid.value.trim() === "") {
        alert("아이디를 입력하세요.");
        form.userid.focus();
        return false;
    }
    return true;
}

function validateStep2(form) {
    if (form.username.value.trim() === "") {
        alert("이름을 입력하세요.");
        form.username.focus();
        return false;
    }
    if (form.usertel.value.trim() === "") {
        alert("전화번호를 입력하세요.");
        form.usertel.focus();
        return false;
    }
    return true;
}

function validateChangePwd(form) {
    if (form.userpwd.value.trim() === "") {
        alert("새 비밀번호를 입력하세요.");
        form.userpwd.focus();
        return false;
    }
    if (form.userpwd2.value.trim() === "") {
        alert("비밀번호 확인을 입력하세요.");
        form.userpwd2.focus();
        return false;
    }
    if (form.userpwd.value !== form.userpwd2.value) {
        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        form.userpwd2.focus();
        return false;
    }
    return true;
}
function closePopup() {
    if (popupWindow && !popupWindow.closed) {
        popupWindow.close();
    }
}

</script>
 <div class="findPwdFrm">
        <h1>비밀번호 찾기</h1>
        <c:choose>
            <c:when test="${pwd == 0}">
                <!-- 첫 번째 단계: 아이디 입력 -->
                <form action="${pageContext.request.contextPath}/mypage/findPwdStep1" method="post" onsubmit="return validateStep1(this)">
                    <div class="findPwdMain">
                        <div class="findP">비밀번호를 찾고자하는 아이디를 입력해주세요.</div>
                        <input type="text" id="userid" name="userid" placeholder="아이디 입력">
                        <div class="error-message">
                            <c:if test="${not empty useridErrorMessage}">
                                <p class="">${useridErrorMessage}</p>
                            </c:if>
                        </div>
                    </div>
                    <button type="submit" class="findPwdBtn">다음</button>
                </form>
            </c:when>
            <c:when test="${pwd == 1}">
                <!-- 두 번째 단계: 이름과 전화번호 입력 -->
                <form action="${pageContext.request.contextPath}/mypage/findPwdStep2" method="post" onsubmit="return validateStep2(this)">
                    <div class="findPwdMain">
                        <label for="username"></label>
                        <input type="text" id="username" name="username" placeholder="이름 입력">
                        <div class="error-message">
                            <c:if test="${not empty usernameErrorMessage}">
                                <p >${usernameErrorMessage}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="findPwdMain">
                        <label for="tel"></label>
                        <input type="text" id="tel" name="tel" placeholder="전화번호 입력">
                        <div class="error-message">
                            <c:if test="${not empty telErrorMessage}">
                                <p>${telErrorMessage}</p>
                            </c:if>
                        </div>
                    </div>
                    <button type="submit" class="findPwdBtn">다음</button>
                </form>
            </c:when>
            <c:when test="${pwd == 2}">
                <!-- 비밀번호 변경 -->
                <form action="/mini/mypage/changePwd" method="post" onsubmit="return validateChangePwd(this)">
                    <div class="findPwdMain">
                        <label for="userpwd"></label>
                        
                        <input type="password" id="userpwd" name="userpwd" minlength="8" maxlength="15" placeholder="새 비밀번호 입력">
                        <div class="error-message">
                            <c:if test="${not empty pwdErrorMessage}">
                                <p>${pwdErrorMessage}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="findPwdMain">
                        <label for="userpwd2"></label>
                        <input type="password"  id="userpwd2" name="userpwd2" minlength="8" maxlength="15" placeholder="비밀번호 확인 입력">
                       
                        <input type="hidden" id="userid" name="userid" value="${id}"/>
                        <div class="error-message">
                            <c:if test="${not empty pwd2ErrorMessage}">
                                <p>${pwd2ErrorMessage}</p>
                            </c:if>
                        </div>
                    </div>
                    <button type="submit" class="findPwdBtn">비밀번호 변경</button>
                </form>
            </c:when>
        </c:choose>
        <div class="success-message">
             <c:if test="${not empty successMessage}">
        <script type="text/javascript">
            // 알림창을 띄우고 몇초후 페이지를 리다이렉트
            alert("${successMessage}");
            setTimeout(function() {
                window.close(); // 현재 팝업 창을 닫기
            }, 1); 
        </script>
    </c:if>
        </div>
    </div>