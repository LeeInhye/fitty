<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitty 연차 휴가 관리</title>
<link type="text/css" rel="stylesheet" href="resources/css/attendance.css" />
<script type="text/javascript" src="resources/js/attendance.js"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="content-wrapper">
    <div class="container-xxl flex-grow-1 container-p-y" style="padding:0px;">
        <div class="row">

            <!-- <h5 class="py-3 my-4">근태관리 페이지</h5> -->
            <div class="col-xl-12">
            <!-- <h6 class="text-muted">Filled Pills</h6> -->
                <div class="nav-align-top mb-4">
                    <ul class="nav nav-pills mb-3 nav-fill" role="tablist">
                    <li class="nav-item">
                        <button
                        type="button"
                        class="nav-link"
                        role="tab"
                        data-bs-toggle="tab"
                        aria-selected="false"
                        onclick="go('centerAtt.att')"
                        >
                        📅 전직원 근태확인
                        </button>
                    </li>
                    <li class="nav-item">
                        <button
                        type="button"
                        class="nav-link active"
                        role="tab"
                        data-bs-toggle="tab"
                        aria-selected="true"
                        onclick="go('vacControl.att')"
                        >
                        🎁 연차 관리 &nbsp&&nbsp 🎉 휴가 관리
                        </button>
                    </li>
                    <li class="nav-item">
                        <button
                        type="button"
                        class="nav-link"
                        role="tab"
                        data-bs-toggle="tab"
                        aria-selected="false"
                        onclick="go('modifyAtt.att')"
                        >
                        📝 근태 수정
                        </button>
                    </li>
                    </ul>
                    
                    
                    <div class="tab-content">
                <div class="tab-pane fade show active" id="navs-pills-justified-home" role="tabpanel">
                  <div style="height : 20px"></div>
                  <table class="pull-right">
                    <tr>
                      <td width="22px"></td>
                      <td>
                        <select class="form-control mr-sm-0" name="searchType" id="searchType" style="height: 35px;">                                        
                                <option value="userId">근속연수 1년이하</option>
                                <option value="gradeName">근속연수 1~5년</option>
                                <option value="gradeName">근속연수 5~10년</option>
                                <option value="gradeName">근속연수 10년이상</option>
                                <option value="gradeName">작년 근태 80%이상</option>
                                <option value="gradeName">지난달 근태 100%</option>
                        </select>
                      </td>
                      <td><input type="text" class="form-control" placeholder="검색어 입력" name="searchText" id="searchText"  maxlength="30" style="height: 35px;"></td>
                      <td><button type="button" id="searchBtn" class="btn btn-primary" onclick="changeSelect();">검색</button></td>
                      <td width="420px"></td>
                      <td><button class="btn btn-primary" onclick="generalChange();">연월차/휴가발생</button></td>
                      <td><button class="btn btn-secondary" onclick="generalChange();">연월차/휴가소진</button></td>
                      <td><button class="btn btn-info" onclick="generalChange();">공휴일관리</button></td>
                    </tr>        
                  </table>
                </div>
              
        
                <div style="height : 5px"></div>
                    <div class="card-body">
                      <div class="table-responsive">
                        <table class="table memberListTable table-hover" id="dataTable" width="100%" cellspacing="0">
                          <thead>
                              <tr>
                                <th><input type="checkbox" name="choiceAll" id="choiceAll" onclick="checkAll();"></th>
                                <th>사번</th>
                                <th>이름</th>
                                <th>직급</th>
                                <th>입사일</th>
                                <th>근속연수</th>
                                <th>작년근태</th>
                                <th>지난달근태</th>
                                <th>발생연월차</th>
                                <th>잔여연월차</th>
                                <th>발생휴가</th>
                                <th>잔여휴가</th>
                              </tr>
                          </thead>
                          <tfoot>
                              <tr>
                                <th><input type="checkbox" name="choiceAll" id="choiceAll" onclick="checkAll();"></th>
                                <th>사번</th>
                                <th>이름</th>
                                <th>직급</th>
                                <th>입사일</th>
                                <th>근속연수</th>
                                <th>작년근태</th>
                                <th>지난달근태</th>
                                <th>발생연월차</th>
                                <th>잔여연월차</th>
                                <th>발생휴가</th>
                                <th>잔여휴가</th>
                              </tr>
                          </tfoot>
                          
                          <tbody id="memListTBody">
                            <tr>
                              <th><input type="checkbox" name="choiceAll" id="choiceAll" onclick="checkAll();"></th>
                              <th>SS1001</th>
                              <th>김사장</th>
                              <th>사장</th>
                              <th>2020.08.05</th>
                              <th>2.2</th>
                              <th>98%</th>
                              <th>96%</th>
                              <th>15</th>
                              <th>3</th>
                              <th>12</th>
                              <th>2</th>
                            </tr>
                            <tr>
                              <th><input type="checkbox" name="choiceAll" id="choiceAll" onclick="checkAll();"></th>
                              <th>SS1001</th>
                              <th>김사장</th>
                              <th>사장</th>
                              <th>2020.08.05</th>
                              <th>2.2</th>
                              <th>98%</th>
                              <th>96%</th>
                              <th>15</th>
                              <th>3</th>
                              <th>12</th>
                              <th>2</th>
                            </tr>
                            <tr>
                              <th><input type="checkbox" name="choiceAll" id="choiceAll" onclick="checkAll();"></th>
                              <th>SS1001</th>
                              <th>김사장</th>
                              <th>사장</th>
                              <th>2020.08.05</th>
                              <th>2.2</th>
                              <th>98%</th>
                              <th>96%</th>
                              <th>15</th>
                              <th>3</th>
                              <th>12</th>
                              <th>2</th>
                            </tr>
                          </tbody>
                        </table>
                        <div style="height : 20px"></div>
                            <!-- Basic Pagination -->
                            <nav aria-label="Page navigation pageNav">
                                <ul class="pagination">
                                <li class="page-item first">
                                    <a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a>
                                </li>
                                <li class="page-item prev">
                                    <a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-left"></i></a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="javascript:void(0);">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="javascript:void(0);">2</a>
                                </li>
                                <li class="page-item active">
                                    <a class="page-link" href="javascript:void(0);">3</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="javascript:void(0);">4</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="javascript:void(0);">5</a>
                                </li>
                                <li class="page-item next">
                                    <a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a>
                                </li>
                                <li class="page-item last">
                                    <a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a>
                                </li>
                                </ul>
                            </nav>
                            <!--/ Basic Pagination -->
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>


</body>
</html>