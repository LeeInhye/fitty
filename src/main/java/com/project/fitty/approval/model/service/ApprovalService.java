package com.project.fitty.approval.model.service;

import java.util.ArrayList;

import com.project.fitty.approval.model.vo.ApprExpDetail;
import com.project.fitty.approval.model.vo.ApprExpense;
import com.project.fitty.approval.model.vo.ApprOvertime;
import com.project.fitty.approval.model.vo.ApprVacation;
import com.project.fitty.approval.model.vo.Approval;
import com.project.fitty.approval.model.vo.ApprovalMember;
import com.project.fitty.approval.model.vo.File;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;

public interface ApprovalService {
	// 직원리스트
	ArrayList<Employee> selectEmpList();
	
	// 휴가신청
	int insertApproval(Approval ap);
	int insertApprMember(ArrayList<ApprovalMember> list);
	int insertApprVct(ApprVacation vct);
	
	// 연장근무신청
	int insertApprOvt(ApprOvertime ovt);
	
	// 지출결의서신청
	int insertApprExp(ApprExpense exp);
	int insertApprExpDetail(ArrayList<ApprExpDetail> dlist);
	int insertApprFile(ArrayList<File> flist);
	
	// 임시저장
	int insertStorage(Approval ap);
	
	// 결재예정문서(페이징)
	int selectScheduleListCount(String empNo);
	ArrayList<Approval> selectScheduleList(PageInfo pi, String empNo);
	
	// 기안문서함(페이징)
	int selectListCount(String empNo);
	ArrayList<Approval> selectList(PageInfo pi, String empNo);
	
	// 기안문서함(ajax)
	int ajaxSelectListCount(Approval ap);
	ArrayList<Approval> ajaxSelectList(PageInfo pi, Approval ap);
	
	// 임시저장함(페이징)
	int selectStorageListCount(String empNo);
	ArrayList<Approval> selectStorageList(PageInfo pi, String empNo);
	
	// 결재문서함(페이징)
	int selectSignListCount(String empNo);
	ArrayList<Approval> selectSignList(PageInfo pi, String empNo);
	
	// 결재문서함(ajax)
	int ajaxSelectSignListCount(Approval ap);
	ArrayList<Approval> ajaxSelectSignList(PageInfo pi, Approval ap);
	
	// 결재대기문서(페이징)
	int selectWaitingListCount(String empNo);
	ArrayList<Approval> selectWaitingList(PageInfo pi, String empNo);
	
	// 상세페이지
	ArrayList<ApprovalMember> selectMember(String apprNo);
	ApprVacation selectVacation(String apprNo);
	ApprOvertime selectOvertime(String apprNo);
	ApprExpense selectExpense(String apprNo);
	ArrayList<ApprExpDetail> selectExpDetail(String apprNo);
	
	// 결재승인
	int updateApproval(ApprovalMember am);
	int updateApprovalMem(ApprovalMember am);
	
	// 최종승인
	int updateAtt1(ApprVacation vct);
	int updateAtt2(ApprOvertime ovt);
	int insertVacation(ApprVacation vct);
	
	// 반려
	int updateReturnAppr(ApprovalMember am);
	int updateReturnApprMem(ApprovalMember am);
	
	// 임시저장삭제
	int deleteApproval(String apprNo);
	int deleteVacation(String apprNo);
	int deleteOvertime(String apprNo);
	int deleteExpense(String apprNo);
	int deleteExpDetail(String apprNo);
	
	// 메인ㅡ결재진행문서, 완료문서
	ArrayList<Approval> selectMainDraftList(String empNo);
	ArrayList<Approval> selectMainCompleteList(String empNo);
	
	// 임시저장 문서기안
	int updateStorage(Approval ap);
	int updateStorageVct(ApprVacation vct);
	int updateStorageOvt(ApprOvertime ovt);
	int updateStorageExp(ApprExpense exp);
	int updateStorageExpDetail(ArrayList<ApprExpDetail> dlist);
	int updateStorageFile(ArrayList<File> flist);
	
	// 기안문서함 검색
	int selectSearchCount(String empNo, String category, String keyword);
	ArrayList<Approval> selectSearchList(PageInfo pi, String empNo, String category, String keyword);
	
	// 임시저장함 검색
	int selectStorageSearchCount(String empNo, String category, String keyword);
	ArrayList<Approval> selectStorageSearchList(PageInfo pi, String empNo, String category, String keyword);
	
	// 결재문서함 검색
	int selectSignSearchCount(String empNo, String category, String keyword);
	ArrayList<Approval> selectSignSearchList(PageInfo pi, String empNo, String category, String keyword);
}
