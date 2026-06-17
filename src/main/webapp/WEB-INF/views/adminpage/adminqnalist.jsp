<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/adminqnalist.css" type="text/css"/>
<script>
<%
String logid = (String) session.getAttribute("logId");
%>
var userid="<%=logid%>";
window.onload = function () {
	reloadPage(1)

}

function reloadPage(page){
	$.ajax({
		url:"/mini/adminpage/qnaList",
		type:"post",
		data:{
			userid:userid,
			page:page
			
		},
		success:function(r){
			var list = r.list;
			var pVO=r.pVO;
			var tag="<ul id='qnalist'>";
			tag +="<li><div><div class='index'>번호</div><div class='subject'>제목</div><div class='answer'>답변여부</div><div class='writedate'>문의일</div>";
			tag +="</div></li>";
			list.forEach(function(list){
				console.log(typeof list.ok, list.ok);
				tag+="<li><div><div class='index'>"+list.index+"</div><a href='javascript:void(0);' onclick='qnaView(\"" + list.index + "\")'>";
				tag+="<div class='subject'>"+list.subject+"</div>";
				tag+="</a><div class='answer'>"+ (list.ok ==1 ? "답변완료" : "접수중")+"</div><div class='writedate'>"+list.writedate+"</div></div></li>";
			});
			$("#ajaxdiv").html(tag);
			   var paginationTag = "";

	            // 이전 버튼
	            if (pVO.nowPage > 1) {
	                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage - 1) + ");'>Previous</a></li>";
	            }

	            // 페이지 번호 출력
	            for (var p = pVO.startPageNum; p <= pVO.startPageNum + pVO.onePageNum - 1; p++) {
	                if (p <= pVO.totalPage) {
	                    paginationTag += "<li class='page-item " + (pVO.nowPage === p ? "active" : "") + "'><a class='page-link' href='javascript:reloadPage(" + p + ");'>" + p + "</a></li>";
	                }
	            }

	            // 다음 버튼
	            if (pVO.nowPage < pVO.totalPage) {
	                paginationTag += "<li class='page-item'><a class='page-link' href='javascript:reloadPage(" + (pVO.nowPage + 1) + ");'>Next</a></li>";
	            }

	            $(".pagination").html(paginationTag);
		   
			
		},error:function(e){
			console.log(e);
		}
	});
	
}
function inquirywrite(){
	
	window.location.href="/mini/mypage/inquiryWrite/";
}
function qnaView(index){
	console.log(index);
	 window.open('/mini/mypage/inquiryView/'+index, 'qnaView', 'width=500,height=700 ,left=1200, top=150');
}

</script>
<div id="rootpage">
	<div class="mypageFavFrm">
			<div class="mypageFavTop">
				<div class="mypageFavName">
					<a href="/mini/mypage/mypage"> 마이페이지</a>
				</div>
				<h2>Q&A관리</h2>
			</div>
			
			<div class="mypageFavMain">
				<div id='ajaxdiv'><!-- ajax로 넣을 div -->
				
				</div>
				
			</div>
		<ul class="pagination justify-content-center">
				
				</ul>
				<div class="box_rightType1">
			
				</div>
		</div>		
			<div class="snb_mypage">	
			<ul>
				<li><a href="/mini/mypage/rootpage">회원관리</a></li>
				<li><a href="/mini/adminpage/boardList">게시글관리</a></li>
				<li class="on"><a href="/mini/adminpage/adminQnaList" id="qna">Q&A관리</a></li>
			</ul>
		</div>	
			
	
	
</div>