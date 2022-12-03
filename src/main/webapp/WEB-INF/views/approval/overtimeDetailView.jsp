<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<div class="outer">
		<jsp:include page="sideMenu.jsp"/>
		
		<div class="main">
			<form action="" name="oForm">
				<h4 style="color:rgb(50, 50, 50);">연장근무신청</h4><br>
				
				<button class="f-btn" type="button" onclick="approve();">
					<i class='bx bxs-edit'></i>
					결재
				</button>
				<button class="f-btn" type="button" data-bs-toggle="modal" data-bs-target="#apprReason">
					<i class='bx bx-arrow-back'></i>
					반려
				</button>
				<button class="f-btn" data-bs-toggle="modal" data-bs-target="#addMem" type="button">
				 	<i class='bx bx-error-circle'></i>
				 	결재정보
				</button>
				<button class="f-btn" style="float:right;" type="button" onclick="location.href='waitingList.ap'">
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
								<h5 class="modal-title" id="modalToggleLabel" style="color:rgb(51, 51, 51);">결재정보</h5>
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
											<td>이름</td>
											<td>직급</td>
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
											    	<i class='bx bx-chevrons-right'></i>
												</td>
												<td>승인</td>
												<td>이름</td>
											   	<td>직급</td>
											   	<td></td>
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
								  
								  
								})
							 	function approve(){
									alertify.confirm('승인하시겠습니까?', function(){ $("form[name=oForm]").attr("action","approve.ap").submit();}
						  	 		); 
								}
								
								function returnAppr(){
									alertify.confirm('반려하시겠습니까?', function(){ $("form[name=oForm]").attr("action","return.ap").submit();}
								    );
								}
							  
							</script>
							<div class="modal-footer">
								<button class="btn btn-primary" type="button" data-bs-dismiss="modal" id="aa" onclick="insertApprLine();">확인</button>
								<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</div>
			 
				<div class="app-form1">
					<input type="hidden" name="empNo" value="${loginUser.empNo }">
					<input type="hidden" name="insertEmpNo" value="${ovt.empNo }">
					<input type="hidden" name="apprNo" value="${ ovt.apprNo }">
					<input type="hidden" name="ovtDate" value="${ ovt.ovtDate }">
					<input type="hidden" name="apprDocType" value="${ovt.apprDocType}">
					<br>
					<h5 align="center" style="color:rgb(50, 50, 50);"><b>연장근무신청서</b></h5>
					<br><br>
					<table id="tb1">
						<tr>
							<th width="40%">기안자</th>
						 	<td>${ ovt.empName }</td>
						</tr>
						<tr>
						  	<th>기안일</th>
						  	<td>${ ovt.apprEnrollDate }</td>
						</tr>
						<tr>
						  	<th>문서번호</th>
						  	<td>${ ovt.apprNo }</td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${ mlist[0].apprMemCount eq 1 }">
							<input type="hidden" name="apprMemCount" value="1">
							<input type="hidden" name="apprLevel" value="1">
							<table id="tb2">
								<tr>
									<th rowspan="3" width="25px;">승인</th>
									<c:forEach var="m" items="${ mlist }">
										<td height="24px">${ m.grApprGrade }</td>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="m" items="${ mlist }">
										<td height="60%">${ m.empName }</td>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="m" items="${ mlist }">
										<td width="75px">${m.apprDate }</td>
									</c:forEach>
								</tr>
							</table>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="apprMemCount" value="2">
							<c:if test="${ mlist[1].empNo eq loginUser.empNo }">
							<input type="hidden" name="apprLevel" value="2">
							</c:if>
							<table id="tb5">
								<tr>
									<th rowspan="3" width="25px;">승인</th>
									<c:forEach var="m" items="${ mlist }">
										<td height="24px">${ m.grApprGrade }</td>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="m" items="${ mlist }">
										<td width="75px">${ m.empName }</td>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="m" items="${ mlist }">
										<td height="24px" style="font-size:small">${m.apprDate }</td>
									</c:forEach>
								</tr>
							</table>
						</c:otherwise>
					</c:choose>
					<script>
						$(function(){
							let value = $("#tb5").children().children().eq(2).children().eq(0).text();
							if(!value){
								$("#tb5").children().children().eq(2).children().eq(0).append("<input type='hidden' name='apprLevel' value='1'>");
							}else{
								$("#tb5").children().children().eq(2).children().eq(0).append("<input type='hidden' name='apprLevel' value='2'>");
								$("#tb5").children().children().eq(1).children().eq(0).prepend('<img src="resources/approval_images/stamp_approved.png" width="35" height="40"><br>');
							}
						})
					</script>
					 
					<table id="tb3">
						<tr>
							<th rowspan="3" width="25%;">신청</th>
						 	<td height="24px">${ ovt.grApprGrade }</td>
						</tr>
						<tr>
						 	<td>
							  	<div><img src="resources/approval_images/stamp_approved.png" width="35" height="40"></div>
							  	${ ovt.empName }
						 	</td>
						</tr>
						<tr>
						 	<td height="24px" style="font-size:small;">${ ovt.apprEnrollDate }</td>
						</tr>
					</table>
					 
					<table id="tb4">
						<tr>
						    <th width="20%" height="40px;">근무 일시</th>
						    <td>&nbsp;${ ovt.ovtDate }&nbsp;&nbsp;&nbsp; ${ ovt.ovtStartTime } ~ ${ ovt.ovtEndTime }
						  	</td>
						</tr>
						<tr>
							<th height="40px;">근무 시간</th>
						  	<td>&nbsp;</td>
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
						 	<td>${ ovt.ovtReason }</td>
						</tr>
					</table>
				</div>
			</form>
			<div
			   class="modal fade"
			   id="apprReason"
			   aria-labelledby="modalToggleLabel"
			   tabindex="-1"
			   style="display: none"
			   aria-hidden="true"
			 >
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalToggleLabel" style="color:rgb(51, 51, 51); margin-left:25px;">반려하기</h5>
							<button
							  type="button"
							  class="btn-close"
							  data-bs-dismiss="modal"
							  aria-label="Close"
							></button>
						</div>
						<div class="reModal-body">
							<br>
							<form action="" name="reason">
								<span style="margin-top:20px;">결재문서명</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="margin-left:10px;">
									<c:choose>
										<c:when test="${ ovt.apprDocType eq 1 }">
											휴가신청
										</c:when>
										<c:when test="${ ovt.apprDocType eq 2 }">
											연장근무신청
										</c:when>
										<c:otherwise>
											지출결의서
										</c:otherwise>
									</c:choose>
								</span>
								<br><br>
								<span>반려의견</span>
								<input type="text" class="reModal" name="apprComment">
								<input type="hidden" name="insertEmpNo" value="${loginUser.empNo }">
								<input type="hidden" name="apprNo" value="${ ovt.apprNo }">		
							</form>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" type="button" data-bs-dismiss="modal" id="aa" onclick="returnAppr();">반려</button>
						 	<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
        </div>
	</div>

</body>
</html>