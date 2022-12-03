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
			<h4 style="color:rgb(50, 50, 50);">결재 예정 문서</h4><br><br>
			<table id="dTable" align="center">
				<tr style="background:rgb(231, 231, 255)">
					<th height="30">기안일</th>
					<th>결재양식</th>
					<th width="40%;">제목</th>
					<th>첨부파일</th>
					<th>기안자</th>
				</tr>
				<c:choose>
					<c:when test="${ not empty list }">
						<c:forEach var="a" items="${list }">
					 		<tr>
					 			<td height="30">${ a.apprEnrollDate }<input type="hidden" name="apprDocType" class="apprDocType" value="${ a.apprDocType }"></td>
					 			<c:choose>
									<c:when test="${ a.apprDocType eq 1 }">
										<td>휴가신청</td>
									</c:when>
									<c:when test="${ a.apprDocType eq 2 }">
										<td>연장근무신청</td>
									</c:when>
									<c:otherwise>
										<td>지출결의서</td>
									</c:otherwise>
								</c:choose>
					 			<td>${ a.apprTitle }<input type="hidden" name="apprNo" class="apprNo" value="${ a.apprNo }"></td>
					 			<td></td>
					 			<td>${ a.empName }</td>
					 		</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5" height="30">문서가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<br><br>
			<script>
				$(function(){
					$("#dTable>tbody>tr").click(function(){
						location.href = 'apprDetail.ap?apprNo=' + $(this).children().children(".apprNo").val() 
									  + '&apprDocType=' + $(this).children().children(".apprDocType").val();
					})
				})
			</script>
			
			<div class="paging-area">
				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center">
					
						<c:choose>
							<c:when test="${ pi.currentPage eq 1 }">
								<li class="page-item prev disabled">
									<a class="page-link"
									><i class="tf-icon bx bx-chevron-left"></i
									></a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item prev">
									<a class="page-link" href="duleList.ap?empNo=${loginUser.empNo }&cpage=${ pi.currentPage-1 }"
								    ><i class="tf-icon bx bx-chevron-left"></i
									></a>
								</li>
							</c:otherwise>
						</c:choose>
							
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:choose>
								<c:when test="${ p eq pi.currentPage }">
									<li class="page-item active disabled">
										<a class="page-link" href="duleList.ap?empNo=${loginUser.empNo }&cpage=${ p }">${ p }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="duleList.ap?empNo=${loginUser.empNo }&cpage=${ p }">${ p }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
							
						<c:choose>
							<c:when test="${ pi.currentPage eq pi.maxPage }">
								<li class="page-item next disabled" >
									<a class="page-link"
									><i class="tf-icon bx bx-chevron-right"></i
								   	></a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item next">
									<a class="page-link" href="duleList.ap?empNo=${loginUser.empNo }&cpage=${ pi.currentPage+1 }"
									><i class="tf-icon bx bx-chevron-right"></i
								  	></a>
								</li>
							</c:otherwise>
						</c:choose>
					  
					</ul>
				</nav>
			</div>
			<br>
			<div align="center">
				<select name="" id="sel3">
					<option value="">전체기간</option>
					<option value="">1개월</option>
					<option value="">6개월</option>
					<option value="">1년</option>
				</select>
				<select name="" id="sel4">
					<option value="">제목</option>
					<option value="">결재양식</option>
					<option value="">기안자</option>
				</select>
				<input type="text" id="search"><button id="s-btn2">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg>
				</button>
			</div>
		</div>
	</div>

</body>
</html>