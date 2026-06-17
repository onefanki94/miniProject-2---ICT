<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/boardList.css" type="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
<%

String rootlist = (String) session.getAttribute("rootlist");
%>
window.onload = function () {
	reloadPage(1); 
}
	
	function reloadPage(page){
	var rootlist="<%=rootlist%>";
	console.log(rootlist);
	if(rootlist==""||rootlist=="null"||rootlist=='festival'){
		$.ajax({
			url:"/mini/adminpage/listSelect",
			 data: {
		            page: page  // 현재 페이지 번호를 서버에 전달
		        },
			success:function(r){
				console.log(r);
				var flist = r.flist;  
		        var pVO = r.pVO; 
				var tag="<h2>축제목록</h2><form method='post' action='/mini/adminpage/listDel'><ul id='boardList'>"
				tag+="<li><p id='checkbutton'><button class='btn btn-outline-secondary' type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div id='usertitle'><div class='no'>번호 </div><div class='title'>제목</div><div class='addr'>주소</div>";
				tag +="<div class='startdate'>시작일</div><div class='enddate'>마지막일</div><div class='like'>좋아요수</div>";
				tag +="<div class='hit'>조회수</div></div></li>";
				flist.forEach(function(flist){
					tag+="<li> <div><input type='checkbox' name='test[]' class='checkbox' style='display: none;' value='"+flist.no+"'/>";
					tag+="<div class='no'>"+flist.no+"</div><a class='festivallink' href='/mini/festival/festivalView/"+flist.no+"'><div class='title'>"+flist.title+"</div></a><div class='addr'>"+flist.addr+"</div>";
					tag+="<div class='startdate'>"+flist.start_date+"</div><div class='enddate'>"+flist.end_date+"</div><div class='like'>"+flist.like+"</div>";
					tag+="<div class='hit'>"+flist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=listdel('"+flist.no+"')>삭제</button></div></li>";
				});
				tag+="</ul>";
				tag+="	<input id='listDel'class='btn btn-outline-secondary' type='submit' value='축제삭제' style='display: none;'/></form>	"
				$("#board").html(tag); 
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
			   
				
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	// 맛집
	else if(rootlist=="rest"){
		$.ajax({
			url:"/mini/adminpage/restList",
			 data: {
		            page: page  // 현재 페이지 번호를 서버에 전달
		        },
			success:function(r){
				var rlist = r.rlist;  
		        var pVO = r.pVO; 
				var tag="<h2>맛집목록</h2><form method='post' action='/mini/adminpage/rlistDel'><ul id='boardList'>"
				tag +="<li><p id='checkbutton'><button class='btn btn-outline-secondary' type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div class='restlist'><div class='rest_code'>번호 </div><div class='store_name'>식당명</div><div class='addr'>식당주소</div>";
				tag +="<div class='rest'>휴일</div><div class='opentime'>오픈시간</div><div class='likes'>좋아요수</div>";
				tag +="<div class='hit'>조회수</div></div></li>";
				rlist.forEach(function(rlist){
					tag+="<li> <div><input type='checkbox' name='rest_code[]' class='checkbox' style='display: none;' value='"+rlist.rest_code+"'/>";
					tag+="<div class='rest_code'>"+rlist.rest_code+"</div><a class='restlink' href='/mini/rest/restView/"+rlist.rest_code+"'><div class='store_name'>"+rlist.store_name+"</div></a><div class='addr'>"+rlist.addr+"</div>";
					tag+="<div class='rest'>"+rlist.rest+"</div><div class='opentime'>"+rlist.opentime+"</div><div class='likes'>"+rlist.likes+"</div>";
					tag+="<div class='hit'>"+rlist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=rlistdel('"+rlist.rest_code+"')>삭제</button></div></li>";
				});
				tag+="</ul>";
				tag+="	<input class='btn btn-outline-secondary' id='listDel' type='submit' value='맛집삭제' style='display: none;'/></form>	"
				$("#board").html(tag); 
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
	//코스
	else if(rootlist=="course"){
		
			$.ajax({
				url:"/mini/adminpage/courseList",
				 data: {
			            page: page  // 현재 페이지 번호를 서버에 전달
			        },
				success:function(r){
					var clist = r.clist;  
			        var pVO = r.pVO; 
					var tag="<h2>코스목록</h2><form method='post' action='/mini/adminpage/clistDel'><ul id='boardList'>"
					tag +="<li><p id='checkbutton'><button class='btn btn-outline-secondary' type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div class='restlist'><div class='news_no'>번호 </div><div class='subject'>제목</div><div class='ip'>IP</div>";
					tag +="<div class='userid'>글쓴이</div><div class='writedate'>작성일</div><div class='reply_count'>댓글수</div>";
					tag +="<div class='hit'>조회수</div></div></li>";
					clist.forEach(function(clist){
						tag+="<li> <div><input type='checkbox' name='news_no[]' class='checkbox' style='display: none;' value='"+clist.news_no+"'/>";
						tag+="<div class='news_no'>"+clist.news_no+"</div><a class='courselink' href='/mini/course/courseView/?news_no="+clist.news_no+"'><div class='subject'>"+clist.subject+"</div></a><div class='ip'>"+clist.ip+"</div>";
						tag+="<div class='userid'>"+clist.userid+"</div><div class='writedate'>"+clist.writedate+"</div><div class='reply_count'>"+clist.reply_count+"</div>";
						tag+="<div class='hit'>"+clist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=clistdel('"+clist.news_no+"')>삭제</button></div></li>";
					});
					tag+="</ul>";
					tag+="	<input class='btn btn-outline-secondary' id='listDel' type='submit' value='코스삭제' style='display: none;'/></form>	"
					$("#board").html(tag); 
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
	}
	
	

	function checkboxon(){
		var checkbox= document.querySelectorAll('.checkbox');
		  var firstCheckbox = checkbox[0];
		var onebox= firstCheckbox.style.display;
		if (onebox =='none'){
		 checkbox.forEach(function(checkbox) {
		        checkbox.style.display = 'block'; // 각 체크박스의 display 스타일을 'block'으로 설정
		        document.getElementById('listDel').style.display="block";
		        document.getElementById('oncheck').style.display="block";
		    });
		 }else{
			 checkbox.forEach(function(checkbox) {
			        checkbox.style.display = 'none'; // 각 체크박스의 display 스타일을 'none'으로 설정
			        document.getElementById('listDel').style.display="none";
			        document.getElementById('oncheck').style.display="none";
			    });
		}
	}
	function checkedboxon(){
		var checkbox= document.querySelectorAll('.checkbox');
		var firstCheckbox = checkbox[0];
		if(firstCheckbox.checked){
			
			 checkbox.forEach(function(checkbox) {
			        checkbox.checked=false;// 각 체크박스의 display 스타일을 'none'으로 설정
			 })
		}else{
			 checkbox.forEach(function(checkbox) {
			        checkbox.checked=true;// 각 체크박스의 display 스타일을 'none'으로 설정
			 })	
		}
		}
	//축제 하나씩삭제
	function listdel(no){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="/mini/adminpage/listDel/"+no;
		}
	}
	//맛집 하나씩 삭제
	function rlistdel(rest_code){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="/mini/adminpage/rlistDel/"+rest_code;
		}
	}
	//축제
	function festivalbutton(page){
		
		$.ajax({
			url:"/mini/adminpage/listSelect",
			 data: {
		            page: page  // 현재 페이지 번호를 서버에 전달
		        },
			success:function(r){
				console.log(r);
				var flist = r.flist;  
		        var pVO = r.pVO; 
				var tag="<h2>축제목록</h2><form method='post' action='/mini/adminpage/listDel'><ul id='boardList'>"
				tag+="<li><p id='checkbutton'><button class='btn btn-outline-secondary'type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div id='usertitle'><div class='no'>번호 </div><div class='title'>제목</div><div class='addr'>주소</div>";
				tag +="<div class='startdate'>시작일</div><div class='enddate'>마지막일</div><div class='like'>좋아요수</div>";
				tag +="<div class='hit'>조회수</div></div></li>";
				flist.forEach(function(flist){
					tag+="<li> <div><input type='checkbox' name='test[]' class='checkbox' style='display: none;' value='"+flist.no+"'/>";
					tag+="<div class='no'>"+flist.no+"</div><a class='festivallink' href='/mini/festival/festivalView/"+flist.no+"'><div class='title'>"+flist.title+"</div></a><div class='addr'>"+flist.addr+"</div>";
					tag+="<div class='startdate'>"+flist.start_date+"</div><div class='enddate'>"+flist.end_date+"</div><div class='like'>"+flist.like+"</div>";
					tag+="<div class='hit'>"+flist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=listdel('"+flist.no+"')>삭제</button></div></li>";
				});
				tag+="</ul>";
				tag+="	<input class='btn btn-outline-secondary' id='listDel' type='submit' value='축제삭제' style='display: none;'/></form>	"
				$("#board").html(tag); 
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
		            window.location.reload();
		            $(".pagination").html(paginationTag);
			},
			error:function(e){
				console.log(e);
			}
		});
	}
	//코스 하나씩 삭제
	function clistdel(news_no){
		if(confirm("현재글을 삭제하시겠습니까?")){
				location.href="/mini/adminpage/clistDel/"+news_no;
			}
	}
	//맛집 리스트
	function restbutton(page){
		
		$.ajax({
			url:"/mini/adminpage/restList",
			 data: {
		            page: page  // 현재 페이지 번호를 서버에 전달
		        },
			success:function(r){
				var rlist = r.rlist;  
		        var pVO = r.pVO; 
				var tag="<h2>맛집목록</h2><form method='post' action='/mini/adminpage/rlistDel'><ul id='boardList'>"
				tag +="<li><p id='checkbutton'><button type='button' onclick='checkboxon()'>일괄선택</button><button id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div class='restlist'><div class='rest_code'>번호 </div><div class='store_name'>식당명</div><div class='addr'>식당주소</div>";
				tag +="<div class='rest'>휴일</div><div class='opentime'>오픈시간</div><div class='likes'>좋아요수</div>";
				tag +="<div class='hit'>조회수</div></div></li>";
				rlist.forEach(function(rlist){
					tag+="<li> <div><input type='checkbox' name='rest_code[]' class='checkbox' style='display: none;' value='"+rlist.rest_code+"'/>";
					tag+="<div class='rest_code'>"+rlist.rest_code+"</div><a class='restlink' href='/mini/rest/restView/"+rlist.rest_code+"'><div class='store_name'>"+rlist.store_name+"</div></a><div class='addr'>"+rlist.addr+"</div>";
					tag+="<div class='rest'>"+rlist.rest+"</div><div class='opentime'>"+rlist.opentime+"</div><div class='likes'>"+rlist.likes+"</div>";
					tag+="<div class='hit'>"+rlist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=rlistdel('"+rlist.rest_code+"')>삭제</button></div></li>";
				});
				tag+="</ul>";
				tag+="	<input class='btn btn-outline-secondary' id='listDel' type='submit' value='맛집삭제' style='display: none;'/></form>	"
				$("#board").html(tag); 
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
		            window.location.reload();
		            $(".pagination").html(paginationTag);
			},error:function(e){
				console.log(e);
			}
		});
	}
	//코스 목록
	function coursebutton(page){
		
		$.ajax({
			url:"/mini/adminpage/courseList",
			 data: {
		            page: page  // 현재 페이지 번호를 서버에 전달
		        },
			success:function(r){
				var tag="<h2>코스목록</h2><form method='post' action='/mini/adminpage/clistDel'><ul id='boardList'>"
				tag +="<li><p id='checkbutton'><button class='btn btn-outline-secondary' type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p><div class='restlist'><div class='news_no'>번호 </div><div class='subject'>제목</div><div class='ip'>IP</div>";
				tag +="<div class='userid'>글쓴이</div><div class='writedate'>작성일</div><div class='reply_count'>댓글수</div>";
				tag +="<div class='hit'>조회수</div></div></li>";
				var clist = r.clist;  
		        var pVO = r.pVO; 
				clist.forEach(function(clist){
					tag+="<li> <div><input type='checkbox' name='news_no[]' class='checkbox' style='display: none;' value='"+clist.news_no+"'/>";
					tag+="<div class='news_no'>"+clist.news_no+"</div><a class='courselink' href='/mini/course/courseView/?news_no="+clist.news_no+"'><div class='subject'>"+clist.subject+"</div></a><div class='ip'>"+clist.ip+"</div>";
					tag+="<div class='userid'>"+clist.userid+"</div><div class='writedate'>"+clist.writedate+"</div><div class='reply_count'>"+clist.reply_count+"</div>";
					tag+="<div class='hit'>"+clist.hit+"</div><button class='btn btn-outline-secondary' type='button'onclick=clistdel('"+clist.news_no+"')>삭제</button></div></li>";
				});
				tag+="</ul>";
				tag+="	<input class='btn btn-outline-secondary' id='listDel' type='submit' value='코스삭제' style='display: none;'/></form>	"
				$("#board").html(tag); 
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
		            window.location.reload();
		            $(".pagination").html(paginationTag);
			},error:function(e){
				console.log(e);
			}
			
		});
	}
</script>
<div id='rootpage'>
	<div class="boardlist">
		<div class="mypageFavTop">
			<div class="mypageFavName">
				<a href="/mini/mypage/mypage"> 마이페이지</a>
			</div>
			<h2>정보관리</h2>
			<div id="sortbutton"><button class="btn btn-outline-secondary" onclick='festivalbutton(1)'>축제</button><button class="btn btn-outline-secondary" onclick='restbutton(1)'>맛집</button><button class="btn btn-outline-secondary" onclick='coursebutton(1)'>코스</button></div>
		</div>
	
		<div class="adminpagemain">
			
			<div id='board'>

			</div>
				
		</div>
		<ul class="pagination justify-content-center">
  
		</ul>
			
			<div class="box_rightType1">
			
			</div>
		</div>
		<div>
			<div class="snb_mypage">
				<ul>
					<li><a href="/mini/mypage/rootpage">회원관리</a></li>
					<li class="on"><a href="/mini/adminpage/boardList">게시글관리</a></li>
					<li ><a href="/mini/adminpage/adminQnaList" id="qna">Q&A관리</a></li>
				</ul>
			</div>				
		</div>	
</div>
