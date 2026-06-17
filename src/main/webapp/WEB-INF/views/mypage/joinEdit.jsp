<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
 .joinFrm{
        width: 380px;  margin: 0 auto; overflow:auto;
    }
    .joinI input[type="text"]{
        width: 250px; padding: 8px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
    }
    .joinI input[type="password"]{
        width: 250px; padding: 8px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
    }
    .joinT select{
     padding: 8px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
    }
    .joinT input{
     padding: 8px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
    }
    .joinT :focus{
     border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .joinZ input{
     padding: 8px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
    }
    .joinZ :focus{
     border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .joinI input[type="text"]:focus{
     border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .joinI input[type="password"]:focus{
     border: 2px solid #87CEEB; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
    }
    .joinI input[type="button"]{
     	color: #fff; background: #87CEEB; 
        border-style: none; 
        padding: 7px;  border-radius: 10px;
    }
     .joinZ input[type="button"]{
     color: #fff; background: #87CEEB; 
        border-style: none; 
        padding: 7px; border-radius: 10px;
    }
    .joinS input[type="submit"]{
    width: 380px;
     color: #fff; background: #87CEEB; 
        border-style: none; 
        padding: 9px;  border-radius: 10px;
        margin-top:10px;
    }
  /*   .joinS{
    	display: flex; 
        justify-content: flex-end;
        align-items: center; 
  */
	header,footer{display:none;}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//우편번호 찾기(Daum API)
function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
        
            var addr = '';
            var extraAddr = ''; 

          
            if (data.userSelectedType === 'R') { 
                addr = data.roadAddress;
            } else { 
                addr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){
              
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
               
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                    extraAddr = ' (' + extraAddr + ')';
             
            } else {
             
           }
            document.getElementById("zipcode").value = data.zonecode;
            document.getElementById("addr").value = addr;
            document.getElementById("addrdetail").focus();
        }
    }).open();
}
</script>
<script>
//아이디 중복검사
function idDoubleCheck(){
	if(document.getElementById("userid").value==""){//아이디를 입력하지않았을때
		alert("아이디를 입력후 중복검사하세요.");
		document.getElementById("userid").focus();
		return false;
	}else{//아이디를 입력했을때
		var userid = document.getElementById("userid").value;
		//           "매핑주소?userid=ddd"                          창이름       옵션
		window.open("/mini/mypage/idDoubleCheck?userid="+userid, "idCheck","width=460, height=150, left=700,top=100");
	}
}
function setKeyCheck(){
	document.getElementById("chk").value="N";
}
	//form 유효성검사하기
	function formCheck(){
		if(document.getElementById("userid").value==''){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(document.getElementById("chk").value!='Y'){
			alert("아이디 중복검사를 하세요.")
			return false;
		}
		//비밀번호
		if(document.getElementById("userpwd").value==''){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(document.getElementById("userpwd").value!=document.getElementById("userpwd2").value){
			alert("비밀번호가 다릅니다.");
			return false;
		}
		
		//이름
		var username = document.getElementById("username").value;
		var regEx = /^[가-힣]{2,15}$/;
		if(!regEx.test(username)){
			alert("이름을 잘못입력하였습니다.");
			return false;
		}
		
		var tel = document.getElementById("tel1").value+"-"+document.getElementById("test2").value+"-"+document.getElementById("test3").value;
		refEx = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
		if(!regEx.test(tel)){
			alert("연락처를 잘못입력하였습니다.")
			return false;
		}
		return true;
	}
</script>
<div class="joinFrm">
 <h1>개인정보 변경</h1>
	<form method="post" action="/mini/mypage/joinEditOk" onsubmit="return formCheck()">
		<div class="joinMain">
			<div class="joinN">아이디</div>
			<div class="joinI">
				<input type="text" name="userid" id="userid" value="${vo.userid}" disabled/>
			</div>
			<div class="joinN">비밀번호</div>
			<div class="joinI">
				<input type="password" name="userpwd" id="userpwd" minlength="8" maxlength="15"/>
			</div>
			<div class="joinN">비밀번호확인</div>
			<div class="joinI">
				<input type="password" name="userpwd2" id="userpwd2"/>
			</div>
			<div class="joinN">이름</div>
			<div class="joinI">
				  <input type="text" name="username" id="username" value="${vo.username}" disabled/>
			</div>
			<div class="joinN">이메일</div>
			<div class="joinI">
				 <input type="text" name="email" id="email" value="${vo.email}"/>
			</div>
			<div class="joinT">연락처</div>
				<div class="joinT">
					<select name="tel1" id="tel1">
						<option <c:if test="${vo.tel1=='010'}">selected</c:if>>010</option>
                        <option	<c:if test="${vo.tel1=='02'}">selected</c:if>>02</option>
                        <option <c:if test="${vo.tel1=='031'}">selected</c:if>>031</option>
                        <option <c:if test="${vo.tel1=='051'}">selected</c:if>>051</option>
					</select> -
					<input type="text" name="tel2" id="tel2" size="4" value="${vo.tel2}" maxlength="4" minlength="3"/> -
                    <input type="text" name="tel3" id="tel3"size="4" value="${vo.tel3}"  maxlength="4"/>
				</div>
				<div class="joinN">우편번호</div>
			<div class="joinZ">
				<input type="text" name="zipcode" id="zipcode" size="5" value="${vo.zipcode}"/>
				<input type="button" id="zipSearch" value="우편변호찾기" onclick="daumPostcode()"/>
			</div>
			<div class="joinN">주소</div>
			<div class="joinI">
				<input type="text" name="addr" id="addr"  value="${vo.addr}" style="width:70%"/>
			</div>
			<div class="joinN">상세주소</div>
			<div class="joinI">
				<input type="text" name="addrdetail" id="addrdetail" value="${vo.addrdetail}"/>
			</div>
			<div class="joinS">
				<input type="submit" value="회원정보수정하기"/>
			</div>
		</div>
	</form>
</div>