<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<script src="https://kit.fontawesome.com/5736c47827.js" crossorigin="anonymous"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=b45e962e5c780aecefa8a8cae0f46328&autoload=false"></script>
<link rel="stylesheet" href="/mini/css/food.css" type="text/css"/>
<title>${restView.store_name} : 음식 | 상세 정보</title>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const stars = document.querySelectorAll('.star');
    const selectedRatingInput = document.getElementById('selectedRating');
    const reviewForm = document.getElementById('reviewForm');

 // 별점 클릭 이벤트
    $('.rating .star').on('click', function() {
        var ratingValue = $(this).data('value');
        $('#selectedRating').val(ratingValue);  // 선택한 별점 값을 hidden input에 저장

        // 모든 별점 선택 해제 후 선택한 별점까지 선택 표시
        $('.rating .star').removeClass('selected');
        $(this).addClass('selected');
        $(this).prevAll().addClass('selected');  // 이전 별들에도 선택 표시
    });
    
    

    // 리뷰 제출 버튼 클릭 시 폼 제출
    const reviewSubmitButton = document.querySelector('.review_submit');
    if (reviewSubmitButton) {
        reviewSubmitButton.addEventListener('click', function(event) {
            if (selectedRatingInput.value === '') {
                alert('별점을 선택해 주세요.');
                event.preventDefault(); // 별점을 선택하지 않으면 폼 제출 방지
            }
        });
    }

    $(document).on('click', '.like-icon', function() {
        var rest_code = $(this).data('rest-code');
        var userid = '${logId}';  // 사용자 ID (서버에서 렌더링된 값)

        if (!userid) {
            alert('로그인이 필요합니다.');
            return;
        }

        $.ajax({
            url: `/mini/rest/restView/${rest_code}/Togglelikes`,
            type: 'POST',
            data: { rest_code: rest_code, userid: userid },
            success: function(response) {
                if (response.error) {
                    alert(response.error);
                } else {
                    var icon = $(`.like-icon[data-rest-code="${rest_code}"]`);
                    icon.text(response.likes ? '♥(조아용)' : '♡(좋아요)'); // 좋아요 상태 업데이트
                    
                    // 좋아요 상태에 따라 텍스트 색상 변경
                    if (response.likes) {
                        icon.css('color', 'red');  // 좋아요 눌렀을 때 빨간색
                    } else {
                        icon.css('color', 'black');  // 좋아요 취소 시 검정색
                    }
                    
                    $('#like-count').text(response.likeCount); // 좋아요 수 업데이트
                }
            },
            error: function(error) {
                console.error('에러 발생:', error);
            }
        });
    });

    $(document).ready(function() {
        var userId = '${logId}';  // 사용자 ID (서버에서 렌더링된 값)

        if (userId) {
            $.ajax({
                url: `/mini/rest/restView/${restView.rest_code}/mylikes`,
                type: 'GET',
                data: { userId: userId },
                success: function(result) {
                    if (result.error) {
                        console.error(result.error);
                    } else {
                        var likedRestCodes = result.likes;
                        $('.like-icon').each(function() {
                            var restCode = $(this).data('rest-code');
                            var isLiked = likedRestCodes.includes(restCode);

                            $(this).text(isLiked ? '♥(조아요)' : '♡(좋아요)');
                            
                            // 초기 좋아요 상태에 따라 색상 설정
                            $(this).css('color', isLiked ? 'red' : 'black');
                        });
                    }
                },
                error: function(error) {
                    console.error('에러 발생:', error);
                }
            });
        }
    });


    // 리뷰 목록 불러오기
    function reviewList() {
        $.ajax({
            url: `/mini/rest/restView/${restView.rest_code}/reviewList`,
            type: 'GET',
            success: function(result) {
                var reviewTag = "";
                $(result).each(function(idx, rVO) {
                    reviewTag += `
                        <div class="review-item">
                            <div class="review-content">
                                <b>`+rVO.userid+`</b> (`+rVO.writedate+`)
                                <p>`+rVO.contents+`</p>`;

                                var logId = '${logId}'
                                if (rVO.userid === logId || logId === 'root' ) {
                        reviewTag += `
                            <input type='button' value='수정' class='btn btn-outline-secondary' data-review-no='`+rVO.review_no+`'/>
                            <input type='button' value='삭제' class='btn btn-outline-danger' data-review-no='`+rVO.review_no+`'/>`;
                        reviewTag += `
                            </div>
                            <div class='edit-form' data-review-no='`+rVO.review_no+`' style='display:none;'>
                            <form class="edit-review-form" method="post" action="/mini/rest/restView/${restView.rest_code}/edit">
                                    <textarea name='contents' id='contents`+rVO.review_no+`' style="width: 500px;">`+rVO.contents+`</textarea>
                                    <input type='hidden' name='review_no' value='`+rVO.review_no+`'/>
                                    <input type='submit' value='댓글수정하기'/>
                                </form>
                            </div><hr/>`;
                    } else {
                        reviewTag += `</div><hr/>`;
                    }
                });
                $(".reviewList").html(reviewTag);
            },
            error: function(error) {
                console.log(error.responseText);
            }
        });
    }

    // 리뷰 등록
   $('#reviewForm').on('submit', function(e) {
    e.preventDefault();  // 폼의 기본 제출 방지
    
    $.ajax({
        type: 'POST',
        url: `/mini/rest/restView/${restView.rest_code}/ReviewOk`,
        data: $(this).serialize(),  // 폼 데이터를 직렬화하여 전송
        success: function(result) {
            if (result === '1') {
                alert('리뷰가 성공적으로 등록되었습니다.');
                $('#contents').val('');
                $('#selectedRating').val('');  // 숨겨진 별점 값 초기화
                $('.rating .star').removeClass('selected');  // 모든 별점 선택 해제
                reviewList();  // 리뷰 목록 갱신
            } else {
                alert('리뷰 등록에 실패하였습니다.');
            }
        },
        error: function(error) {
            console.log(error.responseText);
        }
    });
});

// 수정 버튼 클릭 시 수정 폼 표시
   $(document).on('click', '.btn-outline-secondary', function() {

       $('.edit-form').hide();

       var review_no = $(this).data('review-no');

       $(`.edit-form[data-review-no="` + review_no + `"]`).show();
   });

   // 리뷰 수정
   $(document).on('submit', '.edit-review-form', function(event) {
       event.preventDefault();  


       var params = $(this).serialize();


       $.ajax({
           type: 'POST',
           url: `/mini/rest/restView/${restView.rest_code}/edit`,
           data: params,  
           success: function(result) {
               if (result === '1') {
                   alert('리뷰가 성공적으로 수정되었습니다.');
                   reviewList();  
               } else {
                   alert('리뷰 수정에 실패하였습니다.');
               }
           },
           error: function(error) {
               console.log(error.responseText);
           }
       });
   });

 // 리뷰 삭제하기
    $(document).on("click", ".btn-outline-danger", function() {
        if (confirm("리뷰를 삭제하시겠습니까?")) {
            var review_no = $(this).data('review-no');
            $.ajax({
               type : 'get',
                url: `/mini/rest/restView/${restView.rest_code}/del`,
                data: { review_no: review_no },
                success: function(result) {
                    if (result === '0') {
                        alert("삭제 실패하였습니다.");
                    } else {
                       alert("리뷰가 삭제 되었습니다.");
                        reviewList();
                    }
                },
                error: function(error) {
                    console.log(error.responseText);
                }
            });
        }
    });

    reviewList();
});
</script>
 <!-- 상단이미지 -->
   <div id="imgBox1">
      <img src="/mini/images/Food/야시장.jpg" id="imgContent1" />
   </div>
<header class="header">
      <h2>📌음식점 상세보기</h2>
        <img src="/mini/images/Food/${restView.imageurl}" alt="${restView.store_name} Image" class="header-img"/>
        <h1 class="store-name">${restView.store_name}</h1>
        <span class="status">${isOpen}</span>
    </header>
<!-- 주소 , 전화번호, 대표메뉴, 카테고리 영역  -->
    <section class="details">
        <div class="detail-item">
            <i class="fa-solid fa-location-arrow"> 주소 </i>
            <p>${restView.addr}</p>
        </div>
        <div class="detail-item">
            <i class="fa-solid fa-headset"> 문의 및 안내 </i>
            <p>${restView.tel}</p>
        </div>
        <div class="detail-item">
            <i class="fa-solid fa-utensils"> 대표메뉴 </i>
            <p> ${restView.repMenu}</p>
        </div>
        <div class="detail-item">
            <i class="fa-solid fa-list"> 카테고리 </i>
            <p>${restView.category}</p>
        </div>
      <div class="detail-item">
    <i class="fa-solid fa-thumbs-up like-icon" data-rest-code="${restView.rest_code}"> 좋아요 </i>
    <p id="like-count">${updatedLikeCount}</p>
</div>
      <div class="detail-item">
            <i class="fa-solid fa-list"> 별점 </i>
            <p>${averageRating}</p>
        </div>
    </section>

<!-- 영업시간  -->
    <section class="hours">
        <h2>영업시간</h2>
        <p>${restView.opentime}</p>
    </section>
<!-- 메뉴 리스트  -->
    <section class="menu-list">
        <h2>메뉴 리스트</h2>
        <p>${restView.menu1}</p>
    </section>
<!-- 가게 사진 목록  -->
    <section class="photos">
        <h2>${restView.store_name}의 사진</h2>
        <div class="photos-gallery">
            <img src="/mini/images/Food/${restView.imageurl1}" alt="Photo 1"/>
            <img src="/mini/images/Food/${restView.imageurl2}" alt="Photo 2"/>
            <img src="/mini/images/Food/${restView.imageurl3}" alt="Photo 3"/>
        </div>
    </section>
<!-- 가게 상세 내용  -->
    <section class="explanation">
        <h2>상세 설명</h2>
        <p>${restView.explanation}</p>
    </section>
</div>
<!-- 리뷰 섹션 -->
<c:if test="${logStatus == 'Y'}">
    <section class="review-form">
        <h3>리뷰 작성하기</h3>
       <form id="reviewForm" method="post" action="/mini/rest/restView/${restView.rest_code}/ReviewOk">
            <input type="hidden" name="rest_code" value="${restView.rest_code}"/>
            
            <!-- 리뷰 내용 -->
            <div class="form-group">
                <label for="contents">리뷰 내용:</label>
                <textarea id="contents" name="contents" rows="4" required></textarea>
            </div>
            
            <!-- 별점 선택 -->
            <div class="form-group">
                <label for="rating">별점:</label>
                <div class="rating">
                    <span class="star" data-value="1">★</span>
                    <span class="star" data-value="2">★</span>
                    <span class="star" data-value="3">★</span>
                    <span class="star" data-value="4">★</span>
                    <span class="star" data-value="5">★</span>
                </div>
                <input type="hidden" id="selectedRating" name="rating" value=""/> <!-- 선택한 별점 값을 저장 -->
            </div>
            
            <!-- 리뷰 제출 -->
            <input class="review_submit" type="submit" value="리뷰등록"/> <!-- 버튼을 submit으로 변경 -->
        </form>
    </section>
</c:if>

<section class="reviews">
    <h2>리뷰</h2>
    <div class="reviewList">
        <!-- 리뷰 내용이 여기에 삽입됩니다 -->
    </div>
</section>
<!-- 지도 영역  -->
 <section class="map">
<h2>가게 위치</h2>
    <div id="map" style="width:100%;height:700px;"></div>
    <!-- 서버에서 전달받은 데이터 JSON으로 변환 -->
    <script type="application/json" id="storeData">
        ${kakaomapJson}
    </script>
<script>
    function loadKakaoMapsScript(callback) {
        const script = document.createElement('script');
        script.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=b45e962e5c780aecefa8a8cae0f46328&autoload=false';
        script.onload = callback;
        script.onerror = function() {
            console.error('Failed to load Kakao Maps script.');
        };
        document.head.appendChild(script);
    }

    function initializeMap() {
        kakao.maps.load(function() {
            const jsonString = document.getElementById('storeData').textContent;
            let locations;
            try {
                locations = JSON.parse(jsonString);
                console.log('Parsed JSON data:', locations); // JSON 데이터 확인
            } catch (e) {
                console.error('Failed to parse JSON data:', e);
                return;
            }

            const targetRestCode = locations.length > 0 ? locations[0].rest_code : null;
            const targetLocations = locations.filter(locations => locations.rest_code === targetRestCode);

            if (targetLocations.length === 0) {
                console.error('No store data found for the specified rest_code.');
                return;
            }

            const firstLocation = targetLocations[0];
            const centerPosition = new kakao.maps.LatLng(parseFloat(firstLocation.x_point), parseFloat(firstLocation.y_point));
            
            const mapContainer = document.getElementById('map');
            const mapOptions = {
                center: centerPosition, 
                level: 1,
                disableDefaultUI: true
            };
            const map = new kakao.maps.Map(mapContainer, mapOptions);

            
            // 지도 이동 제어 비활성화
            map.setDraggable(false); // 드래그로 이동 불가
            map.setZoomable(false); // 줌 조절 불가

            // 마커와 정보창 추가
            targetLocations.forEach(locations => {
                const position = new kakao.maps.LatLng(parseFloat(locations.x_point), parseFloat(locations.y_point));
                const marker = new kakao.maps.Marker({
                    position: position,
                    map: map,
                    clickable : true
                });
                
                marker.setMap(map);
                
                const infowindowContent = `<div style="padding:5px; font-size : 0.5em;">`+locations.store_name+`</div>`;
                iwRemoveable = true;                
                
                // InfoWindow 객체 생성
                const infowindow = new kakao.maps.InfoWindow({
                    content: infowindowContent,
                    removable : iwRemoveable
                });
                
                console.log(locations.store_name);
                console.log(locations.addr);
                
                kakao.maps.event.addListener(marker, 'click', function() {
                    infowindow.open(map, marker);
                });
            });
        });
    }

    loadKakaoMapsScript(initializeMap);
    </script>
    </section>
    
  <!-- 같은 카테고리의 목록 보여주기 -->
<section class="similarRestaurant">
    <h2>${restView.store_name}과 비슷한 맛집</h2>
    <div class="RestaurantSimilar">
        <c:forEach var="restaurant" items="${similarRestaurant}">
            <div class="photo-item">
                <a href="/mini/rest/restView/${restaurant.rest_code}">
                    <img src="/mini/images/Food/${restaurant.imageurl}" alt="${restView.store_name}"/>
                </a>
                <p>${restaurant.store_name}</p>
            </div>
        </c:forEach>
    </div>
</section>

<!-- 리뷰 보여주는건 위 아래 둘다 보여지게  -->
<section class="reviews">
        <h2>리뷰</h2>
        <div class="reviewList">
        </div>
    </section>