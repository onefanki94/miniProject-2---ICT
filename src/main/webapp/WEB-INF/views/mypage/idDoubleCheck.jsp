<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<Style>
	header,footer{display:none;}
	.idCheck1 input[type="button"]{
	color: #fff; background: #1E90FF; 
        border-style: none; 
        padding: 5px;  border-radius: 10px;
	}
	
	.idCheck2 input[type="text"]{
	 padding: 3px; margin-bottom: 10px; border-radius: 10px;
        border: 2px solid #ddd; 
	}
	.idCheck2 input[type="text"]:focus{
	 border: 2px solid #1E90FF; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 기본 포커스 윤곽선 제거 */
	}
	
	.idCheck2 input[type="submit"]{
	color: #fff; background: #1E90FF; 
        border-style: none; 
        padding: 5px;  border-radius: 10px;
        
	}
	.idCheck2{
	display: flex; /* Flexbox 사용 */
  justify-content: center; /* 수평 가운데 정렬 */
        
	}
	
	
	
</Style>
<script>
	function idCheck(){
		if(document.getElementById('userid').value==""){
			alert("아이디를 입력후 중복검사하세요.");
			return false;
		}
		return true;
	}
	function setUserid(){
		//opener인 join.jsp에 있는 userid필드의 값을 셋팅
		opener.document.getElementById("userid").value='${userid}'
		opener.document.getElementById("chk").value='Y';
		self.close(); //window.close();
	}
</script>
<div class="idCheck1">
<!-- 아이디 중복 검사 한 결과 -->
<!-- 사용가능한 아이디 -->
	<c:if test="${result==0 }">
		<b>${userid }</b>는 사용가능한 아이디 입니다.
		<input type= "button" value="사용하기" onclick="setUserid()"/>
		
	</c:if>
	<!-- 사용불가능한 아이디 -->
	<c:if test="${result>0}">
	<div style='color:red'>${userid }는 사용불가능한 아이디입니다</div>
	</c:if>
	<hr/>
<!-- 새로운 아이디 중복검사 폼을 만들기-->
<div class="idCheck2">
	<form method="get" action="/mini/mypage/idDoubleCheck" onsubmit="return idCheck()">
		아이디 입력 : <input type="text" name="userid" id="userid"/>
		<input type="submit" value="아이디중복검사하기"/>
	</form>
</div>
</div>
