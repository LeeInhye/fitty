/**
 * 
 */
  $(function(){
 	
	$(document).ready(function(){
	$(".card-body button[name=simple]").click(function(){
            		selectModifyDetail( $(this).children("#moAttNo").val());
            	})
 	})

	 
 	
	 
 })
 
 
 function selectModifyDetail(moAttNo){
	
 	console.log(moAttNo);
 	
 
    $.ajax({
        url: "modifyDetail.mo",
		data:{
		    moAttNo : moAttNo
		},
        type:"post",
        success:function(att){
          	
          	let value=""
          	
          	value +=      "<div class='card mb-4 modifyDiv' style='height: 759px;'>"
		    +               "<h5 class='card-header'><img src='" + att.empPhoto + "' alt='Avatar' class='rounded-circle' width='40px;' height='40px;'/><b> "+ att.empName +"</b> " + att.grName +" " + att.moAttType + " 📝 수정요청안</h5>"
		    +               "<div class='card-body' style='width: 95%;'>"
		    +                 "<form id='formAccountSettings' method='POST' action='modifyMo.mo'>"
			+                 	"<input type='hidden' value='" + att.moAttNo + "' name='moAttNo'>"
		    +                   "<table class='table table-hover modifyTable'>"
		    +                      "<thead>"
		                      
		    +                       "<tr>"
			+                         "<td>조회</td>"
		    +                         "<td>수정요청일</td>"
		    +                         "<td>출근시간</td>"
		    +                         "<td>퇴근시간</td>"
		    +                         "<td>총 근무시간</td>"
		    +                         "<td>상태</td>"
			+                         "<td>작성일</td>"
		    +                       "</tr>"
		    +                     "</thead>"
		    +                     "<tbody>"
		    +                       "<tr>"
			+                         "<td>"+ att.moReadFlag +"</td>"
		    +                         "<td>"+ att.moAttModifyD +"</td>"
		    +                         "<td>"+ att.attIn +"</td>"
		    +                         "<td>"+ att.attOut +"</td>"
		    +                         "<td>"+ att.gapHour + ":" + att.gapMinute + ":" + att.gapSecond +"</td>"
		    +                         "<td>"+ att.attStatus +"</td>"
			+                         "<td>"+ att.moAttEnrollD +"</td>"
		    +                       "</tr>"
		    +                     "</tbody>"
		    +                   "</table>"
		    +                 "</form>"
		    +                 "<form class='mb-3 col-md-12 reason' style='margin-top: 15px;' method='POST' action='confirmMo.mo'>"
			+                 	"<input type='hidden' value='" + att.moAttNo + "' name='moAttNo'>"
		    +                   "<h5 class='card-header' style='margin-bottom : 15px'><b>🧾 " + att.moAttType + "수정사유</b></h5>"
		    +                   "<textarea class='textarea' autofocus>" + att.moAttReason + "</textarea>"
			+                   "<div class='row submitDiv' style='margin-left: 90px;'>"
		    +                   "<div class='mt-2 btnDiv col-md-10' style='margin-bottom:10px;'>"
		    +                       "<label for='address' class='form-label' style='font-size: 10px; width:50px'>수정일시</label>"
			+                       "<input type='date' class='attDate value='" + att.attDate + "'>'"
		    +                       "<input type='time' class='form-control' id='attTime' name='attTime' min='00:00:00' max='23:59:59' value='" + att.moAttModifyTime + "'/>"
		    +                     "</div>"

		    +                   "</div>"
		    +                   "<h5 class='card-header' style='margin-bottom : 15px; padding-top:0';><b>📋 수정의견</b></h5>"
		    +                   "<textarea class='textarea' autofocus required name='moAttBack' style='background-color:#E7E7E7' id='moAttBack' readOnly>"+ att.moAttBack +"</textarea>"
		    
		    +                 "</form>"
          	
          	$(".printModifyDiv").html(value);
			
        },
        error:function(){
            console.log("관리자 예약내역리스트 조회용 ajax통신 실패"); 
        }
    })

}


function selectMoAttForm(){
	let empNo = $("#empNo").val();
	
	console.log(empNo);
	$.ajax({
        url: "selectMoAttForm.mo",
		data:{
		    empNo : empNo
		},
        type:"post",
        success:function(e){
          	
          	let value=""
          	
          	value +=      "<div class='card mb-4 vacDetailDiv'>"
				  +				 "<h5 class='card-header' style='margin-bottom:20px; margin-top:20px;'><b> "+ e.empName +"</b> " + e.grName + " 📝 수정요청서 작성</h5>"
				  +				"<div class='card-body' style='width: 95%;'>"
				  +					"<form id='formAccountSettings' method='POST' action='insertMoAtt.mo'>"
				  +					"<div class='row'>"
				  +						"<input type='hidden' value='" + e.empNo + "' name='empNo'>"
				  +						"<div class='mb-3 col-md-4'>"
				  +						"<label for='address' class='form-label' style='font-size: 10px; width:50px'>수정일</label>"
				  +                       "<input type='date' class='attDate' name='attDate' >"
				  +						"</div>"
				  +						"<div class='mb-3 col-md-4'>"
				  +						"<label for='address' class='form-label' style='font-size: 10px; width:50px'>수정시</label>"
				  +                       "<input type='time' class='form-control' min='00:00:00' max='23:59:59' id='moAttModifyTime' name='moAttModifyTime'>"
				  +						"</div>"
				  +						"<div class='mb-3 col-md-4'>"
				  +						"<label for='organization' class='form-label'>수정요청선택</label>"
				  +						"<div style='height : 10px'></div>"
				  +						"<input class='form-check-input'  type='radio' name='moAttType' value='I'>&nbsp출근수정&nbsp&nbsp&nbsp&nbsp&nbsp"
				  +						"<input class='form-check-input'  type='radio' name='moAttType' value='O'>&nbsp퇴근수정&nbsp&nbsp&nbsp&nbsp&nbsp"
				  +						"</div>"
				  +						"<div class='mb-3 col-md-12' style='margin-top: 20px;''>"
				  +						"<label for='reason' class='form-label' >수정 요청사유</label><br>"
				  +						"<textarea class='reasonArea' autofocus required name='moAttReason'></textarea>"
				  +						"</div>"
				  +					"</div>"
				  +					"<div class='mt-2 attModifyFormBtnDiv'>"
				  +						"<button type='submit' class='btn btn-primary me-2'>수정요청</button>"
				  +					"</div>"
				  +					"</form>"
				  +			"</div>"
				  +		"</div>"
          	
          	$(".printModifyDiv").html(value);
			
        },
        error:function(){
            console.log("근태 수정폼 작성용 ajax통신 실패"); 
        }
    })

}
