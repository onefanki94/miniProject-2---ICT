<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/qnaView.css" type="text/css"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% 
    // 헤더와 풋터를 제외하려면 true로 설정합니다.
    
    request.setAttribute("excludeFooter", true);
	String logid = (String) session.getAttribute("logId");
	
%>



<div class="mypageFavFrm">
    <div class="mypageFavTop">
      <h1 class="loginTop"><img src="/mini/images/main/logo.png"></h1>
        <h2>Q&A 보기</h2>
    </div>
    <div class="container">
        <div class='sub'>제목:${vo.subject}</div>
                
        <div class='con'>내용:</div>
        <div id='qnacontent'>${vo.content}</div>
    
    	<c:if test="${avo.content!=null||  fn:length(avo.content) != 0}">
	    	<div id='acontent'>	
	    		<div class='acon'>답변</div>
	    		<div id='answercon'>${avo.content}</div>
	    	</div>
    	</c:if>
    	<c:if test="${logId== 'root'&& (avo.content == null||  fn:length(avo.content) == 0)}">
    	<h2>답변하기</h2>
    		<form method="post" action="/mini/adminpage/answerWrite">
    			<input type ="text" name="content" id="content"/>
    			<input type="hidden" name='index' value="${vo.index}">
    			<button  class="btn btn-outline-secondary">답변하기</button>
    		</form>	
    			
    	</c:if>
    
    	<c:if test="${logId== 'root'&& (avo.content != null||  fn:length(avo.content) != 0)}">
    		<button  class="btn btn-outline-secondary center-button"  onclick='hideon()'type="button">수정하기</button>
    		<div id="Aeditform" style="display:none;">
	    		<form method="post" action="/mini/adminpage/answerEdit">
	    			<input type ="text" name="content" id="content"value="${avo.content}"/>
	    			<input type="hidden" name='index' value="${vo.index}">
	    			<button  class="btn btn-outline-secondary" >답변수정</button>
	    		</form>	
	    	</div>
    	</c:if>
    	</div>
</div>
	<script>
		function hideon(){
			 var element = document.getElementById("Aeditform");
		var buttonhidecheck= document.getElementById("Aeditform").style.display;
		console.log(buttonhidecheck)
			 if(buttonhidecheck == 'none'){
				  element.style.display = 'block'; 
				 console.log(buttonhidecheck);
			 }else{
				 element.style.display ="none";
			 }
			 
		}
	</script>
