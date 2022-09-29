/**
 * 
 */
 
 //console.log($("input:hidden[name='invEmpNo']").val());
 //console.log($("input:hidden[id='empNoInput']").val());

 $(function(){
	selectEmpList();

    $(document).ready(function(){
    	$("#searchBtn").on("click",function() {
    		
    		selectEmpList();
    		})
	})

	 $(document).on("click", ".empList button", function(){ // on 이벤트로 변경
		selectChatRoom( $(this).children("#invEmpNo").val() );
	});


	$(document).on("click", "#send", function(){ // on 이벤트로 변경
		send();
	});

})
 
 
 function selectEmpList(){
	const empNo = $("#empNoInput").val();
	console.log(empNo);
 	//$("input:radio[name='orderByPercent']:radio[value='selectAll']").prop('checked', true); invEmpNo
	
	 $.ajax({
			  url:"chatEmp.ch",
			 data:{
			   searchText:$("#searchText").val()
			 },
			 type:"post",
			 success:function(list){
			  
				//console.log(list);
			    let value = "";
				
				if(list.length == 0) {
					value += "<li>직원이 없습니다</li>"
				} else {
					
					value += "<li style='font-size : 18px;  margin-top:10px;'><b>관리자</b></li>"
								+ "<ul>"
					for(let i=0; i<list.length; i++){
			              if((list[i].empGrade === "C" || list[i].empGrade === "A") && (list[i].empNo != empNo)) {
							 value += "<li class='dataLi' style='font-size : 15px;  margin-top:10px;'><button type='button' style='border : none; background-color : white;'><img src='" + list[i].empPhoto + "' alt='Avatar' class='rounded-circle' width='35px;' height='35px;'/>"
							+ "<input type='hidden' value='" + list[i].empNo + "' id='invEmpNo' name='invEmpNo'><b style='font-size : 15px;  margin-top:10px;' >　" + list[i].empName + "</b> 🧘‍♂️ " + list[i].grName + "</button></li>"
						  }
						}
						value += "</ul>"
							  + "<li style='font-size : 18px;  margin-top:10px;'><b>트레이너</b></li>"
							  + "<ul>"
					for(let i=0; i<list.length; i++){
								if((list[i].empGrade === "T") && (list[i].empNo != empNo) ) {
									value += "<li class='dataLi'  style='font-size : 15px; margin-top:10px;'><button type='button' style='border : none; background-color : white;'><img src='" + list[i].empPhoto + "' alt='Avatar' class='rounded-circle' width='35px;' height='35px;'/>"
									+ "<input type='hidden' value='" + list[i].empNo + "' id='invEmpNo' name='invEmpNo'><b style='font-size : 15px;  margin-top:10px;'>　" + list[i].empName + "</b> 🏃‍♂️ " + list[i].grName + "</button></li>"
								}
							  }
						value += "</ul>"
			             
					}

						
					
					
					$(".empList").html(value);

			   
			 }
	   ,
	   error:function(){
		 console.log("회원목록 조회용 ajax 통신 실패");
	   }
	   
	})
}


function selectChatRoom(invEmpNo){
	
	
	const empNo = $("#empNoInput").val();

	
	$.ajax({
		    url:"bubbleList.ch",
			data:{
			 invEmpNo:invEmpNo,
			 empNo:empNo
			},
			type:"post",
			success:function(invMap){
				let c = invMap.c;
				let invC = invMap.invC;
				let bubbleList = invMap.bubbleList;
			    let value = ""

			   // 해줘야 하는것 : 리스트말고 invEmpno, name, empPhoto, grname 객체 하나가 필요함, 즉 리턴할때 map으로 리턴해야함 ㅜㅜ
			
			console.log(bubbleList);
			 console.log("bubbleList.length : " + bubbleList.length)

			 value +=  "<h5 class='card-header' style='margin-bottom : 20px; margin-top:20px;'>"
				   +   "<img src='"+ invC.empPhoto +"' alt='Avatar' class='rounded-circle' width='40px;' height='40px;'/>"
				   +   "<b font-size:20px;>🎉" + invC.empName + " " + invC.grName + "🎉</b></h5>"
				   +   "<input type='hidden' id='chatRoomNo' value='" + c.chatRoomNo + "'>"
				   +   "<input type='hidden' id='id' value='" + invC.empName + "'>"
				   +   "<input type='hidden' id='photo' value='" + invC.empPhoto + "'>"
				   +   "<input type='hidden' id='hiddenEmpNo' value='" + c.empNo + "'>"
				   +   "<input type='hidden' id='hiddenInvEmpNo' value='" + invC.invEmpNo + "'>"
			   
			   if(bubbleList.length == 0) {
				   value += "<div id='chatarea' class='card-header' style='width: 80%; height: 600px; overflow: auto;'>"
						 + 		   "<div id='chatTextArea' style='text-align:center'>" + invC.empName + "님과의 새로운 대화가 시작되었습니다.</div>"
						 +		   "</div>"
						 + 	"</div>"
						 
			   } else {
				   
				   value +=  "<div id='chatarea' class='card-header' style='width: 80%; height: 600px; overflow: auto;'>"
							 +			   "<div id='chatTextArea'>"
						 for(let i=0; i<bubbleList.length; i++){
							if(bubbleList[i].empNo === c.empNo){
								value +=  		  "<table class='myTable'>"
								+					   "<tr>"
								+						   "<td rowspan='2' width='50px; style='margin-left:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' align='left' class='rounded-circle col-md-1' style='width:50px; height:50px;'/></td>"
								+						   "<td width='90px;' width='90px;'  style='text-align:left'>" + bubbleList[i].empName + "</td>"
								+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText' style='text-align:right; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
								+					   "</tr>"
								+					   "<tr>"
								+						   "<td style='font-size : 10px; text-align:left;'>" + bubbleList[i].bblDate  + "</td>"
								+					   "</tr>"
								+				   "</table>"
							} else {
								value += 		   "<table class='yourTable'>"
								+					   "<tr>"
								+						   "<td rowspan='2'width='50px; style='margin-right:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar'  align='left' class='rounded-circle col-md-1' style='width:50px; height:50px;'/></td>"
								+						   "<td width='90px;'  style='text-align:left'>" + bubbleList[i].empName  + "</td>"
								+						   "<td rowspan='2' width='90px;' class='textTd'><div class='noStyle' id='yourText' style='text-align:left; background-color:white; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
								+					   "</tr>"
								+					   "<tr>"
								+						   "<td style='font-size : 10px; text-align:right;'>" + bubbleList[i].bblDate  + "</td>"
								+					   "</tr>"
								+				   "</table>"
							}
						 }

						}

						value +=  	 "</div></div><form>"
						+				   "<textarea id='message' style='width:740px; margin-left:107px;'></textarea>"
						+				   "<input type='button' class='btn btn-primary' style='margin-top:-42px; height : 50px;' id='send' value='보내기' />"
						+		   		"</form>"
						+		   "</div>"
						+	   "</div>"

						$(".vacDetailDiv").html(value);
			  
			}
	  ,
	  error:function(){
		console.log("회원목록 조회용 ajax 통신 실패");
	  }
	  
   })
}


	// ##### 입장~~~!!
	let websocket;
	$(function(){
		
		
	connect();
	})
	
	function connect(){

		websocket = new SockJS("/fitty/chat-ws");
			//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
			websocket.onopen = onOpen;
			websocket.onmessage = onMessage;

	}
	
	// ##### 연결 되었습니다!
	function onOpen(){

		console.log("연결됨")
	}
	
	// ##### 메세지 보내기 버튼 클릭!
	/*

	*/
	function send(){

		

		const date = new Date();

		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const dateStr = year + '-' + month + '-' + day;

		const hours = ('0' + date.getHours()).slice(-2);
		const minutes = ('0' + date.getMinutes()).slice(-2);
		const seconds = ('0' + date.getSeconds()).slice(-2);
		const timeStr = hours + ':' + minutes + ':' + seconds;


		id = document.getElementById("empNameInput").value;
		photo = document.getElementById("empPhotoInput").value;
		msg = document.getElementById("message").value;

		websocket.send(
										"<table class='myTable'>"
								+ 					  "<tr>"
								+						   "<td rowspan='2' width='50px; style='margin-left:10px;'><img src='" + photo + "' alt='Avatar' align='left' class='rounded-circle col-md-1' style='width:50px; height:50px;'/></td>"
								+						   "<td width='90px;' style='text-align:left;'>" + id  + "</td>"
								+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText' style='text-align:right; color : grey'>" + msg + "</div></td>"
								+					   "</tr>"
								+					   "<tr>"
								+						   "<td style='font-size : 10px; text-align:left;'>" + dateStr + " " + timeStr + "</td>"
								+					   "</tr>"
								+ 			"</table>"
								
		)
		document.getElementById("message").value = "";
		

		$.ajax({
			url:"insertBubble.ch",
		   data:{
			 empNo:$("#hiddenEmpNo").val(),
			 bblContent:msg,
			 chatRoomNo : $("#chatRoomNo").val()
		   },
		   type:"post",
		   success:function(bubbleList){

			let value = "";

			if(bubbleList.length == 0) {
				value += "<div id='chatTextArea' style='text-align:center; overflow: auto;'>" + invC.empName + "님과의 새로운 대화가 시작되었습니다.</div>"
					  +		   "</div>"
					  + 	"</div>"
					  
			} else {
				
				value += 		   "<div id='chatTextArea' style='overflow: auto;'>"
					  for(let i=0; i<bubbleList.length; i++){
						 if(bubbleList[i].empNo === empNo){
							value += 		   "<table class='myTable'>"
							+					   "<tr>"
							+						   "<td rowspan='2' width='50px; style='margin-left:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' align='left' class='rounded-circle col-md-1' style='width:50px; height:50px;'/></td>"
							+						   "<td width='90px;'  style='text-align:left'>" + bubbleList[i].empName + "</td>"
							+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText' style='text-align:right; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
							+					   "</tr>"
							+					   "<tr>"
							+						   "<td style='font-size : 10px; text-align:left;'>" + bubbleList[i].bblDate  + "</td>"
							+					   "</tr>"
							+				   "</table>"
						 } else {
							 value +=  		   "<table class='yourTable'>"
							 +					   "<tr>"
							 +						   "<td rowspan='2' width='50px; style='margin-left:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' align='left' class='rounded-circle col-md-1' style='width:50px; height:50px;'/></td>"
							 +						   "<td width='90px;'  style='text-align:left'>" + bubbleList[i].empName  + "</td>"
							 +						   "<td rowspan='2' class='textTd'><div class='noStyle' id='yourText' style='text-align:left; background-color:white; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
							 +					   "</tr>"
							 +					   "<tr>"
							 +						   "<td style='font-size : 10px; text-align:right;'>" + bubbleList[i].bblDate  + "</td>"
							 +					   "</tr>"
							 +				   "</table>"
						 }
					  }

					 }

					 value +=  	 "</div></div><form>"
					 +				   "<textarea id='message' style='width:740px; margin-left:107px;'></textarea>"
					 +				   "<input type='button' class='btn btn-primary' style='margin-top:-42px; height : 50px;' id='send' value='보내기' />"
					 +		   		"</form>"
					 +		   "</div>"
					 +	   "</div>"
					 console.log(value);
					 $(".chatarea").html(value);
					
			 
		   }
	 ,
	 error:function(){
	   console.log("채팅메시지 삽입 ajax 통신 실패");
	 }
	 
  })


	}
	
	function onMessage(evt){
		$("#chatTextArea").html(  $("#chatTextArea").html() + "<div style='height:20px;'></div>" + evt.data);
	}
	

	