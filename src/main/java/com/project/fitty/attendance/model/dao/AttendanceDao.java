package com.project.fitty.attendance.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.fitty.attendance.model.vo.Attendance;
import com.project.fitty.attendance.model.vo.ModifyAtt;
import com.project.fitty.common.model.vo.PageInfo;
import com.project.fitty.employee.model.vo.Employee;

@Repository
public class AttendanceDao {
	
	public int updateWorkIn(SqlSessionTemplate sqlSession,Attendance a) {
		int timeResult = sqlSession.update("attendanceMapper.updateWorkInTime", a);
		int statusResult = sqlSession.update("attendanceMapper.updateAttInStatus",a);
		return timeResult + statusResult;
	}
	
	public Attendance selectInAttendance(SqlSessionTemplate sqlSession, Attendance a) {
		return sqlSession.selectOne("attendanceMapper.selectInAttendance", a);
	}
	
	public int updateWorkOutLogOut(SqlSessionTemplate sqlSession, Attendance a) {
		int timeResult = sqlSession.update("attendanceMapper.updateWorkOutTime", a);
		int statusResult = sqlSession.update("attendanceMapper.updateAttOutStatus",a);
		return timeResult + statusResult;
	}

	public Attendance selectMyAttendance(SqlSessionTemplate sqlSession, Attendance a) {
		Attendance att = sqlSession.selectOne("attendanceMapper.selectMyAttendance", a);
		return sqlSession.selectOne("attendanceMapper.selectMyAttendance", a);
	}
	
	public Attendance selectLastWorkTime(SqlSessionTemplate sqlSession, Attendance a) {
		return sqlSession.selectOne("attendanceMapper.selectLastWorkTime",a);
	}
	
	public ArrayList<Attendance> selectAllAttList(SqlSessionTemplate sqlSession, Employee e) {
	
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectAllAttList", e);
		
	}
	
	
	public ArrayList<Attendance> selectOtherAttList(SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectOtherAttList", e);
		
	}
	
	
	public ArrayList<Attendance> selectCountList( SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectCountList", e);
	}
	
	public ArrayList<Attendance> selectOtherCountList( SqlSessionTemplate sqlSession, Employee e) {
		return (ArrayList)sqlSession.selectList("attendanceMapper.selectOtherCountList", e);
	}
	
	
	public int insertAttendance(SqlSessionTemplate sqlSession, Attendance a) {
		return sqlSession.insert("attendanceMapper.insertAttendance", a);
	}
	
	public int updateAttendanceStatus(SqlSessionTemplate sqlSession, Attendance a) {
		return sqlSession.insert("attendanceMapper.updateAttendanceStatus", a);
	}
	
	
	
	
	
	public ArrayList<Attendance> selectVacList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap <String, Object> sqlMap){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("attendanceMapper.selectVacList", sqlMap, rowBounds);
	}
	
	public ArrayList<Attendance> selectPerYearMonthList(SqlSessionTemplate sqlSession, Attendance a){
		return (ArrayList) sqlSession.selectList("attendanceMapper.selectPerYearMonthList", a);
	}
	
	
	public ArrayList<Attendance> selectTodaySearchList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> sqlMap) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList) sqlSession.selectList("attendanceMapper.selectTodaySearchList", sqlMap, rowBounds);
	}
	
	public int selectAttNo(SqlSessionTemplate sqlSession, ModifyAtt m) {
		return sqlSession.selectOne("attendanceMapper.selectAttNo", m);
	}
	
	public int AdminUpdateAttInStatus(SqlSessionTemplate sqlSession, Attendance a) {
		return sqlSession.update("attendanceMapper.AdminUpdateAttInStatus", a);
	}
	
	public int AdminUpdateAttOutStatus(SqlSessionTemplate sqlSession, Attendance a) {
		//System.out.println("다오실행됨");
		int result = sqlSession.update("attendanceMapper.AdminUpdateAttOutStatus", a);
		//System.out.println("다오 : " + result);
		return  result;
	}
	
	public ArrayList<Attendance> selectmyMonthAttList(SqlSessionTemplate sqlSession, String empNo){
		return (ArrayList) sqlSession.selectList("attendanceMapper.selectMyMonthAttList", empNo);
	}
	
}
