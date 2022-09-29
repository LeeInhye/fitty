/**
 * 
 */
 $(function(){
 	
	$(document).ready(function(){
	$(".modifyWrap button[name=simple]").click(function(){
            		selectModifyDetail( $(this).children("#moAttNo").val());
            	})
 	})

	 $(document).ready(function(){
		$(".modifyWrap button[name=simple]").click(function(){
						changeReadFlag( $(this).children("#moAttNo").val());
					})
		 })
 	
 })

 function changeReadFlag(moAttNo){
	console.log(moAttNo);
	$.ajax({
	url: "changeReadFlag.mo",
		data:{
		    moAttNo : moAttNo
		},
        type:"post",
        success:function(result){
          	
          	
			console.log("읽음으로 변경됨");
			
        },
        error:function(){
            console.log("관리자 예약내역리스트 조회용 ajax통신 실패"); 
        }
    })
 }
 
  function selectModifyDetail(moAttNo){

 
    $.ajax({
        url: "modifyDetail.mo",
		data:{
		    moAttNo : moAttNo
		},
        type:"post",
        success:function(att){
          	
          	let value=""
          	
          	value +=      "<div class='card mb-4 modifyDiv' style='height: 680px;'>"
		    +               "<h5 class='card-header'><img src='" + att.empPhoto + "' alt='Avatar' class='rounded-circle' width='40px;' height='40px;'/><b> "+ att.empName +"</b> " + att.grName +" " + att.moAttType + " 📝 수정요청안</h5>"
		    +               "<div class='card-body' style='width: 95%;'>"
		    +                 "<form id='formAccountSettings' method='POST'>"
			+                 	"<input type='hidden' value='" + att.moAttNo + "' name='moAttNo'>"
		    +                   "<table class='table table-hover modifyTable'>"
		    +                      "<thead>"
		                      
		    +                       "<tr>"
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
		    +                         "<td>"+ att.moAttModifyD +"</td>"
		    +                         "<td>"+ att.attIn +"</td>"
		    +                         "<td>"+ att.attOut +"</td>"
		    +                         "<td>"+ att.gapHour + ":" + att.gapMinute + ":" + att.gapSecond +"</td>"
		    +                         "<td>"+ att.attStatus +"</td>"
			+                         "<td>"+ att.moAttEnrollD +"</td>"
		    +                       "</tr>"
		    +                     "</tbody>"
		    +                   "</table>"
		    +                 "<div class='mb-3 col-md-12 reason' style='height : 450px; padding-top: 7px;'>"
			+                 	"<input type='hidden' value='" + att.moAttNo + "' name='moAttNo'>"
			+                 	"<input type='hidden' value='" + att.empNo + "' name='empNo'>"
		    +                   "<h5 class='card-header' style='padding : 10px; margin-top:15px;'><b>🧾 " + att.moAttType + "수정사유</b></h5>"
			+                 	"<input type='hidden' value='" + att.moAttType + "' name='moAttType'>"
		    +                   "<textarea class='textarea' style='height : 80px' autofocus>" + att.moAttReason + "</textarea>"
			+                   "<div class='row submitDiv' style='margin-left: 50px; padding-bottom:0px; margin-bottom:0px;'>"
				+                   "<div class='mt-2 btnDiv col-md-6' style='margin-bottom:10px;'>"
				+                       "<label for='address' class='form-label' style='font-size: 10px; width:50px'>수정일</label>"
				+                       "<input type='text' readonly name='moAttModifyD' class='moAttModifyD' value='" + att.moAttModifyD + "'>'"
				+                       "<input type='hidden' readonly name='attDate' class='attDate' value='" + att.moAttModifyD + "'>'"
				+					"</div>"
				+                   "<div class='mt-2 btnDiv col-md-6' style='margin-bottom:10px;'>"
				+						"<label for='address' class='form-label' style='font-size: 10px; width:50px'>수정시</label>"
				+                       "<input type='time'  min='00:00:00' max='23:59:59' class='form-control' id='moAttModifyTime' name='moAttModifyTime' value='" + att.moAttModifyTime + "'/>"
				+					"</div>"
				+                   "<div class='mt-2 btnDiv col-md-12' style='margin-bottom:10px;'>"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='O'>&nbsp정상&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='L'>&nbsp지각&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='X'>&nbsp결석&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='E'>&nbsp조퇴&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='Q'>&nbsp오전반차&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='Z'>&nbsp오후반차&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='Y'>&nbsp연월차&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='V'>&nbsp휴가&nbsp&nbsp&nbsp&nbsp&nbsp"
				+						"<input class='form-check-input'  type='radio' name='attStatus' value='P'>&nbsp연장&nbsp&nbsp&nbsp&nbsp&nbsp"
				+				  "</div>"
		    +                   "</div>"
		    +                   "<h5 class='card-header' style='padding : 10px; margin-top:15px;' ><b>📋 수정의견</b></h5>"
		    +                   "<textarea class='textarea'style='height : 80px' autofocus required name='moAttBack' style='background-color:#E7E7E7' id='moAttBack'>"+ att.moAttBack +"</textarea>"
			+                     "<div class='mt-2 btnDiv col-md-2' style='padding-bottom:0px; height : 35px;'>"
			+ 						"<button type='button' class='btn btn-primary me-2'  style='width:200px;' onclick='okModifyAtt();'>수정</button>"
			+						"<button type='button' class='btn btn-danger me-2' style='width:200px;' onclick='cantModifyAtt();'>반려</button>"
		    +                 "</form>"
			+              "</div>"
		    +                 "</div>"
			
			$(".printModifyDiv").html(value);
			
        },
        error:function(){
            console.log("관리자 예약내역리스트 조회용 ajax통신 실패"); 
        }
    })

}
function okModifyAtt(){
	$("#formAccountSettings").attr("action", "updateModifyMo.mo");
	document.getElementById('formAccountSettings').submit();
}

function cantModifyAtt(){
	$("#formAccountSettings").attr("action", "cantModifyAtt.mo");
	document.getElementById('formAccountSettings').submit();
}