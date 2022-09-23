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
	//console.log("로그인유저 : " + empNo);
	//console.log("상대방 : " + invEmpNo);
	
	$.ajax({
		    url:"bubbleList.ch",
			data:{
			 invEmpNo:invEmpNo,
			 empNo:empNo
			},
			type:"post",
			success:function(invMap){
				//console.log("ddddd")
				let c = invMap.c;
				let invC = invMap.invC;
				let bubbleList = invMap.bubbleList;
			  // console.log(invMap);
			   let value = ""

			   // 해줘야 하는것 : 리스트말고 invEmpno, name, empPhoto, grname 객체 하나가 필요함, 즉 리턴할때 map으로 리턴해야함 ㅜㅜ
			
			console.log(bubbleList);
			 console.log("bubbleList.length : " + bubbleList.length)

			 value +=  "<h5 class='card-header' style='margin-bottom : 20px; margin-top:20px;'>"
				   +   "<img src='"+ invC.empPhoto +"' alt='Avatar' class='rounded-circle' width='30px;' height='30px;'/>"
				   +   "<b>" + invC.empName + " " + invC.grName + "</b></h5>"
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
				   
				   value +=  /*"<div>"*/ "<div id='chatarea' class='card-header' style='width: 80%; height: 600px; overflow: auto;'>"
							 +			   "<div id='chatTextArea'>"
						 for(let i=0; i<bubbleList.length; i++){
							if(bubbleList[i].empNo === c.empNo){
								value +=  		  "<table class='myTable'>"
								+					   "<tr>"
								+						   "<td width='150px;' style='text-align:left'>" + bubbleList[i].empName + "</td>"
								+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText'  style='text-align:right; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
								+						   "<td rowspan='2' style='margin-left:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' class='rounded-circle col-md-1' style='width:30px; height:30px;'/></td>"
								+					   "</tr>"
								+					   "<tr>"
								+						   "<td style='font-size : 10px; text-align:left;'>" + bubbleList[i].bblDate  + "</td>"
								+					   "</tr>"
								+				   "</table>"	
							} else {
								value += 		   "<table class='yourTable'>"
								+					   "<tr>"
								+						   "<td rowspan='2' style='margin-right:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' class='rounded-circle col-md-1' style='width:30px; height:30px;'/></td>"
								+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='yourText' style='text-align:left; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
								+						   "<td width='150px;'>" + bubbleList[i].empName  + "</td>"
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
						//console.log(value);
						console.log("ffff : " + $(".vacDetailDiv").children().next().val());
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
		//bubbleList.ch
		//websocket = new SockJS("/fitty/chat-ws");
		websocket = new SockJS("/fitty/chat-ws");
			//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
			websocket.onopen = onOpen;
			websocket.onmessage = onMessage;
			//http://localhost:8765/fitty/chatEcho
	}
	
	// ##### 연결 되었습니다!
	function onOpen(){
		//id = document.getElementById("id").value;
		//websocket.send(id + "님과의 대화입니다.");
		console.log("연결됨")
	}
	
	// ##### 메세지 보내기 버튼 클릭!
	/*
	document.getElementById("send").addEventListener("click", function() {
		send();
	});
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

		//websocket.send(/*css 소스 + */id + ":"+ msg);
		websocket.send(
										"<table class='myTable'>"
								+ 					  "<tr>"
								+						   "<td width='150px;' style='text-align:left;'>" + id  + "</td>"
								+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText' style='text-align:right; color : grey'>" + msg + "</div></td>"
								+						   "<td rowspan='2' style='margin-left:10px;'><img src='" + photo + "' alt='Avatar' class='rounded-circle col-md-1' style='width:30px; height:30px;'/></td>"
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
							+						   "<td width='150px;'  style='text-align:left'>" + bubbleList[i].empName + "</td>"
							+						   "<td rowspan='2' class='textTd'><div class='noStyle' id='myText' style='text-align:right; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
							+						   "<td rowspan='2' style='margin-left:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' class='rounded-circle col-md-1' width='30px;' height='30px;'/></td>"
							+					   "</tr>"
							+					   "<tr>"
							+						   "<td style='font-size : 10px; text-align:left;'>" + bubbleList[i].bblDate  + "</td>"
							+					   "</tr>"
							+				   "</table>"
						 } else {
							 value +=  		   "<table class='yourTable'>"
							 +					   "<tr>"
							 +						   "<td rowspan='2' style='margin-right:10px;'><img src='" + bubbleList[i].empPhoto + "' alt='Avatar' class='rounded-circle col-md-1' width='30px;' height='30px;'/></td>"
							 +						   "<td rowspan='2' class='textTd'><div class='noStyle' id='yourText' style='text-align:left; color : grey'>" + bubbleList[i].bblContent + "</div></td>"
							 +						   "<td width='150px;'>" + bubbleList[i].empName  + "</td>"
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
		console.log('Info: connection onmessage.');
	   	console.log("ReceiveMessage:" , evt.data +'\n');
	   		
	   	
		//data= evt.data;
		//chatTextArea = document.getElementById("chatTextArea");
		//chatTextArea.innerHTML =  evt.data;
		$("#chatTextArea").html(  $("#chatTextArea").html() + "<div style='height:20px;'></div>" + evt.data);
	}
	
	// ##### 연결을 해제합니다!
	/*
	document.getElementById("exit").addEventListener("click", function() {
		disconnect();
	});
	/*
	function disconnect(){
		id = document.getElementById("id").value;
		websocket.send(id+"님이 퇴장하셨습니다");
		websocket.close();
	}
	*/
	