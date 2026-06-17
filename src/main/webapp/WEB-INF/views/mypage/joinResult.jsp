<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
function closePopup() {
    if (popupWindow && !popupWindow.closed) {
        popupWindow.close();
    }
}

</script>


  <c:if test="${result == 0}">
        <script>
            alert("회원가입에 실패했습니다. 다시 시도해주세요.");
            history.back(); // 이전 페이지로 돌아가기
        </script>
    </c:if>
    <c:if test="${result == 1}">
        <script>
            alert("회원가입이 완료되었습니다."); // 알림창 띄우기
            setTimeout(function() {
                window.close(); // 현재 팝업 창을 닫기
            }, 1); 
        </script>
    </c:if>