package com.project.fitty.approval.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.fitty.approval.model.dao.ApprovalDao;
import com.project.fitty.approval.model.vo.ApprExpDetail;
import com.project.fitty.approval.model.vo.ApprExpense;
import com.project.fitty.approval.model.vo.ApprOvertime;
import com.project.fitty.approval.model.vo.ApprVacation;
import com.project.fitty.approval.model.vo.Approval;
import com.project.fitty.approval.model.vo.ApprovalMember;
import com.project.fitty.approval.model.vo.File;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;
import com.project.fitty.vacation.model.vo.Vacation;

@Service
public class ApprovalServiceImpl implements ApprovalService{
	
	@Autowired
	private ApprovalDao aDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Employee> selectEmpList() {
		return aDao.selectEmpList(sqlSession);
	}
	
	@Override
	public int insertApproval(Approval ap) {
		return aDao.insertApproval(sqlSession, ap);
	}

	@Override
	public int insertApprMember(ArrayList<ApprovalMember> list) {
		return aDao.insertApprMember(sqlSession, list);
	}

	@Override
	public int insertApprVct(ApprVacation vct) {
		return aDao.insertApprVct(sqlSession, vct);
	}

	@Override
	public int insertApprOvt(ApprOvertime ovt) {
		return aDao.insertApprOvt(sqlSession, ovt);
	}

	@Override
	public int insertApprExp(ApprExpense exp) {
		return aDao.insertApprExp(sqlSession, exp);
	}

	@Override
	public int insertApprExpDetail(ArrayList<ApprExpDetail> dlist) {
		return aDao.insertApprExpDetail(sqlSession, dlist);
	}

	@Override
	public int insertApprFile(ArrayList<File> flist) {
		return aDao.insertApprFile(sqlSession, flist);
	}

	@Override
	public int selectListCount(String empNo) {
		return aDao.selectListCount(sqlSession, empNo);
	}

	@Override
	public int selectScheduleListCount(String empNo) {
		return aDao.selectScheduleListCount(sqlSession, empNo);
	}
	
	@Override
	public ArrayList<Approval> selectScheduleList(PageInfo pi, String empNo) {
		return aDao.selectScheduleList(sqlSession, pi, empNo);
	}

	@Override
	public ArrayList<Approval> selectList(PageInfo pi, String empNo) {
		return aDao.selectList(sqlSession, pi, empNo);
	}

	@Override
	public int ajaxSelectListCount(Approval ap) {
		return aDao.ajaxSelectListCount(sqlSession, ap);
	}

	@Override
	public ArrayList<Approval> ajaxSelectList(PageInfo pi, Approval ap) {
		return aDao.ajaxSelectList(sqlSession, pi, ap);
	}

	@Override
	public int selectStorageListCount(String empNo) {
		return aDao.selectStorageListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Approval> selectStorageList(PageInfo pi, String empNo) {
		return aDao.selectStorageList(sqlSession, pi, empNo);
	}

	@Override
	public int selectSignListCount(String empNo) {
		return aDao.selectSignListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Approval> selectSignList(PageInfo pi, String empNo) {
		return aDao.selectSignList(sqlSession, pi, empNo);
	}

	@Override
	public int ajaxSelectSignListCount(Approval ap) {
		return aDao.ajaxSelectSignListCount(sqlSession, ap);
	}

	@Override
	public ArrayList<Approval> ajaxSelectSignList(PageInfo pi, Approval ap) {
		return aDao.ajaxSelectSignList(sqlSession, pi, ap);
	}

	@Override
	public int insertStorage(Approval ap) {
		return aDao.insertStorage(sqlSession, ap);
	}

	@Override
	public int selectWaitingListCount(String empNo) {
		return aDao.selectWaitingListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Approval> selectWaitingList(PageInfo pi, String empNo) {
		return aDao.selectWaitingList(sqlSession, pi, empNo);
	}
	
	@Override
	public ArrayList<ApprovalMember> selectMember(String apprNo) {
		return aDao.selectMember(sqlSession, apprNo);
	}

	@Override
	public ApprVacation selectVacation(String apprNo) {
		return aDao.selectVacation(sqlSession, apprNo);
	}

	@Override
	public ApprOvertime selectOvertime(String apprNo) {
		return aDao.selectOvertime(sqlSession, apprNo);
	}

	@Override
	public ApprExpense selectExpense(String apprNo) {
		return aDao.selectExpense(sqlSession, apprNo);
	}

	@Override
	public ArrayList<ApprExpDetail> selectExpDetail(String apprNo) {
		return aDao.selectExpDetail(sqlSession, apprNo);
	}

	@Override
	public int updateApproval(ApprovalMember am) {
		return aDao.updateApproval(sqlSession, am);
	}

	@Override
	public int updateApprovalMem(ApprovalMember am) {
		return aDao.updateApprovalMem(sqlSession, am);
	}

	@Override
	public int updateAtt1(ApprVacation vct) {
		return aDao.updateAtt1(sqlSession, vct);
	}
	
	@Override
	public int updateAtt2(ApprOvertime ovt) {
		return aDao.updateAtt2(sqlSession, ovt);
	}

	@Override
	public int insertVacation(ApprVacation vct) {
		return aDao.insertVacation(sqlSession, vct);
	}

	@Override
	public int updateReturnAppr(ApprovalMember am) {
		return aDao.updateReturnAppr(sqlSession, am);
	}

	@Override
	public int updateReturnApprMem(ApprovalMember am) {
		return aDao.updateReturnApprMem(sqlSession, am);
	}

	@Override
	public int deleteApproval(String apprNo) {
		return aDao.deleteApproval(sqlSession, apprNo);
	}

	@Override
	public int deleteVacation(String apprNo) {
		return aDao.deleteVacation(sqlSession, apprNo);
	}

	@Override
	public int deleteOvertime(String apprNo) {
		return aDao.deleteOvertime(sqlSession, apprNo);
	}

	@Override
	public int deleteExpense(String apprNo) {
		return aDao.deleteExpense(sqlSession, apprNo);
	}

	@Override
	public int deleteExpDetail(String apprNo) {
		return aDao.deleteExpDetail(sqlSession, apprNo);
	}

	@Override
	public ArrayList<Approval> selectMainDraftList(String empNo) {
		return aDao.selectMainDraftList(sqlSession, empNo);
	}

	@Override
	public ArrayList<Approval> selectMainCompleteList(String empNo) {
		return aDao.selectMainCompleteList(sqlSession, empNo);
	}

	@Override
	public int updateStorage(Approval ap) {
		return aDao.updateStorage(sqlSession, ap);
	}

	@Override
	public int updateStorageVct(ApprVacation vct) {
		return aDao.updateStorageVct(sqlSession, vct);
	}

	@Override
	public int updateStorageOvt(ApprOvertime ovt) {
		return aDao.updateStorageOvt(sqlSession, ovt);
	}

	@Override
	public int updateStorageExp(ApprExpense exp) {
		return aDao.updateStorageExp(sqlSession, exp);
	}

	@Override
	public int updateStorageExpDetail(ArrayList<ApprExpDetail> dlist) {
		return aDao.updateStorageExpDetail(sqlSession, dlist);
	}

	@Override
	public int updateStorageFile(ArrayList<File> flist) {
		return aDao.updateStorageFile(sqlSession, flist);
	}

	@Override
	public int selectSearchCount(String empNo, String category, String keyword) {
		return aDao.selectSearchCount(sqlSession, empNo, category, keyword);
	}

	@Override
	public ArrayList<Approval> selectSearchList(PageInfo pi, String empNo, String category, String keyword) {
		return aDao.selectSearchList(sqlSession, pi, empNo, category, keyword);
	}
	
	@Override
	public int selectStorageSearchCount(String empNo, String category, String keyword) {
		return aDao.selectStorageSearchCount(sqlSession, empNo, category, keyword);
	}

	@Override
	public ArrayList<Approval> selectStorageSearchList(PageInfo pi, String empNo, String category, String keyword) {
		return aDao.selectStorageSearchList(sqlSession, pi, empNo, category, keyword);
	}
	
	@Override
	public int selectSignSearchCount(String empNo, String category, String keyword) {
		return aDao.selectSignSearchCount(sqlSession, empNo, category, keyword);
	}

	@Override
	public ArrayList<Approval> selectSignSearchList(PageInfo pi, String empNo, String category, String keyword) {
		return aDao.selectSignSearchList(sqlSession, pi, empNo, category, keyword);
	}


}
