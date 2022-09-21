<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitty 채팅</title>
<link type="text/css" rel="stylesheet" href="resources/css/chat.css" />
<script type="text/javascript" src="resources/js/chat.js"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="row">
   <!-- 채팅메뉴 -->
 <div class="col-md-3">
   <div class="card mb-4 chatMenu" style="background-color: #E7E7FF;">
     <div class="btnFlex">
       <button class="col-md-6" id="empListBtn" aria-selected="true">🙋‍♀️ MEMBER</button>
       <button class="col-md-6">💌 CHAT</button>
     </div>
     <form class="chatMenuForm">
       <div class="profileHeader">
      		
            <h5 class="card-header" style="color:#697a8d; padding-bottom:0px;">
	            <img src="<c:out value='${loginUser.empPhoto}' default='resources/profile_images/defaultProfile.png' />" alt="Avatar" class="rounded-circle" width="30px;" height="30px;"/>
	            <b>${ loginUser.empName } 🏃‍♂️ ${ loginUser.grName }</b>
            </h5>
            <input type="hidden" value="${loginUser.empNo}" id="empNoInput">
      	</div>

       <!-- Search -->
       <table class="navbar-nav align-items-center" style="margin-top: 20px; margin-bottom:20px;">
         <tr>
         	 <!-- 검색값은 처음에 ㄱ한자 공백임!!! -->
         	 <td><input type="text" class="form-control" placeholder="직원명 입력" name="searchText" id="searchText"  maxlength="30" style="height: 35px;" value=""></td>
             <td><button type="button" id="searchBtn" class="btn btn-sm rounded-pill btn-outline-primary">
             <i class='bx bx-search' style="color:#696CFF;"></i></button></td>
         </tr>
       </table>
       <!-- /Search -->

       <div>
         <ul class="empList">
           
         </ul>
       </div>
       
     </form>
   </div>
 </div>


 <!-- 채팅창 -->
 <div class="col-md-9 ">
   <div class="card mb-4 vacDetailDiv">
   
  </div>
</div>

<script type="text/javascript" src="resources/js/chat.js"></script>
<script type="text/javascript" src="resources/js/chat/chatRoomOne.js"></script>
</body>
</html>