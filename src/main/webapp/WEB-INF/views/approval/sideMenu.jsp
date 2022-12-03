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
	<div class="sideMenu">
		
		<button id="s-btn1" data-bs-toggle="modal" data-bs-target="#newAppModal">새 결재 진행</button>
		
	 	<div class="list">
			<span><b>결재하기</b></span>
			<ul>
			  	<li><a type="button" onclick="postFormSubmit('waitingList.ap');">결재 대기 문서</a></li>
				<li><a type="button" onclick="postFormSubmit('duleList.ap');">결재 예정 문서</a></li>
			</ul>
			<span><b>개인 문서함</b></span>
			<ul>
			  	<li><a type="button" onclick="postFormSubmit('draftList.ap');">기안 문서함</a></li>
				<li><a type="button" onclick="postFormSubmit('storageList.ap');">임시 저장함</a></li>
				<li><a type="button" onclick="postFormSubmit('signList.ap');">결재 문서함</a></li>
			</ul>
		</div>
	</div>
    <form id="postForm" action="" method="post">
		<input type="hidden" name="empNo" value="${ loginUser.empNo }">
	</form>
    <script>
		function postFormSubmit(url){
			$("#postForm").attr("action", url).submit();
		}
	</script>
       
	<div
	  class="modal fade"
	  id="newAppModal"
	  aria-labelledby="modalToggleLabel"
	  tabindex="-1"
	  style="display: none"
	  aria-hidden="true"
	>
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel" style="color:rgb(51, 51, 51);">결재양식 선택</h5>
					<button
					  type="button"
					  class="btn-close"
					  data-bs-dismiss="modal"
					  aria-label="Close"
					></button>
				</div>
				<div class="modal-body">
				  	<div class="selType">
					    <button class="seltn" id="seltn1">- 휴가신청 </button><br><br>
					    <button class="seltn" id="seltn2">- 연장근무신청 </button><br><br>
					    <button class="seltn" id="seltn3">- 지출결의서 </button>
					</div>
					<div class="selthumbnail">
					    <img width="330" height="390" src="resources/approval_images/vct.png" style="display:none;" id="img1">
					    <img width="330" height="390" src="resources/approval_images/ovt.png" style="display:none;" id="img2">
					    <img width="330" height="390" src="resources/approval_images/exp.png" style="display:none;" id="img3">
				   	</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="sub">확인</button>
				   	<button class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$("#seltn1").click(function(){
				$("#sub").removeAttr("onclick");
			$("#sub").attr("onclick", "location.href='vacation.ap'");
				$(".selthumbnail img").hide();
			$("#img1").show();
			})
			$("#seltn2").click(function(){
				$("#sub").removeAttr("onclick");
				$("#sub").attr("onclick", "location.href='overtime.ap'");
					$(".selthumbnail img").hide();
				$("#img2").show();
		 	})
			$("#seltn3").click(function(){
				$("#sub").removeAttr("onclick");
				$("#sub").attr("onclick", "location.href='expense.ap'");
					$(".selthumbnail img").hide();
				$("#img3").show();
			})
		})
	</script>
       

</body>
</html>