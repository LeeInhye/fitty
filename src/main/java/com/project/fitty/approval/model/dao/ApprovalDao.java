package com.project.fitty.approval.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.fitty.approval.model.vo.ApprExpDetail;
import com.project.fitty.approval.model.vo.ApprExpense;
import com.project.fitty.approval.model.vo.ApprOvertime;
import com.project.fitty.approval.model.vo.ApprVacation;
import com.project.fitty.approval.model.vo.Approval;
import com.project.fitty.approval.model.vo.ApprovalMember;
import com.project.fitty.approval.model.vo.File;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;

@Repository
public class ApprovalDao {
	
	public ArrayList<Employee> selectEmpList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("approvalMapper.selectEmpList");
	}
	
	public int insertApproval(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.insert("approvalMapper.insertApproval", ap);
	}
	
	public int insertApprMember(SqlSessionTemplate sqlSession, ArrayList<ApprovalMember> list) {
		int result = 0;
		for(int i=0; i<list.size(); i++) {
			result = sqlSession.insert("approvalMapper.insertApprMember", list.get(i));
		}
		return result;
	}
	
	public int insertApprVct(SqlSessionTemplate sqlSession, ApprVacation vct) {
		return sqlSession.insert("approvalMapper.insertApprVct", vct);
	}
	
	public int insertApprOvt(SqlSessionTemplate sqlSession, ApprOvertime ovt) {
		return sqlSession.insert("approvalMapper.insertApprOvt", ovt);
	}
	
	public int insertApprExp(SqlSessionTemplate sqlSession, ApprExpense exp) {
		return sqlSession.insert("approvalMapper.insertApprExp", exp);
	}
	
	public int insertApprExpDetail(SqlSessionTemplate sqlSession, ArrayList<ApprExpDetail> dlist) {
		int result = 0;
		for(int i=0; i<dlist.size(); i++) {
			result = sqlSession.insert("approvalMapper.insertApprExpDetail", dlist.get(i));
		}
		return result;
	}
	
	public int insertApprFile(SqlSessionTemplate sqlSession, ArrayList<File> flist) {
		int result = 0;
		for(int i=0; i<flist.size(); i++) {
			result = sqlSession.insert("approvalMapper.insertApprFile", flist.get(i));
		}
		return result;
	}
	
	public int selectScheduleListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("approvalMapper.selectScheduleListCount", empNo);
	}
	
	public ArrayList<Approval> selectScheduleList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectScheduleList", empNo, rowBounds);
	}
	
	public int selectListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("approvalMapper.selectListCount", empNo);
	}
	
	public ArrayList<Approval> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectList", empNo, rowBounds);
	}
	
	public int ajaxSelectListCount(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.selectOne("approvalMapper.ajaxSelectListCount", ap);
	}
	
	public ArrayList<Approval> ajaxSelectList(SqlSessionTemplate sqlSession, PageInfo pi, Approval ap){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.ajaxSelectList", ap, rowBounds);
	}
	
	public int selectStorageListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("approvalMapper.selectStorageListCount", empNo);
	}
	
	public ArrayList<Approval> selectStorageList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectStorageList", empNo, rowBounds);
	}
	
	public int selectSignListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("approvalMapper.selectSignListCount", empNo);
	}
	
	public ArrayList<Approval> selectSignList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectSignList", empNo, rowBounds);
	}
	
	public int ajaxSelectSignListCount(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.selectOne("approvalMapper.ajaxSelectSignListCount", ap);
	}
	
	public ArrayList<Approval> ajaxSelectSignList(SqlSessionTemplate sqlSession, PageInfo pi, Approval ap){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.ajaxSelectSignList", ap, rowBounds);
	}

	public int insertStorage(SqlSessionTemplate sqlSession, Approval ap) {
		return sqlSession.insert("approvalMapper.insertStorage", ap);
	}
	
	public int selectWaitingListCount(SqlSessionTemplate sqlSession, String empNo) {
		return sqlSession.selectOne("approvalMapper.selectWaitingListCount", empNo);
	}
	
	public ArrayList<Approval> selectWaitingList(SqlSessionTemplate sqlSession, PageInfo pi, String empNo){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("approvalMapper.selectWaitingList", empNo, rowBounds);
	}
	
	public ArrayList<ApprovalMember> selectMember(SqlSessionTemplate sqlSession, String apprNo){
		return (ArrayList)sqlSession.selectList("approvalMapper.selectMember", apprNo);
	}
	
	public ApprVacation selectVacation(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.selectOne("approvalMapper.selectVacation", apprNo);
	}
	
	public ApprOvertime selectOvertime(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.selectOne("approvalMapper.selectOvertime", apprNo);
	}

	public ApprExpense selectExpense(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.selectOne("approvalMapper.selectExpense", apprNo);
	}
	
	public ArrayList<ApprExpDetail> selectExpDetail(SqlSessionTemplate sqlSession, String apprNo){
		return (ArrayList)sqlSession.selectList("approvalMapper.selectExpDetail", apprNo);
	}
	
	public int updateApproval(SqlSessionTemplate sqlSession, ApprovalMember am) {
		return sqlSession.update("approvalMapper.updateApproval", am);
	}
	
	public int updateApprovalMem(SqlSessionTemplate sqlSession, ApprovalMember am) {
		return sqlSession.update("approvalMapper.updateApprovalMem", am);
	}
	
	public int updateAtt1(SqlSessionTemplate sqlSession, ApprVacation vct) {
		return sqlSession.update("approvalMapper.updateAtt1", vct);
	}
	
	public int updateAtt2(SqlSessionTemplate sqlSession, ApprVacation vct) {
		return sqlSession.update("approvalMapper.updateAtt2", vct);
	}
	
	public int insertVacation(SqlSessionTemplate sqlSession, ApprVacation vct) {
		return sqlSession.insert("approvalMapper.insertVacation", vct);
	}
	
	public int updateReturnAppr(SqlSessionTemplate sqlSession, ApprovalMember am) {
		return sqlSession.update("approvalMapper.updateReturnAppr", am);
	}
	
	public int updateReturnApprMem(SqlSessionTemplate sqlSession, ApprovalMember am) {
		return sqlSession.update("approvalMapper.updateReturnApprMem", am);
	}
	
	public int deleteApproval(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.delete("approvalMapper.deleteApproval", apprNo);
	}
	
	public int deleteVacation(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.delete("approvalMapper.deleteVacation", apprNo);
	}
	
	public int deleteOvertime(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.delete("approvalMapper.deleteOvertime", apprNo);
	}
	
	public int deleteExpense(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.delete("approvalMapper.deleteExpense", apprNo);
	}
	
	public int deleteExpDetail(SqlSessionTemplate sqlSession, String apprNo) {
		return sqlSession.delete("approvalMapper.deleteExpDetail", apprNo);
	}
}
