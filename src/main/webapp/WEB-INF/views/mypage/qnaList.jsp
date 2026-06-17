<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/qnaList.css" type="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 -->
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
		url:"/mini/mypage/qnaList",
		type:"post",
		data:{
			userid:userid,
			page:page
			
		},
		success:function(r){
			var list = r.list;
			var pVO=r.pVO;
			var tag="<ul id='qnalist'>";
			tag +="<li><div><div class='index1'>번호</div><div class='subject1'>제목</div><div class='answer1'>답변여부</div><div class='writedate1'>문의일</div>";
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
<div id='rootpage'>
	<div class="mypageFavFrm">
		<div class="mypageFavTop">
			<div class="mypageFavName">
				<a href="/mini/mypage/mypage"> 마이페이지</a>
			</div>
			<h2>Q&A</h2>
		</div>
		
		
			<div ><input type='button' class="btn btn-outline-secondary" style="flex-shrink: 0;" onclick="inquirywrite()"value='문의하기'/></div>
		<div class="mypageFavMain">
			<div class="mypageM">
				<div id='ajaxdiv'><!-- ajax로 넣을 div -->
					
				</div>
					
			</div>	
		</div>
		<ul class="pagination justify-content-center">
  
		</ul>
		
		<div class="box_rightType1">
			<!-- snb -->
		</div>
			</div>
			
				<div class="snb_mypage">
					<ul>
						<li ><a href="/mini/mypage/mypage_list_fav">찜목록</a></li>
						<li ><a href="/mini/mypage/mypage_list_cs2">코스</a></li>
						<li class="on"><a href="/mini/mypage/qnaList" id="qna">Q&A</a></li>
					</ul>
				</div>
			
			
		
		
		
	
		
	</div>
	