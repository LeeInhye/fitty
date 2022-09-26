<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	 #helloMan, #about-time {
	     color:rgb(50, 50, 50);
	     font-size: 11px;
	     margin : 5px;
	 }
	
	 #navbar-collapse {
	     margin : 0px;
	 }
	
	 #init-btn, #out-btn {
	     margin : 5px;
	 }
	
	 .bx-envelope, .bx-message-rounded-dots, .bx-bell {
	     font-size:25px;
	     color: #696CFF;
	     margin : 2px;
	 }
	
	 .big-menu-label{
	     color:rgb(50, 50, 50);
	     font-size: 14px;
	 }
	
	 .small-menu-label{
	     font-size: 12px;
	 }
	
	
#calendar{
	width: 100%; height:100%;
  }

  .div:hover{
    background-color:#696cff0c;
  }

  .mm{
    font-size: 20px; font-weight: bolder; text-align: center; margin-bottom:10px
  }

  table{
    width: 90%; height:90%; margin:auto; margin-radius:5px;
  }

  tr{
  	height:15%
  }

  td{
    padding: 3px 3px; text-align: right; vertical-align: sub; 
    min-width: 105px;
    max-width: 105px;
    width: 105px; 
  }

  .div{
    width:100%; height:100%; border:1px solid lightGray; border-radius:5px
  }

  .div>span{
    display: block; padding: 10px 10px;
    height: 30%;
  }

  .day{
    height: 70%;
    text-align: center;
  }
  
  .calMove{
  	height:5%
  }
  
  .cal{
  	height:90%
  }	
  
  .arrow:hover{color:purple; cursor:pointer};
	
</style>
</head>
<body>

<jsp:include page="../common/header.jsp" />


<!-- 내용 감싸는 전체 wrap -->
<div class="content-wrapper">
<div class="container-xxl flex-grow-1 container-p-y" style="padding:0px; margin-top:-45px">
<div class="row">
<div class="col-xl-12">
<div class="nav-align-top mb-4"><br>
	
<div class="row">
	
	<%-- 
	<c:set var="date" value="<%=new java.util.Date()%>" />
	<fmt:formatDate var="exDate" value="${date}" pattern="yy/MM/dd" />
	 --%>
	 
	 <!-- 1. 회원카드 -->
	<div class="col-md-2 col-12 mb-md-0 mb-4">
	<div class="card" align="center" style="min-height:758px">
		<div class="card-header">
			<div style='font-size:17px; font-weight:600; background:lavender'>회원정보</div><br>
			<img src="resources/upload_profileImg/22092315545910883.jpg" class="w-px-50 h-auto rounded-circle" style='width:100px !important'><br>
			<label>${c.userName }</label> (<label id="age"></label> / <label>${c.userGender }</label>) <br>
			<label id="phone" style='font-size:15px'></label><br>
			<label style='font-size:15px'>160 cm</label>
			<label style='font-size:15px'>45 kg</label><br><br>
			<label style='font-size:15px; font-weight:600'>예약일 : 2022-09-26</label><br>
			<button type="button" class="btn btn-primary">출석</button>
			<button type="button" class="btn btn-secondary">결석</button>
			
		</div>
		
        <div class="card-body">
        	<div style='font-size:17px; font-weight:600; background:lavender'>수업정보 및 목표</div><br>
        	<label>남은회차 : 27/30</label><br><br>
        	<label>수업시작일 : 2022-09-01</label><br><br>
        	<label style='font-size:15px; font-weight:600'>수업목표 : ${c.classGoal }</label><br>
        	<label style='font-size:15px; font-weight:600'>기대결과 :  ${c.classResult}</label><br><br>
        	<div class="progress" style='height:30px'>
	          <div class="progress-bar bg-info" role="progressbar" style="width: 87%;" aria-valuenow="87" aria-valuemin="0" aria-valuemax="100">87%</div>
	        </div>
        </div>
	</div>
	</div>
	
	
	
	
	<script>
	
		//생년월일로 만나이 계산
		let birth = "${c.userBirth}";

		let year = birth.substr(0, 2);
		let y = Number("19" + year);
		let m = Number(birth.substr(2, 2));
		let d = Number(birth.substr(4, 2));
		
		let tod = new Date();
		let birthDate = new Date(y, m-1, d); // 2000년 8월 10일 
		console.log(birthDate);
		
	
		let age = tod.getFullYear() - birthDate.getFullYear();
		const mon = tod.getMonth() - birthDate.getMonth();
		if (mon < 0 || (mon === 0 && tod.getDate() < birthDate.getDate())) {
		    age--;
		}
		
		$("#age").text(age);
		
		//
		let phone = "${c.userPhone}";
		let a = phone.substr(0, 3);
		let b = phone.substr(4, 4);
		let c = phone.substr(5, 4);
		
		let userPhone = a + " - " + b + " - " + c;
		
		$("#phone").text(userPhone);
	</script>
	
	
	 
	
	<!-- 2. 내용카드 -->
	<div class="col-md-10">
	<div class="nav-align-top mb-4">
	
        <!-- 내용 넣을 부분 (* 수정해도 되는 부분)-->
		<div class="tab-content" style="height: 758px;">
	
		<div style='margin:auto; width:100%; height:100%;'>
	        	<div id='calendar' style='height:100%'></div>
		</div>
		
		
		
		<script>
		var today = new Date();
		
		var yy = "";
		var mm = "";
		var dd = "";
		
		$(function(){
			
			calrendarMaker();
		
            $(document).on("click", ".pre", function() { // 이전달
                today = new Date ( today.getFullYear(), today.getMonth()-1, today.getDate());
                dd = today.getDate(); //오늘의 일
                mm = today.getMonth()+1;  //오늘에 해당하는 월
    			yy = today.getFullYear().toString().substring(2); //오늘에 해당하는 년
           		calrendarMaker();
            })
		
            $(document).on("click", ".next", function() { // 다음달
                today = new Date ( today.getFullYear(), today.getMonth()+1, today.getDate());
                dd = today.getDate(); //오늘의 일
                mm = today.getMonth()+1;  //오늘에 해당하는 월
    			yy = today.getFullYear().toString().substring(2); //오늘에 해당하는 년
           		calrendarMaker();
            })
            
            
            //var ttt = new Date(); //지정된 형식대로 만든 오늘날짜
            
			dd = today.getDate(); //오늘의 일
			mm = today.getMonth()+1;  //오늘에 해당하는 월
			yy = today.getFullYear().toString().substring(2); //오늘에 해당하는 년

			if(dd<10){
			    dd='0'+dd
			}
			if(mm<10){
			    mm='0'+mm
			}
			var ttt = yy + "/" + mm + "/" + dd;
            
		})
            
		
		function calrendarMaker(){
			
			// 식단리스트를 조회하는 ajax
			$.ajax({
				url : "select.cl",
				data : {classNo: ${classNo}},
				success:function(data){ // 
					
				
				var d = data.d; //diet리스트
				var e = data.e; //exercise리스트
				
				var all = data.all; //각 일자별 전체 운동 갯수
				var com = data.com; //각 일자별 운동완료한 갯수
				
				console.log(d);
				console.log(e);
				console.log(all);
				console.log(com);
				
				
				var now = new Date();	// 현재 날짜 및 시간
				var mn = now.getMonth()+1;
				
					// 달력 연도
		            var calendarYear = today.getFullYear();
		            // 달력 월
		            var calendarMonth = today.getMonth() + 1;
		            // 달력 일
		            var calendarToday = today.getDate();
		            
		            // 달력 월의 마지막 일
		            var monthLastDate = new Date(calendarYear, calendarMonth, 0);
		            var calendarMonthLastDate = monthLastDate.getDate();
		            
		            // 달력 월의 시작 요일
		            var monthStartDay = new Date(calendarYear, today.getMonth(), 1);
		            var calendarMonthStartDay = monthStartDay.getDay();
		            
		            // 주 카운트
		            var calendarWeekCount = Math.ceil((calendarMonthStartDay + calendarMonthLastDate) / 7);
		            
		            var html = "";
		                html += "<div align='center' class='calMove'>";
		                
		                
		                html += "<button type='button' class='pre' style='border:none; background:none;'><i class='bx bxs-left-arrow arrow' style='color:lavender'></i></button>";
		                html += " &nbsp;&nbsp;&nbsp;<label class='mm'>" + calendarMonth + "월</label> &nbsp;&nbsp;&nbsp;";
		                html += "<button type='button' class='next' style='border:none; background:none;'><i class='bx bxs-right-arrow arrow' style='color:lavender'></i></button>";

		                html += "</div><br>";
		                
		                html += "<table class='calrendar'>";
		                html += "<thead>";
		                html += "<tr align='center'>";
		                html += "<th style='color:red'>SUN</th><th>MON</th><th>THU</th><th>WEN</th><th>THU</th><th>FRI</th><th>SAT</th>";
		                html += "</tr>";
		                html += "</thead>";
		                html += "<tbody>";
		                
		                // 위치
		                var calendarPos = 0;
		                // 날짜
		                var calendarDay = 0;
		                
		                for (var index1 = 0; index1 < calendarWeekCount; index1++) {
		                  html += "<tr>";
		                  for (var index2 = 0; index2 < 7; index2++) {
		                    html += "<td>";
		                    if (calendarMonthStartDay <= calendarPos && calendarDay < calendarMonthLastDate) {
		                    	calendarDay++;
		                      
		                      	if(calendarDay == calendarToday && calendarMonth == mn){
		                      		html += "<div class='div' style='width: 99%; height: 103%; border: 5px solid #9a9cf76e;'>"
		                      			  + "<span>" + calendarDay + "</span>";
		                      	}else{
			                      	html += "<div class='div'><span>" + calendarDay + "</span>";
		                      	}
		                      	
		                      	html += "<div class='day'><div class='diet' style='background:#fcffceab;'>";
		                      	
		                      		//조회해온 리스트의 각 날짜와 div 안의 날짜가 같을 경우 반복문을 돌려 뿌려지도록
			                      	for(let i in d){
			                      		if( (yy + "/" + mm + "/" + calendarDay) == d[i].dietDate ){
 			                      	/* html += "식단 "; */
			                      			if(d[i].bfImage != null){
			                      				html += "🍋";
			                      			}				                      			
			                      			if(d[i].lcImage != null){
			                      				html += "🍑";
			                      			}
			                      			if(d[i].dnImage != null){
			                      				html += "🍏";
			                      			}
			                      			if(d[i].reImage != null){
			                      				html += "🍇";
			                      			}
			                      			/* html += "<div style='background:purple; border-radius:70%; width:15px; height:15px; margin:auto; float:left'></div>" */
			                      		}
			                      	}
		                        html += "</div><div class='exercise' style='background:#c75ef621'>";
		                      		
		                      		//각 일자별 진행률 보여주기
	                      			//완료
		                      		for(let i in com){ 
		                      			if( (yy + "/" + mm + "/" + calendarDay) == com[i].exDate ){
		                      				html += "운동 <label style='font-weight:500'>" + com[i].exSet + "</label> / ";
		                      			}
		                      		}
	                      			//전체
		                      		for(let i in all){ 
		                      			if( (yy + "/" + mm + "/" + calendarDay) == all[i].exDate ){
		                      				html += "<label style='font-weight:500'>" + all[i].exCount + "</label>";
		                      			}
		                      		}
		                      	html += "</div>";
		                      	
		                       	html += "</div>"
		                              + "</div></div>";
		                              
		                    }
		                    
		                    html += "</td>";
		                    calendarPos++;
		                  }
		                  html += "</tr>";
		                }
		                html += "</tbody>";
		                html += "</table></div>";
		                console.log(html);
		                
		                $("#calendar").html(html);
		                
		                
		                $(".div").click(function(){
		        			
		                    let dd = $(this).children().eq(0).text(); //클릭한 div의 "일"
		                    
		                    if(dd>0 && dd<10){ // "일"을 두글자로 표현
		                      dd = "0" + dd;
		                    }

		                    let month = $(".mm").text().replace("월", ""); //달력내의 "월"을 두글자로 표현
		                    let mm = "";
		                    if(month>0 && month<10){
		                      mm = "0" + month;
		                    }

		                    let yy = calendarYear.toString(); //달력내의 "년"을 두글자로 표현
		                    yy =yy.substring(2);

		                    
		                    let clDate = yy + "/" + mm + "/" + dd; //클릭한 div의 지정형식 날짜 (DB에서 비교 가능한 값)
		                    
		                    
		                    
		                    let t = new Date(); //현재 날짜(년월일)
		                    let clickDate = new Date(calendarYear, month-1, dd); //클릭한 div의 시스템 날짜
		                    
		                    
		                    
		                    
		                    if(clickDate < t){ //오늘 이후의 날짜는 클릭되지 않도록
		                       	location.href = 'exercise.cl?classNo=${classNo}&exDate=' + clDate;
		                    }else{
		                  	  alert("선택 불가능한 날짜입니다.");
		                    }
		                    
		              	}) 
		                
				},
				error:function(){
					console.log("달력 조회용 ajax 통신 실패");
				}
			})
                
		}
		
		
		
        </script>
		
		
		
		
		
	
		
	              
		</div>
		<!-- / 내용 넣을 부분 -->
	
    </div>
    </div>

	    
</div>
	
</div>
</div>
</div>
</div>
</div>
<!-- /내용 감싸는 전체 wrap -->

	

</body>
</html>