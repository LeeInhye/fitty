<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="resources/css/approval.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<div class="outer">
		<jsp:include page="sideMenu.jsp"/>
		
		<div class="main">
			<form action="" method="post" name="expForm" enctype="multipart/form-data">
				<h4 style="color:rgb(50, 50, 50);">지출결의서</h4><br>
				
				<button class="f-btn" onclick="insertAppr();" type="button">
					<i class='bx bxs-edit'></i>
					결재요청
				</button>
				<button class="f-btn" type="button" onclick="insertStorage();">
					<i class='bx bx-download'></i>
					임시저장
				</button>
				<button class="f-btn" onclick="cancel();" type="button">
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
									alertify.confirm('결재를 요청하시겠습니까?', function(){ $("form[name=expForm]").attr("action","insertExp.ap"); $("form[name=expForm]").submit();}
								    ); 
								}
								
								function insertStorage(){
									alertify.confirm("작성하던 내용을 저장하시겠습니까?", function(){
										$("form[name=expForm]").attr("action", "insertStorage.ap").submit();
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
					<h5 align="center" style="color:rgb(50, 50, 50);"><b>지출결의서</b></h5>
					<br><br>
					<input type="hidden" name="apprMemCount" value="">
					<input type="hidden" name="apprDocType" value="3">
					<table id="tb1">
						<tr>
							<th width="40%">기안자</th>
							<td>${loginUser.empName }</td>
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
							<th width="20%" height="40px;">제목</th>
							<td colspan="3"><input type="text" class="title" name="apprTitle"></td>
						</tr>
						<tr>
							<th height="40px;">작성자</th>
							<td width="80%"><input type="text" class="wrt" name="expMem"></td>
						</tr>
						<tr>
							<th height="40px;">금액</th>
							<td colspan="3"></td>
						</tr>
						<tr>
							<th height="120px;">지출 사유</th>
							<td colspan="3"><input type="text" class="rsn" name="expReason"></td>
						</tr>
					</table>
					<script>
						var count = 0;
						function plus(){
							
							count++;
							
							var value = "";
							
							value += "<tr><td height='30' width='130'><input type='date' class='dt2' name='dlist["+ count +"].expDate'></td>"
							       + "<td width='110'><select name='dlist["+ count +"].expStatus' class='sel2'>"
					           	   + "<option value='1'>기구구입비</option>"
						           + "<option value='2'>비품구입비</option>"
						           + "<option value='3'>회식비</option></select></td>"
						           + "<td><input type='text' class='con' id='amount"+ count +"' name='dlist["+ count +"].expAmount' onchange='sum()'></td>"
						           + "<td width='40%'><input type='text' class='con' name='dlist["+ count +"].expHistory'></td>"
						           + "<td width='15%''><input type='text' class='con' name='dlist["+ count +"].expNote'></td></tr>";
						              
							$("#tb7").children().children().filter(":last").before(value);
							sum();
						}
						function del(){
							if($("#tb7").children().children().length == 3){
								alertify.alert("한 행 이상 필수로 입력해야 합니다.");
							}else{
								$("#tb7").children().children().filter(":nth-last-child(2)").remove();
								count--;
							}
						}
					</script>
					<div style="margin-right:3%;">
						<button type="button" class="pm" onclick="del();"><i class='bx bxs-minus-square' style="font-size:20px;"></i></button>
						<button type="button" class="pm" onclick="plus();"><i class='bx bxs-plus-square' style="font-size:20px;"></i></button>
					</div>
					<table id="tb7" style="padding-top:none;">
						<tr>
							<th height="30">일자</th>
							<th>분류</th>
							<th>금액</th>
							<th>사용내역</th>
							<th>비고</th>
						</tr>
						<tr>
							<td height="30" width="130"><input type="date" class="dt2" name="dlist[0].expDate"></td>
							<td width="110">
								<select name="dlist[0].expStatus" class="sel2">
								    <option value="1">기구구입비</option>
								    <option value="2">비품구입비</option>
								    <option value="3">회식비</option>
								</select>
							</td>
							<td><input type="text" class="con" id="amount0" name="dlist[0].expAmount" onchange="sum()"></td>
							<td width="40%"><input type="text" class="con" name="dlist[0].expHistory"></td>
							<td width="15%"><input type="text" class="con" name="dlist[0].expNote"></td>
						</tr>
						<tr>
							<td colspan="5" height="30">합계 : </td>
						</tr>
					</table>
					<span style="margin-left:30px;">* 영수증 별도 제출</span><br><br>
					<div>
						<span style="margin-left:40px;">파일 첨부</span>
						<div class="addfile">
							<span>이 곳에 파일을 드래그하세요. 또는</span>
							<span class="addfilebtn">
						 		<label for="upfile" style="color:gray;">파일선택</label>
								<input type="file" name="upfile" id="upfile" style="display:none;" onchange="selectFile()" multiple>
					    	</span>
					    	<br>
					    	<ul class="fileList">
					    		
					    	</ul>
						</div>
					</div>
					<br><br><br><br><br>
				</div>
				<script>
					// 파일 리스트 번호   
					var fileIndex = 0;
				
				    $(function (){        
					// 파일 드롭 다운      
				   	fileDropDown();
						
				 	});
		       		function sum(){
		           		var amount = new Array();
		           		var sum = 0;   
		
		       			for(i=0; i<count+1; i++){
		       				amount.push(parseInt($("#amount" + i).val()));
		       				if(count+1 == $(".sel2").length){
		        				sum = amount.reduce(function(accumulator, currentValue, i){
		       					return accumulator + currentValue;
		        				});
		       				}
		       			}
		           		
		           		
		           		$("#tb4").children().children().eq(2).children().eq(1).empty();
		           		$("input[name=expTotalAmount]").attr("value", sum);
		           		$("#tb4").children().children().eq(2).children().eq(1).append("&nbsp;" + sum);
		       		}	
		     
		       		function delFile(btn){
		       			$(btn).parents("li").remove();
		       		}
		       		     
		    	   // 파일 드롭 다운    
		    	   function fileDropDown(){       
		    		    var dropZone = $(".addfile");        
		    		   	//Drag기능    
		    		   	dropZone.on('dragenter',function(e){            
		    			   e.stopPropagation();            
		    			   e.preventDefault();            
		    			   // 드롭다운 영역 css            
		    			   dropZone.css('background-color','#E3F2FC');        
		    			});        
		    			dropZone.on('dragleave',function(e){            
		   				    e.stopPropagation();            
		   				    e.preventDefault();            
		   				    // 드롭다운 영역 css            
		   					dropZone.css('background-color','#FFFFFF');        
		 				 });        
		    			dropZone.on('dragover',function(e){            
							e.stopPropagation();            
							e.preventDefault();            
		  					// 드롭다운 영역 css            
		 					dropZone.css('background-color','#E3F2FC');        
		  				});        
		    			dropZone.on('drop',function(e){            
		   					e.preventDefault();            
		   					// 드롭다운 영역 css           
		   					dropZone.css('background-color','#FFFFFF');                        
		   					var files = e.originalEvent.dataTransfer.files;            
		   					if(files != null){                
								if(files.length < 1){                    
									alert("폴더 업로드 불가");                    
									return;                
								}                
		 						selectFile(files)            
		 					}else{               
								alert("ERROR");            
							}        
		 				});    
		 			}     
					// 파일 선택시    
					function selectFile(fileObject){        
						var files = null;         
						if(fileObject != null){           
							// 파일 Drag 이용하여 등록시            
							files = fileObject;        
						}else{            
							// 직접 파일 등록시           
							files = $('#upfile')[0].files;        
						}   
						// 다중파일 등록     
						if(files != null){        
							for(var i = 0; i < files.length; i++){   
								// 파일 이름    
								var fileName = files[i].name;     
								var fileNameArr = fileName.split("\.");   
							    
							// 업로드 파일 목록 생성    
							uploadFile(fileIndex, fileName);  
							// 파일 번호 증가        
							fileIndex++;          
						 
							}        
						}else{       
						alert("ERROR");     
						}
								console.log($("#upfile")[0].files);
					}
		 			
		 			function uploadFile(fileIndex, fileName){
		       			value="";
		       			
		       			value += "<li><span><button type='button' onclick='delFile(this)'; class='del'><i class='bx bx-x'></i></button></span>"
		       			       + "<span>" + fileName + "</span>"
		       			       + "</li>";
		       			$(".fileList").append(value);
		       		}
		       </script>
			</form>
		</div>
	</div>
</body>
</html>