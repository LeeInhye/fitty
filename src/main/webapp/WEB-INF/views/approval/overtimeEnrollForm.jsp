<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="resources/css/approval.css" />
<style>
	#tb1{width:300px; height:120px; float:left;}
	#tb2{width:100px; height:120px; float:right;}
	
	#tb6{width:94%;}
	.dt, .ti{height:30px; border:1px solid gray; border-radius: 5px;  margin-left:5px;}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<div class="outer">
		<jsp:include page="sideMenu.jsp"/>
		
		<div class="main">
			<form action="" name="ovtForm">
				<h4 style="color:rgb(50, 50, 50);">연장근무신청</h4><br>
				
				<button class="f-btn" onclick="insertAppr();" type="button">
				 	<i class='bx bxs-edit'></i>
				 	결재요청
				</button>
				<button class="f-btn" type="button" onclick="insertStorage();">
				 	<i class='bx bx-download'></i>
				 	임시저장
				</button>
				<button class="f-btn" class="f-btn" onclick="cancel();" type="button">
				 	<i class='bx bxs-x-circle'></i>
				 	취소
				</button>
				<button class="f-btn" data-bs-toggle="modal" data-bs-target="#addMem" type="button">
					<i class='bx bx-error-circle'></i>
					결재정보
				</button>
				<button class="f-btn" style="float:right;" type="button" onclick="location.href='draftList.ap'">
				 	<i class='bx bx-menu'></i>
				 	목록
				</button>
				<br><br>
				<div
		          class="modal fade"
		          id="addMem"
		          aria-labelledby="modalToggleLabel"
		          tabindex="-1"
		          style="display: none"
				  aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header">
							  <h5 class="modal-title" id="modalToggleLabel" style="color:rgb(51, 51, 51);">결재선 선택</h5>
							  <button
							    type="button"
							    class="btn-close"
							    data-bs-dismiss="modal"
							    aria-label="Close"
							  ></button>
							</div>
							<div class="modal-body">
								<div class="memlist">
									<span style="margin-left:10px;">조직도</span>
									<hr>
									<ul>
										<div id="appr-mem1">
											<c:forEach var="e" items="${ list }">
												<c:if test="${ e.empGrade ne 'T' }">
													<li><div class="wd"></div><i class='bx bxs-user'></i><button type="button" onclick="clickMem(this)" value1="${e.grApprGrade }" value2="${ e.empNo }">${ e.empName }</button></li>
												</c:if>
											 	
											</c:forEach>
											<li><div class="wd"></div><button class="membtn" type="button"><i class='bx bx-add-to-queue'></i></button>트레이너
												<ul>
												    <div id="appr-mem2" style="display:none;">
												     	<c:forEach var="e" items="${ list }">
															<c:if test="${ e.empGrade eq 'T' }">
													      		<li><div class="wd"></div><i class='bx bxs-user'></i><button type="button" onclick="clickMem(this)" value1="${e.grApprGrade }" value2="${ e.empNo }">${ e.empName }</button></li>
													      	</c:if>
												    	</c:forEach>
												    </div>
												</ul>
											</li>
										</div>
									</ul>
								</div>
								<div class="addlist">
									<table>
										<tr>
											<td width="40" height="30"></td>
											<td width="50">타입</td>
											<td width="110">이름</td>
											<td width="100">직급</td>
											<td width="30"><button><i class='bx bxs-trash'></i></button></td>
										</tr>
										<tr>
										 	<th colspan="5" height="30" style="background:rgba(211, 211, 211, 0.5);">&nbsp;신청</th>
										</tr>
										<tr>
											<td height="40" style="background:rgba(211, 211, 211, 0.3);"><button type="button" style="background:rgba(211, 211, 211, 0);"><i class='bx bx-chevrons-right'></i></button></td>
											<td>기안</td>
											<td>${ loginUser.empName }</td>
											<c:choose>
												<c:when test="${ loginUser.empGrade eq 'C' }">
													<td>대표</td>
												</c:when>
												<c:when test="${ loginUser.empGrade eq 'A' }">
													<td>팀장</td>
												</c:when>
												<c:otherwise>
													<td>사원</td>
												</c:otherwise>
											</c:choose>
											<td></td>
										</tr>
										<tr>
										 	<th colspan="5" height="30" style="background:rgba(211, 211, 211, 0.5);">&nbsp;승인</th>
										</tr>
									  
									</table>
								  
									<div id="plus" width="40" style="float:left;">
										<table>
											<tr class="addmem">
											    <td height="80" width="40" style="background:rgba(211, 211, 211, 0.3);">
												   	<button style="background:rgba(211, 211, 211, 0);" type="button" id="insert" onclick="none();">
												    	<i class='bx bx-chevrons-right'></i>
												    </button>
												</td>
											</tr>
										</table>
									</div>
									<div id="mem" style="float:right;">
										<table>
											
										</table>
									</div>
								</div>
							</div>
							<script>
							    $(function(){
									$('.membtn').click( function() {
									  $('#appr-mem2').slideToggle(20);
									} );
									
									let today = new Date();
									let year = today.getFullYear();
									let month = today.getMonth()+1;
									let date = today.getDate();
									
									today = year + "-" + month + "-" + date;
									
									$("#tb1").children().children().eq(1).children().eq(1).append(today);
							    })
							    
							    function insertAppr(){
									alertify.confirm('결재를 요청하시겠습니까?', function(){ $("form[name=ovtForm]").attr("action","insertOvt.ap"); $("form[name=ovtForm]").submit();}
								   	); 
							    }
							    
							    function insertStorage(){
									alertify.confirm("작성하던 내용을 저장하시겠습니까?", function(){
										$("form[name=ovtForm]").attr("action", "insertStorage.ap").submit();
									})
							    }
							    
							    function cancel(){
	 	  						 	alertify.confirm('현재 작성 중인 내용을 저장하지 않고 나가시겠습니까?', function(){ location.replace("apprMain.ap"); }
		        					);
							    }
							    
							    function none(){
							 		alertify.alert("결재 승인자를 선택해주세요.").set('basic', true);
							    }
						    
							    function clickMem(btn){
							 		let val1 = $(btn).text();
						 	 	 	let val2 = $(btn).attr("value1");
							 	  	let val3 = $(btn).attr("value2");
								  	$("#insert").attr("onclick", "insertMem(this)");
								  	$("#insert").attr("value1", val1);
								  	$("#insert").attr("value2", val2);
								  	$("#insert").attr("value3", val3);
							  
							    }
						    
								function insertMem(btn){
									if($("#mem tr").length == 0){	   
										var value = "";
										
										value += "<tr><td height='40' width='50'>결재</td>"
										   	   + "<td width='110'>" + $(btn).attr("value1")
										   	   + "</td><td width='100'>"+ $(btn).attr("value2") + "</td>"
										   	   + "<td width='30'>"
										   	   + "<button type='button' onclick='delete1st(this);' value='" + $(btn).attr("value3") + "'>"
										   	   + "<i class='bx bxs-trash'></i>"
										   	   + "</button></td></tr>";
										   	   
										$("#mem>table").append(value);
										$("#insert").removeAttr("value");
										$("#insert").removeAttr("onclick");	
									}else if($("#mem tr").length == 1){
									 
										if($("#mem>table").children().eq(0).children().eq(3).children().val() != $(btn).attr("value3")){
											value += "<tr><td height='40' width='50'>결재</td>"
								    	   		   + "<td width='110'>" + $(btn).attr("value1")
									    	       + "</td><td width='100'>"+ $(btn).attr("value2") + "</td>"
									    	       + "<td width='30'>"
									    		   + "<button type='button' onclick='delete1st(this);' value='" + $(btn).attr("value3") + "'>"
									    		   + "<i class='bx bxs-trash'></i>"
									    	  	   + "</button></td></tr>";
									    			   
											$("#mem>table").append(value);
											$("#insert").removeAttr("value");
										  	$("#insert").removeAttr("onclick");	
										}else{
								    		alertify.alert("이미 선택되었습니다.");
								    	}
									}else{
										alertify.alert("승인자는 2명까지만 선택 가능합니다.").setHeader('');
									}
								  
								}
						    
								function delete1st(btn){
									$(btn).parents("tr").remove();
									$(btn).parents("tr").removeAttr("value");
								 
								}
						    
							</script>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" data-bs-dismiss="modal" id="aa" onclick="insertApprLine();">확인</button>
						    	<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</div>
				<script>
					function insertApprLine(){
						$("#tb3").show();
						
						if($("#mem tr").length == 1){
							$("#tb5").hide();
							$("#tb2 td").empty();
			 			$("#tb2").show();
			 			$("#tb2").children().children().eq(0).children().eq(1).empty();
			 			$("#tb2").children().children().eq(0).children().eq(1).append("<input type='hidden' id='empNo1' name='mlist[0].empNo' value=''>");
			 			
			 			let value1 = $("#mem").children().children().children().eq(2).text();
			 			$("#tb2").children().children().eq(0).children().eq(1).append(value1);
			 			
			 			let value2 = $("#mem").children().children().children().eq(1).text();
			 			$("#tb2").children().children().eq(1).children().eq(0).append(value2);
			 			
			 			let value3 = $("#mem").children().children().children().eq(3).children().val();
			 			$("#empNo1").attr("value", value3);
			 			$("input[name=apprMemCount]").attr("value", "1");
			 			
			 			$("#tb5").children().children().eq(0).children().eq(1).empty();
			 			
						}else if($("#mem tr").length == 2){
							$("#tb2").hide();
							$("#tb5 td").empty();
							$("#tb5").show();
							$("#tb5").children().children().eq(0).children().eq(1).empty();
							$("#tb5").children().children().eq(0).children().eq(1).append("<input type='hidden' id='empNo1' name='mlist[0].empNo' value=''>");
							$("#tb5").children().children().eq(0).children().eq(1).append("<input type='hidden' id='empNo2' name='mlist[1].empNo' value=''>");
							
							let value1 = $("#mem").children().children().eq(0).children().eq(2).text();
			 				$("#tb5").children().children().eq(0).children().eq(1).append(value1);
							
				 			let value2 = $("#mem").children().children().eq(0).children().eq(1).text();
				 			$("#tb5").children().children().eq(1).children().eq(0).append(value2);
				 			
				 			let value3 = $("#mem").children().children().eq(1).children().eq(2).text();
				 			$("#tb5").children().children().eq(0).children().eq(2).append(value3);
				 			
				 			let value4 = $("#mem").children().children().eq(1).children().eq(1).text();
				 			$("#tb5").children().children().eq(1).children().eq(1).append(value4);
				 			
				 			let value5 = $("#mem").children().children().eq(0).children().eq(3).children().val();
				 			$("#empNo1").attr("value", value5);
				 			
				 			let value6 = $("#mem").children().children().eq(1).children().eq(3).children().val();
				 			$("#empNo2").attr("value", value6);
				 			
				 			$("#tb2").children().children().eq(0).children().eq(1).empty();
				 			$("input[name=apprMemCount]").attr("value", "2");
						}else{
							$("#tb5").hide();
						}
					}
				</script>
				<div class="app-form1">
					<br>
					<h5 align="center" style="color:rgb(50, 50, 50);"><b>연장근무신청서</b></h5>
					<br><br>
					<input type="hidden" name="apprMemCount" value="">
					<input type="hidden" name="apprDocType" value="2">
					<input type="hidden" name="apprTitle" value="연장근무신청">
					<table id="tb1">
						<tr>
							<th width="40%">기안자</th>
						 	<td>${ loginUser.empName }</td>
						</tr>
						<tr>
							<th>기안일</th>
							<td></td>
						</tr>
						<tr>
						 	<th>문서번호</th>
							<td></td>
						</tr>
					</table>
					<table id="tb2" style="display:none;">
						<tr>
						 	<th rowspan="3" width="25%">승인</th>
						 	<td height="24px"></td>
						</tr>
						<tr>
						  	<td></td>
						</tr>
						<tr>
						  	<td height="24px"></td>
						</tr>
					</table>
					<table id="tb5" style="display:none;">
						<tr>
						 	<th rowspan="3" width="25px">승인</th>
					 	 	<td height="24px" width="75px"></td>
						  	<td></td>
						</tr>
						<tr>
						  	<td></td>
						  	<td></td>
						</tr>
						<tr>
						  	<td height="24px"></td>
						  	<td></td>
						</tr>
					</table>
					<table id="tb3" style="display:none;">
						<tr>
							<th rowspan="3" width="25%;">신청</th>
							<td height="24px">
								<c:choose>
							       	<c:when test="${ loginUser.empGrade eq 'C' }">
							       		대표
							       	</c:when>
							       	<c:when test="${ loginUser.empGrade eq 'A' }">
							       		팀장
							       	</c:when>
							       	<c:otherwise>
							       		사원
							       	</c:otherwise>
							      </c:choose>
							</td>
						</tr>
						<tr>
					  		<td>${loginUser.empName }<input type="hidden" name="empNo" value="${loginUser.empNo }"></td>
						</tr>
						<tr>
						  	<td height="24px"></td>
						</tr>
					</table>
				  
					<table id="tb4">
						<tr>
						  	<th width="20%" height="40px;">근무 일시</th>
						  	<td>
						    	<input type="date" class="dt" name="ovtDate"> &nbsp;&nbsp;&nbsp;
						    	<input type="time" class="ti" name="ovtStartTime"> &nbsp;~ <input type="time" class="ti" name="ovtEndTime" onchange="count()">
						  	</td>
						</tr>
						<tr>
						  	<th height="40px;">근무 시간</th>
						  	<td>&nbsp;&nbsp;</td>
						</tr>
						<tr>
						  	<td colspan="2" height="80px;" class="cmt2">
						    	* 주간 근무시간 - 근무일이 포함된 한 주<br>
					    	 	정상근무시간 + 연장근무 승인 요청에 대한 결재가 완료된 총 시간입니다. <br>
					    		근태관리에서 시간 수정이 가능하므로 주간 근무시간은 상이해질 수 있습니다.
						  	</td>
						</tr>
						<tr>
						  	<th height="120px;">신청 사유</th>
						  	<td><input type="text" class="rsn" name="ovtReason"></td>
						</tr>
					</table>
					
					<script>
							function count(){
								let hour1 = $("input[name=ovtStartTime]").val();
								let hour2 = $("input[name=ovtEndTime]").val();
								
								hour1 = hour1.replace(/\:/g, "");
								hour2 = hour2.replace(/\:/g, "");
								
								let count = (hour2 - hour1) / 100;
								
								$("#tb4").children().children().eq(1).children().eq(1).append(count + '시간');
							}
					</script>

				</div>
			</form>
         </div>
	</div>
</body>
</html>