<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/mini/css/rootpage.css" type="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
window.onload = function () {
    reloadPage(1);  // 첫 번째 페이지를 로드합니다.
}

function reloadPage(page) {
    $.ajax({
        url: "/mini/adminpage/mem",
        type: "GET",
        data: {
            page: page  // 현재 페이지 번호를 서버에 전달
        },
        success: function (response) {
            var members = response.members;  // 회원 목록
            var pVO = response.pVO;  // 페이징 정보

            // 1. 회원 목록 렌더링
            var tag = "<li><p id='checkbutton'><button class='btn btn-outline-secondary' style='flex-shrink: 0;'type='button' onclick='checkboxon()'>일괄선택</button><button class='btn btn-outline-secondary' id='oncheck' type='button' style='display: none;' onclick='checkedboxon()'>일괄체크</button></p>";
            tag += "<div id='usertitle2'><div class='memid '>아이디 </div><div class='memname'>이름</div><div class='mememail'>이메일</div>";
            tag += "<div class='memtel'>전화번호</div><div class='memaddr'>주소</div><div class='memaddrdetail'>상세주소</div>";
            tag += "<div class='memwritedate'>가입일</div></div></li>";
            
            members.forEach(function (member) {
                tag += "<li><div><input type='checkbox' name='test[]' class='checkbox' style='display: none;' value='" + member.userid + "'/>";
                tag += "<div class='memid'>" + member.userid + "</div><div class='memname'>" + member.username + "</div>";
                tag += "<div class='mememail'>" + member.email + "</div><div class='memtel'>" + member.tel + "</div><div class='memaddr'>" + member.addr + "</div>";
                tag += "<div class='memaddrdetail'>" + member.addrdetail + "</div>" +
                "<div class='memwritedate'>" + member.writedate + "</div>" +
                "<button class='btn btn-outline-secondary' type='button' style='flex-shrink: 0;' onclick='userdel(\"" + member.userid + "\")'>탈퇴</button></div></li>";
            });

            $("#userList").html(tag);

            // 2. 페이징 정보 렌더링
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
        error: function (e) {
            console.log(e);
        }
    });
}

function checkboxon() {
    var checkbox = document.querySelectorAll('.checkbox');
    var firstCheckbox = checkbox[0];
    var onebox = firstCheckbox.style.display;
    if (onebox == 'none') {
        checkbox.forEach(function (checkbox) {
            checkbox.style.display = 'block';  // 각 체크박스의 display 스타일을 'block'으로 설정
            document.getElementById('memDel').style.display = "block";
            document.getElementById('oncheck').style.display = "block";
        });
    } else {
        checkbox.forEach(function (checkbox) {
            checkbox.style.display = 'none';  // 각 체크박스의 display 스타일을 'none'으로 설정
            document.getElementById('memDel').style.display = "none";
            document.getElementById('oncheck').style.display = "none";
        });
    }
}

function checkedboxon() {
    var checkbox = document.querySelectorAll('.checkbox');
    var firstCheckbox = checkbox[0];
    if (firstCheckbox.checked) {
        checkbox.forEach(function (checkbox) {
            checkbox.checked = false;  // 체크 해제
        });
    } else {
        checkbox.forEach(function (checkbox) {
            checkbox.checked = true;  // 체크 선택
        });
    }
}

function userdel(userid) {
    if (confirm("정말 삭제하시겠습니까?")) {
    	$.ajax({
    		url:"/mini/adminpage/userDel/",
    		type:"post",
    		data:{userid:userid},
    		success:function(r){
    			console.log("성공");
    			 window.location.reload(); 
    		},
    		error:function(e){
    			console.log("실패");
    		}
    	
    	});
      
    }
}

</script>
<div id='rootpage'>
<div class="mypageFavFrm">
	
		<div class="mypageFavTop">
			<div class="mypageFavName">
				<a href="/mini/mypage/mypage"> 마이페이지</a>
			</div>
			<h2>회원관리</h2>
		</div>
	
		<div class="adminpagemain">
			
			<div>
				<form method="post" action="/mini/adminpage/memDel">	
					<ul id="userList">
					</ul>
					<input class="btn btn-outline-secondary" id='memDel'  type="submit" value="삭제" style="display: none;"/>
				</form>	
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
					<li class="on"><a href="/mini/mypage/rootpage">회원관리</a></li>
					<li ><a href="/mini/adminpage/boardList">게시글관리</a></li>
					<li ><a href="/mini/adminpage/adminQnaList" id="qna">Q&A관리</a></li>
				</ul>
			</div>				
		</div>	
</div>
	