<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/mini/css/cal.css" type="text/css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <script>
        let labels = [];
        let datas = [];

        // 날씨 관련된 변수
        var weathertoday = new Date();
        var weatheryear = weathertoday.getFullYear();
        var weathermonth = weathertoday.getMonth() + 1;
        var weatherday = weathertoday.getDate();
        let weatherclosestTime = null;
        let weatherclosestDifference = Infinity;
        var weathernowdate = weatheryear + "-";
        if (weathermonth < 10) {
            weathermonth = "0" + weathermonth;
        }
        if (weatherday < 10) {
            weatherday = "0" + weatherday;
        }
        weathernowdate = weathernowdate + weathermonth + "-" + weatherday;
        const weathernowtime = Math.floor((Date.now() + 9 * 60 * 60 * 1000) / 1000);
        let max_temp = -100;
        let min_temp = 100;


        // 달력 관련된 변수
        var now = new Date();  // 기본적으로 현재 날짜로 설정
        var year;
        var month;
        var rnow = new Date();
        var nowd = rnow.getDate();
        var nowm = rnow.getMonth() + 1;
        var nowy = rnow.getFullYear();
        console.log(nowd, nowm, nowy);

        document.addEventListener('DOMContentLoaded', function() {
            loadWeatherData(); // 날씨 데이터를 먼저 로드
        });

        function loadWeatherData() {
            setTimeout(function() {
                var xHttp = new XMLHttpRequest();

                xHttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        let result = JSON.parse(this.responseText);
                       
                        labels = [];
                        datas = [];
                        let tempData = {}; // 날짜별로 temp_max, temp_min, icon을 저장
                        for (let i = 0; i < result.list.length; i++) {
                            let date = result.list[i].dt_txt.substring(0, 10); // "YYYY-MM-DD" 형식으로 날짜 추출
                            let weatherIcon = result.list[i].weather[0].icon;
						
                            if (!tempData[date]) {
                                tempData[date] = { 
                                    max: -Infinity, 
                                    min: Infinity, 
                                    icon: weatherIcon, 
                                    hasRain: false 
                                };
                            }

                            if (result.list[i].main.temp_max > tempData[date].max) {
                                tempData[date].max = result.list[i].main.temp_max;
                            }
                            if (result.list[i].main.temp_min < tempData[date].min) {
                                tempData[date].min = result.list[i].main.temp_min;
                            }

                            if (weatherIcon.startsWith("09") || weatherIcon.startsWith("10")) {
                                tempData[date].hasRain = true;
                            }

                            // 비오는 날씨가 한번이라도 나타나면 아이콘을 비오는 이미지로 설정
                            if (tempData[date].hasRain) {
                                tempData[date].icon = "09n"; // "rain.png"로 비오는 이미지 설정
                            }
                        }

                        // 데이터를 labels와 datas 배열에 저장
                        for (let date in tempData) {
                            datas.push(tempData[date].icon);
                            labels.push("최고"+Math.round(tempData[date].max) + "°C <br/>최저" + Math.round(tempData[date].min)  + "°C");
                        }

                        
                        setDayView(); // 날씨 데이터 로드 후 달력 초기화
                    }
                };
                var url = "https://api.openweathermap.org/data/2.5/forecast?lat=35.1796&lon=129.0756&appid=79908538f557fa6efd9c4f4b21907bca&lang=kr&units=metric";
                xHttp.open("GET", url, true);
                xHttp.send();
            }, 100);
        }

        function setDayView() {
            year = now.getFullYear();
            month = now.getMonth() + 1;  // getMonth()는 0부터 시작하므로 1을 더해줌

            document.getElementById('yn').innerHTML = 
                year + "년 " + month + "월" + 
                "<div><button onclick='prevMonth()'><img src='/mini/images/weather/leftbutton.png'></button>" + 
                "<button onclick='nextMonth()'><img src='/mini/images/weather/rightbutton.png'/></button>" + 
                "<button onclick='goNow()'><img src='/mini/images/weather/resetbutton.png'/></button></div>";

            var firstDayOfMonth = new Date(year, month - 1, 1);
            var week = firstDayOfMonth.getDay();

            var lastDayOfMonth = new Date(year, month, 0).getDate();

            var dayStr = "";
            var weekName = ['일', '월', '화', '수', '목', '금', '토'];
            for (var i = 0; i < weekName.length; i++) {
                dayStr += "<li class='weekName'>" + weekName[i] + "</li>";
            }

            for (var s = 0; s < week; s++) {
                dayStr += "<li class='dayn'>&nbsp;</li>";
            }

            for (var d = 1; d <= lastDayOfMonth; d++) {
                if (nowd == d && month == nowm && year == nowy) {
                    // 오늘 날짜
                    dayStr += "<li class='nowday'><button onclick='test(" + year + "," + month + "," + d +","+datas[0].substring(0,2)+ ")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div><div class='colorday'>"+labels[0]+"</div><div><img src='/mini/images/weather/"+datas[0]+".png'/></div></button></li>";
                
                } else if (d > nowd && d <= nowd + 5 && month == nowm && year == nowy) {
                    // 오늘 이후 5일까지
                    var Index = d - nowd;  // labels 배열에서 오늘 이후의 날짜에 맞는 인덱스 계산
                    if (Index < labels.length) {  // 인덱스가 배열 범위를 초과하지 않도록 확인
                        dayStr += "<li class='dayn'><button onclick='test(" + year + "," + month + "," + d + ","+datas[Index].substring(0,2)+")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div><div class='colorday'>"+labels[Index]+"</div><div><img src='/mini/images/weather/"+datas[Index]+".png'/></div></div></button></li>";
                    } else {
                        dayStr += "<li class='dayn'><button onclick='test(" + year + "," + month + "," + d + ")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div></button></li>";
                    }

                } else if (d <= (nowd + 5 - lastDayOfMonth) && month == nowm + 1 && month <= 12) {
                    // 달이 다음 달로 넘어가는 경우
                    var Index = lastDayOfMonth - nowd + d;  // labels 배열에서 다음 달 날짜에 맞는 인덱스 계산
                    if (Index < labels.length) {  // 인덱스가 배열 범위를 초과하지 않도록 확인
                        dayStr += "<li class='dayn'><button onclick='test(" + year + "," + (month) + "," + d + ","+datas[Index].substring(0,2)+")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div><div class='colorday'>"+labels[Index]+"</div><div><img src='/mini/images/weather/"+datas[Index]+".png'/></div></button></li>";
                    } else {
                        dayStr += "<li class='dayn'><button onclick='test(" + year + "," + (month) + "," + d + ")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div></button></li>";
                    }

                } else {
                    // 그 외의 날짜
                    dayStr += "<li class='dayn'><button onclick='test(" + year + "," + month + "," + d + ")'><div class='daynum' id=" + year + "-" + month + "-" + d +">" + d + "</div></button></li>";
                }
            }         
            console.log(labels);
            console.log(datas);
            document.getElementById("day").innerHTML = dayStr;
        }
        let previousSelectedDay = null; 
        function test(y, m, dnum,dataindex) {
        	let selectedDay2 = document.getElementById(y + "-" + m + "-" + dnum);  // 선택한 날짜의 요소 가져오기
        	let selectedDay = selectedDay2.parentNode;  // 선택한 날짜의 부모 요소 가져오기
			let bselctday=selectedDay.parentNode;
        

        	if (previousSelectedDay !== null) {
        	    previousSelectedDay.style.color = '';  
        	    previousSelectedDay.style.backgroundColor = ''; 
        	    previousSelectedDay.style.border='';
        	    previousSelectedDay.style.borderRadius='';
        	}

        	selectedDay.style.setProperty('color', '#1E90FF', 'important');
        	selectedDay.style.backgroundColor = '#F0F8FF'; 
        	selectedDay.style.border='1px solid #1E90FF';
        	selectedDay.style.borderRadius='10px';
        	
        	previousSelectedDay = selectedDay;

            if (m < 10) {m = "0" + m;}
            if (dnum < 10){ dnum = "0" + dnum;}
            if(dataindex<10){dataindex="0"+dataindex;}
         
    
         
            if(dataindex!=null && dataindex!=0){
            	if (dataindex=="01" || dataindex=="02" || dataindex=="03"){
            		console.log("out일때 나오는 창");
	            	var date= y + "-" + m + "-" + dnum;
	            	var environment="out";
	            	
	            	$.ajax({
	            		
	            		url:"/mini/calendar/listView/"+date+"/"+environment,
	            	
            		
						success:function(r){
						var tag = "<div class='container'>";
            			r.map(function (data,idx){
            				tag+="<div class='list'>";
            				tag+="<a href='/mini/festival/festivalView/"+data.no+"'>";
            				tag+="<img class='list_img' src='/mini/images/poster/"+data.poster+"'/>";
            				tag+="<div class='list_detail'>";
            				tag+="<h3 class='detail'>"+data.title+"</h3>"
            				tag+="<p class='detail'>"+data.start_date+"~"+data.end_date+"</p>";
            				tag+="<p class='detail'>"+data.addrdetails+"</p>";
            				tag+="</div></a></div>";

            			}); 
            			tag +="</div>";
            			
            			$("#listView").html(tag);
            	
            		},error:function(e){
            			console.log(e.responseText);
            		}
            		
            		
            	});
	            	
            	}else{
            		console.log("in일때 나오는 창");
            		var date= y + "-" + m + "-" + dnum;
	            	var environment="in";
	            	var tag = "<div class='container'>";
	            	$.ajax({
	            		url:"/mini/calendar/listView/"+date+"/"+environment,
	            	
            		
						success:function(r){
            			r.map(function (data,idx){
            				tag+="<div class='list'>";
            				tag+="<a href='/mini/festival/festivalView/"+data.no+"'>";
            				tag+="<img class='list_img' src='/mini/images/poster/"+data.poster+"'/>";
            				tag+="<div class='list_detail'>";
            				tag+="<h3 class='detail'>"+data.title+"</h3>"
            				tag+="<p class='detail'>"+data.start_date+"~"+data.end_date+"</p>";
            				tag+="<p class='detail'>"+data.addrdetails+"</p>";
            				tag+="</div></a></div>";

            			});
            			tag +="</div>";
            			
            			$("#listView").html(tag);
            	
            		},error:function(e){
            			console.log(e.responseText);
            		}
            		
            		
            	});
	            	
            	}
            }else{
            
            	var date= y + "-" + m + "-" + dnum;
            	var tag = "<div class='container'>";
            	$.ajax({
            		url:"/mini/calendar/listView/"+date,
            		success:function(r){	
            			r.map(function (data,idx){
            				tag+="<div class='list'>";
            				tag+="<a href='/mini/festival/festivalView/"+data.no+"'>";
            				tag+="<img class='list_img' src='/mini/images/poster/"+data.poster+"'/>";
            				tag+="<div class='list_detail'>";
            				tag+="<h3 class='detail'>"+data.title+"</h3>"
            				tag+="<p class='detail'>"+data.start_date+"~"+data.end_date+"</p>";
            				tag+="<p class='detail'>"+data.addrdetails+"</p>";
            				tag+="</div></a></div>";

            			});
            			tag +="</div>";
            			
            			$("#listView").html(tag);
            	
            		},error:function(e){
            			console.log(e.responseText);
            		}
            		
            		
            	});

            }
        }

        function nextMonth() {
            now.setMonth(now.getMonth() + 1); // 월을 1 증가시킴
            setDayView(); // 새로운 월에 대해 달력을 다시 그림
        }

        function prevMonth() {
            now.setMonth(now.getMonth() - 1); // 월을 1 감소시킴
            setDayView(); // 새로운 월에 대해 달력을 다시 그림
        }

        function goNow() {
            now = new Date(nowy, nowm - 1, nowd);
            setDayView();
        }
        
       
    </script>
</head>
<!-- 상단이미지 -->
<div id="imgBox1">
   <img src="/mini/images/cal/달력2.jpg" id="imgContent1" />
</div>
<div id="calendar">
    <div id="dateView">
        <div id="pagename"><h3>월별축제달력</h3></div>
        <div id="yn"></div>
        <div id="calView">
            <div id='days'>
                <ul id="day">
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
  
</div>
<div id="listView">
  
 </div>
