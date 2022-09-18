<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitty 직원 스케줄</title>
<!-- fullcalendar -->
<!-- 
<link href='resources/fullcalendar/lib/main.css' rel='stylesheet' />
<script src='resources/fullcalendar/lib/main.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
-->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->  
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">  
<!-- jquery CDN -->  
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- fullcalendar CDN -->  
<!-- <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />  
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>   -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<!-- fullcalendar 언어 CDN -->  
<!-- <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script> -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.min.js'></script>

<style>
/* body 스타일 */
html, body{
	/* overflow: hidden; */
	font-size: 16px;
}

/* 드래그 박스 스타일 */
/* 
#external-events {
	position: fixed;
	left: 20px;
	top: 20px;
	width: 100px;
	padding: 0 10px;
	border: 1px solid #ccc;
	background: #eee;
	text-align: left;
} */

/* 
#external-events h4 {    
	font-size: 16px;    
	margin-top: 0;    
	padding-top: 1em;  
}  

#external-events .fc-event {    
	margin: 3px 0;    
	cursor: move;  
}   

#external-events p {    
	margin: 1.5em 0;    
	font-size: 11px;    
	color: #666;  
}   

#external-events p input {    
	margin: 0;    
	vertical-align: middle;  
}   

#calendar-wrap {    
	margin-left: 200px;  
}    */

#calendar {    
	max-width: 1200px;    
	margin: 0 auto;  
}
</style>

</head>
<body>

<jsp:include page="../common/header.jsp"/>

<div class="content-wrapper">
	<div class="container-xxl flex-grow-1 container-p-y" style="padding : 0px;">
    	<div class="row">
      		<div class="col-xl-12">
        		<div class="nav-align-top mb-4">
          			<div class="tab-content" style="height: 900px;">
            		<h5 class="text-muted">📅스케줄관리 - 스케줄 조회</h5>
					<br><br>
			
					<div id="wrap">
						<!-- 캘린더 태그 -->
						<div id='calendar-container'>
							<div id='calendar'></div>
						</div> 
					</div>
					
					<!--
					<script>
						(function(){
							$(function(){
								// calendar element 취득
								var calendarEl = $('#calendar')[0];

								// full-calendar 생성하기
								var calendar = new FullCalendar.Calendar(calendarEl, {
									// calendar 높이 설정
									height: '750px',
									// 화면에 맞게 높이 재설정
									expandRows: true,
									// Day 캘린더에서 시작 시간
									slotMinTime: '09:00',
									// Day 캘린더에서 종료 시간
									slotMaxTime: '22:00',
									// 헤더에 표시할 툴바
									headerToolbar: {
										left: 'prev,next today',
										center: 'title',
										right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
									},
									// 초기 로드 될때 보이는 캘린더 화면 (기본설정 : 달)
									initialView: 'dayGridMonth',
									// 날짜를 선택하면 day 캘린더나 week캘린더로 링크
									navLinks: true,
									// 수정 가능
									editable: true,
									// 달력 일자 드래그 설정 가능
									selectable: true,
									// 현재 시간 마크
									nowIndicator: true,
									// 이벤트가 오버되면 높이 제한 (+ 몇개 식으로 표현)
									dayMaxEvents: true,
									// 한국어 설정
									locale: 'ko',
									// 드래그 가능
									droppable: true,
									// 이벤트 추가되면 발생하는 이벤트
									eventAdd: function(obj){
										console.log(obj);
									},
									// 이벤트 수정되면 발생
									eventChange: function(obj){
										console.log(obj);
									},
									// 이벤트 삭제되면 발생
									eventRemove: function(obj){
										console.log(obj);
									},
									// 드래그로 이벤트 생성 
									/*
									select: function(arg){
										var title = prompt('Event Title:');
										if(title){
											calendar.addEvent({
												title: title,
												start: arg.start,
												end: arg.end,
												allDay: arg.allDay
											})
										}
										calendar.unselect()
									}
									*/
								})
								calendar.render();
							});
						})();
					</script>
					-->

					<!--  
					<script>
					const calendarEl = document.getElementById("calendar"); //캘린더를 넣어줄 html div
					
					let calendar;
					
					calendar_rendering();
					
					function calendar_rendering() {
						calendar = new FullCalendar.Calendar(calendarEl, {
						initialView: "dayGridMonth",
						});
						calendar.render();
					}
					</script>
					-->

					<script>
					$(function(){
						selectList();
					})
					
					function selectList() {

						$.ajax({
							url : "list.ca",
							success : function(list) {
								/*
								console.log(list);
								[{"bookNo":"1","bookDate":"2022-09-03","bookStime":"09:00","bookEtime":"10:00","empName":"김사장","userName":"차은우"}
								,{"bookNo":"2","bookDate":"2022-09-10","bookStime":"11:00","bookEtime":"13:00","empName":"박관리","userName":"이지은"}
								,{"bookNo":"3","bookDate":"2022-09-09","bookStime":"14:00","bookEtime":"15:00","empName":"박관리","userName":"정수정"}
								,{"bookNo":"5","bookDate":"2022-09-17","bookStime":"15:00","bookEtime":"17:00","empName":"최헬트","userName":"쯔위"}
								,{"bookNo":"4","bookDate":"2022-09-15","bookStime":"10:00","bookEtime":"11:00","empName":"박관리","userName":"쯔위"}
								,{"bookNo":"6","bookDate":"2022-09-20","bookStime":"17:00","bookEtime":"18:00","empName":"최헬트","userName":"토마스"}
								,{"bookNo":"7","bookDate":"2022-09-25","bookStime":"15:00","bookEtime":"17:00","empName":"윤단백","userName":"정재현"}
								,{"bookNo":"8","bookDate":"2022-09-27","bookStime":"17:00","bookEtime":"19:00","empName":"윤단백","userName":"김현빈"}]
								*/

								// 내가 넘겨주고자 하는 값을 리스트로 다시 담아줌
								let data = [];
								for (let i=0; i < list.length; i++) {
									let obj = {
										title : list[i].bookNo,
										start : list[i].bookDate,
										end : list[i].bookDate,
										textColor : list[i].textColor,
										backgroundColor : list[i].backgroundColor
									};
									data.push(obj);
								}
								
								// calendar element 취득
								//var calendarEl = $('#calendar')[0];
								const calendarEl = document.getElementById("calendar");
								// full-calendar 생성하기
								var calendar = new FullCalendar.Calendar(calendarEl, {
									// calendar 높이 설정
									height: '750px',
									// 화면에 맞게 높이 재설정
									expandRows: true,
									// Day 캘린더에서 시작 시간
									slotMinTime: '09:00',
									// Day 캘린더에서 종료 시간
									slotMaxTime: '22:00',
									// 헤더에 표시할 툴바
									headerToolbar: {
										left: 'prev,next today',
										center: 'title',
										right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
									},
									// 초기 로드 될때 보이는 캘린더 화면 (기본설정 : 달)
									initialView: 'dayGridMonth',
									// 날짜를 선택하면 day 캘린더나 week캘린더로 링크
									navLinks: true,
									// 수정 가능
									editable: true,
									// 달력 일자 드래그 설정 가능
									selectable: true,
									// 현재 시간 마크
									nowIndicator: true,
									// 이벤트가 오버되면 높이 제한 (+ 몇개 식으로 표현)
									dayMaxEvents: true,
									// 한국어 설정
									locale: 'ko',
									// 드래그 가능
									droppable: true,
									events : data,
									ventClick:function(arg) {
										ModalOpen(arg);
									}
								});
								calendar.render();
							},
							error : function() {
								console.log("통신 실패");
							}
						})
					}
					</script>


          			</div>
        		</div>
      		</div>
    	</div>
	</div>
</div>
</body>
</html>


