<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/mini/css/festivalList.css" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<script>
document.addEventListener('DOMContentLoaded', function() {
    const buttons = document.querySelectorAll('.sort-buttons .sort-button');

    // 현재 URL의 sortBy 파라미터 값을 가져옵니다
    const urlParams = new URLSearchParams(window.location.search);
    const sortBy = urlParams.get('sortBy') || 'date'; // 기본값을 'date'로 설정
    
    buttons.forEach(button => {
        // 버튼의 data-sort 값과 URL 파라미터 값을 비교하여 선택된 버튼에 클래스를 추가합니다
        if (button.dataset.sort === sortBy) {
            button.classList.add('selected');
        }
        button.addEventListener('click', function(event) {
            event.preventDefault(); // 링크 클릭 시 페이지 이동 방지
            
            // 현재 선택된 버튼의 클래스를 제거
            buttons.forEach(btn => btn.classList.remove('selected'));

            // 클릭한 버튼에 selected 클래스 추가
            this.classList.add('selected');

            // 링크를 통해 페이지 이동
            window.location.href = this.href;
        });
    });
});
</script>

<div id="festlvalList">
    <div class="banner">
        <img src="/mini/images/list_top/busan2.jpeg" alt="Banner Image"/>
    </div>
    <div class="sort-buttons">
        <a href="?sortBy=date" data-sort="date" class="sort-button">축제일순</a>
        <a href="?sortBy=like" data-sort="like" class="sort-button">인기순</a>
        <a href="?sortBy=hit" data-sort="hit" class="sort-button">조회순</a>
    </div>
    <div class="container">
        <c:forEach var="vo" items="${festivalList}">
            <div class="list">
                <a href="${pageContext.request.contextPath}/festival/festivalView/${vo.no }">
                    <img class="list_img" src="/mini/images/poster/${vo.poster}" />
                    <div class="list_detail">
                        <h3 class="detail">${vo.title}</h3>
                        <p class="detail">${vo.start_date}~${vo.end_date}</p>
                        <p class="detail">${vo.addrdetails}</p>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<div>
    <!-- 페이징 -->
    <ul class="pagination justify-content-center">
        <!-- Previous 버튼 -->
        <c:if test="${pVO.nowPage > 1}">
            <li class="page-item">
                <a class="page-link" href="javascript:reloadPage(${pVO.nowPage - 1}, '${param.sortBy}');">Previous</a>
            </li>
        </c:if>
        <c:if test="${pVO.nowPage == 1}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0);">Previous</a>
            </li>
        </c:if>
        
        <!-- 페이지 번호 -->
        <c:forEach var="p" begin="${pVO.startPageNum}" end="${pVO.startPageNum + pVO.onePageNum - 1}">
            <c:if test="${p <= pVO.totalPage}">
                <li class="page-item <c:if test='${pVO.nowPage == p}'>active</c:if>'">
                    <a class="page-link" href="javascript:reloadPage(${p}, '${param.sortBy}');">${p}</a>
                </li>
            </c:if>
        </c:forEach>

        <!-- Next 버튼 -->
        <c:if test="${pVO.nowPage < pVO.totalPage}">
            <li class="page-item">
                <a class="page-link" href="javascript:reloadPage(${pVO.nowPage + 1}, '${param.sortBy}');">Next</a>
            </li>
        </c:if>
        <c:if test="${pVO.nowPage == pVO.totalPage}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0);">Next</a>
            </li>
        </c:if>
    </ul>
</div>

<script type="text/javascript">
function reloadPage(pageNumber, sortBy) {
    // 페이지를 리로드하는 함수
    window.location.href = '/mini/festival/festivalList?page=' + pageNumber + '&sortBy=' + sortBy;
}
</script>
