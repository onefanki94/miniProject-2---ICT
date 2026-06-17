<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
function loginClosed() {
    // 브라우저의 뒤로 가기 기능을 수행
	 var referrer = document.referrer;
    console.log(referrer);
    
  
}

window.onload = loginClosed;
</script>
