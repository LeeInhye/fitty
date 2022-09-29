/**
 * 
 */
 
 //selectInAttendance를 setInterval로 호출하면 됨 ajax로..
 
 $(function(){
 	console.log("달러펑션" + $("#loginUserDiv input[id=loginUserEmp]").val());
	
	showCalendar($("#loginUserDiv input[id=loginUserEmp]").val());
 	
 	if($("#loginUserAttin").val() === 0 || $("#loginUserAttin").val() === "0"){
 		 $("#intervalTime").html("<span style='font-size : 20px;' class='badge rounded-pill bg-label-primary'>출근전</span>");
 	} else if ($("#loginUserAttOut").val() === 0 || $("#loginUserAttOut").val() === "0"){
 		let interval = setInterval(getWorkTimeOneSec, 1000);
 	} else {
 		getLastWorkTime();
 	}
 	
 	
 	
	
 	
 })
 
 function showCalendar(empNo){
 
 console.log(empNo);
 $.ajax({
		url: "myMonthAttlist.att",
		data : {
			empNo :empNo
		},
		success: function(list){
			console.log(list);
			
			// 넘겨주고자 하는 값 리스트로 담아줌
			let data = [];
			for(let i=0; i<list.length; i++){
				let attIn = {
					color : "white",
					textColor : "grey",
				    id : list[i].attIn,
					fontSize : 12,
					title : "출근 : " + list[i].attIn,
					start : list[i].attDate, 
					end : list[i].attDate
				};
				let attOut = {
					color : "white",
					textColor : "grey",
				    id : list[i].attOut,
					fontSize : 12,
					title : "퇴근 : " + list[i].attOut,
					start : list[i].attDate, 
					end : list[i].attDate
				};
				let attStatus = {
					color : "#E7E7E7",
					textColor : "white",
				    id : list[i].attStatus,
					fontSize : 12,
					title : list[i].attStatus,
					start : list[i].attDate, 
					end : list[i].attDate
				};
				

				if(attStatus.title === "주말") {
					attStatus = {
						color : "white",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}
				} else if(attStatus.title == "결근"){
					attStatus = {
						color : "#E74C3C",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}
				} else if(attStatus.title == "지각"){
					attStatus = {
						color : "#F1C40F",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}
				} else if(attStatus.title === "조퇴"){
					attStatus = {
						color : "#BF5BC7",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
				}
		  	   } else if(attStatus.title === "오전반차" || attStatus.title === "오후반차" || attStatus.title === "연월차"){
					attStatus = {
						color : "green",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
			  }
			   } else if(attStatus.title === "휴가"){
					attStatus = {
						color : "#29CCF9",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}
				} else if(attStatus.title === "정상출근"){
					attStatus = {
						color : "#DCDADA",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}
				} else {
					attStatus = {
						color : "#686BFF",
						textColor : "white",
						id : list[i].attStatus,
						fontSize : 12,
						title : list[i].attStatus,
						start : list[i].attDate, 
						end : list[i].attDate
					}

					
				}

				data.push(attIn);
				data.push(attOut);
				data.push(attStatus);
			
			}
			

			// -------------------- 캘린더 렌더링 --------------------
			   var initialLocaleCode = 'ko';
			   var calendarEl = document.getElementById('calendar');
			   var calendar = new FullCalendar.Calendar(calendarEl, {
				  // calendar 높이 설정
				  height: '650px',
				  // 화면에 맞게 높이 재설정
				  expandRows: true,
				  // 초기 로드 될때 보이는 캘린더 화면 (기본설정 : 달)
				  initialView : 'dayGridMonth',
				  // 한국어 설정
				  locale : 'ko', 
				  // 시간 설정
				  timeZone : 'UTC',
				  // 헤더에 표시할 툴바
				  headerToolbar: {
					  left: 'prev,next today',
					  center: 'title',
					  right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
				  },
				  // Day 캘린더에서 시작 시간
				  slotMinTime: '09:00',
				  // Day 캘린더에서 종료 시간
				  slotMaxTime: '23:00',
				  // 날짜를 선택하면 day 캘린더나 week캘린더로 링크
				  navLinks: true,
				  // 현재 시간 마크
				  nowIndicator: true,
				  // 이벤트가 오버되면 높이 제한 (+ 몇개 식으로 표현)
			      dayMaxEvents: true,
			      // DB 이벤트로 추가
				  events : data,
				  // 이벤트에 시간 표시
				  displayEventTime: false
			   });
			   calendar.render();
		   // ------------------------------------------------------------
		},
		error: function(){
			alertify.alert("❌ 스케줄 조회에 실패했습니다 ❌\n다시 시도해주세요".set('basic', true));
			console.log("ajax 통신 실패");
		}
	})
 }
 
 function getWorkTimeOneSec(){
 	
 	let loginUserEmp = $("#loginUserEmp").val();
 
 
    $.ajax({
        url: "getWorkTimeOneSec.att",
		data:{
		    empNo : loginUserEmp
		},
        type:"post",
        success:function(att){
        
	            $("#hour").html(att.gapHour);
	            $("#minute").html(att.gapMinute);
	            $("#second").html(att.gapSecond);

        },
        error:function(){
            console.log("관리자 예약내역리스트 조회용 ajax통신 실패"); 
        }
    })

}

function getLastWorkTime(){
	let loginUserEmp = $("#loginUserEmp").val();
 
 
    $.ajax({
        url: "getLastWorkTime.att",
		data:{
		    empNo : loginUserEmp
		},
        type:"post",
        success:function(att){
          		
			  $("#hour").html(att.gapHour);
	            $("#minute").html(att.gapMinute);
	            $("#second").html(att.gapSecond);
			
        },
        error:function(){
            console.log("관리자 예약내역리스트 조회용 ajax통신 실패"); 
        }
    })

}