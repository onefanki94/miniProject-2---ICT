<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script>
	let max_temp = -100;
	let min_temp = 100;
	let max_min_temp = [];
	let rain = [];
    var labels = {};
    var datas = {};
    var chart;
    var currentLabels = []; // 현재 선택된 날짜의 시간 데이터
    var currentData = []; // 현재 선택된 날짜의 온도 데이터
    var selectedDate = ""; // 현재 선택된 날짜를 저장하는 변수
    var weather = {};
    var weatherlist = {};
    let max_min_tempData = {}; // 각 날짜의 최고/최저 온도와 날씨 아이콘을 저장
    function updateChart(date) {
        selectedDate = date;  // 선택된 날짜를 저장
        currentLabels = labels[selectedDate];
        currentData = datas[selectedDate];

        // 오늘 날짜인지 확인
        let today = new Date();
        let todayFormatted = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);

        // 오늘 날짜이면 closestIndex부터 데이터 슬라이스
        if (selectedDate === todayFormatted) {
            let closestIndex = 0;
            let currentHour = today.getHours();
            let minDifference = Number.MAX_VALUE;

            for (let i = 0; i < labels[selectedDate].length; i++) {
                let hour = parseInt(labels[selectedDate][i].substring(0, 2)); // 시간 추출
                let diff = Math.abs(currentHour - hour); // 현재 시간과 각 시간의 차이 계산

                if (diff < minDifference) {
                    minDifference = diff;
                    closestIndex = i;  // 가장 가까운 시간의 인덱스 저장
                }
            }

            // 오늘의 가까운 시간대부터 차트 업데이트
            chart.data.labels = currentLabels.slice(closestIndex);  // 가장 가까운 시간부터 시작
            chart.data.datasets[0].data = currentData.slice(closestIndex);  // 가장 가까운 시간대의 데이터부터 시작
            console.log("오늘 날짜 차트 업데이트:", chart.data.labels);
        } else {
            // 오늘이 아닌 경우 전체 데이터를 보여줌
            chart.data.labels = currentLabels;
            chart.data.datasets[0].data = currentData;
        }

        chart.update({
            duration: 800,  // 0.8초 동안 애니메이션 효과
            easing: 'easeInOutQuad' // 애니메이션 속도 조절
        });
    }
    window.onload = function () {
        setTimeout(function () {
            var xHttp = new XMLHttpRequest();

            xHttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    let result = JSON.parse(this.responseText);
                    
                    weather = result;
                    console.log("값오는지 확인", weather);
                   
                    max_min_temp = [];
                    rain = [];
                   

                    result.list.forEach(item => {
                        let date = new Date(item.dt_txt);
                        let formattedDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
                        let formattedTime = ('0' + date.getHours()).slice(-2) + ':' + ('0' + date.getMinutes()).slice(-2);

                        if (!labels[formattedDate]) {
                            labels[formattedDate] = [];
                            datas[formattedDate] = [];
                        }

                        labels[formattedDate].push(formattedTime);  // 시간 추가
                        datas[formattedDate].push(item.main.temp);  // 온도 추가

                        // 최고/최저 온도와 비 여부 저장
                        if (!max_min_tempData[formattedDate]) {
                            max_min_tempData[formattedDate] = { 
                                max: -Infinity, 
                                min: Infinity, 
                                icon: item.weather[0].icon, 
                                hasRain: false 
                            };
                        }

                        if (item.main.temp_max > max_min_tempData[formattedDate].max) {
                            max_min_tempData[formattedDate].max = item.main.temp_max;
                        }

                        if (item.main.temp_min < max_min_tempData[formattedDate].min) {
                            max_min_tempData[formattedDate].min = item.main.temp_min;
                        }

                        // 비오는 날씨 아이콘 저장
                        if (item.weather[0].icon.startsWith("09") || item.weather[0].icon.startsWith("10")) {
                            max_min_tempData[formattedDate].hasRain = true;
                            max_min_tempData[formattedDate].icon = "09n"; // 비오는 이미지로 설정
                        }
                    });

                    console.log("최고/최저 온도 및 비오는 날씨 저장:", max_min_tempData);

                    // 오늘 날짜 처리
                    let today = new Date();
                    let todayFormatted = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);

                    if (!labels[todayFormatted]) {
                        todayFormatted = Object.keys(labels)[0]; // 첫 번째 날짜 선택
                    }

                    currentLabels = labels[todayFormatted];
                    currentData = datas[todayFormatted];
                    selectedDate = todayFormatted; // 선택된 날짜 저장

                    // 차트 초기화
                 const data = {
					    labels: currentLabels, 
					    datasets: [{
					        data: currentData, 
					        fill: true,
					        borderColor: "#FFD632",
					        backgroundColor:"#FFF5CC",
					        tension: 0.5,
					    }]
					};
					
					const config = {
					    type: "line",
					    data: data,
					    options: {
					        onClick: (event) => {
					            const points = chart.getElementsAtEventForMode(event, 'nearest', { intersect: true }, false);
					            if (points.length > 0) {
					                const elementIndex = points[0].index;
					                weatherlist = weather.list[elementIndex];
					                const timeLabel = data.labels[elementIndex];
					                const value = data.datasets[0].data[elementIndex];
					
					                nowweather(selectedDate, timeLabel, value, weatherlist);
					            }
					        },
					        scales: {
					            x: {
					                grid: { display: false }
					            },
					            y: {
					            	  suggestedMin: Math.min(...currentData) - 1, 
					            	    suggestedMax: Math.max(...currentData) + 1,
					                beginAtZero: false,
					                grid: { display: false },
					                ticks: { display: false }  // Y축 값 숨기기
					            }
					        },
					        plugins: {
					            legend: { display: false },
					            datalabels: {
					                display: true,  // 각 포인트에 값을 표시
					                align: 'top',   // 점 위에 표시
					                anchor: 'end',  // 점의 끝 부분에 맞춤
					                color: 'black', // 텍스트 색상
					                formatter: function(value) {
					                    return value.toFixed(1);  // 소수점 2자리로 표시
					                }
					            }
					        }
					    },
					    plugins: [ChartDataLabels]  // datalabels 플러그인 활성화
					};
					
					chart = new Chart(document.getElementById("myChart"), config);
                    // 차트에서 현재 시간에 가장 가까운 데이터로 시작하도록 설정
                    chart.update();
					
                    createDateButtons();

                    // 오늘 날짜의 날씨 정보 표시
                    var nowday = new Date(selectedDate);
                    var days = ['일', '월', '화', '수', '목', '금', '토'];
                    var dayOfWeek = days[nowday.getDay()];
                    var tag = "<div><img src='/mini/images/weather/" + weather.list[0].weather[0].icon + ".png'/>";
                    tag +="<span>"+weather.list[0].main.temp+"<span>°C</div>";
                    tag +="<div><div class='nowdata'>강수확률:"+weather.list[0].pop+"%</div><div class='nowdata'>습도:"+weather.list[0].main.humidity+"%</div>";
                    tag +="<div>풍속:"+weather.list[0].wind.speed+"m/s</div></div>";
                    tag +="<div><div>날씨</div><div>"+dayOfWeek+"요일</div><div>"+weather.list[0].weather[0].description+"</div>"
                    $("#nowweather").html(tag);
                }
            };

            var url = "https://api.openweathermap.org/data/2.5/forecast?q=busan&appid=79908538f557fa6efd9c4f4b21907bca&lang=kr&units=metric";
            xHttp.open("GET", url, true);
            xHttp.send();
        }, 100);
    	URL2.forEach(function(url,index){
    		$.ajax({
    			url:url,
    			success:function(result){
    				let r =JSON.parse(result);
    				console.log(r.result);
    				if(r.result.data && r.result.data.length>0){
    					for(var i = 0; i<r.result.data.length;i++){
    						let temp = r.result.data[i].water_temp;
    						if(temp> waterTemp.max){
    							waterTemp.max=temp;
    						}if(temp<waterTemp.min){
    							waterTemp.min=temp;
    						}
    						water_temp.push(temp);
    					}
    				}
    				 $(wdivs[index]).html("<span id='suon'>수온</span><span id='watertemp'>"+ waterTemp.min + "~" + waterTemp.max+"°C</span>"); 
    				
    			},
    			error:function(e){
    				console.log(e);
    			}
    		});
    		
    	});
    	
    	//파고구하기
        URL.forEach(function(url,index) {
            $.ajax({
                url: url,
                success: function(result){
                    // 데이터가 유효한지 확인
                    let r = JSON.parse(result);
                    console.log(r.result);
                    console.log(r.result.data.length);
                    if (r.result.data && r.result.data.length > 0) {
                        for (var i = 0; i < r.result.data.length; i++) {
                            let height = r.result.data[i].wave_height;
                            // 최대값과 최소값 갱신
                            if (height > waterData.max) {
                                waterData.max = height;
                            }
                            if (height >0 && height < waterData.min) {
                                waterData.min = height;
                            }
    			            // 각 wave_height 값을 배열에 저장
                            wave_height.push(height);
                        }
                    } 
                    $(divs[index]).html("<span id='pago'>파고</span><span id='waterhight'>"+ waterData.min + "~" + waterData.max+"m</span>"); 
                },
                error: function(error) {
                    console.log(error);
                }
            });
        });
        
    	if(value==null||value==""){
    		console.log(value);
    		$.ajax({
    			url:"/mini/mainFestivalList/부산",
    			success:function(r){
    				  $('#autoplay').slick('unslick');
    				console.log("성공");
    				var tag="";
    				r.map(function(list,idx){
    					tag+="<div class='class2'><a href=/mini/festival/festivalView/"+list.no+"><img src='/mini/images/poster/"+list.poster+"'/><div class='postername'>"+list.title+"</div></a></div>"
    				})				
    				$("#autoplay").html(tag);
    				$(document).ready(function(){
    				         $('.autoplay').slick({
    				            centerMode: true,
    				            slidesToShow: 4,
    				            slidesToScroll: 1,
    				            autoplay: true,
    				            autoplaySpeed: 2000, 
    				            draggable:true ,
    				            infinite: true
    				         });
    				      
    				   });
    			},error:function(e){
    				console.log("실패");
    			}
    			
    		});
    		$.ajax({
    			url:"/mini/mainRestList/부산",
    			success:function(r){
    				$('#center').slick('unslick');
    				console.log("음식성공");
    				var tag="";
    				r.map(function(list,idx){
    					tag+= "<div class='class3'><a href='/mini/rest/restView/"+list.rest_code+"'><img src='/mini/images/Food/"+list.imageurl+"'/><div>"+list.store_name+"</div></a></div>";
    				})
    				$("#center").html(tag);
    				 $(document).ready(function(){
    				      $('.center').slick({
    				         centerMode: true,
    				         centerPadding: '60px',
    				         slidesToShow: 5,
    				         autoplay: true,
    				         autoplaySpeed: 2000,
    				         draggable:true ,
    				         infinite: true,
    				         responsive: [
    				         {
    				            breakpoint: 768,
    				            settings: {
    				            arrows: false,
    				            centerMode: true,
    				            centerPadding: '40px',
    				            slidesToShow: 3
    				            }
    				         },
    				         {
    				            breakpoint: 480,
    				            settings: {
    				            arrows: false,
    				            centerMode: true,
    				            centerPadding: '40px',
    				            slidesToShow: 1
    				            }
    				         }
    				      ]
    				      });
    				   });	
    			
    				
    			},
    			error:function(e){
    				console.log("error발생");
    			}
    		});
    		
    	}
    	//축제*행사 랭킹
    	$.ajax({
    		url:"/mini/festivalRank",
    		success:function(r){
    			var tag="";
    			
    			r.map(function(list,idx){
    				tag+="<div class='hitFestivalContent'> <a href=/mini/festival/festivalView/"+list.no+"><img src='/mini/images/poster/"+list.poster+"'/></div>";
    			});
    			
    			$("#hitFestivalBox").html(tag);
    			
    		},
    		error:function(e){
    			console.log("행사축제로드실패");
    		}
    		
    	});
    	//맛집 랭킹
    	$.ajax({
    		url:"/mini/restRank",
    		success:function(r){
    			var tag="<div class='hitFood'><Span>🥇</Span><a href='/mini/rest/restView/"+r[0].rest_code+"'><img src='/mini/images/Food/"+r[0].imageurl+"'/></a></div>";
    				tag+="<div class='hitFood'><Span>🥈</Span><a href='/mini/rest/restView/"+r[1].rest_code+"'><img src='/mini/images/Food/"+r[1].imageurl+"'/></a></div>";
    				tag+="<div class='hitFood'><Span>🥉</Span><a href='/mini/rest/restView/"+r[2].rest_code+"'><img src='/mini/images/Food/"+r[2].imageurl+"'/></a></div>";

    				$("#hitFoodBox").html(tag);
    		},
    		error:function(e){
    			console.log(e);
    		}
    		
    	});

    	//여기까지 로드시 실행될 파트
        
        
    };

    function createDateButtons() {
    	var nowday = new Date(selectedDate);
        var days = ['일', '월', '화', '수', '목', '금', '토'];
        var dayOfWeek = days[nowday.getDay()];
    	console.log(dayOfWeek);
        let buttonContainer = document.getElementById("buttonContainer");
        buttonContainer.innerHTML = ""; // 중복 방지
        for (let date in labels) {
            let button = document.createElement("button");
            button.innerHTML = "<div><div>"+dayOfWeek+"</div><div><img src='/mini/images/weather/"+max_min_tempData[date].icon+".png'/></div><div>"+ Math.round(max_min_tempData[date].max)+"°C/"+ Math.round(max_min_tempData[date].min)+"°C</div></div>";
            button.onclick = function () {
                updateChart(date);
                var a=max_min_tempData[date]
                updatenowweather(date,max_min_tempData)
                 // 버튼을 클릭하면 해당 날짜의 최고/최저 온도 및 날씨 확인
            };
            buttonContainer.appendChild(button);
        }
    }

    function nowweather(selectedDate,timeLabel,value,weatherlist){

        var nowday = new Date(selectedDate);
        var days = ['일', '월', '화', '수', '목', '금', '토'];
        var dayOfWeek = days[nowday.getDay()];
        var tag="<div><img src='/mini/images/weather/"+weatherlist.weather[0].icon+".png'/>";
        tag +="<span>"+value+"<span>°C</div>";
        tag +="<div><div class='nowdata'>강수확률:"+weatherlist.pop+"%</div><div class='nowdata'>습도:"+weatherlist.main.humidity+"%</div>";
        tag +="<div>풍속:"+weatherlist.wind.speed+"m/s</div></div>";
        tag +="<div><div>날씨</div><div>"+dayOfWeek+"요일</div><div>"+weatherlist.weather[0].description+"</div>"
        $("#nowweather").html(tag);
    }
    function updatenowweather(date,max_min_tempData){
    	
    	test=date+" 00:00";
		
    	console.log(weather.list.length);
    	console.log("값이 넘어와야한다",max_min_tempData[date].icon);
    	for(var i =0; i<weather.list.length;i++){
    		if(test==weather.list[i].dt_txt.substring(0,16)){
    		console.log("asdf",date);
    		var nowday = new Date(date);
    		var days=['일', '월', '화', '수', '목', '금', '토'];
    		var dayOfWeek = days[nowday.getDay()];
    		//살았다..
    		//여기는 오늘말고 다른날짜들 버튼 누를시 상단에 값나올곳
    		
    		var tag = "<div><img src='/mini/images/weather/"+max_min_tempData[date].icon+".png'/>";
    		tag +="<span>"+max_min_tempData[date].max+"<span>°C</div>";
    		tag +="<div><div class='nowdata'>강수확률:"+weather.list[i].pop+"%</div><div class='nowdata'>습도:"+weather.list[i].main.humidity+"%</div>";
    		tag +="<div>풍속:"+weather.list[i].wind.speed+"m/s</div></div>";
    		tag +="<div><div>날씨</div><div>"+dayOfWeek+"요일</div>";
    		if(max_min_tempData[date].icon=='09n'){
    			tag	+=	"<div>비</div>";
    		}else{
    			tag+="<div>"+weather.list[i].weather[0].description+"</div>";
    		}
    		
    		 $("#nowweather").html(tag);
    		console.log(weather.list[i]);
    	}else{
    		//여기는 오늘날짜 현재시간에 가장 가까운 온도나오게 하기.
    	}
    	}
    	
    }
</script>

<!-- HTML 부분 -->
<div class="container">
    <!-- 오늘의 날씨가 표시될곳 -->
    
</div>
<style>
    #nowweather{
     display: flex;
    }

</style>