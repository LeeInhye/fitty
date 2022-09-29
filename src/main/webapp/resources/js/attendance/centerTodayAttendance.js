$(function(){

	selectTodayAttList(1);

	$("#nextBtn").attr("disabled", true);
	$("#rightArrow").css("color", "#DCDADA");
	
	let month = Number($("#thisMonth").val());
    let year = Number($("#thisYear").val());
    let day = Number($("#thisDay").val());

    $(document).ready(function(){
    	$("#nextBtn").on("click",function() {

			if ( (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) && (month == 2) && (day < 29) ) {
				// 윤년이고 2월 평일이라면
				day = day + 1
				$("#thisDay").val(day);	
			} else if ( (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) && (month == 2) && (day == 29) ) {
				day = 1;
				month = month + 1;
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
			} else if ( (month == 2) && (day < 28) ) {
				day = day + 1
				$("#thisDay").val(day);	
			} else if ( (month == 2) && (day == 28) ) {
				day = 1;
				month = month + 1;
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
			} else if( ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) && day < 31)
				|| ( (month == 4 || month == 6 || month == 9 || month == 11 ) && day < 30 ) ){
				day = day + 1
				$("#thisDay").val(day);	
			} else if ( ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) && day == 31)
				|| ((month == 4 || month == 6 || month == 9 || month == 11 ) && day == 30) ) {
				day = 1;
				if(month < 12) {
					month = month + 1;
				} else {
					month = 1;
	    			year = year + 1;
				}
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
	    		$("#thisYear").val(year);
	    		}
	    		
	    		nowCheck();
    		})
	})
    		
    $(document).ready(function(){
    	$("#backBtn").on("click",function() {
    		
    		if ( (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) && (month == 3) && (day > 1) ) {
				// 윤년이고 2월 평일이라면
				day = day - 1
				$("#thisDay").val(day);	
			} else if ( (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) && (month == 3) && (day == 1) ) {
				day = 29;
				month = month - 1;
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
			} else if ( (month == 3) && (day > 1) ) {
				day = day - 1 
				$("#thisDay").val(day);	
			} else if ( (month == 3) && (day == 1) ) {
				day = 28;
				month = month - 1;
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
			} else if( ((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) && day > 1)
				|| ( (month == 2 ||  month == 4 || month == 6 || month == 9 || month == 11 ) && day > 1 ) ){
				day = day - 1
				$("#thisDay").val(day);	
			} else if ( (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) && day == 1) {
				day = 30;
				if(month > 1) {
					month = month - 1;
				} else {
					month = 12;
	    			year = year - 1;
				}
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
	    		$("#thisYear").val(year);
	    	} else if ( (month == 2 || month == 4 || month == 6 || month == 9 || month == 11 ) && day == 1) {
				day = 31;
				month = month - 1;
				$("#thisDay").val(day);	
				$("#thisMonth").val(month);
			}
	    		
	    		nowCheck();
    })

	$(document).ready(function(){
		$("#orderByGrade").on("change",function(){
			nowCheck();
		})
	})
	
	$(document).ready(function(){
		$("#orderByStatus").on("change",function(){
			nowCheck();
		})
	})
	
	

	$(document).ready(function(){
		$("#searchBtn").on("click",function(){
			let searchText = $('#searchText').val()
			nowSearch(1, searchText );	
		})
	})

})
    
    
})

function nowCheck(){

	let month = Number($("#thisMonth").val());
    let year = Number($("#thisYear").val());
    let day = Number($("#thisDay").val());
    
    let today = new Date();
	
	let nowYear = today.getFullYear();
	let nowMonth = today.getMonth()+1;
	let nowDate = today.getDate();
	
	
    if(year == nowYear && month == nowMonth && nowDate == day) {
    // 같은년월
        $("#nextBtn").attr("disabled", true);
        $("#rightArrow").css("color", "#DCDADA");
        selectTodayAttList(1);
    } else {
    // 다른년월
    	$("#rightArrow").css("color", "#696CFF");
    	$("#nextBtn").attr("disabled", false);
        selectTodayAttList(1);
    }
    
   
    
}

function selectTodayAttList(page){

   
		
		$.ajax({
			url: "todayAttList.att",
			data:{
				addSqlGrade : $("#orderByGrade").val(),
				addSqlStatus : $("#orderByStatus").val(),
				sqlEmpName :$("#searchText").val(),
				searchFlag : 'N',
				thisYear : $("#thisYear").val(),
				thisMonth : $("#thisMonth").val(),
				thisDay : $("#thisDay").val(),
				cpage:page
			},
			type:"post",
			success:function(result){
			
				let value = "";
				let pageValue = "";
				
				let aList = result.aList;
				let pi = result.pi;
			

				if(pi.listCount === "0") {
					value += "<tr>"
						+ "<td colspan='7'> 직원이 없습니다. </td>"
							+ "</tr>";
				} else {
					for(let i=0; i<aList.length; i++){
						
						value += "<tr>"
								+  	 "<td>" +  aList[i].empNo + "</td>"
								+  	 "<td>" +  aList[i].empName + "</td>"
								+  	 "<td>" +  aList[i].grName + "</td>"
								+  	 "<td>" +  aList[i].attDate + "</td>"
								+  	 "<td>" +  aList[i].attIn + "</td>"
								+  	 "<td>" +  aList[i].attOut + "</td>"
								if(aList[i].attStatus === "정상출근") {
						value += 			"<td><span class='badge rounded-pill bg-label-secondary'>" + aList[i].attStatus + "</td></span>"
								} else if (aList[i].attStatus === "지각") {
						value += 			"<td><span class='badge rounded-pill bg-label-warning'>　" + aList[i].attStatus + "　</td></span>"
								} else if (aList[i].attStatus === "결근") {
						value += 			"<td><span class='badge rounded-pill bg-label-danger'>　" + aList[i].attStatus + "　</td></span>"
								} else if (aList[i].attStatus === "조퇴") {
						value += 			"<td><span class='badge rounded-pill bg-label-warning'>　" + aList[i].attStatus + "　</td></span>"
								} else if (aList[i].attStatus === "오전반차" || aList[i].attStatus === "오후반차") {
						value += 			"<td><span class='badge rounded-pill bg-label-success'>" + aList[i].attStatus + "</td></span>"
								} else if (aList[i].attStatus === "휴가") {
						value += 			"<td><span class='badge rounded-pill bg-label-success'>　" + aList[i].attStatus + "　</td></span>"
								} else if (aList[i].attStatus === "연월차") {
						value += 			"<td><span class='badge rounded-pill bg-label-success'>" + aList[i].attStatus + "</td></span>"
								} else {
						value += 			"<td><span class='badge rounded-pill bg-label-primary'>　" + aList[i].attStatus + "　</td></span>"
								}
						value +=  	 "<td>" +  aList[i].attPlusWork + "</td>"
								+ "</tr>";
					}

					
					if(pi.currentPage == 1){
						// 현재페이지가 1페이지면 < 버튼 disabled
						pageValue += "<li class='page-item prev'><button disabled class='page-link'><i class='tf-icon bx bx-chevron-left'></i></button></li>";
							
					} else {
						// 현재 페이지가 1페이지가 아니면
						pageValue += "<li class='page-item prev'><button class='page-link' onclick='selectTodayAttList(" + (pi.currentPage - 1) + ")'><i class='tf-icon bx bx-chevron-left'></i></button></li>";
					}
					
					for(let p=pi.startPage; p<=pi.endPage; p++) { 
						if(p == pi.currentPage) { 
								pageValue += "<li class='page-item'><button class='page-link' disabled>"  + p  + "</button></li>"
						}else {
								pageValue += "<li class='page-item'><button class='page-link' onclick='selectTodayAttList(" + p +")'>" + p + "</button></li>"
						} 
					}     
			
					if(pi.currentPage == pi.maxPage) {
						pageValue += "<li class='page-item prev'><button disabled class='page-link'><i class='tf-icon bx bx-chevron-right'></i></button></li>"
					} else {
						pageValue +=	"<li class='page-item next'><button class='page-link' onclick='selectTodayAttList(" + (pi.currentPage + 1) + ")'><i class='tf-icon bx bx-chevron-right'></i></button></li>"
						
					}
					
					$("#memListTBody").html(value);
					$(".pagination").html(pageValue);
					$("#selectAll").attr("checked", true);
			}
		}
		,error:function(){
				console.log("페이지 로딜 리스트 조회용 ajax통신 실패"); 
		}
	

	})

}
    		
	
function nowSearch(page, searchText){

	$("#searchText").val("");	
		$.ajax({
			url: "todayAttList.att",
			data:{
				addSqlGrade : $("#orderByGrade").val(),
				addSqlStatus : $('input:radio[name="orderByStatus"]').val(),
				sqlEmpName :searchText,
				searchFlag : 'Y',
				thisYear : $("#thisYear").val(),
				thisMonth : $("#thisMonth").val(),
				thisDay : $("#thisDay").val(),
				cpage:page
			},
			type:"post",
			success:function(result){
			
			
				let value = "";
				let pageValue = "";
				
				let aList = result.aList;
				let pi = result.pi;
				
				if(aList.length == 0) {
					value += "<tr>"
						+ "<td colspan='7'> 직원이 없습니다. </td>"
							+ "</tr>";
				} else {
					for(let i=0; i<aList.length; i++){
						
						value += "<tr>"
								+  	 "<td>" +  aList[i].empNo + "</td>"
								+  	 "<td>" +  aList[i].empName + "</td>"
								+  	 "<td>" +  aList[i].grName + "</td>"
								+  	 "<td>" +  aList[i].attDate + "</td>"
								+  	 "<td>" +  aList[i].attIn + "</td>"
								+  	 "<td>" +  aList[i].attOut + "</td>"
								+  	 "<td>" +  aList[i].attStatus + "</td>"
								+  	 "<td>" +  aList[i].attPlusWork + "</td>"
								+ "</tr>";
					}

					
					if(pi.currentPage == 1){
						// 현재페이지가 1페이지면 < 버튼 disabled
						pageValue += "<li class='page-item prev'><button disabled class='page-link'><i class='tf-icon bx bx-chevron-left'></i></button></li>";
							
					} else {
						// 현재 페이지가 1페이지가 아니면
						pageValue += "<li class='page-item prev'><button class='page-link' onclick='selectAllAttList(" + (pi.currentPage - 1) + ")'><i class='tf-icon bx bx-chevron-left'></i></button></li>";
					}
					
					for(let p=pi.startPage; p<=pi.endPage; p++) { 
						if(p == pi.currentPage) { 
								pageValue += "<li class='page-item'><button class='page-link' disabled>"  + p  + "</button></li>"
						}else {
								pageValue += "<li class='page-item'><button class='page-link' onclick='selectAllAttList(" + p +")'>" + p + "</button></li>"
						} 
					}     
			
					if(pi.currentPage == pi.maxPage) {
						pageValue += "<li class='page-item prev'><button disabled class='page-link'><i class='tf-icon bx bx-chevron-right'></i></button></li>"
					} else {
						pageValue +=	"<li class='page-item next'><button class='page-link' onclick='selectAllAttList(" + (pi.currentPage + 1) + ")'><i class='tf-icon bx bx-chevron-right'></i></button></li>"
						
					}
					
					$("#memListTBody").html(value);
					$(".pagination").html(pageValue);
					$("#selectAll").attr("checked", true);
			}
		}
		,error:function(){
				console.log("페이지 로딜 리스트 조회용 ajax통신 실패"); 
		}
	

	})

}