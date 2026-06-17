<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
function loginClosed() {
    // Java 변수 값을 자바스크립트 변수로 전달
    var userId = "<%= session.getAttribute("logId") %>";
    var userName = "<%= session.getAttribute("logName") %>";
    var logStatus = "<%= session.getAttribute("logStatus") %>";
	
	console.log(userId+","+userName+","+logStatus);
		
    //부모창 새로고침
 
  	window.opener.location.reload();
    // 팝업 창 닫기
    window.close();
}

window.onload = loginClosed;
</script>

<div>로그인 성공 후 처리 중...</div>
