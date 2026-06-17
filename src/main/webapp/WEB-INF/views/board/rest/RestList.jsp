<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>음식 | DANDI</title>
<link rel="stylesheet" href="/mini/css/food.css" type="text/css"/>
<script>
$(document).ready(function() {
    $('.carousel-container').each(function() {
        var $container = $(this);
        var $carousel = $container.find('.carousel');
        var $items = $carousel.find('.food-item');
        var itemWidth = $items.outerWidth(true);
        var totalItems = $items.length;
        var itemsToShow = 5; // Number of items to show
        var totalWidth = itemWidth * totalItems;
        
        var currentIndex = 0;
        var maxIndex = totalItems - itemsToShow;

        $container.find('.next').click(function() {
            if (currentIndex < maxIndex) {
                currentIndex++;
                updateCarousel();
            }
        });

        $container.find('.prev').click(function() {
            if (currentIndex > 0) {
                currentIndex--;
                updateCarousel();
            }
        });

        function updateCarousel() {
            var offset = -itemWidth * currentIndex;
            $carousel.css('transform', 'translateX(' + offset + 'px)');
        }

        // Initial setup
        updateCarousel();
    });
});
</script>
<!-- 카테고리별 의 지도 표시 링크 따로 표시  -->
   <%--  <div class="categoryMapView">
        <button class="categoryMap"><a href="#">${food[0].category}</a></button>
        <button class="categoryMap"><a href="#">${Japanesefood[0].category}</a></button>
        <button class="categoryMap"><a href="#">${westernstyle[0].category}</a></button>
        <button class="categoryMap"><a href="#">${cafe[0].category}</a></button>
        <button class="categoryMap"><a href="#">${Chinesefood[0].category}</a></button>
        <button class="categoryMap"><a href="#">${Uniquefood[0].category}</a></button>
    </div> --%>
   
 <!-- 상단이미지 -->
   <div id="imgBox1">
      <img src="/mini/images/Food/야시장.jpg" id="imgContent1" />
   </div>
   <div id="restTitle"><h2>맛집 한눈에 보기👀</h2></div>
<div class="restList">
    <div class="tagHeader">
        <h2>${food[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${food}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>
<div class="restList">
    <div class="tagHeader">
        <h2>${Japanesefood[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${Japanesefood}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>
<div class="restList">
    <div class="tagHeader">
        <h2>${westernstyle[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${westernstyle}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>
<div class="restList">
    <div class="tagHeader">
        <h2>${cafe[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${cafe}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>
<div class="restList">
    <div class="tagHeader">
        <h2>${Chinesefood[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${Chinesefood}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>
<div class="restList">
    <div class="tagHeader">
        <h2>${Uniquefood[0].category}</h2>
    </div>
    <div class="carousel-container">
        <button class="prev">&lt;</button>
        <div class="carousel">
            <c:forEach var="foodVO" items="${Uniquefood}">
                <div class="food-item">
                    <a href="/mini/rest/restView/${foodVO.rest_code}">
                        <img src="/mini/images/Food/${foodVO.imageurl}" alt="음식 이미지"/>
                    </a>
                    <p>${foodVO.store_name}</p>
                </div>
            </c:forEach>
        </div>
        <button class="next">&gt;</button>
    </div>
</div>