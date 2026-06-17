<%@page import="com.ict.mini.vo.FestivalVO"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Locale" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/festivalView.css" type="text/css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d185fd23633c2504d7447e6d035d34d9"></script>

<script>
function initializePage() {
    
 	// JSP에서 데이터를 자바스크립트 변수로 전달
    var festivalTitle = "${festival.title}";
    var festivalLat = ${festival.lat};
    var festivalLon = ${festival.lon};
    
    console.log(festivalTitle, festivalLat, festivalLon); // 값 확인
    
    // 카카오 지도 생성
    kakao.maps.load(() => {
	    var container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스
	    var options = { // 지도를 생성할 때 필요한 기본 옵션
	        center: new kakao.maps.LatLng(festivalLat, festivalLon), // 지도의 중심좌표.
	        level: 3 // 지도의 레벨(확대, 축소 정도)
	    };
	
	    var map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴
	    
	 // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: new kakao.maps.LatLng(festivalLat, festivalLon), // 마커의 위치
            title: festivalTitle // 마커의 타이틀
        });
    });
}
window.onload = initializePage;
</script>
<script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            // 축제 날짜를 JSP에서 전달받아 JavaScript 변수로 설정
            var festivalStartDate = new Date("${festival.start_date}");
            var festivalEndDate = new Date("${festival.end_date}");
            
            // 현재 날짜 구하기
            var currentDate = new Date();
            
            // 상태를 업데이트할 요소 선택
            var statusElement = document.querySelector('.ongoing, .upcoming, .finished');
            
            if (currentDate >= festivalStartDate && currentDate <= festivalEndDate) {
                statusElement.textContent = "진행 중";
                statusElement.className = "ongoing";
            } else if (currentDate < festivalStartDate) {
                statusElement.textContent = "준비 중";
                statusElement.className = "upcoming";
            } else {
                statusElement.textContent = "종료";
                statusElement.className = "finished";
            }
        });
      
        var festivalNo = '${festival.no}';
        var userId = '${logId}';

        if (userId) {
            $.ajax({
                url: '/mini/festival/festivalView/${no}/mylikes',
                type: 'GET',
                data: { userId: userId },
                success: function(result) {
                    if (result.error) {
                        console.error(result.error);
                    } else {
                        var likedRestCodes = result.likes;
                        $('.like-icon').each(function() {
                            var no = $(this).data('no');
                            $(this).text(likedRestCodes.includes(no) ? '♥' : '♡');
                        });
                    }
                },
                error: function(error) {
                    console.error('에러 발생:', error);
                }
            });
        }

        $(document).on('click', '.like-icon', function() {
            var no = $(this).data('no');
            var userid = '${logId}';

            if (!userid) {
                alert('로그인이 필요합니다.');
                return;
            }

            $.ajax({
                url: '/mini/festival/festivalView/${no}/Togglelikes',
                type: 'POST',
                data: { no: no, userid: userid },
                success: function(response) {
                    if (response.error) {
                        alert(response.error);
                    } else {
                        var icon = $(`.like-icon[data-no="${no}"]`);
                        icon.text(response.likes ? '♥' : '♡');
                    }
                },
                error: function(error) {
                    console.error('에러 발생:', error);
                }
            });
        });
     
</script>
<script>



$(document).ready(function() {
   console.log("Festival_no:", "${festival.no}");
    reviewList(); 
    function reviewList() {
        var festival_no = "${festival.no}";
        
        $.ajax({
            url: '/mini/festival/festivalView/' + ${festival.no} + '/festivalList',
            type: 'GET',
            success: function(result) {
                console.log(result);

                function getStarRatingHtml(rating, maxStars) {
                    var starsHtml = '';
                    for (var i = 1; i <= maxStars; i++) {
                       starsHtml += `<span class="star-icon ${i <= rating ? 'filled' : ''}">★</span>`;
                    }
                    return starsHtml;
                }
                
                var reviewTag = "";
                if (result.length === 0) {
                    reviewTag = "<p>등록된 리뷰가 없습니다.</p>";
                } else {
                $(result).each(function(idx, rVO) {
                   console.log(rVO);
                   
                   var maxStars = rVO.rating; // rVO.rating을 maxStars로 사용
                   var starsHtml = getStarRatingHtml(rVO.rating, maxStars);
                   
                    /* reviewTag += `<div>
                                    <div><b>`+rVO.userid+`</b> `+rVO.writedate; */
                    
                    
    
                        reviewTag += `<div>
                                   <div><b>`+rVO.userid+`</b>`+rVO.writedate+`</div>
                                   <div class="rating-display" >`+starsHtml+`</div>
                                   <p>`+rVO.contents+`</p></div>`

                                   if (rVO.userid === '${logId}') {
                                      reviewTag += `
                                           <input type='button' value='수정' class='edit-button' data-review-no='`+rVO.review_no+`'/>
                                           <input type='button' value='삭제' class='delete-button' onclick="refreshPage()" data-review-no='`+rVO.review_no+`'/>`;
                                       reviewTag += `
                                           </div>
                                           <div class='edit-form' data-review-no='`+rVO.review_no+`' style='display:none;'>
                                       <form class="edit-review-form" method="post" action="/mini/festival/festivalView/' + ${festival.no} + '/edit">
                                               <textarea name='contents' id='contents`+rVO.review_no+`' style="width: 500px;">`+rVO.contents+`</textarea>
                                               <input type='hidden' name='review_no' value='`+rVO.review_no+`'/>
                                               <input type='hidden' name='rating' value='`+rVO.rating+`'/>
                                               <input type='submit' value='댓글수정하기' onclick="refreshPage()"/>
                                           </form>
                                       </div><hr/>`;
                               } else {
                                   reviewTag += `</div><hr/>`;
                               }
                           });
                         }
                           $(".reviewList").html(reviewTag);
                       },
                       error: function(error) {
                           console.log(error.responseText);
                       }
                   });
               }


    $('#reviewForm').on('submit', function(event) {
        event.preventDefault(); // 기본 폼 제출 막기

        var contents = $('#contents').val(); // 댓글 내용
        var rating = $("input[name=rating]").val(); // 평점 가져오기
       
        if (!contents || !rating) {
            alert('댓글 내용과 평점을 입력해 주세요.');
            return;
        }
        
        var formData = $(this).serialize(); // 폼 데이터를 직렬화
      console.log('formData',formData);
        $.ajax({
            type: 'POST',
            url: '/mini/festival/festivalView/review/write',
            data: formData,
            success: function(result) {
                if (result === '1') { // 댓글 등록시
                    alert('리뷰가 성공적으로 등록되었습니다.');
                    $('#contents').val('');
                    $('input[name="rating"]').val('');
                    reviewList();
                    
                } else {
                    alert("리뷰 등록 실패");
                }
                console.log(result);
            },
            error: function(e) {
                console.log('에러 발생:', e.responseText);
            }
        });
    });
       
        $(document).on('click', '.edit-button', function() {

              $('.edit-form').hide();

              var review_no = $(this).data('review-no');

              $(`.edit-form[data-review-no="` + review_no + `"]`).show();
          });

    // 수정 폼 제출 처리
    $(document).on('submit', '.edit-review-form', function(event) {
        event.preventDefault(); // 기본 폼 제출 막기

        var formData = $(this).serialize(); // 폼 데이터를 직렬화

        $.ajax({
            type: 'POST',
            url: '/mini/festival/festivalView/' + ${festival.no} + '/edit',
            data: formData,
            success: function(result) {
                if (result === '1') {
                    alert('리뷰가 성공적으로 수정되었습니다.');
                    $('.edit-form').hide(); // 수정 폼 숨기기
                    reviewList(); // 리뷰 목록 갱신
                } else {
                    alert('리뷰 수정에 실패했습니다.');
                }
            },
            error: function(error) {
                console.log('에러 발생:', error.responseText);
            }
        });
    });


    $(document).on('click', '.delete-button', function() {
        if (confirm("댓글을 삭제하시겠습니까?")) {
           var review_no = $(this).data('review-no');

            if (!review_no) {
                alert('리뷰 번호를 찾을 수 없습니다.');
                return;
            }
            
            $.ajax({
                url: '/mini/festival/festivalView/{festival_no}/delete',
                type: 'POST',
                data: { review_no: review_no },
                success: function(result) {
                    if (result === '1') {
                        alert('리뷰가 삭제되었습니다.');
                        reviewList(); // 리뷰 목록 갱신
                    } else {
                        alert('리뷰 삭제에 실패했습니다.');
                    }
                },
                error: function(error) {
                    console.log('에러 발생:', error.responseText);
                }
            });
        }
    }); 

    reviewList();
});
function refreshPage() {
    // 페이지 새로 고침
    location.reload();
}
   

</script>
<script>
$(document).ready(function() {
    $('.star').on('click', function() {
        var rating = $(this).find('input').val();
        //$('input[name="rating"]').val(rating); // rating 값 업데이트

        // Update star appearance
        $('.star-icon').css('color', '#d3d3d3'); // 기본 회색으로 초기화
        $(this).prevAll().addBack().find('.star-icon').css('color', '#ffcc00'); // 선택된 별 색상으로 변경
    });
});


</script>
<div id="festivalView">
    <div class="container">
        <div class="topImg">
            <img src="${pageContext.request.contextPath}/images/poster/${festival.poster}" alt="${festival.title}"/>
        </div>
        <div class="details">
            <h1>${festival.title } </h1>
            <div class="status"> 
                <c:choose>
                	<c:when test="${currentDate.after(festivalStartDate) && currentDate.before(festivalEndDate)}">
			            <div class="ongoing">진행중</div>
			        </c:when>
                    <c:when test="${currentDate.before(festivalStartDate)}">
                        <div class="upcoming">준비중</div>
                    </c:when>
                    <c:otherwise>
                        <div class="finished">종료</div>
                    </c:otherwise>
                </c:choose>
                
            </div> 
            <p>${festival.start_date} ~ ${festival.end_date}</p>
            <div class="like_hit">
             <i class="like-icon" data-no="${festival.no}" style="font-style: normal;"> ♡</i>
            	
            	<img src="${pageContext.request.contextPath}/images/icon/hit.png" style="width:16px; height:16px"/>
            	<span id="viewCount">${festival.hit}</span> 
            </div>
            <div class="content">S
                <c:out value="${festival.content != null ? festival.content : 'No content available.'}" escapeXml="false"/>
            </div>
            <hr/>
            <div class="middleContainer">
	            <div class="middleImg">
	            	<img style="width:400px; height:500px;" src="${pageContext.request.contextPath}/images/poster/${festival.poster}" alt="${festival.title}"/>
	        	</div>
	        	<div class="middleDetail">
	        		<p>
	        			<img src="${pageContext.request.contextPath}/images/icon/calendar2.png" class="icon"/>
	        			${festival.start_date} ~ ${festival.end_date}
	        		</p>
	        		<p>
	        			<img src="${pageContext.request.contextPath}/images/icon/address2.png" class="icon"/>
	        			${festival.addrdetails } ${festival.addr }
	        		</p>
	        		<p>
	        			<img src="${pageContext.request.contextPath}/images/icon/location.png" class="icon"/>
	        			<c:choose>
				            <c:when test="${festival.environment == 'in'}">
				                실내
				            </c:when>
				            <c:when test="${festival.environment == 'out'}">
				                실외
				            </c:when>
				            <c:otherwise>
				                정보 없음
				            </c:otherwise>
				        </c:choose>
	        		</p>
	        		<p>
	        			<img src="${pageContext.request.contextPath}/images/icon/host2.png" class="icon"/>
	        			${festival.host}
	        		</p>
	        		<p>
	        			<img src="${pageContext.request.contextPath}/images/icon/tel.png" class="icon"/>
	        			${festival.tel }
	        		</p>
	        	</div>
	        </div>
	        <hr/>
	        <!-- <div id="map" class="map" style="width:100%; height:400px;" ></div> -->
	        <div id="kakaoMapLink" class="kakao-map-link" style="margin-top: 20px;">
		    <h2>오는길</h2>
			    <div id="map" style="width:1200px; height:400px;"></div>
			</div>
			<hr/>
			<c:if test="${not empty popularRestaurants}">
			    <h2>이 음식점은 어떠세요?</h2>
			    <div id="popularRestaurantsList">
			        <c:forEach var="restaurant" items="${popularRestaurants}">
			            <div class="restaurantItem">
			                <a href="${pageContext.request.contextPath}/rest/restView/${restaurant.rest_code}">
                    			<img src="${pageContext.request.contextPath}/images/Food/${restaurant.imageurl}"/>
			                    <div class="restaurantDetail">
			                        <h3 class="detail">${restaurant.store_name}</h3>
			                        <p class="detail">${restaurant.addr}</p>
			                    </div>
			                </a>
			            </div>
			        </c:forEach>
			    </div>
			</c:if>
	        <hr/>
	        <c:if test="${not empty ongoingFestivals}">
			    <h2>이런 축제는 어때요?</h2>
			    <div id="ongoingFestivalsList">
			        <c:forEach var="festival" items="${ongoingFestivals}">
			            <div class="ongoingFestival">
			                <a href="${pageContext.request.contextPath}/festival/festivalView/${festival.no}">
			                    <img src="${pageContext.request.contextPath}/images/poster/${festival.poster}" alt="${festival.title}"/>
			                    <div class="festivalDetail">
			                        <h3 class="detail">${festival.title}</h3>
			                        <p class="detail">${festival.start_date} ~ ${festival.end_date}</p>
			                    </div>
			                </a>
			            </div>
			        </c:forEach>
			    </div>
			</c:if>
			<c:if test="${empty ongoingFestivals}">
			    <p>현재 진행 중인 축제가 없습니다.</p>
			</c:if>
			<hr/>
			<h2>리뷰</h2>
			<!-- 리뷰 섹션 -->
			<c:if test="${logStatus == 'Y'}">
			    <section class="review-form">  
			       <form id="reviewForm" method="post" action="/mini/festival/festivalView/review/write">
			            <input type="hidden" name="festival_no" value="${festival.no}"/>
					                                                
			            <!-- 리뷰 내용 -->
						<div class="form-group">
						    <label for="reviewContent">리뷰 내용:</label>
						    <textarea id="contents" name="contents" rows="4" required></textarea>
						</div>
						<!-- 별점 선택 -->
						<div class="form-group">
						    <label for="rating">별점:</label>
						    <div class="rating">
						    	<label class="star" >
					                <input type="radio" for="star1" name="rating" value="1">
					                <span class="star-icon">★</span>
					            </label>
					            <label class="star" >
					                <input type="radio" for="star2" name="rating" value="2">
					                <span class="star-icon">★</span>
					            </label>
					            <label class="star" >
					                <input type="radio" for="star3" name="rating" value="3">
					                <span class="star-icon">★</span>
					            </label>
					            <label class="star" >
					                <input type="radio" for="star4" name="rating" value="4">
					                <span class="star-icon" id="star4">★</span>
					            </label>
					            <label class="star" >
					                <input type="radio" for="star5" name="rating" value="5">
					                <span class="star-icon" id="star5">★</span>
					            </label>
						    </div>
						    <!-- <input type="hidden" id="selectedRating" name="rating" value=""/>  선택한 별점 값을 저장 -->
						</div>
						<!-- 리뷰 제출 -->
						<input class="submit" type="submit" value="등록" onclick="refreshPage()"/>
					</form>
				</section>
			</c:if>
			
			<section class="reviews">
				<div class="reviewList">
					
					<!-- 리뷰 내용이 여기에 삽입됩니다 -->
				</div>
			</section>
		</div>
	</div>
    
</div>

